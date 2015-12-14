From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 14 Dec 2015 22:17:55 +0100
Subject: [PATCH 0/3] cpuidle: avoid module usage in non-modular code
In-Reply-To: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
References: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <566F3203.5010009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2015 12:57 AM, Paul Gortmaker wrote:
> This series of commits is a part of a larger project to ensure
> people don't reference modular support functions in non-modular
> code.  Overall there was roughly 5k lines of dead code in the
> kernel due to this.  So far we've fixed several areas, like tty,
> x86, net, ... and we continue to work on other areas.
>
> There are several reasons to not use module support for code that
> can never be built as a module, but the big ones are:
>
>   (1) it is easy to accidentally code up unused module_exit and remove code
>   (2) it can be misleading when reading the source, thinking it can be
>        modular when the Makefile and/or Kconfig prohibit it
>   (3) it requires the include of the module.h header file which in turn
>       includes nearly everything else.
>
> Fortunately for cpuidle, the changes are largely trivial and change
> zero runtime.  All the changes here just remap the modular functions
> onto the non-modular ones that they would be remapped onto anyway.
>
> Changes are against linux-next and compile tested on ARM allmodconfig.
> I've Cc'd ARM list because all of these are used on ARM, but I'm
> thinking these probably can go in via the PM tree.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
