From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Mar 2018 18:59:04 +0100
Subject: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
In-Reply-To: <0288a32a-bbbf-20ca-2ebf-6fc8e82168df@arm.com>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <20180318202251.5gpv6sblfr4edxmj@flea>
 <E1exwhF-0000Qw-4g@stardust.g4.wien.funkfeuer.at>
 <20180320141353.zmzq4e5652rsp4ye@flea>
 <0288a32a-bbbf-20ca-2ebf-6fc8e82168df@arm.com>
Message-ID: <20180322175904.j2aho4tglifezzhq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 05:09:47PM +0000, Andre Przywara wrote:
> Hi,
> 
> On 20/03/18 14:13, Maxime Ripard wrote:
> > On Mon, Mar 19, 2018 at 04:27:36PM +0100, Harald Geyer wrote:
> >>> together with all the patches but the
> >>> PWM (so I had to drop the backlight node as well).
> >>>
> >>> Please coordinate with Andre about who should send the PWM support.
> >>
> >> Seems the patch got broken because only the backlight node but not the
> >> pwm node was removed. Anyway, since Andre has already sent an updated
> >> version of his series, maybe just revert the broken patch, merge his
> >> series and then apply the original teres-i patch again?
> > 
> > Unfortunately, there's dependencies on the PWM driver itself, and the
> > maintainer hasn't replied yet.
> 
> But those dependencies are purely "administrative", not technical,
> aren't they? As the existing driver worked already with the DT changes,
> it's just the listing of the compatible strings in the binding doc that
> is missing? IIRC we added those later on in the past already.
> 
> So I think it's safe to merge them independently:
> "[PATCH v2 1/4] pwm: sun4i: drop unused .has_rdy member" and
> "[PATCH v2 2/4] pwm: sun4i: simplify controller mapping" are
> PWM fixes and go via Thierry, I guess.
> 
> "[PATCH v2 3/4] dt-bindings: pwm: sunxi: add new compatible strings" is
> just Documentation of existing behaviour, and independent from 1/4 and 2/4.
> 
> "[PATCH v2 4/4] dts: sunxi: A64: Add PWM controllers" just "softly"
> depends on the introduction of the compatible strings in 3/4, but has no
> real technical dependency. It can go in any time on its own without
> breaking the build or functionality.
> 
> Or am I too sloppy here?

As far as I know, Thierry never commented on any version of these
patches, so I'd still like to get his review first.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/2a2b95b2/attachment.sig>
