From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 1 Oct 2014 10:47:59 +0300
Subject: Differences between tlv320aic3x and tlv320aic31xx
In-Reply-To: <20140930183731.GC3907@piout.net>
References: <20140930183731.GC3907@piout.net>
Message-ID: <542BB1AF.3060501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2014 09:37 PM, Alexandre Belloni wrote:
> Hi,
>
> I'm trying to add support for the tlv320aic3104a present on a
> custom board using an am335x.
>
> I see that Benoit seemed to have been successful when using the
> tlv320aic3x driver with minor modifications.
> http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January/058966.html
>
> On the other hand, in the past, I've used a tlv320aic3100 with the
> tlv320aic31xx driver.
>
> My plan for now is to use the tlv320aic3x driver with snd-soc-evm as
> this is the one it is using (it is using .codec_dai_name =
> "tlv320aic3x-hifi").
>
> I had no luck until now but I still have to review my pinmuxing. But
> before I investigate to much, can you confirm what codecs are supported
> by which driver? I'm pretty sure that would be a nice addition to the
> documentation too.
> 0

Hi Alexandre,
Based on a brief look at the data sheet I am afraid you will not have 
any luck using tlv320aic3x driver with tlv320aic3104. tlv320aic31xx is a 
better match, but sill not close enough.

Based on the register map you may have a change to get the codec working 
using tlv320aic32x4 driver. At least the register map appears to be a 
pretty good match. However, I have no experience either with the driver 
or the codec.

Best regards,
Jyri
