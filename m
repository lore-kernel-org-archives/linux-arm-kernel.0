From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Nov 2011 17:07:51 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <4EC3EBEC.3020601@gmail.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain>  <4EC3E446.4030608@gmail.com>
 <1321461458.3137.374.camel@hornet.cambridge.arm.com>
 <4EC3EBEC.3020601@gmail.com>
Message-ID: <1321463271.3137.380.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 16:59 +0000, Rob Herring wrote:
> It has nothing to do with taste and obviously documentation changes over
> time. I'm going to start naming everything with legacy because someday
> it all will be...
> 
> It's about how you create compatible strings. They should not be
> generic, but specific to particular hardware version. If you happen to
> be compatible with older h/w then you can claim compatibility with that
> older h/w.

Notice that it's not:

	compatible=legacy

not even:

	compatible=arm,legacy

It's:
	
	compatible=arm,vexpress-legacy

A specific variant of Versatile Express hardware. It's just that the
"legacy" word carries some meaning. Would it looked better if it was
called:

	compatible=arm,vexpress-nalatenskap

? (thanks, google translate ;-)

> >> If you defined the property when the
> >> original vexpress was designed, it never would have had legacy in the
> >> name. Generally speaking you never change bindings on old platforms.
> >>
> >> So I would have "arm,vexpress" mean legacy and "arm,vexpress-rs1" be the
> >> new memory map.
> > 
> > I'd rather second Dave's idea of having
> > 
> >>> 	compatible = "arm,vexpress-<model>", "arm-vexpress-rs1", "arm-vexpress";
> > 
> > and
> > 
> >>> +	compatible = "arm,vexpress-<model>", "arm,vexpress-legacy", "arm-vexpress";
> 
> If arm,vexpress-ca9 is the only legacy platform, then just drop
> arm,vexpress-legacy altogether.

It's not. There is additional one, which is not publicly available, but
is using the motherboard in legacy mode.

Cheers!

Pawe?
