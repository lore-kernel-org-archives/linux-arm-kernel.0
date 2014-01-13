From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Jan 2014 11:09:35 +0000
Subject: [PATCH RFC 06/10] ARM: s3c64xx: pm: Add device tree based power
 domain instantiation
In-Reply-To: <52D2EE32.5060709@gmail.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-7-git-send-email-tomasz.figa@gmail.com>
 <20140112192910.GW29039@sirena.org.uk> <52D2EE32.5060709@gmail.com>
Message-ID: <20140113110935.GB29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 08:34:10PM +0100, Tomasz Figa wrote:
> On 12.01.2014 20:29, Mark Brown wrote:
> >On Sat, Jan 11, 2014 at 08:42:48PM +0100, Tomasz Figa wrote:

> >>This patch adds support for registering power domains of S3C64xx SoCs
> >>and binding devices to them using device tree.

> >>+#ifdef CONFIG_OF
> >>+static struct of_device_id s3c64xx_pd_matches[] = {
> >>+	{ .compatible = "samsung,s3c6400-clock", },
> >>+	{ .compatible = "samsung,s3c6410-clock", },
> >>+	{ },
> >>  };

> >Looks like a rebasing issue?  Otherwise this looks nice.

> Hmm, what's the problem here? Maybe I'm just blind, but I fail to
> see anything wrong (except that the array should be const...).

> Thanks for reviewing this.

I wasn't expecting to see references to clocks come up in power domain
code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/a4c4f762/attachment.sig>
