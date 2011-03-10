From: davidb@codeaurora.org (David Brown)
Date: Thu, 10 Mar 2011 12:06:59 -0800
Subject: [PATCH 0/4] SCM fixes and updates
In-Reply-To: <4D77D502.1090606@codeaurora.org> (Stephen Boyd's message of
	"Wed, 09 Mar 2011 11:29:06 -0800")
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<4D77D502.1090606@codeaurora.org>
Message-ID: <8yay64magf0.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09 2011, Stephen Boyd wrote:

> On 02/24/2011 10:44 AM, Stephen Boyd wrote:
>> These are a few updates to SCM. The first two patches fix some
>> bad code generation. The next patch saves a couple instructions
>> on the slow path and the final patch determines the cacheline
>> size dynamically instead of statically.
>>
>> Stephen Boyd (4):
>>   msm: scm: Mark inline asm as volatile
>>   msm: scm: Fix improper register assignment
>>   msm: scm: Check for interruption immediately
>>   msm: scm: Get cacheline size from CTR
>
> Can we queue up patches 1 to 3 from this series for the next window? It
> looks like everyone is ok with them. I'll respin the fourth patch once I
> figure out where to go with it.

Seems reasonable to me.  I'll break the first three out and include them
into msm-next.

Stephen Boyd (3):
  msm: scm: Mark inline asm as volatile
  msm: scm: Fix improper register assignment
  msm: scm: Check for interruption immediately

 arch/arm/mach-msm/scm.c |   58 ++++++++++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 26 deletions(-)

I have pulled these changes into my MSM tree, which can be
found at

  git://codeaurora.org/quic/kernel/davidb/linux-msm.git

in the for-next branch

This patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The path will hopefully also be merged in Linus' tree for the next
-rc kernel release.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
