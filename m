From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jun 2012 09:52:28 +0100
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <4FE8EFC4.3090509@wwwdotorg.org>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4FE80413.6070001@nvidia.com> <4FE87FE3.1080608@wwwdotorg.org>
 <4FE882A5.3080504@nvidia.com>
 <20120625222646.GB30406@opensource.wolfsonmicro.com>
 <4FE8EFC4.3090509@wwwdotorg.org>
Message-ID: <20120626085228.GG30406@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 05:09:56PM -0600, Stephen Warren wrote:

> Just making sure I parsed that right. I think what you're saying is
> that the device itself should represent its input pins, e.g.:
> 
> tps6586x {
>     vin-ldo01-supply = <&some_regulator>;

Yes, that's what I'd expect here.

> ... rather than each regulator specifying its parent, which might
> result in some duplication, since in this case both ldo0/1 are
> supplied from the same input pin:

Plus you then get back to the problem of users having to figure out
where to put the references which makes everything harder to use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/01d6d3ed/attachment.sig>
