From: ccross@android.com (Colin Cross)
Date: Wed, 21 Sep 2011 09:14:08 -0700
Subject: [PATCH] ARM: tegra: Remove redundant change to the CPSR in
	headsmp.S
In-Reply-To: <20110914091531.GA2104@arm.com>
References: <1315411253-17559-1-git-send-email-dave.martin@linaro.org>
	<20110912165222.GE2020@arm.com>
	<CAMbhsRSoSYhuqPC+SmCNk4dseok0vs02su0kihKNqXGpCvUvSg@mail.gmail.com>
	<20110914091531.GA2104@arm.com>
Message-ID: <CAMbhsRTrwyEwxCKHEYx0PVt7DTFDE7o5+9T8qz=82jZBEYYYxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 2:15 AM, Dave Martin <dave.martin@linaro.org> wrote:

<snip>

> With regard to Thumb-2 kernels, what code is responsible for
> performing the jump to tegra_secondary_startup?
arch/arm/mach-tegra/platsmp.c puts the physical address of
tegra_secondary_startup into the reset vector, and then brings the cpu
out of reset.  As far as I know, it is always in ARM mode, but it is
possible that it comes through ROM code that ends with a bx, allowing
it to be entered in Thumb mode.

> If the jump is done by making an exception return from some firmware,
> you may find you hit tegra_secondary_starup in ARM state, and
> everything will go horribly wrong...
>
> It could be worth making the secondary kernel entry point ARM code
> unconditionally (just as is now done for the primary kernel entry
> point).
That seems safest.

> Cheers
> ---Dave
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
