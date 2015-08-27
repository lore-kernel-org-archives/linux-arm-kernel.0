From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 27 Aug 2015 16:54:49 +0100
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <1440552341.10987.53.camel@linaro.org>
References: <20150821184059.GB2000@svinekod>
 <20150824091845.GA28290@leoy-linaro> <20150824095144.GA7139@leverpostej>
 <1440411596.3517.12.camel@linaro.org>
 <20150824114903.GT10728@bivouac.eciton.net>
 <1440490427.10987.29.camel@linaro.org>
 <20150825094630.GU10728@bivouac.eciton.net>
 <1440497710.10987.42.camel@linaro.org> <20150825104256.GB13471@leverpostej>
 <1440510194.10987.52.camel@linaro.org> <20150825160030.GA3774@leoy-linaro>
 <1440552341.10987.53.camel@linaro.org>
Message-ID: <55DF32C9.8040302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/15 02:25, Haojian Zhuang wrote:
>> Option 1:
>>
>> 	memory at 0 {
>> 		device_type = "memory";
>> 		reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
>> 		      <0x00000000 0x05f00000 0x00000000 0x00eff000>,
>> 		      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
>> 		      <0x00000000 0x07410000 0x00000000 0x38bf0000>;
>> 	};
>>
>> [snip]
 >>
>> Option 2:
>>
>> 	memory at 0 {
>> 		device_type = "memory";
>> 		reg = <0x0 0x0 0x0 0x40000000>;
>> 	};
>>
 >> [snip]
 >>
>
> I prefer the second one. From my view, memory node should only describe
> the hardware information of memory.

Haven't we already established that, to avoid the risk of UEFI 
applications accessing inappropriate memory locations, a (correct) UEFI 
implementation must use, and pass to the kernel, a memory map that looks 
like option 1?

That being the case why would we want u-boot (or any other similar 
bootloader) to pass a memory map that is gratuitously different to the 
one supplied by UEFI?


Daniel.
