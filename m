From: d.cristiani@idem-tech.it (Dylan Cristiani)
Date: Fri, 1 Oct 2010 17:37:06 +0200
Subject: PXA270 linux-2.6.35.7 boot hang
In-Reply-To: <AANLkTi=JEUbxmTZ6PHbz_Gi7KvNf+KJat7R1ot5LQ1SH@mail.gmail.com>
References: <AANLkTim4HqQkT0uZTpsGCsFqObVA+v+Q7wHekGp5V+f3@mail.gmail.com>
	<AANLkTi=JEUbxmTZ6PHbz_Gi7KvNf+KJat7R1ot5LQ1SH@mail.gmail.com>
Message-ID: <20101001173706.00006c12@unknown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Oct 2010 21:53:14 +0800
Eric Miao <eric.y.miao@gmail.com> wrote:

> On Fri, Oct 1, 2010 at 6:33 PM, Santhosh N <san.mlists@gmail.com>
> wrote:
> > Hi,
> >
> > I am porting the latest linux kernel 2.6.35.7 on our PXA270 board.
> > The kernel starts booting and stops at:
> > Uncompressing Linux... done, booting the kernel.
> >
> > I can run the linux kernel 2.6.26 on the same board without any
> > issues. I am passing the boot args as:
> > bootargs=console=ttyS2,460800 rw root=1f02
> >
> > The STUART is used as the debug serial port. I had to change the
> > uart_base to STUART in arch/arm/mach-pxa/include/mach/uncompress.h
> > to get ?"Uncompressing Linux... done, booting the kernel.".
> >
> > I have set also set CONFIG_SERIAL_PXA_CONSOLE=y.
> >
> > Can anyone tell if I am missing something?
> >
> 
> There could be many reasons. But you may want to turn on DEBUG_LL
> and earlyprintk for some early diagnostic messages. You got
> "Uncompress ..." messages so I assume the UART is setup correctly to
> this weird 460800 baudrate (though I doubt STUART on PXA27x is able
> to do that)
i agree with Eric but i remember that the maximum baud rate is 921,600
bps for all S-FF-BTUART pxa's uarts; maybe you can try also to migrate
from working kernel 2.6.26 to 2.6.27.... and so on, to see when it
first hangs, then seeing what was changed, with relation with
your specific cpu and/or platform, could be the trick.
