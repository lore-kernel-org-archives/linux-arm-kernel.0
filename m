From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 24 Jan 2013 07:45:02 +0530
Subject: [PATCH 4/4] irqchip: gic: Perform the gic_secondary_init() call
 via CPU notifier
In-Reply-To: <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
 <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <CAOh2x=msVSRmnzp0Fen+OoNpkQ25kGW=XKCbrOtwjNToomC9mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 11:29 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> All the calls to gic_secondary_init() pass 0 as the first argument.
> Since this function is called on each CPU when starting, it can be done
> in a platform-independent way via a CPU notifier registered by the GIC
> code.

>  arch/arm/mach-spear13xx/platsmp.c    |  8 --------

For SPEAr,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
