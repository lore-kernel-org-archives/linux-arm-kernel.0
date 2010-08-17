From: wellsk40@gmail.com (Kevin Wells)
Date: Tue, 17 Aug 2010 10:30:22 -0700
Subject: video: amba_clcd: Clock balance fixes and power optimization
	changes
In-Reply-To: <1281567784-12684-1-git-send-email-wellsk40@gmail.com>
References: <1281567784-12684-1-git-send-email-wellsk40@gmail.com>
Message-ID: <AANLkTi=uSopTVhbuhjuuYRvMYTY6gpe_JsEiFN9RZYWN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 4:03 PM,  <wellsk40@gmail.com> wrote:
> These patches fix clock balance issues (clk_disable called when
> clk_enabled was not previously called) and optimizes clocking for
> register access.
>
> [PATCH 1/2] video: amba_clcd: Fix driver clock enable/disable balance issues
> [PATCH 2/2] video: amba_clcd: Seperate controller and register clock enables
>
> Patch 1 is basically RK's suggested fix repackaged here.
>
> The register clocking fix was written to avoid calling the AMBA
> clock enable and disable functions as nested calls (ie, 2 calls
> to disable). The number of calls can be reduced by a few calls if
> nesting can be used. This depends on the arch's clock drivers and
> whether they support nesting. The method used here is safe for
> clock drivers that don't like nested calls.
>

I haven't heard any feedback on these patch suggestions. Patch 1 is needed.
Patch 2 is highly desirable to keep power usage to a minimum when the
lcd is off.

> These patches can be pulled from:
> ? ? ? ?git://lpclinux.com/linux-2.6-lpc pl11x_clk_fixes
>
>
