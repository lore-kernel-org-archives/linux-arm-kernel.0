From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 28 May 2018 17:50:42 +0200
Subject: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
In-Reply-To: <20180528072034.GB3143@dragon>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
 <20180227101712.3zwobvs4ox4jchcj@earth.universe>
 <20180528022652.GA3143@dragon>
 <20180528064131.y5burm5kakiazaq4@earth.universe>
 <20180528072034.GB3143@dragon>
Message-ID: <20180528155042.ilmyqe4z5gekakrl@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 28, 2018 at 03:20:35PM +0800, Shawn Guo wrote:
> On Mon, May 28, 2018 at 08:41:31AM +0200, Sebastian Reichel wrote:
> > > Are you saying this is a very specific setup required by i.MX53 only?
> > 
> > Yes, all other SoCs supported by Linux ARM PMU counters driver can
> > just use the registers without having to enable platform specific
> > bits first.
> > 
> > > In that case, I can live with it.
> > 
> > What about the DT node? I did not add it, since this is a i.MX53
> > specific workaround anyways.
> 
> What you are adding here is secure-reg-access property, which has an
> defined meaning in PMU binding doc.  I'm not really sure if it's
> appropriate to use the property as a condition for DBGEN bit setup.
> Or can we set up the bit regardless of the property?

The description for DBGEN bit is:

> Debug enable. This allows the user to manually activate clocks
> within the debug system. This register bit directly controls the
> platform's dbgen_out output signal which connects to the DAP_SYS to
> enable all debug clocks. Once enabled, the clocks cannot be disabled
> except by asserting the disable_trace input of the DAP_SYS.

I only enable this bit when the kernel configuration allows
using the PMU, since otherwise we do not need the clocks
in the debug system. This limits any potential side-effects
of this patchset.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180528/a922700f/attachment.sig>
