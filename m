From: davem@davemloft.net (David Miller)
Date: Mon, 04 Feb 2013 00:24:10 -0500 (EST)
Subject: [PATCH 1/1] net: fec: fix miss init spinlock
In-Reply-To: <CAHrpEqSLx-J-1SYC6OapqidY+U3acnTmNyOj8UrNRZwYZRXCoQ@mail.gmail.com>
References: <1359708986-23634-1-git-send-email-Frank.Li@freescale.com>
 <20130202.230851.809969826800130930.davem@davemloft.net>
 <CAHrpEqSLx-J-1SYC6OapqidY+U3acnTmNyOj8UrNRZwYZRXCoQ@mail.gmail.com>
Message-ID: <20130204.002410.508273179967651174.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <lznuaa@gmail.com>
Date: Mon, 4 Feb 2013 10:22:23 +0800

> 2013/2/3 David Miller <davem@davemloft.net>:
>> From: Frank Li <Frank.Li@freescale.com>
>> Date: Fri, 1 Feb 2013 16:56:26 +0800
>>
>>> @@ -1607,6 +1607,7 @@ static int fec_enet_init(struct net_device *ndev)
>>>       }
>>>
>>>       spin_lock_init(&fep->hw_lock);
>>> +     spin_lock_init(&fep->tmreg_lock);
>>
>> This breaks the build, tmreg_lock is only present in certain
>> configurations.
> 
> No, FEC have changed to check dramatically instead of static config.
> You can look fec.h.  tmreg_lock is always defined.

Not in the 'net' tree or you don't want this bug fixed there at all?
