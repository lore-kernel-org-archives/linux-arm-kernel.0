From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 20 Jul 2012 13:00:01 +0530
Subject: [RFC 4/4] ARM: OMAP3: PM: Use .power_on/.power_down to clean
 omap_sram_idle
In-Reply-To: <1342764284-8143-5-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
 <1342764284-8143-5-git-send-email-rnayak@ti.com>
Message-ID: <CAMQu2gyk=h2Mt1RfJ83xSVN4dtTLt2Za15OEKBTq_4WaCOkGFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> With .power_on/.power_down hooks now available within the powerdomain
> framework, its possible to clean a lot of mpu/core power_on/power_down
> related code within omap_sram_idle into respective callbacks for these
> powerdomains.
>
> This should atleast also optimise the core domain context save
> in CPUidle when attempting deeper C states, to prevent a core
> domain context save when a device in core is still active.
> The current code in such cases does a blind context save and
> tries to put core domain down, even while devices are active.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
Looks more modular now. Thanks Rajendra and this series is
a good step towards decoupling CORE IDLE with CPUIDLE.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
