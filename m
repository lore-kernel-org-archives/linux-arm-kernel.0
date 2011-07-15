From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Jul 2011 11:37:54 +0300
Subject: [PATCH] OMAP: powerdomains: Make all powerdomain target states
	as ON at init
In-Reply-To: <alpine.DEB.2.00.1107150222400.16606@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
	<20110715080315.GC2611@legolas.emea.dhcp.ti.com>
	<alpine.DEB.2.00.1107150204510.16606@utopia.booyaka.com>
	<20110715081725.GE2611@legolas.emea.dhcp.ti.com>
	<alpine.DEB.2.00.1107150222400.16606@utopia.booyaka.com>
Message-ID: <20110715083753.GG2611@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 15, 2011 at 02:23:16AM -0600, Paul Walmsley wrote:
> Hi Felipe,
> 
> On Fri, 15 Jul 2011, Felipe Balbi wrote:
> 
> > I see... thanks for clarifying. The comment above the code wasn't really
> > clear about it to me.
> 
> No worries.  If you propose a clarification, I'll stick that into the 
> patch.

How about something like:

/*
 * Program target state of all power domains to ON. This is to prevent
 * power domains from hitting low power states during boot up and
 * potentially causing accesses to the address space of an IP while it
 * is disabled.
 *
 * PM late init code will make sure of disabling all unused IPs later.
 */

not sure if it's a lot better though.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110715/9b5e456c/attachment.sig>
