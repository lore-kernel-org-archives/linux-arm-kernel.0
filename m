From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 14 Jul 2015 09:37:54 +0100
Subject: [PATCH 3/3] arm64: dts: add device tree for ARM SMM-A53x2 on
 LogicTile Express 20MG
In-Reply-To: <1435754163-17929-4-git-send-email-sudeep.holla@arm.com>
References: <1435754163-17929-1-git-send-email-sudeep.holla@arm.com>
 <1435754163-17929-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <1436863074.25044.30.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-07-01 at 13:36 +0100, Sudeep Holla wrote:

> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> new file mode 100644
> index 000000000000..5b1d0181023b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
[...]
> +		/include/ "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi"

Unfortunately this causes some issues for the split device tree
repository[0], since things get moved around there.

This new file ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
while the include is at src/arm/vexpress-v2m-rs1.dtsi.

Any ideas how best to deal with this?

I'm willing to try and work around in the conversion scripts but while
rewriting the paths to things on conversion is easy, rewriting the
contents of the files themselves is much less so (or at least would be
prohibitively expensive on input the size of Linux).

Cheers,
Ian.

[0]
https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/
