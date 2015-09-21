From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 21 Sep 2015 13:43:52 -0700
Subject: [PATCH v4] mtd: nand: sunxi: fix OOB handling in ->write_xxx()
 functions
In-Reply-To: <20150914170204.GL11487@google.com>
References: <1442220063-7520-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150914170204.GL11487@google.com>
Message-ID: <20150921204352.GA31505@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 10:02:04AM -0700, Brian Norris wrote:
> On Mon, Sep 14, 2015 at 10:41:03AM +0200, Boris Brezillon wrote:
> > The USER_DATA register cannot be accessed using byte accessors on A13
> > SoCs, thus triggering a bug when using memcpy_toio on this register.
> > Declare an helper macros to convert an OOB buffer into a suitable
> > USER_DATA value and vice-versa.
> > 
> > This patch also fixes an error in the oob_required logic (some OOB data
> > are not written even if the user required it) by removing the
> > oob_required condition, which is perfectly valid since the core already
> > fill ->oob_poi with FFs when oob_required is false.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Cc: <stable@vger.kernel.org> # 3.19+
> > Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
> > 
> > ---
> > Changes since v3:
> > - drop the NFC_USER_DATA_TO_BUF() macro
> 
> I don't have any real objections to this version, and I think some IRC
> discussion helped clear up a few questions. I'll take this for 4.3 soon,
> unless I see any objections.

Pushed to linux-mtd.git.
