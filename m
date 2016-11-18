From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Nov 2016 22:15:48 -0600
Subject: [RFC 6/6] ARM: dts: am57xx-beagle-x15-common: enable etnaviv
In-Reply-To: <CAOCHtYiUz1cjYw9nNa4YZGtzNVgSgjEa=4Lqiktz07rszsSksw@mail.gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-6-robertcnelson@gmail.com>
 <e69a797c-bec3-2243-5c19-9d7633092369@ti.com>
 <CAOCHtYiUz1cjYw9nNa4YZGtzNVgSgjEa=4Lqiktz07rszsSksw@mail.gmail.com>
Message-ID: <3eb346ad-1675-e613-93ef-bd2d07bf2ab8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2016 09:44 PM, Robert Nelson wrote:
> On Thu, Nov 17, 2016 at 8:56 PM, Nishanth Menon <nm@ti.com> wrote:
>> On 11/17/2016 08:44 PM, Robert Nelson wrote:
>> again.. a short commit message at least please? :)
>
> yeah, i'll fix all those. ;)
>
>>
>>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>>> CC: Julien <jboulnois@gmail.com>
>>> CC: Nishanth Menon <nm@ti.com>
>>> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> CC: Tony Lindgren <tony@atomide.com>
>>> ---
>>>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>>> b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>>> index 6df7829..3bc47be 100644
>>> --- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
>>> @@ -97,6 +97,12 @@
>>>                 #cooling-cells = <2>;
>>>         };
>>>
>>> +       gpu-subsystem {
>>
>> A) do we want to make things clear that this is gpu subsystem for gc320?
>> B) How about other platforms that could equally reuse?
>
> so the 'gpu-subsystem' comes from etnaviv:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt?id=refs/tags/v4.9-rc5
>
> For a generic name, it's currently only tied to the etnaviv driver:
>

I was only complaining about "gpu-subsystem {", not the compatible. it 
is not the only gpu subsystem on the SoC. either "gpu-subsystem0 {" or 
something like gpu-subsystem-gc320 might be helpful to clarify.

> gpu-subsystem {
>  compatible = "fsl,imx-gpu-subsystem";
>  cores = <&gpu_2d>, <&gpu_3d>;
> };
>
> it would make sense to make that more generic, so you could tie a 2d
> vivante and a imgtec/sgx 3d core..  <sad laugh> but that would require
> adding a imgtec/sgx driver/bindings to the kernel mainline... </sad
> laugh>
>

I should have clarified... I meant other dra7 devices to reuse the 
same definitions. this definition is not by any means constrained to 
EVM - it is a SoC definition, it should be moved to appropriate place 
(convention for dra7 is to mark them as disabled by default in 
SoC.dtsi to prevent proliferation of paper spin dtsi and just do 
"status = okay" in board file to indicate presence in the variation 
for the board).

Yes - I guess some day there might be a bunch of folks like etnaviv 
who might make an community driver possible..


-- 
Regards,
Nishanth Menon
