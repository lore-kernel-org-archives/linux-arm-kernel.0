From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Apr 2016 17:44:48 +0100
Subject: [RFT PATCH 1/3] usb: misc: usb3503: Fix HUB mode after
 bootloader initialization
In-Reply-To: <57234BA2.6020304@samsung.com>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <1461927591-7864-2-git-send-email-k.kozlowski@samsung.com>
 <20160429113059.GX3217@sirena.org.uk>
 <57234BA2.6020304@samsung.com>
Message-ID: <20160429164448.GY3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 01:55:14PM +0200, Krzysztof Kozlowski wrote:
> On 04/29/2016 01:30 PM, Mark Brown wrote:

> > Supplies are only optional if they may be physically absent.  In this
> > case it's possible that on device regulators may be used instead, a
> > pattern more like that used for arizona-ldo1 where we represent those
> > regulators might be better as it's more clearly describing the
> > situation.  I'm just wondering if the supply lookup stuff there should
> > be factored out as this is not an uncommon pattern..

> > It should at least be clearly stated what's going on, ignoring failure
> > to get supplies is generally a bug and people will tend to blindly cut
> > and paste things (witness all the breakage in graphics drivers with
> > this).

> The VDD33 is really optional. The device can work in different
> configuration, e.g. only on VBAT. How the reset logic would work then? I
> don't know... I would suspect that it could be exactly the same (just
> replace VDD33 with VBAT) but I am not sure.

What the Arizona example I mentioned does is look for the property
specifying an external supply in DT and if there isn't one assumes that
it must be using the internal regulator.  That's a bit icky but it does
the right thing and is much simpler from a user point of view.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/988b5d5b/attachment.sig>
