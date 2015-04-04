From: broonie@kernel.org (Mark Brown)
Date: Sat, 4 Apr 2015 19:52:12 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <551FDFEF.6010207@redhat.com>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
 <20150404123302.GY6023@sirena.org.uk> <551FDFEF.6010207@redhat.com>
Message-ID: <20150404185212.GA6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 04, 2015 at 02:58:23PM +0200, Hans de Goede wrote:

> 	regulators {
> 		/* Default work frequency for buck regulators */
> 		x-powers,dcdc-freq = <1500>;

Are you sure this is safe and correct for all boards (with most
regulator designs I'd expect it to be dictated by passive choice)?  

> 
> 		reg_dcdc2: dcdc2 {
> 			regulator-name = "dcdc2";
> 		};

These names should all be removed, they're vanishingly unlikely to
reflect the schematic supply name (which is what the property is there
for) and this should either be the same as the regulator API comes up
with by default or override any better naming it manages to provide.

> 		reg_ldo1: ldo1 {
> 			/* LDO1 is a fixed output regulator */
> 			regulator-always-on;

If there's no control this should be redundant.

> 			regulator-min-microvolt = <1300000>;
> 			regulator-max-microvolt = <1300000>;

Are you *sure* this voltage is the one used on all boards?  If it's the
physically fixed output voltage then it shouldn't be in the constraints
at all and the driver should just know.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150404/8012dd0b/attachment.sig>
