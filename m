From: marex@denx.de (Marek Vasut)
Date: Wed, 29 Jan 2014 15:53:14 +0100
Subject: imx-drm: screen flickering
In-Reply-To: <20140129111557.GI16215@pengutronix.de>
References: <CAH9NwWe673znThNPWRvOCyAU2o7M-oouHD7+1tyRcmWTeJ8YFw@mail.gmail.com>
 <20140129111557.GI16215@pengutronix.de>
Message-ID: <201401291553.15040.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 29, 2014 at 12:15:57 PM, Sascha Hauer wrote:
> Hi Christian,
> 
> On Tue, Jan 28, 2014 at 09:11:32AM +0100, Christian Gmeiner wrote:
> > Hi all.
> > 
> > From time to time it happens that my LVDS display is flickering (look
> > at scroll bar in the video).
> > https://drive.google.com/file/d/0B_fznDimUHVubWtvVFlMTkdBbUU/edit?usp=sha
> > ring
> > 
> > I really want to find the root cause of it, but I do not know where to
> > start. I can trigger this
> > sometimes after xscreensever "blanks" the screen and the screensafer
> > gets disabled
> > via user input.
> > 
> > Any hints?
> 
> Sorry, no idea. Philipp and me watched the video, but we both haven't
> seen something like this before.

Isn't it the clock polarity being inverted thing again [1]?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-
December/215536.html

The easiest way to check this would be to try sig_cfg.clk_pol = 0 or = 1 and see 
if it changes anything.

Best regards,
Marek Vasut
