From: phorton@bitbox.co.uk (Peter Horton)
Date: Wed, 15 Dec 2010 09:35:42 +0000
Subject: [PATCH RFC] i.MX51 Framebuffer support
In-Reply-To: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4D088BEE.3030709@bitbox.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2010 13:47, Sascha Hauer wrote:
>
> The following series adds i.MX51 framebuffer support based on the IPUv3. It
> is not perfect but I decided it is good enough to open it for a wider audience
> and collect first reviews. I tested this on a babbage board using both outputs
> (VGA/DVI) with different resolutions up to 1680x1050 and different colour depths.
> I also tested it on one custom board using a fixed display setting.
>

Good stuff, almost works here :)

Custom board with an HDMI bridge hooked to DI0.

About 50% of power ups fail to show a display because the DE signal is 
bogus. It appears to be correct for the active window but remains active 
for the vertical blanking period. If the DE signal is correct we get a 
good display. I've tried investigating but the IPU section of the manual 
is unfathomable (and that's just the section on the waveform generator).

Resizing the display to a larger size sometimes shows a square of solid 
colour on the display, hardware cursor perhaps ?

Every now and then changing the video mode causes the kernel to hang 
hard. Unfortunately this is not very reproduceable.

P.
