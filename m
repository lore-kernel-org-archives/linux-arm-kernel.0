From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 20 May 2014 06:57:49 +0200
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <537A540E.8070302@ti.com>
References: <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe>
 <20140516180154.GG22031@atomide.com>
 <20140516213907.GL12881@atomide.com> <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com> <537A540E.8070302@ti.com>
Message-ID: <20140520045748.GA28812@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 19, 2014 at 09:57:18PM +0300, Tomi Valkeinen wrote:
> > 3. Having to maintain a database in kernel of display mappings separately
> >    in addition to the .dts files.
> 
> Yes, that's slightly annoying. Not really a big burden, though, as it's
> quite rare to get a new encoder or panel driver.

I wonder if the "omapdss," prefix could be added to *all* remote
endpoints seen by omapdss. Pseudocode:

for each port in dss {
    for each endpoint in port {
        panel = get_phandle(endpoint, "remote-endpoint");

        /* only add prefix if it's not already there (kexec) */
        if (panel.compatible != "omapdss,.*")
            panel.compatible = "omapdss," + panel.compatible;
    }
}

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/cf5dd055/attachment.sig>
