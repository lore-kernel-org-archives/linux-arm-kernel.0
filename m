From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Feb 2013 13:30:22 +0800
Subject: [PATCH 3/3] pinctrl: imx: move hard-coding data into device tree
In-Reply-To: <51251E5A.1080806@wwwdotorg.org>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-4-git-send-email-shawn.guo@linaro.org>
 <51251E5A.1080806@wwwdotorg.org>
Message-ID: <20130221053020.GE17738@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 12:04:58PM -0700, Stephen Warren wrote:
> There are a couple of potential issues with this patch, which I'm in two
> minds about:
> 
> 1)
> 
> This is an incompatible change to the DT binding definition. A DT
> written to the old specification won't work with a newer kernel and
> vice-versa. This isn't supposed to happen with device tree.
> 
> Right now I believe we're still being flexible about DT binding changes,
> but I've seen hints that this kind of thing will start getting lots of
> push-back in the near future...
> 
Last time I heard of the time frame about doing this is when we get
device tree source maintained in a separate repository from the kernel
tree.  I'm not sure how far we're still away from that.  But most of
sub-architectures (including IMX) have not been converted over to
device tree.  And as far as I know, none of IMX based product runs
device tree kernel yet.  So I think at least for IMX we are still
in a phase of being flexible about DT binding changes.

> That all said, I'd also love to change the Tegra pinctrl binding now
> that we have CPP, since I could replace all the strings in the current
> binding with integers and presumably save some space in the .dtb. Hence,
> I'd love to maintain the flexibility to keep changing the .dts and
> kernel code in lock-step.
> 
> 2)
> 
> This patch removes a bunch of tables from the kernel. I like having the
> tables in the kernel, since in theory it could allow a future debugfs or
> sysfs interface to pinctrl that allows manipulation of the pinctrl HW
> state at a semantic level. This is only possible if the DT binding
> includes details such as "set this pin to this function", and the driver
> includes the tables to convert that into details such as register
> address and value. I don't think such an "API" could be implemented for
> IMX after this patch. Still, given the IMX binding already merged "pin"
> and "function" into a single integer in the binding, I'm not sure if IMX
> could support that kind of "API" before anyway?
> 
Right, we do not support that even before the patch.  As the platform
maintainer and user, I do not think this kind of support is so useful
for IMX.

> This is part of the reason I pushed hard for the pinctrl APIs to operate
> at the semantic pin/group/function level, and that Tegra's pinctrl
> drivers explicitly have tables listing all the pins/groups/functions,
> rather than just putting a bunch of register values into the DT.
> 
> I'm not sure how much of an issue this is, though. LinusW and/or the DT
> maintainers should probably chime in here.
> 
IIRC, LinusW said it can be a decision of platform.

Shawn

> I didn't actually read the driver implementation changes in this patch.
