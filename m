From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Mar 2017 12:52:12 +0000
Subject: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
In-Reply-To: <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
Message-ID: <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 06:53:06PM +0200, Leonard Crestez wrote:

> Enabling bypass mode makes a regulator passthrough the supply voltage
> directly. It is possible that the supply voltage is set high enough that
> it violates machine constraints so let's check for that.
> 
> The supply voltage might be higher because of min_dropout_uV or maybe
> there is just an unrelated consumer who requested a higher voltage.

I would expect that if bypass is enabled then the constraints on the
parent regulator would be set appropriately to support this, I wouldn't
expect that we'd try to apply the operating constraints of the regulator
to the supply.  Usually bypass is used for low power retention modes
with different settings to those used in normal operation that wouldn't
be desired in normal operation, if we were going to have constraints for
this I'd expect a separate set used during bypass.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170324/9370229f/attachment.sig>
