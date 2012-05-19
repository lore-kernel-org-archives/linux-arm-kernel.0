From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 19 May 2012 10:56:35 +0800
Subject: Duplicate labels in dts files
In-Reply-To: <4FB6B896.3090904@wwwdotorg.org>
References: <4FB6B896.3090904@wwwdotorg.org>
Message-ID: <20120519025632.GD5427@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 03:01:10PM -0600, Stephen Warren wrote:
> The following arch/arm/boot/dts/*.dts all have duplicate label
> definitions, albeit all duplicates pointing at the same node. Is this
> expected?

At least for IMX, I would say, yes.

For example, when I have the following node in imx53.dtsi and need to
have it in imx53-ard.dts, the first line of the node definition will
be naturally copied into imx53-ard.dts.  As the result, the label
"uart1" will be "duplicated".

	uart1: serial at 53fbc000 {
		...
	};

> This does work OK with the in-kernel dtc and latest mainline
> dtc, but triggered some error-checks in a dtc patch that I have locally,
> which allows node/property deletion. I think the duplicate labels should
> probably be removed - do you agree?
> 
I hardly think so.  You probably would agree that we shouldn't say
the node is duplicated, since the node will still be one in dtb.
Then, as long as the label points to the same node, we should not say
the label is duplicated either.

-- 
Regards,
Shawn
