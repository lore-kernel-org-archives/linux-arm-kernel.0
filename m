From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 4 Aug 2014 22:01:50 -0400 (EDT)
Subject: [PATCH v16 2/9] ARM: hisi: enable MCPM implementation
In-Reply-To: <CAD6h2NT_yYsDbCTYqgUEjJRcRQ9981Vx=T4yg4EW3ud=RMxPLA@mail.gmail.com>
References: <1407121088-4151-1-git-send-email-haojian.zhuang@linaro.org>
 <1407121088-4151-3-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1408041741460.6061@knanqh.ubzr>
 <CAD6h2NTFJ0qBdymhQ1bEaKpCTQT13r2-F9HRDw9SdSS31Zer8w@mail.gmail.com>
 <alpine.LFD.2.11.1408042101360.6061@knanqh.ubzr>
 <CAD6h2NSs7epwgtH29sjQ37nLZroLJK-+1aqY52JcUg8Y2fXcpw@mail.gmail.com>
 <alpine.LFD.2.11.1408042122480.6061@knanqh.ubzr>
 <CAD6h2NT_yYsDbCTYqgUEjJRcRQ9981Vx=T4yg4EW3ud=RMxPLA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1408042153350.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Aug 2014, Haojian Zhuang wrote:

> On 5 August 2014 09:32, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 5 Aug 2014, Haojian Zhuang wrote:
> >
> >> On 5 August 2014 09:02, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> > On Tue, 5 Aug 2014, Haojian Zhuang wrote:
> >> >
> >> >> On 5 August 2014 06:43, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> >> > Sorry for the delay -- I was on vacation.
> >> >> >
> >> >> > On Mon, 4 Aug 2014, Haojian Zhuang wrote:
> >> >> >
> >> >> >> Multiple CPU clusters are used in Hisilicon HiP04 SoC. Now use MCPM
> >> >> >> framework to manage power on HiP04 SoC.
> >> >> >>
> >> >> >> Changelog:
> >> >> >> v16:
> >> >> >>   * Parse bootwrapper parameters in command line instead.
> >> >> >
> >> >> > What is that about?  I don't particularly like to see bootloader
> >> >> > handshake details passed to the kernel via the kernel command line
> >> >> > mechanism.  Given this looks like special memory regions, can't they be
> >> >> > specified via the device tree instead?
> >> >> >
> >> >>
> >> >> Others don't agree put them into DTS file. So I move them into command line.
> >> >
> >> > Could you give me a pointer to the discussion around that please?
> >> >
> >> >
> >> > Nicolas
> >>
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275944.html
> >>
> >> Mark challenged what's relationship between bootwrapper address and
> >> system controller.
> >
> > There is no relation, obviously.  Hence this doesn't belong in the
> > system controller node.  That doesn't mean it should not be in DT at
> > all.
> >
> >> Actually code in bootwrapper is like trampoline. And it's a software
> >> protocol, not hardware description. So I moved them into command line
> >> instead.
> >
> > There are many examples for software protocols being specified in DT
> > already.  The first that comes to my mind is the "boot method = spin
> > table" which has nothing to do with hardware.  PSCI bindings are about
> > another software-only thing.
> >
> >
> > Nicolas
> 
> bootwrapper {
>         compatible = "hisilicon,hip04-bootwrapper";
>         boot-method = <0x10c00000, 0x10000, 0xa5a5a5a5, 0xe0000100, 0x1000>;
> };
> 
> I changed them into this format. Could you help to review?

Unfortunately I'm not really knowledgeable about best device tree syntax 
and practices.  You'll have to nag someone else for reviewing this.

One thing though, do you really need to put some magic number there?  Is 
it likely to change?  If not this could be hardcoded in the code and 
only describe the special memory region in DT.


Nicolas
