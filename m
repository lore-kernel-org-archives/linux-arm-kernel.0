From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Apr 2016 14:55:13 +0100
Subject: [PATCH v2 2/2] arm64: vhe: Verify CPU Exception Levels
In-Reply-To: <570F931A.7020103@arm.com>
References: <1460472361-28419-2-git-send-email-suzuki.poulose@arm.com>
 <1460554893-26120-1-git-send-email-suzuki.poulose@arm.com>
 <20160414121947.GK30804@cbox> <570F931A.7020103@arm.com>
Message-ID: <20160415135513.GJ22906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 01:54:50PM +0100, Suzuki K Poulose wrote:
> On 14/04/16 13:19, Christoffer Dall wrote:
> >On Wed, Apr 13, 2016 at 02:41:33PM +0100, Suzuki K Poulose wrote:
> 
> >>diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> >>index b2d5f4e..e97af155 100644
> >>--- a/arch/arm64/kernel/smp.c
> >>+++ b/arch/arm64/kernel/smp.c
> >>@@ -75,6 +75,43 @@ enum ipi_msg_type {
> >>  	IPI_WAKEUP
> >>  };
> >>
> >>+#ifdef CONFIG_ARM64_VHE
> >>+
> >>+/* Whether the boot CPU is running in HYP mode or not*/
> >>+bool boot_cpu_hyp_mode;
> >
> >you can make this static now.
> 
> Ah ! Good catch.
> 
> 
> >
> >Otherwise,
> >
> >Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks. I'll queue both of those with the static change and
Christoffer's ack.

Will
