From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 21 Jul 2015 09:32:48 +0300
Subject: [PATCH v2 3/4] of: Add NVIDIA Tegra VIC binding
In-Reply-To: <CACvgo50X_mku2ha8Emi80j9ed+9Kn8SXpLk6ZDFxEKcjUAfCXw@mail.gmail.com>
References: <1437378869-10451-1-git-send-email-mperttunen@nvidia.com>	<1437378869-10451-4-git-send-email-mperttunen@nvidia.com>
 <CACvgo50X_mku2ha8Emi80j9ed+9Kn8SXpLk6ZDFxEKcjUAfCXw@mail.gmail.com>
Message-ID: <55ADE790.9000403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2015 08:20 PM, Emil Velikov wrote:
> Hi Mikko,
> 
> On 20 July 2015 at 08:54, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>> This adds device tree binding documentation for the Video Image
>> Compositor (VIC) present on Tegra124 and newer SoC's.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>  .../devicetree/bindings/gpu/nvidia,tegra20-host1x.txt     | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
>> index 009f4bf..1328f3f 100644
>> --- a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
>> +++ b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
>> @@ -240,6 +240,21 @@ of the following host1x client modules:
>>      - dpaux
>>    - vdd-supply: phandle of a supply that powers the DisplayPort link
>>
>> +- vic: Video Image Compositor
>> +  - compatible: For Tegra124, must contain "nvidia,tegra124-vic".  Otherwise,
>> +    must contain '"nvidia,<chip>-vic", "nvidia,tegra124-vic"', where
>> +    <chip> is tegra132.
> Did you make a typo here, or is "tegra124" string really used to
> identify the tegra132 chips ?

The idea here is that the compatible string must either be
  "nvidia,tegra124-vic"
if the board is a Tegra124 chip. If it's not, the board must be a
Tegra132 (though we probably should add Tegra210 here too) it must be
  "nvidia,tegra132-vic", "nvidia,tegra124-vic"
to indicate that while the hardware is compatible with the Tegra124 VIC
(and thus can use the same driver and we don't need to update the
compatible list in the driver), it is actually the Tegra132 version in
case the driver needs to apply some quirks. Other Tegra bindings use the
same system.

> 
> Thanks
> Emil

Thanks,
Mikko
