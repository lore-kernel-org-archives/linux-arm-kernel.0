From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 11 Jan 2012 09:47:30 +0800
Subject: [PATCH 6/6] dma/imx-sdma: check whether event_id0 < 32 when set
 event_mask
In-Reply-To: <20120111005322.GB2414@b20223-02.ap.freescale.net>
References: <1326178910-14044-1-git-send-email-richard.zhao@linaro.org>
 <1326178910-14044-6-git-send-email-richard.zhao@linaro.org>
 <20120110142008.GE26599@S2101-09.ap.freescale.net>
 <20120110142939.GB2019@richard-laptop>
 <20120110153836.GA27831@S2101-09.ap.freescale.net>
 <20120111005322.GB2414@b20223-02.ap.freescale.net>
Message-ID: <20120111014730.GE2414@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 08:53:23AM +0800, Richard Zhao wrote:
> On Tue, Jan 10, 2012 at 11:38:39PM +0800, Shawn Guo wrote:
> > On Tue, Jan 10, 2012 at 10:29:42PM +0800, Richard Zhao wrote:
> > > On Tue, Jan 10, 2012 at 10:20:10PM +0800, Shawn Guo wrote:
> > > > On Tue, Jan 10, 2012 at 03:01:50PM +0800, Richard Zhao wrote:
> > > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > > > ---
> > > > 
> > > > I think it deserves a sensible commit message explaining why the patch
> > > > is needed.
> > > If event_id0 < 32, 1 << (sdmac->event_id0 - 32) is not zero.
> This meant to make you clear about the patch. I'll add it in commit
> message.
unsigned int t = 31;
printf("%d %08x\n", t, 1 << (t-32));

I test above code on both x86 and arm. They shows different results.
x86: 31 80000000
arm: 31 00000000

I think we still need this patch. we shoud not let it depends on gcc's
behavior.

Thanks
Richard
> > > 
> > My point is you may explain the exact problem you are seeing without
> > this patch
> The kernel don't have event_id < 32 case yet. I found the bug when
> I review the code.
> > and how the patch helps here.  In general, doing so would
> > win a warm feeling from reviewers much more easily than leaving the
> > commit message empty there.
> I understand your point that comment as much as possible.
> 
> Thanks
> Richard
> > 
> > -- 
> > Regards,
> > Shawn
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
