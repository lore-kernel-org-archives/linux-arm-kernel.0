From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Jul 2012 12:38:06 +0100
Subject: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
Message-ID: <20120720113806.GW4495@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 11:27:36AM +0000, AnilKumar, Chimata wrote:
> On Fri, Jul 20, 2012 at 15:29:36, Mark Brown wrote:

> > Every regulator here has a rather large voltage range specified with no
> > consumers added.  Are you sure these voltage ranges make sense in your
> > design and you've not just cut'n'pasted the entire voltage range that
> > your regulator supports without reference to what your board can do?

> tps65217.dtsi is a generic file to be used by the SoCs so these constraints
> were taken from the regulator itself. SoC specific limits can be added in
> SoC specific .dts file to tighten the constraints to require limit. I have
> tested the driver with this approach.

No, this is not a sane approach.  You've no idea if any of these
settings are safe or sane for the board.  Boards should enable things
they know are safe, not remove those they know are broken.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120720/91ea542e/attachment.sig>
