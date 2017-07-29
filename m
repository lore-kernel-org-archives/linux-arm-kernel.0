From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 28 Jul 2017 18:50:58 -0700
Subject: [PATCH] irqchip: brcmstb-l2: Define an irq_pm_shutdown function
In-Reply-To: <20170727223817.7494-1-f.fainelli@gmail.com>
References: <20170727223817.7494-1-f.fainelli@gmail.com>
Message-ID: <CADtm3G4Rnm1276qYWe_MSnoZ2_Lxc1QFCUx1ZVfWtb5n4M2T2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 3:38 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The Broadcom STB platforms support S5 and we allow specific hardware
> wake-up events to take us out of this state. Because we were not
> defining an irq_pm_shutdown() function pointer, we would not be
> correctly masking non-wakeup events, which would result in spurious
> wake-ups from sources that were not explicitly configured for wake-up.
>
> Fixes: 7f646e92766e ("irqchip: brcmstb-l2: Add Broadcom Set Top Box Level-2 interrupt controller")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
