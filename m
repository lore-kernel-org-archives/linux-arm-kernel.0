From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jul 2010 14:17:52 +0100
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 ,
	withRealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <AANLkTikezqBLFd_ECJZ9RoCf2XCNdYyWps_JKfjyQ1se@mail.gmail.com>
References: <AANLkTimq3E7uF4poJkqcDIomEHoS4y24D7sJWt0U44Hd@mail.gmail.com>
	<1279198607.6664.20.camel@e102109-lin.cambridge.arm.com>
	<AANLkTikezqBLFd_ECJZ9RoCf2XCNdYyWps_JKfjyQ1se@mail.gmail.com>
Message-ID: <1279199872.6664.24.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-15 at 14:10 +0100, David Yang wrote:
> I have passed the test,when using wmb() and without PATCH 0/3;

Great, so it's a memory ordering issue.

> But,I have a  doubt : if I use the wmb(), then the l2x0.c 's patch is
> not needed?

Correct, if you add the wmb(), none of the three ordered accessors
patches are needed. But we'll probably push them anyway, in which case
the wmb() becomes superfluous.

> I will test the PATCH v3 0/3  tomorrow, without using wmb();

Thanks.

-- 
Catalin
