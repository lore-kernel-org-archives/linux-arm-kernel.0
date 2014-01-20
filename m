From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 20 Jan 2014 23:01:18 +0100
Subject: Nomadik clk not MULTI_V5 friendly
Message-ID: <20140120220118.GN15169@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

drivers/clk/clk-nomadik.c:

static int __init nomadik_src_clk_init_debugfs(void)
{
        src_pcksr0_boot = readl(src_base + SRC_PCKSR0);
        src_pcksr1_boot = readl(src_base + SRC_PCKSR1);
        debugfs_create_file("nomadik-src-clk", S_IFREG | S_IRUGO,
                            NULL, NULL, &nomadik_src_clk_debugfs_ops);
        return 0;
}

module_init(nomadik_src_clk_init_debugfs);

It does not check if it is actually running on a Nomadik, so when this
module_init() is executed on kirkwood as part of a MULTI_V5 kernel,
bad things happen. Please could you add the necessary check.

Thanks
	Andrew
