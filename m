From: robh@kernel.org (Rob Herring)
Date: Thu, 23 Feb 2017 09:28:23 -0600
Subject: [PATCH 00/35] treewide trivial patches converting pr_warning to
 pr_warn
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
Message-ID: <CAL_JsqLTaq-QLTqfyDO8EVJYpgeUx1e4J0Fo2NvfFWqVoiVedQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 1:11 AM, Joe Perches <joe@perches.com> wrote:
> There are ~4300 uses of pr_warn and ~250 uses of the older
> pr_warning in the kernel source tree.
>
> Make the use of pr_warn consistent across all kernel files.
>
> This excludes all files in tools/ as there is a separate
> define pr_warning for that directory tree and pr_warn is
> not used in tools/.
>
> Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
>
> Miscellanea:
>
> o Coalesce formats and realign arguments
>
> Some files not compiled - no cross-compilers
>
> Joe Perches (35):
>   alpha: Convert remaining uses of pr_warning to pr_warn
>   ARM: ep93xx: Convert remaining uses of pr_warning to pr_warn
>   arm64: Convert remaining uses of pr_warning to pr_warn
>   arch/blackfin: Convert remaining uses of pr_warning to pr_warn
>   ia64: Convert remaining use of pr_warning to pr_warn
>   powerpc: Convert remaining uses of pr_warning to pr_warn
>   sh: Convert remaining uses of pr_warning to pr_warn
>   sparc: Convert remaining use of pr_warning to pr_warn
>   x86: Convert remaining uses of pr_warning to pr_warn
>   drivers/acpi: Convert remaining uses of pr_warning to pr_warn
>   block/drbd: Convert remaining uses of pr_warning to pr_warn
>   gdrom: Convert remaining uses of pr_warning to pr_warn
>   drivers/char: Convert remaining use of pr_warning to pr_warn
>   clocksource: Convert remaining use of pr_warning to pr_warn
>   drivers/crypto: Convert remaining uses of pr_warning to pr_warn
>   fmc: Convert remaining use of pr_warning to pr_warn
>   drivers/gpu: Convert remaining uses of pr_warning to pr_warn
>   drivers/ide: Convert remaining uses of pr_warning to pr_warn
>   drivers/input: Convert remaining uses of pr_warning to pr_warn
>   drivers/isdn: Convert remaining uses of pr_warning to pr_warn
>   drivers/macintosh: Convert remaining uses of pr_warning to pr_warn
>   drivers/media: Convert remaining use of pr_warning to pr_warn
>   drivers/mfd: Convert remaining uses of pr_warning to pr_warn
>   drivers/mtd: Convert remaining uses of pr_warning to pr_warn
>   drivers/of: Convert remaining uses of pr_warning to pr_warn
>   drivers/oprofile: Convert remaining uses of pr_warning to pr_warn
>   drivers/platform: Convert remaining uses of pr_warning to pr_warn
>   drivers/rapidio: Convert remaining use of pr_warning to pr_warn
>   drivers/scsi: Convert remaining use of pr_warning to pr_warn
>   drivers/sh: Convert remaining use of pr_warning to pr_warn
>   drivers/tty: Convert remaining uses of pr_warning to pr_warn
>   drivers/video: Convert remaining uses of pr_warning to pr_warn
>   kernel/trace: Convert remaining uses of pr_warning to pr_warn
>   lib: Convert remaining uses of pr_warning to pr_warn
>   sound/soc: Convert remaining uses of pr_warning to pr_warn

Where's the removal of pr_warning so we don't have more sneak in?

Rob
