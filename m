From: nm@ti.com (Nishanth Menon)
Date: Tue, 26 Nov 2013 16:13:53 -0600
Subject: [PATCH 05/12] ARM: OMAP2+: Remove legacy PM init
In-Reply-To: <1385424867-27243-6-git-send-email-tony@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <1385424867-27243-6-git-send-email-tony@atomide.com>
Message-ID: <CAGo_u6pwOdizyxD8Hy_znQHG0Spk-UTOKYxfj30UMxi7=cUbtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 6:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> This is no longer needed when booted with device tree.
[...]
>  static inline void omap_init_cpufreq(void)
>  {
>         struct platform_device_info devinfo = { };
>
> -       if (!of_have_populated_dt())
> -               devinfo.name = "omap-cpufreq";
> -       else
> -               devinfo.name = "cpufreq-cpu0";
> +       devinfo.name = "cpufreq-cpu0";

struct platform_device_info devinfo = { .name = "cpufreq-cpu0" };

otherwise, ok with the change.
Thanks and Regards,
Nishanth Menon
