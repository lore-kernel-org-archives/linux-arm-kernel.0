From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Sep 2013 21:48:31 +0800
Subject: [PATCH 1/2] ARM: i.MX6: dts: change iomuxc pinctrl config to
 match Rev. 1 IMX6DQRM
In-Reply-To: <52241BB3.5030909@freescale.com>
References: <521C40D9.3070802@freescale.com>
 <1377659855-9573-1-git-send-email-alison_chaiken@mentor.com>
 <1377659855-9573-2-git-send-email-alison_chaiken@mentor.com>
 <52241BB3.5030909@freescale.com>
Message-ID: <20130904134828.GA16815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 01:01:39PM +0800, Huang Shijie wrote:
> I tested this patch with the imx6q-ard board and imx6dl-ard board.
> 
> For the gpmi nand test result:
> [1] imx6q-ard: We can pass the bonie++ stress test with the imx6q-ard board.
> 
> [2] imx6dl-ard: But we fails to read the nand ID with the imx6dl-ard board.
> In other word, this gpmi can _not_ works with this patch.

The reason I'm not keen on merging this patch is just because I'm
concerned by such breakages that it could possibly bring us.

Do you actually see any issue in real with using the existing pad
settings on your board?

> But without this patch, the imx6dl-ard works fine.
> 
> In section 4.1, the spec tells us that the 0x1b0b0 is just the "default
> settings for the each pad",
> not the right settings for the each pad.

+1, the default setting != the best setting for boards, and that's why
the design leaves the pad settings configurable.

Shawn
