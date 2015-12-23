From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed, 23 Dec 2015 17:01:37 +0800
Subject: [PATCH v1 1/6] dt-bindings: misc: add document for reboot-mode
 driver
In-Reply-To: <20151223003217.GA18700@rob-hp-laptop>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
 <1450775124-23966-1-git-send-email-andy.yan@rock-chips.com>
 <20151223003217.GA18700@rob-hp-laptop>
Message-ID: <567A62F1.1040505@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob:

On 2015?12?23? 08:32, Rob Herring wrote:
> On Tue, Dec 22, 2015 at 05:05:24PM +0800, Andy Yan wrote:
>> add device tree bindings document for reboot-mode driver
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> ---
>>
>> Changes in v1: None
>>
>>   .../devicetree/bindings/misc/reboot-mode.txt       | 41 ++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/reboot-mode.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/reboot-mode.txt b/Documentation/devicetree/bindings/misc/reboot-mode.txt
>> new file mode 100644
>> index 0000000..082bc0c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/reboot-mode.txt
>> @@ -0,0 +1,41 @@
>> +Generic reboot mode communication driver
> You're not describing a driver. It is a mapping of boot modes to values.
>> +
>> +This driver get reboot mode arguments from userspace
> Coming from userspace is a Linuxism.
>
>> +and stores it in special register or ram . Then the
>> +bootloader will read it and take different action
>> +according the argument stored.
>> +
>> +Required properties:
>> +        - compatible = "reboot-mode" or other vendor compatible string;
>> +
>> +Each mode is represented as a sub-node of reboot_mode:
>> +
>> +Subnode required properties:
>> +        - linux,mode: reboot mode command,such as "loader","recovery", "fastboot".
>> +        - linux,magic: magic number for the mode, this is vendor specific.
>> +
>> +example:
>> +	reboot_mode {
>> +		compatible = "rockchip,reboot-mode";
>> +		rockchip,regmap = <&pmu>;
>> +		offset = <0x40>;
>> +		loader {
>> +			linux,mode = "loader";
>> +			linux,magic = <0x5242C301>;
>> +		};
> These can be much more simply expressed as:
>
> loader = <0x5242c301>;
    how about :
    loader,magic= <0x5242c301>; ?
>
> I would like to see the property names here standardized as much as
> possible. I'm not sure if we can define the properties as a u32 or need
> some flexibility here.
>
> Rob
>
>
>
