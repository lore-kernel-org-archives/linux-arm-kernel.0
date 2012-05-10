From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 10 May 2012 21:19:47 +0800
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <1336647530.15424.384.camel@vkoul-udesk3>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
 <20120510074403.GA3190@n2100.arm.linux.org.uk>
 <1336647530.15424.384.camel@vkoul-udesk3>
Message-ID: <CAMiH66E4Cb5LTi3EiU5HQ6492ZA-mD40eFZaaqmbC7hTz-aQxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 6:58 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Thu, 2012-05-10 at 08:44 +0100, Russell King - ARM Linux wrote:
>> In fact, please look at both imx-dma.c _and_ imx-sdma.c - search for
>> "callback" and have a look at the code around there.
>>
>> You will find that imx-dma.c processes one descriptor per tasklet run,
>> and calls the callback under a spinlock.
>>
>> You'll find that imx-sdma.c always calls callbacks from IRQ context.
> Yup, let me try to fix them!
>
I ever sent you a patch to fix it.

Best Regards
Huang Shijie

> --
> ~Vinod
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
