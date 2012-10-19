From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 19 Oct 2012 14:40:37 +0530
Subject: [PATCH 2/5] ARM: tegra: dts: add slink controller dt entry
In-Reply-To: <50808595.8070505@wwwdotorg.org>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
 <1350557795-31487-3-git-send-email-ldewangan@nvidia.com>
 <50808595.8070505@wwwdotorg.org>
Message-ID: <5081190D.50200@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 October 2012 04:11 AM, Stephen Warren wrote:
> On 10/18/2012 04:56 AM, Laxman Dewangan wrote:
>> Add slink controller details in the dts file of
>> Tegra20 and Tegra30.
>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
>> +	slink at 7000d400 {
>> +		compatible = "nvidia,tegra20-slink";
>> +		reg =<0x7000d400 0x200>;
>> +		interrupts =<0 59 0x04>;
>> +		nvidia,dma-req-sel =<15>;
> I thought the common DT DMA bindings were going to be in 3.7, and hence
> we could just use them here rather than inventing another custom
> property for this purpose?
Adding Vinod here.

I looked the dma devicetree bingind document and did not found the 
generic binding name. Howvere, for arm-pl330.txt, it is explained as
Example:

         pdma0: pdma at 12680000 {
                 compatible = "arm,pl330", "arm,primecell";
                 reg = <0x12680000 0x1000>;
                 interrupts = <99>;
         };

Client drivers (device nodes requiring dma transfers from dev-to-mem or
mem-to-dev) should specify the DMA channel numbers using a two-value pair
as shown below.

   [property name]  = <[phandle of the dma controller] [dma request id]>;

       where 'dma request id' is the dma request number which is connected
       to the client controller. The 'property name' is recommended to be
       of the form <name>-dma-channel.

   Example:  tx-dma-channel = <&pdma0 12>;


So here I can also add the name like same.

Vinod,
Do you see any issue in follow the above mechanism for Tegra dma client 
driver?

Thanks,
Laxman
