From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Wed, 15 Apr 2015 13:50:51 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150415112224.GA26099@e104818-lin.cambridge.arm.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
 <20150414144702.GD14546@e104818-lin.cambridge.arm.com>
 <2485404.lBlHmzQPKN@wuerfel>
 <20150415112224.GA26099@e104818-lin.cambridge.arm.com>
Message-ID: <721B7D5F-0A9A-45B7-8036-730ED54FB3AB@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 15 Apr 2015, at 13:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> I think you are right. I was more thinking of those routed directly to
> the native (non-compat) syscalls. We would need to make sure the return
> value (X0 being the only register not restored on return from exception)
> has the top 32-bit part zeroed.

As the kernel is LP64 and will thus attempt to return a 64bit return value, the
high bits should be properly sign-extended in all cases.

The problem (posed by procedure call standard) of information leakage could 
manifest itself only, if the kernel tried to return something smaller than 64 bits? 
in that case, we can the problem would already exhibit for the LP64 ABI. 

For the ILP32 implementation, I?ll thus assume that all LP64 ABI calls reused
are clean in this regard.

Phil.
