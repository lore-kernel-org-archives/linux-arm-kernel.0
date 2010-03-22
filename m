From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 22 Mar 2010 14:06:53 +0100
Subject: [PATCH] Voipac PXA270: UDC and UHC support
In-Reply-To: <f17812d71003212104i2fd2fec6n1db149f23424f3aa@mail.gmail.com>
References: <201003100543.00221.marek.vasut@gmail.com>
	<201003220428.49585.marek.vasut@gmail.com>
	<f17812d71003212104i2fd2fec6n1db149f23424f3aa@mail.gmail.com>
Message-ID: <201003221406.53658.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 22. b?ezna 2010 05:04:28 Eric Miao napsal(a):
> On Mon, Mar 22, 2010 at 11:28 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Dne Po 22. b?ezna 2010 02:57:33 Eric Miao napsal(a):
> >> >> +static void vpac270_udc_command(int cmd)
> >> >> +{
> >> >> +     if (cmd == PXA2XX_UDC_CMD_CONNECT)
> >> >> +             UP2OCR |= UP2OCR_HXOE | UP2OCR_DPPUE | UP2OCR_DPPUBE;
> >> >> +     else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
> >> >> +             UP2OCR &= ~(UP2OCR_HXOE | UP2OCR_DPPUE |
> >> >> UP2OCR_DPPUBE);
> >> >
> >> > In the "DISCONNECT" case, you reset UP2OCR_HXOE, meaning the usb port
> >> > isn't a USB Device anymore (neither a USB host). If that's on purpose,
> >> > then all good, in the other case, don't reset that one.
> >>
> >> Marek??
> >
> > I wasn't able to get it running without reseting the HXOE (so it's there
> > based on my tests with the hardware). I'll have to investigate it
> > properly when I have more time.
> >
> > So Eric, could you push this in? I'll send a fix if I figure out
> > something's wrong here.
> 
> Could you modify the patch a bit to leave a NOTE there in the
> commit message so we can track? As well as Robert's reviewed-by.
> Thanks.
> 
Updated patch included
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-Voipac-PXA270-UDC-and-UHC-support.patch
Type: text/x-patch
Size: 4421 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100322/f9f50e9e/attachment.bin>
