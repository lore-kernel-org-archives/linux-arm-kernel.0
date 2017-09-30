From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 29 Sep 2017 22:34:08 -0700
Subject: [PATCH 0/7] gpio: brcmstb: improved interrupt and wake support
In-Reply-To: <20170930034057.15166-1-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
Message-ID: <b2758902-a1b7-1621-5eec-651f3ada92e7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/29/2017 08:40 PM, Doug Berger wrote:
> This patch set collects a number of improvements to the GPIO driver
> used by Broadcom Set-Top-Box devices.
> 
> Primarily they are aimed at correcting problems with the interrupt
> controller implementation, but they also extend the functionality for
> waking on GPIO interrupts.

This all looks good to me, thanks a lot for sending those patches out!

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> Doug Berger (7):
>   gpio: brcmstb: allow all instances to be wakeup sources
>   gpio: brcmstb: release the bgpio lock during irq handlers
>   gpio: brcmstb: switch to handle_level_irq flow
>   gpio: brcmstb: correct the configuration of level interrupts
>   gpio: brcmstb: enable masking of interrupts when changing type
>   gpio: brcmstb: consolidate interrupt domains
>   gpio: brcmstb: implement suspend/resume/shutdown
> 
>  drivers/gpio/Kconfig        |   2 +-
>  drivers/gpio/gpio-brcmstb.c | 419 +++++++++++++++++++++++++++++++++-----------
>  2 files changed, 321 insertions(+), 100 deletions(-)
> 

-- 
Florian
