From: zonque@gmail.com (Daniel Mack)
Date: Mon, 16 Dec 2013 10:58:10 +0100
Subject: [PATCH v2 03/16] ARM: dts: provide DMA config to pxamci
In-Reply-To: <1387049660.7152.317.camel@host5.omatika.ru>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>	
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>	
 <1386901645-28895-4-git-send-email-ynvich@gmail.com>	
 <201312142006.26979.arnd@arndb.de>
 <1387049660.7152.317.camel@host5.omatika.ru>
Message-ID: <52AECEB2.4070807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2013 08:34 PM, Sergei Ianovich wrote:
> On Sat, 2013-12-14 at 20:06 +0100, Arnd Bergmann wrote:

>> The patch looks ok in case we are merging your patches for 3.14
>> and Daniel's patches later than that. If they end up in the
>> same merge window however, we'd have to be care to resolve
>> the obvious conflict in a proper way.
> 
> The most recently published Daniel's patch (Aug 2013) wraps
> IORESOURCE_DMA handling on DT presence in a similar way,

Erm, no it doesn't. My patch uses dma_request_slave_channel_compat() in
DT case, and that works fine with the current version of pdma, and
there's no need to read the "dmas" properties directly.

If you want to provide a way to simply denote the dma channel numbers,
without looking at the actual phandle, then yes, we could merge this
patch first, but it would be effectively reverted a proper implementation.


Daniel
