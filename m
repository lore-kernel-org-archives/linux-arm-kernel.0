From: nbowler@elliptictech.com (Nick Bowler)
Date: Thu, 7 Apr 2011 09:18:10 -0400
Subject: [PATCH] ARM: Allow for kernel command line concatenation
In-Reply-To: <1302164236-1516-1-git-send-email-oskar.andero@sonyericsson.com>
References: <1302164236-1516-1-git-send-email-oskar.andero@sonyericsson.com>
Message-ID: <20110407131810.GA6450@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-04-07 10:17 +0200, oskar.andero at sonyericsson.com wrote:
> From: Victor Boivie <victor.boivie@sonyericsson.com>
> 
> This patch allows the provided CONFIG_CMDLINE to be concatenated
> with the one provided by the boot loader. This is useful to
> merge the static values defined in CONFIG_CMDLINE with the
> boot loader's (possibly) more dynamic values, such as startup
> reasons and more.

This sounds very useful!  One comment below.

> Signed-off-by: Victor Boivie <victor.boivie@sonyericsson.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonyericsson.com>
> Signed-off-by: Oskar Andero <oskar.andero@sonyericsson.com>
> ---
>  arch/arm/Kconfig        |   21 +++++++++++++++++++--
>  arch/arm/kernel/setup.c |    9 ++++++++-
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
[...]
> +config CMDLINE_EXTEND
> +	bool "Extend bootloader kernel arguments"
> +	depends on CMDLINE != ""
> +	help
> +	  The default kernel command string will be concatenated with the
> +	  arguments provided by the boot loader.

Since concatenation is not commutative, this help text should describe
exactly the order in which the arguments are concatenated.  How about
this instead:

  The command-line arguments provided by the boot loader will be
  appended to the default kernel command string.

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
