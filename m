From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jan 2011 18:45:00 +0000
Subject: [PATCH v2 0/8] Switch ARM platforms from integrator-flash to
	physmap
In-Reply-To: <20110119145425.GF31652@n2100.arm.linux.org.uk>
References: <1294409399-19245-1-git-send-email-marc.zyngier@arm.com>
	<20110119145425.GF31652@n2100.arm.linux.org.uk>
Message-ID: <1295462700.5742.76.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-19 at 14:54 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 07, 2011 at 02:09:51PM +0000, Marc Zyngier wrote:
> > As the integrator-flash driver is mostly a duplicate of physmap,
> > move all users of this driver to physmap and get rid of the
> > then unused driver.
> 
> Does MTD guarantee that the vpp will be turned off whenever the physmap
> module is removed?  If not, can it?

Vpp seems to be controlled directly from the chip drivers (using the
{ENABLE,DISABLE}_VPP macros and a command-set specific state machine),
and none of the map drivers play with vpp at all, integrator-flash
included.

By the look of it, it seems pretty safe, though your own experience
seems to indicate otherwise. It should be quite easy to plug the vpp off
feature in physmap. I'll give it a go and re-spin the patchset.

	M.
-- 
Reality is an implementation detail.
