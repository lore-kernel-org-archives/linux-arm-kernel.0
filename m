From: john.stultz@linaro.org (John Stultz)
Date: Fri, 20 Nov 2015 11:11:51 -0800
Subject: [PATCH v2] clocksource: arm_global_timer: fix suspend resume
In-Reply-To: <564F6A92.7080006@arm.com>
References: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com>
 <564F570C.7030409@oracle.com> <564F67ED.9000905@ti.com>
 <564F6A92.7080006@arm.com>
Message-ID: <CALAqxLVMtL+Vkao1i61zQFzcPK3VE3ZtUyu1B1TuPQppOGcUNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 10:46 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> This patch has a very specific purpose: instructing the core code that
> this timer will never stop ticking, ever. It is really targeted at
> virtual machines, whose timer is backed by the host timer, even when the
> VM is not running.
>
> Using it on actual hardware is may not be the best idea, specially in
> the presence of PM.

And actually, the CLOCK_SOURCE_SUSPEND_NONSTOP flag was added to
support real hardware, so its not just limited to VMs. But that
hardware does have to keep the lights on for the counter backing the
clocksource, and I'm not sure how common it ever became.

thanks
-john
