From: nm@ti.com (Nishanth Menon)
Date: Thu, 15 Jan 2015 08:40:16 -0600
Subject: [PATCH v3 13/21] ARM: omap: convert wakeupgen to stacked domains
In-Reply-To: <871tmwi0d6.fsf@approximate.cambridge.arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
 <1421087187-26988-14-git-send-email-marc.zyngier@arm.com>
 <20150114222814.GU2419@atomide.com>
 <871tmwi0d6.fsf@approximate.cambridge.arm.com>
Message-ID: <20150115144016.GA19920@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:28-20150115, Marc Zyngier wrote:
> Assuming the workaround I posted earlier works, the OMAP/DRA7 part of
> this series is going to require some rework too (I need to know where
> these legacy interrupts are attached: crossbar, WUGEN, or GIC?).
> 
crossbar will never work with legacy static interrupts anyways - since there
was never a static interrupt possible - I believe we had removed all the
legacy hardcoded interrupt definitions for DRA7. ideally, they should
all be dt only now.

-- 
Regards,
Nishanth Menon
