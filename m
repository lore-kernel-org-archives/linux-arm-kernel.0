From: david@lechnology.com (David Lechner)
Date: Wed, 23 Nov 2016 10:19:53 -0600
Subject: [PATCH v2] ARM: dts: da850: add the mstpri and ddrctl nodes
In-Reply-To: <CAMpxmJVqog0Fno_DO0NQKmVNvzu5d=3GOLk145wBmB-V70BLeg@mail.gmail.com>
References: <1479207611-18028-1-git-send-email-bgolaszewski@baylibre.com>
 <a39b9276-865b-6382-574e-a5ef040a452f@lechnology.com>
 <CAMpxmJVqog0Fno_DO0NQKmVNvzu5d=3GOLk145wBmB-V70BLeg@mail.gmail.com>
Message-ID: <5e647eb0-2f8a-b46b-2048-7616bfb54ad7@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2016 04:27 AM, Bartosz Golaszewski wrote:
> 2016-11-22 23:23 GMT+01:00 David Lechner <david@lechnology.com>:
>> On 11/15/2016 05:00 AM, Bartosz Golaszewski wrote:
>>>
>>> Add the nodes for the MSTPRI configuration and DDR2/mDDR memory
>>> controller drivers to da850.dtsi.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>> v1 -> v2:
>>> - moved the priority controller node above the cfgchip node
>>> - renamed added nodes to better reflect their purpose
>>>
>>>  arch/arm/boot/dts/da850.dtsi | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>>> index 1bb1f6d..412eec6 100644
>>> --- a/arch/arm/boot/dts/da850.dtsi
>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>> @@ -210,6 +210,10 @@
>>>                         };
>>>
>>>                 };
>>> +               prictrl: priority-controller at 14110 {
>>> +                       compatible = "ti,da850-mstpri";
>>> +                       reg = <0x14110 0x0c>;
>>
>>
>> I think we should add status = "disabled"; here and let boards opt in.
>>
>>> +               };
>>>                 cfgchip: chip-controller at 1417c {
>>>                         compatible = "ti,da830-cfgchip", "syscon",
>>> "simple-mfd";
>>>                         reg = <0x1417c 0x14>;
>>> @@ -451,4 +455,8 @@
>>>                           1 0 0x68000000 0x00008000>;
>>>                 status = "disabled";
>>>         };
>>> +       memctrl: memory-controller at b0000000 {
>>> +               compatible = "ti,da850-ddr-controller";
>>> +               reg = <0xb0000000 0xe8>;
>>
>>
>> same here. status = "disabled";
>>
>>> +       };
>>>  };
>>>
>
> Hi David,
>
> I did that initially[1][2] and it was rejected by Kevin[3] and Laurent[4].
>
> FYI this patch has already been queued by Sekhar.

Thanks. I did not see those threads.

FYI to maintainers, having these enabled by default causes error 
messages in the kernel log for other boards that are not supported by 
the drivers. Since there is only one board that is supported and soon to 
be 2 that are not, I would rather have this disabled by default to avoid 
the error messages.

>
> Best regards,
> Bartosz Golaszewski
>
> [1] https://www.spinics.net/lists/arm-kernel/msg539638.html
> [2] http://www.spinics.net/lists/devicetree/msg148575.html
> [3] http://www.spinics.net/lists/devicetree/msg148667.html
> [4] http://www.spinics.net/lists/devicetree/msg148655.html
>
