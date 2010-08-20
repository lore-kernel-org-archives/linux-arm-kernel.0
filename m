From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Aug 2010 16:10:01 +0900
Subject: [PATCH 02/14] ARM: S5PV310: Removed unused clock
In-Reply-To: <AANLkTinjDBxahumErXmXXDW2FLxFi6oXpu-jZa+xzYhF@mail.gmail.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
	<1282140084-10265-3-git-send-email-kgene.kim@samsung.com>
	<AANLkTinjDBxahumErXmXXDW2FLxFi6oXpu-jZa+xzYhF@mail.gmail.com>
Message-ID: <00b201cb4036$b7e1c7b0$27a55710$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> Hello,
> 
Hi :-)

> On Wed, Aug 18, 2010 at 11:01 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This pach removed unused clock on S5PV310/S5PC210.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> In this patch, you've removed corem0, corem1, cores, periph, atclk,
> and pclk_dbg, which are directly affected by cpu-freq drivers. As long
> as CPUFREQ uses clocks under 800MHz, corem0, corem1, cores, and
> periph's dividers should be updated and as long as CPUFREQ uses clocks
> over 800MHz, atclk and pclk_dbg's dividers should also be updated.
> Although in the cpu-freq patches of S5PV210, the cpu-freq driver did
> not use the clock framework and accessed clock registers directly, I
> thought cpu-freq should consider using the clock framework later as,
> sometimes, other drivers and modules are interested in the values
> related with this domain (e.g., for the stability issues,
> suspend-to-mem/disk may want to read and save the clock rates of CPU).
> 
> Do you think CPUFREQ should keep accessing the clock registers
> directly? or should start using clock frameworks later?
> 
> ps. If we are going to change the bus speed as well (as in S5PV210's
> 100MHz mode), we may need to access aclk_cored, aclk_corep, and
> aclk_acp as well.
> 

Basically, no need to control them when changed frequency because can be restored original value.
But I think need to check it again.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
