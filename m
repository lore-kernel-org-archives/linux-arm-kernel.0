From: broonie@kernel.org (Mark Brown)
Date: Sat, 6 Jul 2013 10:19:25 +0100
Subject: [PATCH 1/3] ARM: dts: Put Arndale fixed voltage regulators on a
 simple-bus
In-Reply-To: <2269980.iUpB0kJaI3@flatron>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
 <2269980.iUpB0kJaI3@flatron>
Message-ID: <20130706091925.GL27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 01:36:57AM +0200, Tomasz Figa wrote:
> On Monday 01 of July 2013 22:36:37 Mark Brown wrote:

> > +	regulators {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;

> Are the two #properties above really necessary? The regulators that will 
> be placed here probably don't need any kind of addressing, so it should be 
> possible to omit them.

I believe they're required boilerplate for a correct DT bus.

> > +
> > +		mmc_reg: voltage-regulator {

> I'd suggest suffixing name of this node with an index, like voltage-
> regulator-0 to be more future proof, in case of further fixed regulators 
> being added.

If you want to rename things that's a separate thing so should be a
separate patch - this patch is just about moving the existing devices
onto a bus.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130706/4f173dbe/attachment.sig>
