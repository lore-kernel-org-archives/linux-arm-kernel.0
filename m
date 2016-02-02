From: eric@anholt.net (Eric Anholt)
Date: Mon, 01 Feb 2016 17:52:56 -0800
Subject: [PATCH V4 1/7] clk: bcm2835: the minimum clock divider is 2
In-Reply-To: <87oac03tuz.fsf@eliezer.anholt.net>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
 <1452867667-2447-2-git-send-email-kernel@martin.sperl.org>
 <87oac03tuz.fsf@eliezer.anholt.net>
Message-ID: <87egcv5153.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> kernel at martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Testing with different clock divider values has shown
>> that (at least for the PCM clock) the clock divider
>> has to be at least 2, otherwise the clock will not
>> output a signal.
>
> For a MASH clock (PWM, PCM, SLIMBUS, but not the others), the minimum
> integer component of the divider is:
>
> mash 0: 1
> mash 1: 2
> mash 2: 3
> mash 3: 5

More specific MASH list:

GP0
GP1
(*not* gp2)
PCM
PWM
SLIM
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/4fc8280e/attachment.sig>
