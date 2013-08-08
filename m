From: zonque@gmail.com (Daniel Mack)
Date: Thu, 08 Aug 2013 10:18:43 +0200
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <20130807163258.GL6427@sirena.org.uk>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
 <20130807160743.GI6427@sirena.org.uk> <5202718F.2050507@gmail.com>
 <20130807163258.GL6427@sirena.org.uk>
Message-ID: <52035463.1030909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2013 18:32, Mark Brown wrote:
> On Wed, Aug 07, 2013 at 06:10:55PM +0200, Daniel Mack wrote:
>> On 07.08.2013 18:07, Mark Brown wrote:
> 
>>> Has this been tested with the standalone non-ASoC PXA AC'97 driver?
> 
>> Nope. I have no such device.
> 
> I guess the main test there will be making sure that it builds with ASoC
> disabled.  I'm not sure anything later than PXA3xx ever actually used
> AC'97.
> 

Ah, I see it now.

I guess we have two options: either duplicate code from
soc-dmaengine-pcm, or move soc-dmaengine-pcm out of the ASoC context. I
actually see no dependecy to ASoC from there anyway.


Daniel
