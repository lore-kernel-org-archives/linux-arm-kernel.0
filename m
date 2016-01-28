From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Jan 2016 11:38:40 +0000
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1453965401.19407.18.camel@mtksdaap41>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk>
 <1453965401.19407.18.camel@mtksdaap41>
Message-ID: <20160128113840.GA6078@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 03:16:41PM +0800, Henry Chen wrote:
> On Wed, 2016-01-27 at 14:41 +0000, Mark Brown wrote:

> > No, drivers should *never* enable things that weren't explictly enabled
> > by the machine constraints.  This misses the whole point of having
> > constraints.  They are there so that the system integrator can enable
> > the functionality that is safe on a given board.  

> Okay..the constrains should be define on device tree.
> But which optional properties was suitable to fill on device tree if consumers want to call
> regulator_set_mode directly ?
> I have check the of_regulator.c and not found the suitable property name which can set valid_modes_mask & valid_ops_mask.

If you need to change the mode at runtime you will need to develop a
binding for that, there isn't one at present.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/21ff91c9/attachment-0001.sig>
