From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 15 Apr 2014 10:35:25 +0200
Subject: [PATCH v4 2/2] reset: Add GPIO support to reset controller
 framework
In-Reply-To: <20140414115758.2c0c8a9d@alan.etchedpixels.co.uk>
References: <1397463709-19405-1-git-send-email-p.zabel@pengutronix.de>
 <1397463709-19405-2-git-send-email-p.zabel@pengutronix.de>
 <20140414115758.2c0c8a9d@alan.etchedpixels.co.uk>
Message-ID: <1397550925.3836.30.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

Am Montag, den 14.04.2014, 11:57 +0100 schrieb One Thousand Gnomes:
> > This adds support for GPIO controlled reset pins on peripheral ICs to the reset
> > controller framework. Currently there is no support for specifying a delay
> > between assertion and de-assertion of the reset signal, so this has to be
> > handled by the drivers.
> 
> Lots of GPIO controllers are doing posted writes to the fabric so surely
> your delay will be wrong ?

I haven't seen hardware yet where this is an issue, but it's a valid
point. I can also imagine boards where the GPIO is connected to some
board specific timed reset logic or where the reset length has to be
altered just due to capacitance.

regards
Philipp
