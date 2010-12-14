From: shawn.gsc@gmail.com (Shawn Guo)
Date: Tue, 14 Dec 2010 21:00:40 +0800
Subject: [PATCH v6 00/15] ARM: mxs: Add initial support for MX23 andMX28
In-Reply-To: <20101214083109.GB1913@ubuntu.localdomain>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<20101213142045.GD26210@pengutronix.de>
	<20101214083109.GB1913@ubuntu.localdomain>
Message-ID: <AANLkTikW13zwEqrgvtpR-eUPR=ehaUFO5=LYq5bPCn_6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/14 Shawn Guo <shawn.guo@freescale.com>:
[...]
>> ?- on TIMROTv1 there is no HW_TIMROT_RUNNING_COUNTn register. ?That's
>> ? ?called HW_TIMROT_TIMCOUNTn.
> I'm reusing the offset definition here. But it seems you are asking
> two definitions to avoid confusion.
>
>> ?- Typo in comment above timrot_is_v1: MX23 uses timers 0 and 1, too.
> It's a typo, but partially. mx28 uses timrot 0 and 1, while mx23 uses
> 0 and 2. There are 4 registers for each timrot instance on mx28,
> but only 2 on mx23. So address step 0x40 in HW_TIMROT_TIMCTRLn strides
> one instance on mx28 while two instances on mx23. Confusion again,
> adding more definitions, right?
>
I'm not going to argue the first one, since HW_TIMROT_RUNNING_COUNTn
is being used in functions that are already separated for v1 and v2.
But for HW_TIMROT_TIMCTRLn, it's being used in shared codes/functions.
Can we keep the trick and add more comments on that to save some codes
duplication?

-- 
Regards,
Shawn
