From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 08:46:24 +0200
Subject: [PATCH net v2 3/3] net: stmmac: Improve mcast/ucast filter for
 all Synopsys EMAC Configurations
In-Reply-To: <1404092110-18667-4-git-send-email-vbridgers2013@gmail.com>
References: <1404092110-18667-1-git-send-email-vbridgers2013@gmail.com>
 <1404092110-18667-4-git-send-email-vbridgers2013@gmail.com>
Message-ID: <4380814.yCFVZiTZxJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 29 June 2014 20:35:10 Vince Bridgers wrote:
> The synopsys EMAC can be configured for different numbers of multicast hash
> bins and perfect filter entries at device creation time and there's no way
> to query this configuration information at runtime. As a result, a devicetree
> parameter is required in order for the driver to program these filters
> correctly for a particular device instance. This patch extends the current
> driver by providing a different multicast filter programming function if
> different than the currently supported 64 multicast hash bins and 32
> perfect unicast addresses. This patch is required to correct multicast
> filtering for the Altera Cyclone V SOC.
> 
> Signed-off-by: Vince Bridgers <vbridgers2013@gmail.com>
> 

No objections to the content of the patch, but it would be better to split
it out into two separate patches: one that does the mechanical prototype
and formatting changes, and a smaller one that actually introduces the
functional change. That would make it much easier to review, and to bisect
potential problems when something goes wrong.

	Arnd
