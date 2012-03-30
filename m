From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Mar 2012 11:23:13 -0300
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOMZO5ATwkFOc=B55atMgugx7uiwVe1MyTHS2ynSX7dF5N+S3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 10:55 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> The commit 04bf301 (regulator: Support driver probe deferral) changes
> regulator_get() and regulator_register() to return -EPROBE_DEFER
> instead of -ENODEV. ?Adapt amba bus driver to the change, otherwise
> amba_probe() will fail on the platforms that do not have "vcore"
> regulator device.
>
> It fixes the boot failure on i.mx28 which uses amba-pl011 as serial
> console.

Tested this patch in linux-next-20120330 and my mx28evk still does not boot.

Any other patch is needed?
