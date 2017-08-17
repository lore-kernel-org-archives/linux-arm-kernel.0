From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 17 Aug 2017 08:10:33 +0200
Subject: [PATCHv2 0/3] arm64 xilinx zynqmp firmware interface
In-Reply-To: <43deeed7-32c8-7914-5f44-862ebbe14a3b@arm.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
 <43deeed7-32c8-7914-5f44-862ebbe14a3b@arm.com>
Message-ID: <89e5469b-650e-64c7-1754-797b35bac523@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.8.2017 17:39, Marc Zyngier wrote:
> On 16/08/17 13:24, Michal Simek wrote:
>> Hi,
>>
>> xilinx is using this interface for very long time and we can't merge our
>> driver changes to Linux because of missing communication layer with
>> firmware. This interface was developed before scpi and scmi was
>> available. In connection to power management scpi and scmi are missing
>> pieces which we already use. There is a separate discussion how to
>> extend scmi to support all our use cases.
> 
> So maybe we should wait and see where this discussion is going before we
> merge yet another firmware interface?

It will take a lot of time when this discussion ends and I can't see any
benefit to hold all


>> This simply patch is not adding any power management features but only
>> adding minimum functionality which are needed for drivers.
> 
> I don't get it. 600 lines of firmware interface that isn't used by
> anything? Or is it? Needed by which driver?

I can send that drivers for review. pinctrl, fpga manager, nvmem driver,
clock, serdes phy and reset drivers.
But this driver need to come first because they depend on this.

Thanks,
Michal
