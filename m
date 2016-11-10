From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Nov 2016 16:10:56 +0100
Subject: [PATCH RFC 2/7] ARM: S3C64XX: Add DMA slave maps for PL080 devices
In-Reply-To: <20161110110323.GG1575@localhost.localdomain>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-4-git-send-email-s.nawrocki@samsung.com>
 <20161108144445.GD1575@localhost.localdomain>
 <CGME20161108145620epcas2p4b8e2ec5ffdd4bf04ab3bf0728b46e3f2@epcas2p4.samsung.com>
 <20161108145534.GE1575@localhost.localdomain>
 <f53d533d-163f-31f3-4efb-0e39d201589d@samsung.com>
 <20161110110323.GG1575@localhost.localdomain>
Message-ID: <b654d5f7-7b67-7216-760f-d29e49a29296@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2016 12:03 PM, Charles Keepax wrote:
>> On Tue, Nov 08, 2016 at 04:53:40PM +0100, Sylwester Nawrocki wrote:
[...]
>> I pushed now to branch for-v4.10/dma/pl080-s3c64xx-v2 with this
>> issue fixed and added initialization of the filer function.
> 
> Apologies for the delay got somewhat swamped with internal stuff
> yesterday. Yeah using that branch it looks good to me, the SPI and
> I2S are both working fine. I can download code to the wm0010
> which should be a good work out of the SPI and play audio
> correctly so the I2S should be fine. So for the series:
> 
> Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Great, thanks a lot!  I'm going to post the next iteration with
modified pl080 DMAC patches, addressing comments from Arnd.
I would be grateful if you could confirm it also works on your
platform.

> I do still need to revert these two patches to get the I2S to
> work properly:
> 
> commit d70e861a3154833467023123e218e9b1ba558809
> ASoC: samsung: Remove SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
> 
> commit acde50a7bf1fd6ae0baa4402f0a02c4b1bd4c990
> ASoC: dmaengine_pcm: Make FLAG_NO_RESIDUE internal
> 
> But that is clearly an unrelated issue, which I haven't found
> time to look into yet as we don't use this platform that often
> these days.

Thanks for reporting this, I will see if I can find time to look
into this issue as well.

-- 
Thanks,
Sylwester
