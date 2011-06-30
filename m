From: utx@penguin.cz (Stanislav Brabec)
Date: Fri, 01 Jul 2011 00:20:15 +0200
Subject: kernel panic in spi_complete() on spitz (PXA270)
In-Reply-To: <4E0CE189.1020000@compulab.co.il>
References: <1308845380.4533.54.camel@oct.suse.cz>
	<201106301352.21684.marek.vasut@gmail.com>
	<1309445118.4406.47.camel@oct.suse.cz>
	<4E0C957F.8080807@compulab.co.il>
	<1309450406.4406.59.camel@oct.suse.cz>
	<4E0CB518.2080703@compulab.co.il>
	<20110630180105.GA5064@opensource.wolfsonmicro.com>
	<4E0CE189.1020000@compulab.co.il>
Message-ID: <1309472415.6630.8.camel@utx.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg wrote:

> Stanislav,
> Can't you define a fixed voltage regulator for the ads7846 in spitz board file?
> This shouldn't be a hard task and is the right solution from the regulator API POV.

Yes, I can.

ADS7846 needs more definitions in the platform file to work well on
spitz. The current platform definition is not sufficient and pointer
noise makes it unusable (e. g. 100 pixels jumps). I am comparing Lineo's
2.4 code with 2.6 algorithm and experimenting to get the best results.

-- 

________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx
