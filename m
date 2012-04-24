From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Apr 2012 12:05:26 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <20120424034010.GA32166@shlinux2.ap.freescale.net>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
 <20120423074702.GD24843@shlinux2.ap.freescale.net>
 <20120423144623.GU26306@S2101-09.ap.freescale.net>
 <20120424034010.GA32166@shlinux2.ap.freescale.net>
Message-ID: <20120424040520.GC26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 11:40:11AM +0800, Dong Aisheng wrote:
> Then please feel free to comment on the pinctrl-imx binding if you've
> different option for mxs.

As I said, mxs and imx have different pin controllers.  There is no much
point to enforce them to use the same binding.  The binding design that
makes sense for imx may make less sense for mxs, and vice versa.

For example, all available mxs pin configuration options are only 3,
mA, voltage and pull-up, and they sit on different bit field of
different registers.  I feel much more comfortable with using properties
rather than a raw value to represent them, while I feel the raw value
binding makes some sense to imx, since it has many pin configuration
options and all these options sit in one register.

> But i did not receive you comment...
> 
I do have comment on two-level subnodes and the configuration data
duplication, but I do not think they are so critical.  So I would hold
my comments for now and see if Linus, Stephen and Sascha are happy with
the binding.  If they do, my comments are really not important, and
your patch can just go in.

-- 
Regards,
Shawn
