From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Aug 2015 16:01:26 +0200
Subject: [PATCH] ARM: Fix the secondary_startup function in Big Endian case
In-Reply-To: <20150806135258.GE7557@n2100.arm.linux.org.uk>
References: <1438860452-6347-1-git-send-email-gregory.clement@free-electrons.com>
 <20150806135258.GE7557@n2100.arm.linux.org.uk>
Message-ID: <55C368B6.4030501@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 15:52, Russell King - ARM Linux wrote:
> On Thu, Aug 06, 2015 at 01:27:32PM +0200, Gregory CLEMENT wrote:
>> Since the commit "b2c3e38a5471 ARM: redo TTBR setup code for LPAE",
>> the setup code had been reworked. As a result the secondary CPUs
>> failed to come online in Big Endian.
>>
>> As explained by Russell, the new code expected the value in r4/r5 to
>> be the least significant 32bits in r4 and the most significant 32bits
>> in r5. However, in the secondary code, we load this using ldrd, which
>> on BE reverses that.
>>
>> This patch swap r4/r5 after the ldrd. It is done using the xor
>> instructions in order to not use a temporary register.
> 
> Patch looks good to me, thanks.
> 
So I am going to submit it to your patch system and in the same
time I will fix the typo in my comment:

- @ it can be done in 3 step
- @ without using an temp reg
+ @ it can be done in 3 steps
+ @ without using a temp reg.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
