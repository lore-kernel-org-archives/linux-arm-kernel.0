From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 16 Oct 2015 21:29:25 +0200
Subject: Atmel SoCs and the newly added CONFIG_DELAY_DEVICE_PROBES option
In-Reply-To: <20151016181129.GA1764@gradator.net>
References: <20151016181129.GA1764@gradator.net>
Message-ID: <CAAObsKBn5DaXT3J9CG6j_f0RxJpo+WQcj-8w5xz_N64OWEYesw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2015 at 20:11, Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> Hi,
>
> FYI, to save you a git bisect, the recently added
> CONFIG_DELAY_DEVICE_PROBES (enabled by default) breaks Atmel SoCs.
>
> For a few of quickly noticeable issues:
> - PM is not working:   at91_pm_sram_init: sram pool unavailable!
> - Watchdog is not even probed
> - on -ek boards the wm8904 is not probed either.
>
> Disabling CONFIG_DELAY_DEVICE_PROBES fixes all issues.
>
> Tomeu, what should I provide to help find out what's happening ?

Hi Sylvain, I believe I can do some testing via kernelci on those
boards, latest on monday.

It will probably involve moving some initcalls, and probing more kinds
of devices on-demand. Sometimes the proper solution is to move code
from initcalls into proper drivers which can defer their probe if some
dependency isn't there at that point, but that's likely to be more
invasive than wanted at this point.

Regards,

Tomeu

> Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
