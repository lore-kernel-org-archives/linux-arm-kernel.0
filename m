From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 21 Feb 2013 08:10:31 +0100
Subject: [PATCH] staging: imx/drm: request irq only after adding the crtc
In-Reply-To: <CAKGA1bmFubywyW=t86P_O3YXqzKoboa0xLQvFFQaDqUcaMBX-Q@mail.gmail.com>
References: <1361284559-25125-1-git-send-email-p.zabel@pengutronix.de>
 <CAKGA1bmFubywyW=t86P_O3YXqzKoboa0xLQvFFQaDqUcaMBX-Q@mail.gmail.com>
Message-ID: <20773.51303.693814.857398@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Matt Sealey writes:
> On Tue, Feb 19, 2013 at 8:35 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > If the bootloader already enabled the display, the interrupt handler
> > will be called as soon as it is registered. If the CRTC is not already
> > added at this time, the call to imx_drm_handle_vblank will result in
> > a NULL pointer dereference.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Doesn't this imply that the bootloader doesn't properly quiesce all
> interrupt-causing modules and halt all dma operations?
> 
> Sean Bean said it best: One does not simply walk into Mordor!
> 
> I am not nacking the patch (since it would not change behavior at all
> for those scenarios where quiescence of interrupts and dma was done
> properly before the handover) but I am really unsure that this sets a
> good precedent.. is this all about getting a "glitch free" splash
> screen displayed between bootloader and kernel?
> 
IMO its more about defensive programming. Registering an interrupt
handler only after everything that the handler needs has been
initialized is a Good Thing(TM), no matter whether the interrupt could
possibly occur or not.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
