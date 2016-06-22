From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 22 Jun 2016 09:52:12 +0100
Subject: [PATCH v2 1/8] arm64: dts: db820c: add basic board support
In-Reply-To: <20160622044916.GF1256@tuxbot>
References: <1466529769-2674-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1466529769-2674-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160622044916.GF1256@tuxbot>
Message-ID: <576A51BC.5090108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/06/16 05:49, Bjorn Andersson wrote:
> On Tue 21 Jun 10:22 PDT 2016, Srinivas Kandagatla wrote:
>
> [..]
>> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> [..]
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. DB820c";
>> +	compatible = "qcom,apq8096-sbc";
>
> I'm still not buying the concept of this being the one and only
> single-board-computer.
>
+1

AFAIK, The problem is the dtbTool. dtbTool has predefined all the 
platform names along with its platform ID's [1] for auto generating 
board-id, pmic-id and soc-id. dtbTool checks the compatible strings 
along with soc name with its static list, it would fail if it did not 
find a matching combination of soc,platform compatible.

Either we have to cope up with this and have a compatbile strings which 
keep dtbTool happy
  or
Keep patching dtbtool to be more flexible.

There is another problem with dtbTool, We can not use dtbTool with new 
boards from other vendors with own board names, like SD600 or IFC6410 
and so..


IMO, we should patch dtbTool to make it more flexible to cope up with 
situations like this.

> If this compatible fully and exclusively identifies this particular
> board then dtbTool should be updated to follow the product name
> "qcom,apq8096-db820c". If on the other hand this identifies a class of
> single-board-computers, then the compatible should list both
> "qcom,apq8096-dtb820c" and "qcom,apq8096-sbc".

Am not sure this would actually work when we have two boards with same 
sbc platform ID. Which one would the bootloader pick? and on what basis?

>
>
>
> Further more, the ePAPR defines this property as:
> "Specifies a list of platform architectures with which this platform is
> compatible. This property can be used by operating systems in selecting
> platform specific code."
>
> So I think we should follow the common pattern of having the least
> significant entry being "qcom,apq8096".
I agree.

Thanks,
srini

[1] https://source.codeaurora.org/quic/kernel/skales/tree/dtbTool#n83



>
>> +};
>
> Regards,
> Bjorn
>
