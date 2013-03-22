From: cjb@laptop.org (Chris Ball)
Date: Fri, 22 Mar 2013 12:58:35 -0400
Subject: [PATCH] ARM: at91/avr32/atmel-mci: fix DMA-channel leak on module
 unload
In-Reply-To: <46568.1708221838$1363345027@news.gmane.org> (Ludovic Desroches's
 message of "Fri, 15 Mar 2013 11:56:06 +0100")
References: <1363191119-4948-1-git-send-email-jhovold@gmail.com>
 <46568.1708221838$1363345027@news.gmane.org>
Message-ID: <87ehf7mkw4.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 15 2013, Ludovic Desroches wrote:
> On Wed, Mar 13, 2013 at 05:11:59PM +0100, Johan Hovold wrote:
>> Fix regression introduced by commit 796211b7953 ("mmc: atmel-mci: add
>> pdc support and runtime capabilities detection") which removed the need
>> for CONFIG_MMC_ATMELMCI_DMA but kept the Kconfig-entry as well as the
>> compile guards around dma_release_channel() in remove(). Consequently,
>> DMA is always enabled (if supported), but the DMA-channel is not
>> released on module unload unless the DMA-config option is selected.
>> 
>> Remove the no longer used CONFIG_MMC_ATMELMCI_DMA option completely.
>> 
>> Cc: stable <stable@vger.kernel.org>
>> Signed-off-by: Johan Hovold <jhovold@gmail.com>
>
> Hi Johan,
>
> Good point so
>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks, I'll merge this via the MMC tree if no-one objects.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
