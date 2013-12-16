From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 16 Dec 2013 12:57:42 +0200
Subject: [PATCHv10 22/41] ARM: dts: omap5 clock data
In-Reply-To: <alpine.DEB.2.02.1312161046530.31680@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-23-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.02.1312161046530.31680@utopia.booyaka.com>
Message-ID: <52AEDCA6.2010706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2013 12:51 PM, Paul Walmsley wrote:
> On Tue, 26 Nov 2013, Tero Kristo wrote:
>
>> This patch creates a unique node for each clock in the OMAP5 power,
>> reset and clock manager (PRCM).
>
> ...
>
>> +&cm_core_aon {
>> +	pad_clks_src_ck: pad_clks_src_ck {
>> +		#clock-cells = <0>;
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <12000000>;
>> +	};
>> +
>> +	pad_clks_ck: pad_clks_ck {
>> +		#clock-cells = <0>;
>> +		compatible = "ti,gate-clock";
>> +		clocks = <&pad_clks_src_ck>;
>> +		ti,bit-shift = <8>;
>> +		reg = <0x0108>;
>> +	};
>
> All of the clock data should be underneath a "clocks {" node, for all of
> the chips.  Please see the Calxeda ECX clocks DT data as an example of how
> this should look:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ecx-common.dtsi#n141

Any reason why?

Should be relatively trivial to change though, however I am not too sure 
if this works:

&core_core_aon {
   &clocks {
     pad_clks_src_ck: ...
   };
};

... as I want to modify nodes under the structure. Does it?

-Tero
