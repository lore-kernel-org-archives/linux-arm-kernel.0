From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Sep 2012 11:09:01 +0800
Subject: [PATCH v4 1/7] mfd: add syscon driver based on regmap
In-Reply-To: <20120903023102.GA11891@shlinux2.ap.freescale.net>
References: <1346237818-9498-1-git-send-email-b29396@freescale.com>
 <1346237818-9498-2-git-send-email-b29396@freescale.com>
 <20120831012626.GA7726@r65073-Latitude-D630>
 <20120903023102.GA11891@shlinux2.ap.freescale.net>
Message-ID: <20120903030858.GF2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 10:31:03AM +0800, Dong Aisheng wrote:
> > 
> > I think of_node_put should be moved out from here and put into
> > syscon_node_to_regmap and syscon_regmap_lookup_by_compatible.
> > 
> I guess no, if you want to move of_node_put into syscon_regmap_lookup_by_phandle,
> then syscon_regmap_lookup_by_phandle has the same issue.

I guess not.  syscon_regmap_lookup_by_phandle itself calls of_parse_phandle,
and that's where the refcount gets incremented, so syscon_regmap_lookup_by_phandle
should be responsible for calling of_node_put to get the refcount decremented.

-- 
Regards,
Shawn
