From: balbi@ti.com (Felipe Balbi)
Date: Mon, 1 Aug 2011 11:52:52 +0300
Subject: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
In-Reply-To: <CAOMWX4e0CODd8YT4LC2zHdGhzzZpOqRc0CU8roV-Pw1VTx5XCw@mail.gmail.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
	<20110728055346.GA11921@foobar> <4E315C9F.1030801@ti.com>
	<CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
	<20110729134932.GA2258@foobar>
	<20110729140515.GV31013@legolas.emea.dhcp.ti.com>
	<CAOMWX4e0CODd8YT4LC2zHdGhzzZpOqRc0CU8roV-Pw1VTx5XCw@mail.gmail.com>
Message-ID: <20110801085251.GF31013@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 29, 2011 at 06:07:17PM -0500, Menon, Nishanth wrote:
> On Fri, Jul 29, 2011 at 09:05, Felipe Balbi <balbi@ti.com> wrote:
> >
> >> +}
> >> +EXPORT_SYMBOL(omap_hwmod_name_get_odev);
> >
> > maybe EXPORT_SYMBOL_GPL() ?? Not sure we want non-GPL code to access
> > this ;-)
> 
> Sure.. but is this the way we want to go? if yes, I can post the
> series in a formal way to the list.

I would expect so, but if there are concerns of other non-GPL drivers
needing this, you can at least use:

EXPORT_SYMBOL_GPL_FUTURE();

this would allow you to catch non-GPL drivers accessing this symbol.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110801/09caadd1/attachment-0001.sig>
