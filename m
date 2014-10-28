From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 10:51:34 +0100
Subject: [PATCH 0/8] ARM: ux500: Add initial support for PM domains
In-Reply-To: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
References: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdZPtuC-AQsrZD8xhcg9GacKb2ifZ9u8HqcPU6H1NgGKdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 11:12 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> This patchset enables initial support for PM domains for ux500.
>
> The implementation is based upon the generic PM domain and its corresponding
> DT support, which is used to decribe PM domains and tell what devices resides
> in what PM domain.
>
> In this initial step, the VAPE PM domain is added and the devices with
> corresponding drivers that properly implements runtime PM support. Especially,
> to gate the VAPE PM domain drivers must implement register context save/restore.
> Typically that must be done from the driver's runtime PM callbacks.
>
> Currently the generic PM domain, doesn't handle IRQ safe devices very well. For
> example, having such device in a PM domain would keep it always powered. The
> DMA controller in ux500, handled by the ste_dma40 driver is configured as IRQ
> safe. That limitation in the generic PM domain needs to be fixed, prior we can
> add the DMA device to the VAPE PM domain.

All patches applied and will send a pull request to ARM SoC ASAP.

Yours,
Linus Walleij
