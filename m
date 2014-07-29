From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Jul 2014 13:22:54 +0100
Subject: [PATCH v15 07/12] ARM: dts: append hip04 dts
In-Reply-To: <CAD6h2NSbx_UOBkHFH=yba1cgyd+qLrog5Dpt_NQXg2FSuYCAyQ@mail.gmail.com>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-8-git-send-email-haojian.zhuang@linaro.org>
 <20140728180609.GE2576@leverpostej>
 <CAD6h2NQLgB1=8+WznE19rjsFwm3XWPUYEbDuPCbKbWjseRCBDg@mail.gmail.com>
 <20140729035321.GA8430@quad.lixom.net>
 <20140729111213.GE9245@arm.com>
 <CAD6h2NRuOe9piWOTU7xoaD-0DOceq20SD-XCqygLyQUFVCnsNQ@mail.gmail.com>
 <20140729121300.GH9245@arm.com>
 <CAD6h2NSbx_UOBkHFH=yba1cgyd+qLrog5Dpt_NQXg2FSuYCAyQ@mail.gmail.com>
Message-ID: <20140729122254.GJ9245@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 01:15:45PM +0100, Haojian Zhuang wrote:
> On 29 July 2014 20:13, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jul 29, 2014 at 12:32:09PM +0100, Haojian Zhuang wrote:
> >> On 29 July 2014 19:12, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Tue, Jul 29, 2014 at 04:53:21AM +0100, Olof Johansson wrote:
> >> >> On Tue, Jul 29, 2014 at 10:44:40AM +0800, Haojian Zhuang wrote:
> >> >> > Because I didn't get these materials yet. All clocks are enabled in bootloader.
> >> >>
> >> >> What materials? Technical documentation for the CPU you're upstreaming?
> >> >>
> >> >> It seems like a very bad idea to upstream a DT for a CPU that you don't
> >> >> have documentation for. It seems appropriate to wait until you have
> >> >> documentation so you can make sure that the hardware you're describing
> >> >> is actually what is there, and not something made-up or misdescribed.
> >> >
> >> > I completely agree. Furthermore, given that this SoC implements a dodgy
> >> > custom GIC, I don't think it's unreasonable for us to ask for documentation
> >> > describing that too, otherwise it's going to make maintaining a complicated
> >> > irqchip driver that much worse.
> >> >
> >> I don't have enough documents on clocks. And all clocks are already
> >> enabled in UEFI. There're also no requirement on change the clock
> >> frequency & disable them. So I set all these clocks as fixed rate.
> >>
> >> It's different from GIC. If I don't have documents on GIC, I can't
> >> write code for HIP04 GIC. HiP04 GIC supports 16-cores. ARM GICv2
> >> supports 8-cores. So some registers offsets and bit fields are
> >> different from GICv2.
> >
> > Sure, and I'm asking for those documents to be made publicly available
> > somewhere so that we can refer to them if we need to change this code in
> > future.
> >
> I can send the copy to you since it's already public. But the main
> issue is that this document is written in Chinese. I hope it could be
> written in English.

Any chance of a translation, please? The ARM GIC spec is available in
English, which is largely the language in which the kernel is developed.

Will
