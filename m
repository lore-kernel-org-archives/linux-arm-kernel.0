From: agross@codeaurora.org (Andy Gross)
Date: Fri, 7 Aug 2015 12:30:31 -0500
Subject: next-20150807 build: 2 failures 51 warnings (next-20150807)
In-Reply-To: <20150807122344.GT20873@sirena.org.uk>
References: <E1ZNgYS-0000SE-QL@optimist> <20150807122344.GT20873@sirena.org.uk>
Message-ID: <20150807173031.GA25070@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 01:23:44PM +0100, Mark Brown wrote:
> On Fri, Aug 07, 2015 at 01:15:20PM +0100, Build bot for Mark Brown wrote:
> 
> Today's linux-next fails to build an arm64 allmodconfig with:
> 
> > 	arm64-allmodconfig
> > ../drivers/firmware/qcom_scm-32.c:27:28: fatal error: asm/outercache.h: No such file or directory
> 
> This header file only exists on ARM, either the driver shouldn't be
> built for ARMv8, we need a dummy header for ARMv8 or we need to use the
> header conditionally in the driver.

Right.  We're right in the middle of pulling together SCM for 64 bit.  I think
for now, perhaps I should just send in a stubbed out placeholder for ARMV8 SCM
and then fill it in once we get that patch set reworked (previously sent by
Kumar Gala).

I'll add that to my branch today and it should resolve our next builds.  I'll
send it to arm/soc in a fixes pull request.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
