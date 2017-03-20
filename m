From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Mar 2017 15:00:55 +0000
Subject: [PATCH 17/17] arm64: arch_timer: Add HISILICON_ERRATUM_161010101
 ACPI matching data
In-Reply-To: <13e4473e-e1ec-c193-4d5a-63787d149dda@linaro.org>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170306112622.13853-18-marc.zyngier@arm.com>
 <13e4473e-e1ec-c193-4d5a-63787d149dda@linaro.org>
Message-ID: <20170320150055.GJ31213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 09:19:21PM +0800, Hanjun Guo wrote:
> On 2017/3/6 19:26, Marc Zyngier wrote:
> >In order to deal with ACPI enabled platforms suffering from the
> >HISILICON_ERRATUM_161010101, let's add the required OEM data that
> >allow the workaround to be enabled.
> >
> >Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >---
> > drivers/clocksource/arm_arch_timer.c | 29 +++++++++++++++++++++++++++++
> > 1 file changed, 29 insertions(+)
> >
> >diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> >index 6182871af4eb..b46584f058b6 100644
> >--- a/drivers/clocksource/arm_arch_timer.c
> >+++ b/drivers/clocksource/arm_arch_timer.c
> >@@ -270,6 +270,25 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
> > {
> > 	return __hisi_161010101_read_reg(cntvct_el0);
> > }
> >+
> >+static struct ate_acpi_oem_info hisi_161010101_oem_info[] = {
> >+	{
> >+		.oem_id		= "HISI  ",
> >+		.oem_table_id	= "HIP05   ",
> >+		.oem_revision	= 0,
> >+	},
> >+	{
> >+		.oem_id		= "HISI  ",
> >+		.oem_table_id	= "HIP06   ",
> >+		.oem_revision	= 0,
> >+	},
> >+	{
> >+		.oem_id		= "HISI  ",
> >+		.oem_table_id	= "HIP07   ",
> >+		.oem_revision	= 0,
> >+	},
> >+	{ },
> 
> Maybe it's better to add a comments that to say "It's needed to match
> the end of oem info", but it's up to you :)

Indeed. A comment as to why the sapces are necessary would be very
helpful.

Thanks,
Mark.
