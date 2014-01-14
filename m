From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 07:42:26 -0800
Subject: [PATCH RFC 04/10] base: power: Add generic OF-based power domain
 look-up
In-Reply-To: <1389469372-17199-5-git-send-email-tomasz.figa@gmail.com> (Tomasz
 Figa's message of "Sat, 11 Jan 2014 20:42:46 +0100")
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-5-git-send-email-tomasz.figa@gmail.com>
Message-ID: <87r48a8t99.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa <tomasz.figa@gmail.com> writes:

> This patch introduces generic code to perform power domain look-up using
> device tree and automatically bind devices to their power domains.
> Generic device tree binding is introduced to specify power domains of
> devices in their device tree nodes.
>
> Backwards compatibility with legacy Samsung-specific power domain
> bindings is provided, but for now the new code is not compiled when
> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
> will change as soon as Exynos power domain code gets converted to use
> the generic framework in further patch.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

I haven't read through this in detail yet, but wanted to make sure that
the DT representation can handle nested power domains.  At least
SH-mobile has a hierarchy of power domains and the genpd code can handle
that, so wanted to make sure that the DT representation can handle it as
well.

Thanks,

Kevin
