From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Jul 2012 10:04:53 -0600
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201207240719.03601.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201207171924.33756.arnd@arndb.de> <500DC255.40900@wwwdotorg.org>
 <201207240719.03601.arnd@arndb.de>
Message-ID: <500EC7A5.6020907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2012 01:19 AM, Arnd Bergmann wrote:
> On Monday 23 July 2012, Stephen Warren wrote:
>>> 3. A device with three channels, one of which has two alternatives:
>>
>> s/three/four/   s/one of which/both of which/
>>
>> This binding doc seems reasonable to me.
> 
> I asked a linguist about it who said that you can't have "both" together
> with "four". She also mentioned that my text is rather confusing, so maybe
> you also got it wrong. I'll try adding some explanation:

Oops, I guess I meant s/three/two/ :-)

It seems that given there are two values for dma-names, there really are
two channels; it's just that one channel is bi-directional, and the
second has two alternatives.

Still, I guess you could also view this as three separate channels
instead. In which case, the text below makes sense.

> 3. A device with three channels, one of which has two alternatives:
> 
>         dmas = <&dma0 1 4   /* first channel,  data read */
>                 &dma0 2 6   /* second channel, data write */
>                 &dma1 1 0   /* third channel,  error read */
>                 &dma2 1 0>; /* third channel,  ernative error read */
>         dma-names = "data", "data", "error", "error";
> 
>    The first two channels are identified by having a unique direction
>    flag in combination with the "data" string. For the third channel,
>    there are two dma specifiers with identical flags (1) and strings
>    ("error"), so only one specifier may be used at a time.
