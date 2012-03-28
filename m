From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 11:07:44 +0100
Subject: [PATCH 07/10] clk: Constify parent name arrays
In-Reply-To: <CAJOA=zOXwtpefp2vgHprnmdpaOsHzo_rtMPMrN=X=K7YXM2EYA@mail.gmail.com>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
 <1332833009-4121-8-git-send-email-shawn.guo@linaro.org>
 <CAJOA=zOXwtpefp2vgHprnmdpaOsHzo_rtMPMrN=X=K7YXM2EYA@mail.gmail.com>
Message-ID: <20120328100743.GC3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 06:03:49PM -0700, Turquette, Mike wrote:

> Mark, I've taken this in to my fixes branch, but I dropped the change
> in drivers/clk/clk-fixed-rate.c (since that code has shuffled) and I
> also marked the char *parent[1] in fixed-rate and gate clocks as
> const, in addition to the divider you did in your patch.

That one's more fun as you should really be declaring them as something
like a const array of pointers to const char which is very cumbersome to
actually do and looks ugly as hell.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/ae45a8ac/attachment.sig>
