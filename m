From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 13 Jul 2014 00:16:12 +0200
Subject: [PATCHv2 2/5] mailbox/omap: add support for parsing dt devices
In-Reply-To: <1405116252-53612-3-git-send-email-s-anna@ti.com>
References: <1405116252-53612-1-git-send-email-s-anna@ti.com>
 <1405116252-53612-3-git-send-email-s-anna@ti.com>
Message-ID: <20140712221612.GB17930@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2014-07-11 17:04:09, Suman Anna wrote:
> Logic has been added to the OMAP2+ mailbox code to parse the
> mailbox dt nodes and construct the different sub-mailboxes
> associated with the instance. The DT representation of the
> sub-mailbox devices is different from legacy platform data
> representation to allow flexibility of interrupt configuration
> between Tx and Rx fifos (to also possibly allow simplex devices
> in the future). The DT representation gathers similar information
> that was being passed previously through the platform data, except
> for the number of fifos, interrupts and interrupt type information,
> which are gathered through driver compatible match data.
> 
> The non-DT support has to be maintained for now to not break
> OMAP3 legacy boot, and the legacy-style code will be cleaned
> up once OMAP3 is also converted to DT-boot only.
> 
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
