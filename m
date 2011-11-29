From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 07:11:03 +0100
Subject: [V2 3/3] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <CAN1soZx=9DeyGT_n7+LWwWKVh91wZ4E=9stqSo+5rupR7-wAAQ@mail.gmail.com>
References: <1322445892-22620-1-git-send-email-jtzhou@marvell.com>
 <20111129045550.GQ15008@game.jcrosoft.org>
 <CAN1soZx=9DeyGT_n7+LWwWKVh91wZ4E=9stqSo+5rupR7-wAAQ@mail.gmail.com>
Message-ID: <20111129061103.GS15008@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:37 Tue 29 Nov     , Haojian Zhuang wrote:
> On Tue, Nov 29, 2011 at 12:55 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 10:04 Mon 28 Nov ? ? , Jett.Zhou wrote:
> >> Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
> >> almost the same, so re-arch the rtc-sa1100 to support them.
> >>
> >> Change-Id: I006271045a21d0e42a8e52c1e43c98c559d76909
> >> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
> >> ---
> >> ?arch/arm/mach-pxa/devices.c ? ?| ? 20 +++
> >> ?arch/arm/mach-sa1100/generic.c | ? 20 +++
> >> ?drivers/rtc/Kconfig ? ? ? ? ? ?| ? ?2 +-
> >> ?drivers/rtc/rtc-sa1100.c ? ? ? | ?273 ++++++++++++++++++++++++++++------------
> >> ?4 files changed, 236 insertions(+), 79 deletions(-)
> >>
> >> + ? ? if (sa1100_rtc->id == RTC_MMP) {
> >> + ? ? ? ? ? ? sa1100_rtc->clk = clk_get(&pdev->dev, "MMP-RTC");
> >> + ? ? ? ? ? ? if (IS_ERR(sa1100_rtc->clk)) {
> >> + ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to find rtc clock source\n");
> >> + ? ? ? ? ? ? ? ? ? ? ret = PTR_ERR(sa1100_rtc->clk);
> >> + ? ? ? ? ? ? ? ? ? ? goto err_clk;
> >> + ? ? ? ? ? ? }
> >> + ? ? ? ? ? ? clk_prepare(sa1100_rtc->clk);
> >> + ? ? ? ? ? ? clk_enable(sa1100_rtc->clk);
> > provide the clk in both case as done macb or arm timer
> > so you can drop the RTC_MMP
> >
> Hi Jean,
> 
> It's a good advice. Our current changes doesn't touch the key logic of
> sa1100, and we verify the change in MMP device. But sa1100 doesn't
> support clk since it's too old, and we're lack of sa1100 device to
> verify. So we didn't implement clk in sa1100. If there's a volunteer
> to test, we can implement clk in sa1100. What's your opinion?
sa1100 do support clock
and switch is to clkdev will no too difficult

just provide a fake one

and maybe Russell or Nicolas still have a sa11xx

Best Regards,
J.
