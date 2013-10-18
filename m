From: B47053@freescale.com (Xiubo Li-B47053)
Date: Fri, 18 Oct 2013 03:42:13 +0000
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <20131017141003.GO2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <525FD4C7.3050806@tabi.org> <525FD65B.3040004@metafoo.de>
 <525FE48B.7020709@tabi.org> <525FE728.90403@metafoo.de>
 <525FE815.1040300@tabi.org> <525FEB7A.5040406@metafoo.de>
 <20131017141003.GO2443@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286547C@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > I understand that, but I'm trying to figure out why of_iomap() is
> > > okay for hundreds of other drivers, but not this one.  I've used it
> > > dozens of times myself, without ever worrying about overlapping
> regions.
> 
> > The driver would work fine with just of_iomap(). But the resource
> > range check comes basically for free and it does help to catch errors,
> > so I'd recommend on using it rather than not using it.
> 
> There's also the fact that it's a devm_ function which means less error
> handling code that we can break which is nice.  There's probably a case
> for an improved OF helper here...


Using this instead of of_iomap() is because "devm_" and resource range check
as Lars and Mark said, and there are more than one SAI device here which will
be added later, maybe the resource range check is needed.



Thanks.
--
BRS
Xiubo
