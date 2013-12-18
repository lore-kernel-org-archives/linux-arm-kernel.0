From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Dec 2013 13:15:42 +0100
Subject: [PATCH 2/5] arm: shmobile: r7s72100: add i2c clocks
In-Reply-To: <52B18CC9.8090200@cogentembedded.com>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-3-git-send-email-wsa@the-dreams.de>
 <52B1892B.1020806@cogentembedded.com>
 <20131218114351.GD3314@katana>
 <52B18CC9.8090200@cogentembedded.com>
Message-ID: <20131218121541.GE3314@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, Dec 18, 2013 at 03:53:45PM +0400, Sergei Shtylyov wrote:
> On 18-12-2013 15:43, Wolfram Sang wrote:
> 
> >>>@@ -173,6 +179,10 @@ static struct clk_lookup lookups[] = {
> >>>  	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
> 
> >>>  	/* ICK */
> >>>+	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
> >>>+	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
> >>>+	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
> >>>+	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
> 
> >>    These belong to some other place, the group marked by /* ICK */
> >>is only for CLKDEV_ICK_ID().
> 
> >So, I'll create a /* DEV */ prefix?
> 
>    I really don't know. Other places have /* MSTP */ comment in this
> case despite all clocks, CLKDEV_DEV_ID() and CLKDEV_ICK_ID() are
> really MSTP clocks. I considered the idea of separating
> CLKDEV_ICK_ID() under /* ICK */ comment silly from the very start
> but Simon didn't listen to me.

I am puzzled, too. ICK is a type of registration and not a clock domain.
Also, there is 'mtu2_fck' which is under ICK as well as MSTP? Looks
wrong. From what I understand now, removing the /* ICK */ comment would
be easiest and proper?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/f0c7f207/attachment.sig>
