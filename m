From: ideal.song@samsung.com (Inha Song)
Date: Tue, 13 Jan 2015 10:27:34 +0900
Subject: [alsa-devel] [PATCH 2/3] ASoC: samsung: Document Trats2 audio
 subsystem bindings
In-Reply-To: <20150105152918.GT11764@sirena.org.uk>
References: <1420457117-11030-1-git-send-email-ideal.song@samsung.com>
 <1420457117-11030-3-git-send-email-ideal.song@samsung.com>
 <20150105152918.GT11764@sirena.org.uk>
Message-ID: <20150113102734.7a3aa77a@songinha-Samsung-DeskTop-System>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thank you for your feedback and sorry for late response.

I think, I should remove clock settings in machine driver.
If the clock settings are necessary, I will add "assigned-clocks" nodes
in trats2 sound DT like odroid board.

Best Regards,
Inha Song.

> On Mon, Jan 05, 2015 at 08:25:16PM +0900, Inha Song wrote:
> 
> > + - clocks : Reference to the codec master clock
> > + - clock-names : The clock should be named "mclk"
> 
> This should be done in the CODEC driver, not in the machine driver - the
> CODEC always needs the clock, it's not something specific to this
> machine.  Even if we decide that for Linux the best thing to do is to
> manage the clock in the machine driver it should be described in the DT
> as being attached to the CODEC.
