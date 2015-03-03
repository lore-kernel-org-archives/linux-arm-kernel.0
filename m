From: thunder.leizhen@huawei.com (leizhen)
Date: Tue, 3 Mar 2015 10:32:02 +0800
Subject: [Question] How can we support outer shareable on ARM64?
In-Reply-To: <20150302104414.GC22541@e104818-lin.cambridge.arm.com>
References: <54F41904.90303@huawei.com>
 <20150302104414.GC22541@e104818-lin.cambridge.arm.com>
Message-ID: <54F51D22.40301@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/2 18:44, Catalin Marinas wrote:
> On Mon, Mar 02, 2015 at 04:02:12PM +0800, leizhen wrote:
>> Now, both cacheable memory shareability attribute and barrier are
>> fixed to inner shareable.
> 
> That's correct for memory attributes. As for barriers, the mb()
> generates full system DSB.
OK.
> 
>> But I afraid some hardware need outer shareable.
> 
> Why? All processors or devices controlled by an operating system are
> expected to be in the same inner shareable domain (see shareable memory
> in B2.8.1 in the ARMv8 ARM).
> 
OK. Thank you for help. I saw that sentence:
This architecture assumes that all PEs that use the same operating system or hypervisor are in the same Inner
Shareable shareability domain.
