From: robherring2@gmail.com (Rob Herring)
Date: Mon, 3 Mar 2014 17:04:23 -0600
Subject: spear-cpufreq + multiplatform?
In-Reply-To: <20140303180809.GA28282@joshc.qualcomm.com>
References: <20140303180809.GA28282@joshc.qualcomm.com>
Message-ID: <CAL_JsqJ1sHAXu3vzx7Q3mvFT=3JuH-a6d-tJHYZ=JCHUCF6Luw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 12:08 PM, Josh Cartwright <joshc@codeaurora.org> wrote:
> Hey folks-
>
> I noticed booting today's next on a non-spear platform, that I'm seeing
> the following in my logs:
>
>         [    2.126494] spear_cpufreq: Invalid cpufreq_tbl
>
> Looking closer, it looks like the spear-cpufreq driver has a
> late_initcall() that's not too multiplatform friendly.  Perhaps the
> spear cpufreq initialization routine should be called explicitly from
> some platform-specific code, or explicitly check to ensure it's running
> on SPEAr?

Yes, I've seen this on 3.14 as well.

There are also less harmful driver printk's for drivers where the
device is not present. Serial and EHCI drivers are the main culprits.

Rob

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
