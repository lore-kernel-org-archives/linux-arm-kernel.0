From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 20 Feb 2013 17:09:18 -0600
Subject: [PATCH] staging: imx/drm: request irq only after adding the crtc
In-Reply-To: <1361284559-25125-1-git-send-email-p.zabel@pengutronix.de>
References: <1361284559-25125-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAKGA1bmFubywyW=t86P_O3YXqzKoboa0xLQvFFQaDqUcaMBX-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 8:35 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> If the bootloader already enabled the display, the interrupt handler
> will be called as soon as it is registered. If the CRTC is not already
> added at this time, the call to imx_drm_handle_vblank will result in
> a NULL pointer dereference.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Doesn't this imply that the bootloader doesn't properly quiesce all
interrupt-causing modules and halt all dma operations?

Sean Bean said it best: One does not simply walk into Mordor!

I am not nacking the patch (since it would not change behavior at all
for those scenarios where quiescence of interrupts and dma was done
properly before the handover) but I am really unsure that this sets a
good precedent.. is this all about getting a "glitch free" splash
screen displayed between bootloader and kernel?

--
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
