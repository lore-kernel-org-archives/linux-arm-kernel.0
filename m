From: s-anna@ti.com (Anna, Suman)
Date: Mon, 23 Dec 2013 18:10:27 -0600
Subject: [PATCH 5/7] ARM: dts: Complete data for isp iommu
In-Reply-To: <52B8AC55.70205@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
 <1387284818-28739-6-git-send-email-florian.vaussard@epfl.ch>
 <52B88B1A.40506@ti.com> <52B8AC55.70205@epfl.ch>
Message-ID: <52B8D0F3.5060508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 12/23/2013 03:34 PM, Florian Vaussard wrote:
> Hi Suman,
>
> On 12/23/2013 08:12 PM, Anna, Suman wrote:
>> Hi Florian,
>>
>> On 12/17/2013 06:53 AM, Florian Vaussard wrote:
>>> Add missing information required to probe the iommu for the camera
>>> subsystem.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>> ---
>>>    arch/arm/boot/dts/omap3.dtsi | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>>> index daabf99..610d084 100644
>>> --- a/arch/arm/boot/dts/omap3.dtsi
>>> +++ b/arch/arm/boot/dts/omap3.dtsi
>>> @@ -371,11 +371,13 @@
>>>                dma-names = "tx", "rx";
>>>            };
>>>
>>> -        mmu_isp: mmu at 480bd400 {
>>> +        mmu_isp: mmu_isp at 480bd400 {
>>
>> Any reason for switching the name to mmu_isp?
>>
>
> The name of the hwmod is "mmu_isp". This was not working otherwise,
> but I cannot tell you for sure why without getting back at my office.

Ok, did a bit of digging, this is due to the name tie-in for iommu arch 
data (look at the omap3_camera_init in mach-omap2/devices.c), and the 
obj->name assignment of of->name. This is another thing that needs to be 
looked into since it would be preferable to move away from the name 
based lookup towards using a phandle approach by the iommu consumer drivers.

regards
Suman
