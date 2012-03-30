From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Mar 2012 19:01:34 +0100
Subject: [PATCH] ARM: amba: adapt to regulator probe deferral change
In-Reply-To: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
References: <1333115737-1654-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120330180134.GJ22981@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 09:55:37PM +0800, Shawn Guo wrote:
> The commit 04bf301 (regulator: Support driver probe deferral) changes
> regulator_get() and regulator_register() to return -EPROBE_DEFER
> instead of -ENODEV.  Adapt amba bus driver to the change, otherwise
> amba_probe() will fail on the platforms that do not have "vcore"
> regulator device.

Are you sure this is correct?  Did you read and understand the comment
you removed?

What do platforms do which have AMBA devices but don't have any vcore
regulators?

We're not going through the same farce that the smsc network driver has
gone through: OMAP3430LDP remains fucked through that idiotic ill-thought
out change (c7e963f68888, net/smsc911x: Add regulator support).  See
http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=99
