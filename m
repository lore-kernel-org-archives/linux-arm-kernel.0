From: andrea.adami@gmail.com (Andrea Adami)
Date: Fri, 8 Apr 2011 14:19:13 +0200
Subject: [PATCH] ARM: Allow for kernel command line concatenation
In-Reply-To: <1302255383-12375-1-git-send-email-oskar.andero@sonyericsson.com>
References: <1302255383-12375-1-git-send-email-oskar.andero@sonyericsson.com>
Message-ID: <BANLkTi=mV3VdJWk2H0f0UpgaWK=M8qrS=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 8, 2011 at 11:36 AM,  <oskar.andero@sonyericsson.com> wrote:
> From: Victor Boivie <victor.boivie@sonyericsson.com>
>
> This patch allows the provided CONFIG_CMDLINE to be concatenated
> with the one provided by the boot loader. This is useful to
> merge the static values defined in CONFIG_CMDLINE with the
> boot loader's (possibly) more dynamic values, such as startup
> reasons and more.
>
> Signed-off-by: Victor Boivie <victor.boivie@sonyericsson.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonyericsson.com>
> Signed-off-by: Oskar Andero <oskar.andero@sonyericsson.com>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

All fine from ARM point of view.
Just to remember there is space for a standardization in the sources
being that other archs have ended up using different names for the
same things:

CONFIG_CMDLINE
CONFIG_CMDLINE_BOOL
CONFIG_CMDLINE_OVERRIDE
CONFIG_CMDLINE_OVERWRITE
CONFIG_CMDLINE_EXTEND

During our kexecboot works we have battled with CMDLINE passed by
broken arm bootloaders and we are still fighting with mips kernels...


My 2 cents

Andrea
