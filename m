From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 May 2011 20:06:32 +0200
Subject: [PATCH 1/2] spi/pl022: timeout on polled transfer v2
In-Reply-To: <BANLkTi=COt5Te4bF1M30A+R4Vqnz=kWiJA@mail.gmail.com>
References: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=s4nzi=5f+Vvh3ABuspnKXQVUfLw@mail.gmail.com>
	<BANLkTi=mQbPt9rcqEVyMLy3rkF2D7FMh=g@mail.gmail.com>
	<BANLkTi=COt5Te4bF1M30A+R4Vqnz=kWiJA@mail.gmail.com>
Message-ID: <BANLkTikR7A1Y4sumjZXS5ou3ex7PJOi1CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/19 Vitaly Wool <vitalywool@gmail.com>:
> On Thu, May 19, 2011 at 7:36 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>
>>> just out of curiosity: is it a busy wait? Looks like it is...
>>
>> Yep that's the polling mode part. IRQ and DMA mode should
>> be the norm I guess.
>>
>> Magnus: do you have a specific use case for this thing?
>
> Well, adding cpu_relax() somewhere in the loop might be not a bad idea...

OK sent a patch for it, and Grant applied it within something like
30 seconds :-)

I think on ARM that just boils down to a barrier() so it
basically injects air in the pipeline when busywaiting, I never
understood what that is good for, but it's a good marker anyway.

Linus Walleij
