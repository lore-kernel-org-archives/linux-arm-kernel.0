From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 08 Aug 2013 10:44:49 +0200
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <52035463.1030909@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
 <20130807160743.GI6427@sirena.org.uk> <5202718F.2050507@gmail.com>
 <20130807163258.GL6427@sirena.org.uk> <52035463.1030909@gmail.com>
Message-ID: <52035A81.6090903@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 10:18 AM, Daniel Mack wrote:
> On 07.08.2013 18:32, Mark Brown wrote:
>> On Wed, Aug 07, 2013 at 06:10:55PM +0200, Daniel Mack wrote:
>>> On 07.08.2013 18:07, Mark Brown wrote:
>>
>>>> Has this been tested with the standalone non-ASoC PXA AC'97 driver?
>>
>>> Nope. I have no such device.
>>
>> I guess the main test there will be making sure that it builds with ASoC
>> disabled.  I'm not sure anything later than PXA3xx ever actually used
>> AC'97.
>>
>
> Ah, I see it now.
>
> I guess we have two options: either duplicate code from
> soc-dmaengine-pcm, or move soc-dmaengine-pcm out of the ASoC context. I
> actually see no dependecy to ASoC from there anyway.

There is intentionally no dependency on ASoC for the soc-dmaengine-pcm code, 
though since I wasn't sure whether there was ever going to be a userside 
outside of ASoC the coded ended up in ASoC folder. It shouldn't be a problem to 
make it available to all of ALSA.

Not that the soc-generic-dmaengine-pcm code has a dependency on ASoC though.

- Lars
