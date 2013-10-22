From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 22 Oct 2013 10:33:01 +0200
Subject: [PATCH] ARM: dts: am4372: Add McASP nodes
In-Reply-To: <52662D3B.5050204@ti.com>
References: <1382348758-1083-1-git-send-email-peter.ujfalusi@ti.com>
 <526579FB.10005@cogentembedded.com> <52662D3B.5050204@ti.com>
Message-ID: <5266383D.7090709@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/10/2013 09:46, Peter Ujfalusi wrote:
> Hi,
>
> On 10/21/2013 10:01 PM, Sergei Shtylyov wrote:
>
>>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>>> index c328d5c..defaad1 100644
>>> --- a/arch/arm/boot/dts/am4372.dtsi
>>> +++ b/arch/arm/boot/dts/am4372.dtsi
>>> @@ -633,5 +633,32 @@
>>>                dma-names = "tx", "rx";
>>>            };
>>>
>>> +        mcasp0: mcasp at 48038000 {
>>
>>     According to ePAPR spec [1], "the name of a node should be somewhat
>> generic, reflecting the function of the device and not its
>> precise programming model". In this case probably "sound"?
>
> We use the 'sound' node name for the sound card itself. The case with McASP is
> a bit complicated. It can operate in I2S mode (and similar protocols like RJM,
> LJM, TDM) or it can interface with S/PDIF, IEC60958-1, AES-3 codecs.
> The mode we put McASP depends on the external components, so the same McASP
> can be used in I2S mode in one board while on the other it can be S/PDIF.
> It would have been convenient if I could use 'i2s' as node name but it is not
> true for McASP (Tegra, Exynos for example have I2S, AC97, S/PDIF as separate IP).
>
> IMHO the 'mcasp' is still the best node name for this IP. McASP stands for:
> 'Multichannel Audio Serial Port' and this is pretty much what McASP is.

Yes, I do agree, there are tons of nodes that cannot have generic name. 
Moreover, we are already using that name in few OMAP dts, so for 
consistency, let's keep that name.

Benoit

-- 
Beno?t Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
