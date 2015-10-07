From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 07 Oct 2015 21:45:46 +0200
Subject: [PATCH v4 11/26] ARM: pxa: magician: Optimize EGPIO initial values
In-Reply-To: <1443875705.4186.24.camel@gmail.com> (Philipp Zabel's message of
 "Sat, 03 Oct 2015 14:35:05 +0200")
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B1E9.4020508@tul.cz>
 <1443875705.4186.24.camel@gmail.com>
Message-ID: <87twq2a2dx.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp Zabel <philipp.zabel@gmail.com> writes:

> Am Montag, den 28.09.2015, 23:32 +0200 schrieb Petr Cvek:
>> This patch optimizes initial values of the EGPIO chip driver.
>> 
>> GSM and sound should be powered off during boot. A weak accumulator
>> and
>> a powered GSM sometimes cause a system reboot. A charging current
>> should be
>> as high as possible during boot.
>
> Wouldn't that violate USB spec if we boot the magician while plugged
> into an unpowered USB host?

You're right. As USB 2.0 device cannot draw more than 100mA until enumerated
(prior to battery charging spec 1.1). It is described in USB 2.0 specification,
chapter 7.3.2, in the table :
 - Unconfigured Function/Hub - ICCInit - maximum 100mA.

So I'll drop this patch for now I think.

Cheers.

-- 
Robert
