From: aida.mynzhasova@skitlab.ru (Aida Mynzhasova)
Date: Thu, 06 Jun 2013 10:03:42 +0400
Subject: [PATCH 0/5] Broken DM816x support in Linux 3.10-rc4
In-Reply-To: <alpine.DEB.2.02.1306060346390.15042@utopia.booyaka.com>
References: <1370446156-11788-1-git-send-email-aida.mynzhasova@skitlab.ru>
 <alpine.DEB.2.02.1306060346390.15042@utopia.booyaka.com>
Message-ID: <51B0263E.6000109@skitlab.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.06.2013 07:54, Paul Walmsley wrote:
> ????????????,
>
> On Wed, 5 Jun 2013, Aida Mynzhasova wrote:
>
>> Not so long ago I tried to boot Linux 3.10-rc4 kernel on DM816x EVM
>> board. Unfortunately, my attempts were failed by reason of poor
>> support of DM81xx-based devices in new kernels.
>
> Yeah, TI pretty much gave up on trying to get support for that chip
> upstream a few years ago.  Same for DM814x.
>
>> So, I suggest you this patch series, which fixes that kernel crush and
>> adds new functions/structures, required for early initialization on
>> DM816x (power and clock domains, hwmods). After applying these patches
>> the kernel is able to successfully continue booting till clock
>> initialization (will be added later).
>
> OK, it will be great to get my DM8168EVM booting on mainline.  But there
> are a few preliminary issues with the patches:
>
> 1. All new chip and board support needs to be DT-only.  So, no new board
> files.  Also, all the hwmod data shouldn't have IRQ, DMA, etc. data - that
> should come from DT.  See for example the recently posted patch "[PATCH
> 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info clean up"
>
> 2. Looks like patch 2 is missing from the list.  If it's too big for the
> list, please break it down into smaller patches.
>
> 3. Did you write this code and data, hwmods, etc., or did it come from a
> TI kernel?  Please note this clearly in the patch descriptions.
>
>
> - Paul
>

Hi!

Thanks for reply!
ok, I'll rewrite code by means of DT and add some additional notes to 
patch description.

Aida.
