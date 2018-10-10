From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 10 Oct 2018 09:40:22 +0200
Subject: [PATCH 6/6] arm64: dts: xilinx: ultra96: Standardize LED labels
 and triggers
In-Reply-To: <20181010073546.GA11462@mani>
References: <20181009140522.6492-1-manivannan.sadhasivam@linaro.org>
 <20181009140522.6492-7-manivannan.sadhasivam@linaro.org>
 <7b94c09d-ecbd-e48e-6583-127566715a76@xilinx.com>
 <20181010073546.GA11462@mani>
Message-ID: <b35d87b8-b9f0-ead1-2755-0562fa1d7f3e@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.10.2018 09:35, Manivannan Sadhasivam wrote:
> Hi Michal,
> 
> On Wed, Oct 10, 2018 at 09:25:24AM +0200, Michal Simek wrote:
>> On 9.10.2018 16:05, Manivannan Sadhasivam wrote:
>>> For all 96Boards, the following standard is used for onboard LEDs.
>>>
>>> device-name:green:user1  default-trigger: heartbeat
>>> device-name:green:user2  default-trigger: mmc0/disk-activity
>>>                                           (onboard-storage)
>>> device-name:green:user3  default-trigger: mmc1 (SD-card)
>>> device-name:green:user4  default-trigger: none, panic-indicator
>>> device-name:yellow:wlan  default-trigger: phy0tx
>>> device-name:blue:bt      default-trigger: hci0-power
>>>
>>> So lets adopt the same for Ultra96, which is one of the 96Boards
>>> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
>>> consolidate only User LEDs.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> index eb5e8bddb610..565ceb390f99 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> @@ -57,29 +57,30 @@
>>>  	leds {
>>>  		compatible = "gpio-leds";
>>>  		ds2 {
>>> -			label = "ds2";
>>> +			label = "zynqmp-zcu100-revC:green:user1";
>>
>> The purpose of this series should be standardize Led labels that's why I
>> would expect that leds will be called in the same way on all these
>> boards that's why I am not getting why there is board name.
>>
>> green:user1 or just user1 should be enough.
>>
> 
> Hmm. That's a good point. My proposal to standardize the labels is inspired from
> Dragonboard410c dts [1]. They had the device name in label and I decided to
> go with that. But as you said, the board name is not needed and just 
> `color:led-name` should be fine.
> 
> Will modify this in next interation.

The second part of this is that all current DTSes are using some names
and by changing it you will break compatibility which is something what
you should avoid.
That's why it is really a question if this change should be accepted.

Thanks,
Michal
