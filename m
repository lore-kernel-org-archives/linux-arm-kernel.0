From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Nov 2011 17:37:34 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1321463271.3137.380.camel@hornet.cambridge.arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain>  <4EC3E446.4030608@gmail.com>
 <1321461458.3137.374.camel@hornet.cambridge.arm.com>
 <4EC3EBEC.3020601@gmail.com>
 <1321463271.3137.380.camel@hornet.cambridge.arm.com>
Message-ID: <1321465054.3137.386.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 17:07 +0000, Pawel Moll wrote:
> > > I'd rather second Dave's idea of having
> > > 
> > >>> 	compatible = "arm,vexpress-<model>", "arm-vexpress-rs1", "arm-vexpress";
> > > 
> > > and
> > > 
> > >>> +	compatible = "arm,vexpress-<model>", "arm,vexpress-legacy", "arm-vexpress";
> > 
> > If arm,vexpress-ca9 is the only legacy platform, then just drop
> > arm,vexpress-legacy altogether.
> 
> It's not. There is additional one, which is not publicly available, but
> is using the motherboard in legacy mode.

Alternatively, I could add motherboard node property, something like:

/ {
        motherboard {
		arm,v2m-memory-map = "legacy";

and

/ {
        motherboard {
		arm,v2m-memory-map = "rs1";

That way the "legacies" and "rses" will disappear from the main
compatible value:

	compatible = "arm,vexpress-<model>", "arm-vexpress";

and everyone will be happy :-) There will be a bit more hassle with
getting this property in v2m.c, but not too much. Does it make any
sense?

Cheers!

Pawe?
