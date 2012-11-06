From: lznuaa@gmail.com (Frank Li)
Date: Tue, 6 Nov 2012 09:36:39 +0800
Subject: [PATCH 4/4] FEC: Add time stamping code and a PTP hardware clock
In-Reply-To: <20121102091902.GA3437@netboy.at.omicron.at>
References: <1351657531-25989-1-git-send-email-Frank.Li@freescale.com>
 <20121102091902.GA3437@netboy.at.omicron.at>
Message-ID: <CAHrpEqQsOj-m6QGr6URhOQfkdUxL8jkZUnA0ssZG3jG6zRvZjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +       Say Y here if you want to use PTP Hardware Clock (PHC) in the
>> +       driver.  Only the basic clock operations have been implemented.
>> +
>
> Does the PTP function work with every FEC on ColdFire and i.MX?

No, I just test i.MX.

>
> Or do you need to limit this option in some way?

Okay, I will do that at new patch because this patch have been accepted.

>
> You can reduce the time that the spin lock is held by moving the next
> four lines before the locked region:
>
>> +     fep->cc.mult = FEC_CC_MULT;
>> +     diff = fep->cc.mult;
>> +     diff *= ppb;
>> +     diff = div_u64(diff, 1000000000ULL);
>

Okay, I will do that at new patch and fix a bug when two boards
directly connect at 1G mode.
