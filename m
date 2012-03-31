From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 31 Mar 2012 09:33:45 +0800
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <CAOMZO5ATwkFOc=B55atMgugx7uiwVe1MyTHS2ynSX7dF5N+S3A@mail.gmail.com>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5ATwkFOc=B55atMgugx7uiwVe1MyTHS2ynSX7dF5N+S3A@mail.gmail.com>
Message-ID: <20120331013342.GJ3254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 11:23:13AM -0300, Fabio Estevam wrote:
> On Fri, Mar 30, 2012 at 10:55 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > The commit 04bf301 (regulator: Support driver probe deferral) changes
> > regulator_get() and regulator_register() to return -EPROBE_DEFER
> > instead of -ENODEV. ?Adapt amba bus driver to the change, otherwise
> > amba_probe() will fail on the platforms that do not have "vcore"
> > regulator device.
> >
> > It fixes the boot failure on i.mx28 which uses amba-pl011 as serial
> > console.
> 
> Tested this patch in linux-next-20120330 and my mx28evk still does not boot.
> 
> Any other patch is needed?

Yes.  One more fix is needed.

serial: PL011: move interrupt clearing
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/158694

-- 
Regards,
Shawn
