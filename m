From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 3 Oct 2010 05:42:21 +0200
Subject: PXA270 linux-2.6.35.7 boot hang
In-Reply-To: <20101001173706.00006c12@unknown>
References: <AANLkTim4HqQkT0uZTpsGCsFqObVA+v+Q7wHekGp5V+f3@mail.gmail.com>
	<AANLkTi=JEUbxmTZ6PHbz_Gi7KvNf+KJat7R1ot5LQ1SH@mail.gmail.com>
	<20101001173706.00006c12@unknown>
Message-ID: <201010030542.22204.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 1. ??jna 2010 17:37:06 Dylan Cristiani napsal(a):
> On Fri, 1 Oct 2010 21:53:14 +0800
> 
> Eric Miao <eric.y.miao@gmail.com> wrote:
> > On Fri, Oct 1, 2010 at 6:33 PM, Santhosh N <san.mlists@gmail.com>
> > 
> > wrote:
> > > Hi,
> > > 
> > > I am porting the latest linux kernel 2.6.35.7 on our PXA270 board.
> > > The kernel starts booting and stops at:
> > > Uncompressing Linux... done, booting the kernel.
> > > 
> > > I can run the linux kernel 2.6.26 on the same board without any
> > > issues. I am passing the boot args as:
> > > bootargs=console=ttyS2,460800 rw root=1f02
> > > 
> > > The STUART is used as the debug serial port. I had to change the
> > > uart_base to STUART in arch/arm/mach-pxa/include/mach/uncompress.h
> > > to get  "Uncompressing Linux... done, booting the kernel.".
> > > 
> > > I have set also set CONFIG_SERIAL_PXA_CONSOLE=y.
> > > 
> > > Can anyone tell if I am missing something?
> > 
> > There could be many reasons. But you may want to turn on DEBUG_LL
> > and earlyprintk for some early diagnostic messages. You got
> > "Uncompress ..." messages so I assume the UART is setup correctly to
> > this weird 460800 baudrate (though I doubt STUART on PXA27x is able
> > to do that)
> 
> i agree with Eric but i remember that the maximum baud rate is 921,600
> bps for all S-FF-BTUART pxa's uarts; maybe you can try also to migrate
> from working kernel 2.6.26 to 2.6.27.... and so on, to see when it
> first hangs, then seeing what was changed, with relation with
> your specific cpu and/or platform, could be the trick.

You can send me a sample board, one more into collection never hurts :-D

btw. as Eric pointed out already (and according to brief look at Table 212 ... 
or am I missing something), the baudrate setting looks suspicious. What setting 
do you use in U-Boot (I believe you use U-Boot by seeing "bootargs=").

Also, what serial port do you use in U-Boot ? (grep UART 
include/configs/yourboard.h ; grep BAUD include/configs/yourboard.h)

Also, what U-Boot do you use (and from where) ?

Cheers
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
