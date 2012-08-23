From: jason77.wang@gmail.com (Hui Wang)
Date: Thu, 23 Aug 2012 10:47:41 +0800
Subject: [PATCH] ARM: fix cpu_relax() in case of doing dmb
In-Reply-To: <1345647138-8815-1-git-send-email-shawn.guo@linaro.org>
References: <1345647138-8815-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <503599CD.4060907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> There is an issue reported on imx6q restart function.  The issue is only
> seen with the image building ARMv7 and ARMv6 together, where cpu_relax()
> is define to do dmb.  It's been root-caused by Russell as below.
>
> Russell King - ARM Linux wrote:
>   
>> I suspect having this dmb inside cpu_relax() is flooding the
>> interconnects with traffic, which then prevents other CPUs getting
>> a look-in (maybe there's no fairness when it comes to dmb's.
>>     
>
> Fix the issue by insert a few NOPs into cpu_relax() where doing dmb.
>   
Tested-by: Hui Wang <jason77.wang@gmail.com>
