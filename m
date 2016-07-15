From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Jul 2016 13:50:39 +0100
Subject: "coupled" regulator support
In-Reply-To: <20160715200113.0f3cd823@xhacker>
References: <20160715200113.0f3cd823@xhacker>
Message-ID: <20160715125039.GI30372@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 08:01:13PM +0800, Jisheng Zhang wrote:

> regR can only be set to v1 if devA and devB all call for set voltage to v1
> regR can set to v2 if devA or devB call for set voltage to v2

> To support this situation, I'd like to add flag to regulator structure and
> patch regulator_check_consumers() to check whether we are safe to set the vol

Surely this is just what normal set voltage calls do?  If devA says
set_voltage(v1, v2) but devB still has set_voltage(v2, v2) then we will
leave the voltage at v2, we'll only allow it to be set to v1 if both
consumers agree that this is a valid voltage.  It feels like there's
something else going on here that I'm missing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/43fa8c09/attachment.sig>
