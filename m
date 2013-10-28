From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Oct 2013 10:50:47 +0800
Subject: [PATCH v3 5/5] ARM: dts: imx28: changing usb compatible string
 as only "fsl,imx28-usb"
In-Reply-To: <20131028015926.GB31499@shlinux1.ap.freescale.net>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
 <1382680943-9258-5-git-send-email-peter.chen@freescale.com>
 <20131025082330.GA13790@S2101-09.ap.freescale.net>
 <20131025081429.GA10442@shlinux1.ap.freescale.net>
 <20131025084607.GC13790@S2101-09.ap.freescale.net>
 <20131028015926.GB31499@shlinux1.ap.freescale.net>
Message-ID: <20131028025046.GC2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 09:59:27AM +0800, Peter Chen wrote:
> hmm, before of_match_device gets improved or it is well documented,
> how user knows to organize device_id table.

Just like you, you found it after you saw that of_match_device() does
not return you the expected device :)

> 
> > > Since the imx28-usb is not compatible with imx27-usb,
> > > we'd better only keep "fsl, imx28-usb" compatible string at imx28 dtsi.
> > 
> > From hardware point of view, the USB block on imx28 *is* inherited from
> > imx27, and compatible to imx27 USB block, even though we have a little
> > difference to handle in software.  The compatible string is written in
> > this way at the first place exactly for the reason we can save such
> > DTS change when we have some little incompatibility to handle.
> > 
> 
> OK, I agree, then the of_match_device really should be improved to get
> above purpose.

Yes, there is already patch for that but it just hasn't found its way
to mainline because it causes some issue on SPARC.

> BTW, any reasons why esdhc has different compatible string
> for every SoCs?

Mostly because the hardware design sucks.  There so many register
differences and bugs to deal with between difference SoCs.

Shawn
