From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Jan 2015 14:50:21 +0000
Subject: [PATCH v3 13/21] ARM: omap: convert wakeupgen to stacked domains
In-Reply-To: <20150115144016.GA19920@kahuna> (Nishanth Menon's message of
 "Thu, 15 Jan 2015 14:40:16 +0000")
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
 <1421087187-26988-14-git-send-email-marc.zyngier@arm.com>
 <20150114222814.GU2419@atomide.com>
 <871tmwi0d6.fsf@approximate.cambridge.arm.com>
 <20150115144016.GA19920@kahuna>
Message-ID: <87sifcgksy.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15 2015 at  2:40:16 pm GMT, Nishanth Menon <nm@ti.com> wrote:
> On 14:28-20150115, Marc Zyngier wrote:
>> Assuming the workaround I posted earlier works, the OMAP/DRA7 part of
>> this series is going to require some rework too (I need to know where
>> these legacy interrupts are attached: crossbar, WUGEN, or GIC?).
>> 
> crossbar will never work with legacy static interrupts anyways - since
> there was never a static interrupt possible - I believe we had removed
> all the legacy hardcoded interrupt definitions for DRA7. ideally, they
> should all be dt only now.

Yes, I guessed as much after looking at the DRA7XX hwmod.

So only OMAP4/5 is b0rken at the moment. I can probably work around it
as I did in this example patch, just by changing the compatible strings
for the xlate callback. Very ugly.

	M.
-- 
Jazz is not dead. It just smells funny.
