From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 5 Oct 2010 20:35:08 +0100
Subject: [PATCH v2] Input: Make ADS7846 independent on regulator
In-Reply-To: <20101005185942.GA22808@opensource.wolfsonmicro.com>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com>
	<4C862EB3.4080006@compulab.co.il>
	<20100907125335.GD25830@sirena.org.uk>
	<201009091027.18176.marek.vasut@gmail.com>
	<20100909094120.GB1988@rakim.wolfsonmicro.main>
	<4CAACA63.6090202@compulab.co.il>
	<20101005161608.GD19730@core.coreip.homeip.net>
	<20101005164037.GA20555@opensource.wolfsonmicro.com>
	<20101005180703.GD21399@core.coreip.homeip.net>
	<20101005185942.GA22808@opensource.wolfsonmicro.com>
Message-ID: <20101005203508.7df590db@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If the board doesn't use regulators you can just disable the regulator
> API at which point it compiles out into stubs which report success -
> this has been the case from day one.  There's only an issue if the board
> has a regulator configuration which is partially visible to software.

Which is quite likely on anything complex and means that hardcoding
regulator assumptions is bad.

I actually see two ways of attacking that, one is that the dummy
regulator *and* the compiled in regulator system have a standard
regulator value that can be passed which means "report success, move
along nothing to see" that could be passed into drivers, the other is to
not stick the stuff in drivers.

I suspect the former may be cleaner ?

Alan
