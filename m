From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 03 Jan 2013 00:14:38 +0100
Subject: [PATCH RESEND 6/6] clk: s5p-g2d: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <CA+_b7DK2zbBzbCh15ikEAeGP5h-V9gQ_YcX15O-RNvWxCk8Zfg@mail.gmail.com>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-7-git-send-email-linux@prisktech.co.nz>
 <50D62BC9.9010706@mvista.com> <50E32C06.5020104@gmail.com>
 <CA+_b7DK2zbBzbCh15ikEAeGP5h-V9gQ_YcX15O-RNvWxCk8Zfg@mail.gmail.com>
Message-ID: <50E4BF5E.9060108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2013 06:10 AM, Dan Carpenter wrote:
> clk_get() returns NULL if CONFIG_HAVE_CLK is disabled.

It's not a problem for this driver, as it never dereferences what's
returned from clk_get(). It would have to include <plat/clock.h>, which
it doesn't and which would have clearly indicated abuse of the clock API.

Moreover, this driver now depends on architectures that select HAVE_CLK,
so it couldn't be build when CONFIG_HAVE_CLK is disabled.

> I told Tony about this but everyone has been gone with end of year
> holidays so it hasn't been addressed.
>
> Tony, please fix it so people don't apply these patches until
> clk_get() is updated to not return NULL.  It sucks to have to revert
> patches.

As explained by Russell many times, the clock API users should not care
whether the value returned from clk_get() is NULL or not. It should only
be tested with IS_ERR(). The patches look fine to me, no need to do
anything.

---

Regards,
Sylwester
