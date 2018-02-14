From: kieran.bingham@ideasonboard.com (Kieran Bingham)
Date: Wed, 14 Feb 2018 08:39:19 +0000
Subject: [PATCH v2 2/4] arm64: dts: renesas: r8a77995: add VSP instances
In-Reply-To: <1667048.nVWrpUAVXQ@avalon>
References: <1518550237-16753-1-git-send-email-kbingham@kernel.org>
 <1518550237-16753-3-git-send-email-kbingham@kernel.org>
 <1667048.nVWrpUAVXQ@avalon>
Message-ID: <10851181-b3b1-bb07-82e9-487ae51711ba@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

Thanks for the review,

On 13/02/18 22:03, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Tuesday, 13 February 2018 21:30:35 EET Kieran Bingham wrote:
>> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> The r8a77995 has a VSPBS to support image processing such as blending of
>> two input images, and has two VSPDs to handle display pipelines with a
>> DU.
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>
>> ---
>> v2:
>>  - Fix VSPD register map size
>>  - Squash VSPBS and VSPD patches together
>>
>>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 30 ++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a77995.dtsi index
>> 196a917afea6..19bd8be9926a 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>> @@ -692,6 +692,16 @@
>>  			status = "disabled";
>>  		};
>>
>> +		vspbs: vsp at fe960000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfe960000 0 0x4000>;
> 
> The VSPBS also has OSD-CLUT support in its RPFs, so you need to extend the 
> registers range too.
> 

Wait, but I already changed this ...

</me checks tree>

Yup - this change is already in my tree ... which means I must have made the
change *after* calling git format-patch. Not helpful.

Orz




> Apart from that,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'll collect the tag and repost, this time with the correctly updated version.

(And I'll add in that missing vspd3 from the es1 tree too)


>> +			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 627>;
>> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>> +			resets = <&cpg 627>;
>> +			renesas,fcp = <&fcpvb0>;
>> +		};
>> +
>>  		fcpvb0: fcp at fe96f000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfe96f000 0 0x200>;
>> @@ -701,6 +711,16 @@
>>  			iommus = <&ipmmu_vp0 5>;
>>  		};
>>
>> +		vspd0: vsp at fea20000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfea20000 0 0x8000>;
>> +			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 623>;
>> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>> +			resets = <&cpg 623>;
>> +			renesas,fcp = <&fcpvd0>;
>> +		};
>> +
>>  		fcpvd0: fcp at fea27000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfea27000 0 0x200>;
>> @@ -710,6 +730,16 @@
>>  			iommus = <&ipmmu_vi0 8>;
>>  		};
>>
>> +		vspd1: vsp at fea80000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfea28000 0 0x8000>;
>> +			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 622>;
>> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>> +			resets = <&cpg 622>;
>> +			renesas,fcp = <&fcpvd1>;
>> +		};
>> +
>>  		fcpvd1: fcp at fea2f000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfea2f000 0 0x200>;
> 
