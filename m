From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 11 Mar 2014 10:38:14 +0100
Subject: [PATCH v5] can: xilinx CAN controller support.
In-Reply-To: <20140311044555.GA12373@localhost>
References: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
 <531DD493.3030306@monstr.eu> <531DD5E7.7090406@pengutronix.de>
 <3245971.RIuVmbVL0Z@wuerfel>
 <1964213d-6bd9-49fa-805e-42e1e0630fd5@VA3EHSMHS029.ehs.local>
 <20140311044555.GA12373@localhost>
Message-ID: <546dbc60-dd7b-4249-bab8-ad7e008b9aad@AM1EHSMHS001.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 05:45 AM, Fengguang Wu wrote:
>>> You probably want something like
>>>
>>> 	config CAN_XILINX
>>> 	tristate "Xilinx CAN"
>>> 	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
>>> 	depends on COMMON_CLK && HAS_MMIO  # whatever you need for other architectures
>>
>> Fengguang: Are you use COMPILE_TEST in zero day testing system?
> 
> Yeah, the randconfig build/boot tests should cover both COMPILE_TEST
> and !COMPILE_TEST cases.

But the point is that randconfig is really random it means it definitely can
cover but not there is no certainty that for that build, you are running,
has both option for all architectures enabled.
Or do I read it wrongly?

Thanks,
Michal
