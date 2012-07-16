From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 17 Jul 2012 01:28:04 +0200
Subject: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable OMAP DMA
 engine support
In-Reply-To: <87bojfeikj.fsf@ti.com>
References: <1342321398-11009-1-git-send-email-javier@dowhile0.org>
 <87bojfeikj.fsf@ti.com>
Message-ID: <CABxcv=nbUOKKhJxTG302fX=UzHsX3mN=R2nEi88VZM61ka11Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 7:12 PM, Kevin Hilman <khilman@ti.com> wrote:
> Javier Martinez Canillas <javier@dowhile0.org> writes:
>
>> commit 13f30fc893e4610f67dd7a8b0b67aec02eac1775
>> Author: Russell King <rmk+kernel@arm.linux.org.uk>
>> Date:   Sat Apr 21 22:41:10 2012 +0100
>>
>>     mmc: omap: remove private DMA API implementation
>>
>> removed the private DMA API implementation from the OMAP mmc host to
>> make it use exclusively the DMA engine API.
>>
>> Unfortunately the omap2plus_defconfig doesn't enable this feature
>> leading to the following error on an IGEPv2 Rev.C (and probably on most
>> boards with MMC support):
>
> Personally, I'd rather see this fixed by having the drivers that depend
> on DMA engine 'select DMADEVICES'.  That way, any defconfig will work
> correctly instead of just omap2plus_defconfig.
>
> Kevin
>

Hi Kevin,

Thanks a lot for your feedback. I'll do what you suggest and send a v2
of the patch.

Best regards,
Javier
