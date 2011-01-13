From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 13 Jan 2011 11:36:43 +0900
Subject: [PATCH/RFC 2/3] ARM: S5PV310: Add a platform helper for MIPI
	DSIM/CSIS setup
In-Reply-To: <020401cbb2c1$ef9f7c30$cede7490$%kim@samsung.com>
References: <1294153764-25006-1-git-send-email-s.nawrocki@samsung.com>
	<1294153764-25006-3-git-send-email-s.nawrocki@samsung.com>
	<020401cbb2c1$ef9f7c30$cede7490$%kim@samsung.com>
Message-ID: <4D2E653B.4090502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2011 10:33 AM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>>
>> MIPI_PHYn_CONTROL registers are shared between MIPI DSIM
>> and MIPI CSIS drivers so a spinlock is used to protect multiple
>> access to these registers. Also a proper state of a common
>> PHY enable bit is maintained in order to avoid a DSIM
>> and CSIS driver conflict.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
...
> 
> Basically, it's not good that each machine(SoC) has each own setup-mipi...
> Because it is very similar(almost same)...means can move it in plat-s5p with
> following. 
> 
> 1. # of MIPI PHY can be calculated by platform device id
> 2. can use same definition of MIPI PHY control address with same name
> re-mapping.

Yes, I agree with that. Originally I had it done it plat-s5p, I will
prepare a merged version. The main difference between s5pv210 and s5pv310
indeed was the register naming and placement in PMU or CLK subsystem, so the
register  address definitions were in regs-clk.h or regs-pmu.h. So there 
just will have to be included different header files depending on on SoC 
architecture.


Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
