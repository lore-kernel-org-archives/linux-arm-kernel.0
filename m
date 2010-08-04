From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 04 Aug 2010 15:16:51 +0900
Subject: [alsa-devel] [PATCH 1/2] ARM: S5PV210: Add audio support to	Aquila
In-Reply-To: <20100803085929.GC25306@rakim.wolfsonmicro.main>
References: <4C4F9E4C.7000001@samsung.com>
	<20100729173825.GE24781@opensource.wolfsonmicro.com>
	<4C527C11.5090409@samsung.com>
	<20100803085929.GC25306@rakim.wolfsonmicro.main>
Message-ID: <4C5905D3.8090703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Fri, Jul 30, 2010 at 04:15:29PM +0900, Chanwoo Choi wrote:
> 
>>> All these fixed voltage regulators seem a bit suspicous for a mobile
>>> phone - I'd have expected that the supplies would all be being provided
>>> by your PMIC except for things taken directly from the battery supply
>>> (like the speakers tend to be, for example)?  There's no problem with
>>> the code itself, it just looks a bit odd.
> 
>> All these consumer supply of WM8994 codec connected the below regulator(VCC_1.8V) on
>> a circuit diagram. "VCC_1.8V" regualtor is always enabled, because it is used to many devices.
>> Then I haven't connected all these consumer supply of WM8994 codec to "VCC_1.8V" regulator.
>> I will modify that the consumer supply would be provided by PMIC.
> 
> OK, good - the fact that the connection wasn't being made with the PMIC
> was my main point here.

Did you read writed mail about consumer supply of WM8994 by MyungJoo Ham?
He is in charge of PMIC and Power Management on Aquila board.

MyungJoo Ham is wrote : 
This aquila_buck3_data.constraints would be better have ".always_on =
1" entry as this buck3 is required to be turned on at all times in
Aquila boards (even when the system is in suspend-to-mem state). This
is required especially when there are many devices physically attached
to Buck3 and some of they did not "register" as consumers to Buck3.
Buck3 might be turned off by those who are registered while
"unregistered" are still active.

Can you tell me your opinion about the review by MyungJoo Ham?
I will respect your response.
