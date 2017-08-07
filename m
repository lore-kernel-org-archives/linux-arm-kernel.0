From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 7 Aug 2017 08:09:32 +0200
Subject: [PATCH 0/3] arm64 xilinx zynqmp firmware interface
In-Reply-To: <34C9E6FB-A8CA-462F-8B10-3E15F9EC87D4@suse.de>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <34C9E6FB-A8CA-462F-8B10-3E15F9EC87D4@suse.de>
Message-ID: <1182e5f8-2588-32ff-8380-04273c28d1cd@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5.8.2017 06:23, Alexander Graf wrote:
> 
> 
>> Am 04.08.2017 um 15:45 schrieb Michal Simek <michal.simek@xilinx.com>:
>>
>> Hi,
>>
>> xilinx is using this interface for very long time and we can't merge our
>> driver changes to Linux because of missing communication layer with
>> firmware. This interface was developed before scpi and scmi was
>> available. In connection to power management scpi and scmi are missing
>> pieces which we already use. There is a separate discussion how to
>> extend scmi to support all our use cases.
>> This simply patch is not adding any power management features but only
>> adding minimum functionality which are needed for drivers.
> 
> If you're thinking of changing the interface later down the road, wouldn't it make sense to probe EL3 for its existence? 
You could then expose this interface on today's EL3 and something
scpi/scmi based on tomorrow's.

Right now driver is checking pmu firmware version. Based on this it is
clear how to communicate with it. The same checking could be there for
ATF version. Both of these should tell you exactly what's the
communication channel.
If we decide to use scmi or any other implementation we will increase
versions.

Thanks,
Michal
