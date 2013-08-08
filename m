From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 14:40:22 -0600
Subject: [PATCH v2 2/3] ARM: dt: t114 dalmore: add dt entry for nct1008
In-Reply-To: <52040146.7060703@cogentembedded.com>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-3-git-send-email-wni@nvidia.com>
 <52040146.7060703@cogentembedded.com>
Message-ID: <52040236.2080701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 02:36 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/08/2013 10:56 AM, Wei Ni wrote:
> 
>> Enable thermal sensor nct1008 for t114 dalmore.
> 
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>   arch/arm/boot/dts/tegra114-dalmore.dts |   10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts
>> b/arch/arm/boot/dts/tegra114-dalmore.dts
>> index b5a42f0..9d4d2b2 100644
>> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
>> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
>> @@ -738,6 +738,14 @@
>>               realtek,ldo1-en-gpios =
>>                   <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
>>           };
>> +
>> +        nct1008 {
> 
>    ePAPR [1] says: "the name of a node should be somewhat generic,
> reflecting the function of the device and not its precise programming
> model". So I suggest "thermal"

True, although there's quite some precedent for node-names being the
chip name for external chips in existing DTs. If we change this node
name, I'd like to see a patch that makes all the other "nct1008" nodes
match the new name...
