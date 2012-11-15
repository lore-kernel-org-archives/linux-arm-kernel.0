From: amurray@embedded-bits.co.uk (Andrew Murray)
Date: Thu, 15 Nov 2012 13:52:06 +0000
Subject: [PATCH 1/2] Boottime: A tool for automatic measurement of
 kernel/bootloader boot time
In-Reply-To: <1352973847-21605-2-git-send-email-lee.jones@linaro.org>
References: <1352973847-21605-1-git-send-email-lee.jones@linaro.org>
 <1352973847-21605-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CAPcvp5ER_rMnyzbKR8r8NJf_naNs6y8gBi0jg5TtOwq88Xgh9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2012 10:04, Lee Jones <lee.jones@linaro.org> wrote:
> The overhead is very low and the results will be found under
> sysfs/bootime, as well as detailed results in debugfs under
> boottime/. The bootgraph* files are compatible with
> scripts/bootgraph.pl. The reason for this patch is to provide
> data (sysfs/boottime) suitable for automatic test-cases as
> well as help for developers to reduce the boot time (debugfs).
>
> Based heavily on the original driver by Jonas Aaberg.
>

> +
> +static LIST_HEAD(boottime_list);
> +static DEFINE_SPINLOCK(boottime_list_lock);
> +static struct boottime_timer boottime_timer;
> +static int num_const_boottime_list;
> +static struct boottime_list const_boottime_list[NUM_STATIC_BOOTTIME_ENTRIES];
> +static unsigned long time_kernel_done;
> +static unsigned long time_bootloader_done;
> +static bool system_up;
> +static bool boottime_done;
> +
> +int __attribute__((weak)) boottime_arch_startup(void)
> +{
> +       return 0;
> +}
> +
> +int __attribute__((weak)) boottime_bootloader_idle(void)
> +{
> +       return 0;
> +}

You may wish to use the __weak macro (include/linux/compiler*) instead
of directly using GCC attributes here.

Andrew Murray
