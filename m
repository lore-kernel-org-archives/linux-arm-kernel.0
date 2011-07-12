From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jul 2011 13:09:31 +0200
Subject: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
	configuration
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94030259DB5B@dbde02.ent.ti.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
	<CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
	<CACRpkdbLg0+_2kpi4NizFj0fDWb6QPtkcKirKgoH+83vGD0O0A@mail.gmail.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94030259DB5B@dbde02.ent.ti.com>
Message-ID: <CACRpkdYk65dmgvy325EA0rFEL3sZXMzNBvPBLGxctjQsfZhCBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 12:56 PM, Raju, Sundaram <sundaram@ti.com> wrote:
> [Me]
>> [Jassi]
>> > 3) TI may not have just one DMAC IP used in all the SoCs. So if you want
>> > ?vendor specific defines anyway, please atleast also add DMAC version to it.
>> > ?Something like
>> >> ? ? ? ?DMA_SLAVE_CONFIG,
>> >> ? ? ? ?FSLDMA_EXTERNAL_START,
>> >> + ? ? ? TI_DMA_v1_STRIDE_CONFIG,
>>
>> Yep unless we make it generic DMA_STRIDE_CONFIG simply, this makes
>> a lot of sense.
>
> Okay, I can add one cmd for the EDMAC in DaVinci series of SoCs and
> one for SDMAC in OMAP series of SoCs.

Wait, that's two different silicon blocks right? Then you already have proof
that this spans more than one DMAC and then you can just go for a generic
DMA_STRIDE_CONFIG from day one.

That both are TI does not matter, if they are totally unrelated implementations.

Yours,
Linus Walleij
