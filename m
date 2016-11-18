From: robertcnelson@gmail.com (Robert Nelson)
Date: Thu, 17 Nov 2016 21:44:44 -0600
Subject: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
In-Reply-To: <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-6-robertcnelson@gmail.com>
 <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
Message-ID: <CAOCHtYiUz1cjYw9nNa4YZGtzNVgSgjEa=4Lqiktz07rszsSksw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 8:56 PM, Nishanth Menon <nm@ti.com> wrote:
> On 11/17/2016 08:44 PM, Robert Nelson wrote:
> again.. a short commit message at least please? :)

yeah, i'll fix all those. ;)

>
>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>> CC: Julien <jboulnois@gmail.com>
>> CC: Nishanth Menon <nm@ti.com>
>> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> CC: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>> b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>> index 6df7829..3bc47be 100644
>> --- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>> @@ -97,6 +97,12 @@
>>                 #cooling-cells = <2>;
>>         };
>>
>> +       gpu-subsystem {
>
> A) do we want to make things clear that this is gpu subsystem for gc320?
> B) How about other platforms that could equally reuse?

so the 'gpu-subsystem' comes from etnaviv:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt?id=refs/tags/v4.9-rc5

For a generic name, it's currently only tied to the etnaviv driver:

gpu-subsystem {
 compatible = "fsl,imx-gpu-subsystem";
 cores = <&gpu_2d>, <&gpu_3d>;
};

it would make sense to make that more generic, so you could tie a 2d
vivante and a imgtec/sgx 3d core..  <sad laugh> but that would require
adding a imgtec/sgx driver/bindings to the kernel mainline... </sad
laugh>

>
>> +               compatible = "ti,gc320-gpu-subsystem";
>> +               cores = <&bb2d>;
>> +               status = "okay";
>> +       };
>> +
>>         hdmi0: connector {
>>                 compatible = "hdmi-connector";
>>                 label = "hdmi";
>> @@ -190,6 +196,11 @@
>>                 >;
>>         };
>>  };
>> +
>> +&bb2d {
>> +       status = "okay";
>> +};
>> +
>>  &i2c1 {
>>         status = "okay";
>>         clock-frequency = <400000>;
>>

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
