From: davem@davemloft.net (David Miller)
Date: Wed, 29 Aug 2018 19:46:28 -0700 (PDT)
Subject: [PATCH net-next 0/2] ethtool: drop get_settings and
 set_settings ops
In-Reply-To: <cover.1535477409.git.mkubecek@suse.cz>
References: <cover.1535477409.git.mkubecek@suse.cz>
Message-ID: <20180829.194628.1640012269371401850.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Tue, 28 Aug 2018 19:56:48 +0200 (CEST)

> As Andrew Lunn pointed out in recent discussion, there is only one in tree
> driver left which still defines deprecated callbacks get_settings() and
> set_settings() in ethtool_ops. First patch converts this driver to
> get_link_ksettings() and set_link_ksettings(). Second patch then removes
> the deprecated callbacks from struct ethtool_ops and ethtool code which
> falls back to them.
> 
> This doesn't break old versions of ethtool or any other userspace code
> using ETHTOOL_{G,S}SET. We still implement both (old) ETHTOOL_{G,S}SET and
> (new) ETHTOOL_{G,S}LINKSETTINGS ioctl commands but after this series both
> will be implemented only using {g,s}et_link_ksettings(). The only affected
> code would be out of tree NIC drivers which have not been converted yet.

Nice, thanks for following up on this.

Series applied.
