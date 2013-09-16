From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Sep 2013 16:31:48 +0800
Subject: [PATCH v2 1/1] ARM: imx: i.mx6d/q: disable the double linefill
 feature of PL310
In-Reply-To: <1379294943-15664-1-git-send-email-r64343@freescale.com>
References: <1379294943-15664-1-git-send-email-r64343@freescale.com>
Message-ID: <20130916083146.GI31147@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 09:29:03AM +0800, Jason Liu wrote:
> The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
> The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
> But according to ARM PL310 errata: 752271
> ID: 752271: Double linefill feature can cause data corruption
> Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
> Workaround: The only workaround to this erratum is to disable the
> double linefill feature. This is the default behavior.
> 
> without this patch, you will meet the following error when run the
> memtester application at: http://pyropus.ca/software/memtester/
> 
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365664.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365668.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x0136566c.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365670.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365674.
> FAILURE: 0x00100000 != 0x00200000 at offset 0x01365678.
> 
> Signed-off-by: Jason Liu <r64343@freescale.com>

Applied, thanks.

Shawn
