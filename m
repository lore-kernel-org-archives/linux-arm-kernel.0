From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Dec 2013 12:43:51 +0100
Subject: [PATCH 2/5] arm: shmobile: r7s72100: add i2c clocks
In-Reply-To: <52B1892B.1020806@cogentembedded.com>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-3-git-send-email-wsa@the-dreams.de>
 <52B1892B.1020806@cogentembedded.com>
Message-ID: <20131218114351.GD3314@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >@@ -173,6 +179,10 @@ static struct clk_lookup lookups[] = {
> >  	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
> >
> >  	/* ICK */
> >+	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
> >+	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
> >+	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
> >+	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
> 
>    These belong to some other place, the group marked by /* ICK */
> is only for CLKDEV_ICK_ID().

So, I'll create a /* DEV */ prefix?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/bd1a809b/attachment.sig>
