From: menschel.p@posteo.de (Patrick Menschel)
Date: Fri, 31 Mar 2017 18:51:38 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun7i: Add CAN node and can0_pins_a
 pinctrl settings
In-Reply-To: <20170327064625.we7ydn2oapwizncb@lukather>
References: <1490392339-23565-1-git-send-email-menschel.p@posteo.de>
 <1490392339-23565-3-git-send-email-menschel.p@posteo.de>
 <20170327064625.we7ydn2oapwizncb@lukather>
Message-ID: <91bc06e3-3173-43a1-32f2-a35d94855d46@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

Am 27.03.2017 um 08:46 schrieb Maxime Ripard:
>> @@ -1582,6 +1587,14 @@
>>  			#size-cells = <0>;
>>  		};
>>  
>> +		can0: can at 01c2bc00 {
>> +			compatible = "allwinner,sun4i-a10-can";
> 
> Sorry for not spotting this earlier, but this would need an A20
> compatible too, to deal with the case where it turns out not to be
> compatible.
> 
> you can do something like this:
> compatible = "allwinner,sun7i-a20-can", "allwinner,sun4i-a10-can";

Adding "sun7i-a20-can" to the compatible list results in a checkpatch
warning, that the "driver" is not documented.

 WARNING: DT compatible string "allwinner,sun7i-a20-can" appears
un-documented -- check ./Documentation/devicetree/bindings/
#27: FILE: arch/arm/boot/dts/sun7i-a20.dtsi:1586:
+			compatible = "allwinner,sun7i-a20-can",

Is it really OK to add a driver that doesn't exist yet?

Thanks,
Patrick

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3709 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170331/e81c8fde/attachment.p7s>
