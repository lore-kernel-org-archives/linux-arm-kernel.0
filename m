From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 06 Feb 2015 21:50:13 +0100
Subject: [PATCH 1/1] ARM: dts: Use more descriptive names for Exynos5420
 PDs
In-Reply-To: <54D51170.10903@cogentembedded.com>
References: <1423244258-24314-1-git-send-email-javier.martinez@collabora.co.uk>
 <54D51170.10903@cogentembedded.com>
Message-ID: <54D52905.6040100@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sergei,

Thanks a lot for your feedback.

On 02/06/2015 08:09 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 02/06/2015 08:37 PM, Javier Martinez Canillas wrote:
> 
>> All the device nodes for the Exynos5420 power-domains have a quite
>> generic "power-domain" name.
> 
>     And this is in conformance to the ePAPR standard.
> 

True, I forgot that the ePAPR recommends that the node names should be
somewhat generic but OTOH this is the only Exynos DTSI file that follows
the standard for the power domain device nodes. All other Exynos DTSI
use a prefix to differentiate between each power domain.

>> So in case of an error, the Exynos PD
>> driver shows the following (not very useful) message:
> 
>> "Power domain power-domain disable failed"
> 
>     Why not fix the message instead to use the full device name?
>

Well, the full node name is also not very useful IMHO since you have
to check the DTSI or SoC manual to map the device node unit-address to
the corresponding power domain.

I used $subject when debugging an HDMI issue and instead of dropping
it, I just posted it in case someone considered useful. I don't really
mind if the patch is nacked / not picked.

Best regards,
Javier
