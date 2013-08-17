From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 17 Aug 2013 15:24:28 +0200
Subject: [RFC v1 1/5] irqchip: add Armada 1500 APB interrupt controller
In-Reply-To: <1376682098-10580-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <520F798C.2040606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2013 09:41 PM, Sebastian Hesselbarth wrote:
> This adds irqchip drivers for the secondary interrupt controllers found
> on Armada 1500 APB and SYSMGT APB bus.
>
> I tried to find a compatible irqchip driver within v3.11-rc5, but there
> is no. I guess that it is a common IP core to buy for your SoC, so maybe
> one of the maintainers knows a better name for it. Could be DesignWare
> type-of as timers are DW, too.

 From a quick look into Synopsys DW ip library, it probably matches 
dw_apb_ictl best and should be named accordingly. Next round will
name the source dw_apb_ictl.c and corresponding compatible
"snps,dw-apb-ictl".

In addition, it looks like the ip can support up to 64 irqs. For orion
irq, I have used a "mavell,#interrupts" to allow to pass the number of
supported irqs. Above driver should also exploit a similar
snps-prefixed property.

Sebastian
