From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 Nov 2016 12:06:51 +0530
Subject: [PATCH v4 4/4] ARM: dts: da850: Add the usb otg device nodeg
In-Reply-To: <20161115211951.GH11011@uda0271908>
References: <1478188752-22447-1-git-send-email-abailon@baylibre.com>
 <1478188752-22447-5-git-send-email-abailon@baylibre.com>
 <0c94c5e0-9d2c-fff5-1213-2fb2adb20ab0@ti.com>
 <20161115211951.GH11011@uda0271908>
Message-ID: <9a73c416-fe4c-57c3-af53-87146dae2206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 November 2016 02:49 AM, Bin Liu wrote:
> On Tue, Nov 15, 2016 at 04:16:02PM +0530, Sekhar Nori wrote:
>> On Thursday 03 November 2016 09:29 PM, Alexandre Bailon wrote:
>>> This adds the device tree node for the usb otg
>>> controller present in the da850 family of SoC's.
>>> This also enables the otg usb controller for the lcdk board.
>>>
>>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>>> ---
>>>  arch/arm/boot/dts/da850-lcdk.dts |  8 ++++++++
>>>  arch/arm/boot/dts/da850.dtsi     | 15 +++++++++++++++
>>>  2 files changed, 23 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
>>> index 7b8ab21..9f5040c 100644
>>> --- a/arch/arm/boot/dts/da850-lcdk.dts
>>> +++ b/arch/arm/boot/dts/da850-lcdk.dts
>>> @@ -158,6 +158,14 @@
>>>  	rx-num-evt = <32>;
>>>  };
>>>  
>>> +&usb_phy {
>>> +	status = "okay";
>>> +	};
>>
>> As mentioned by David already, this node needs to be removed. Please
>> rebase this on top of latest linux-davinci/master when ready for merging
>> (driver changes accepted).
> 
> Dropped this patch due to this comment.

Bin, Please do not apply dts or arch/arm/mach-davinci patches. I have a
bunch queued through my tree and more in pipeline and it will cause
unnecessary merge conflicts in linux-next or at Linus.

For future, I have asked Alexandre to send driver and dts patches as
separate series so there is no confusion on who should apply.

Thanks,
Sekhar
