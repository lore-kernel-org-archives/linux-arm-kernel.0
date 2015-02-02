From: jbottomley@parallels.com (James Bottomley)
Date: Mon, 2 Feb 2015 17:55:48 +0000
Subject: [PATCH] phy: qcom-ufs: export symbols needed by main drivers
In-Reply-To: <20150202162648.GA20465@lst.de>
References: <1840882.huchmEIh5K@wuerfel>
 <1422891069.2103.1.camel@parallels.com> <20150202162648.GA20465@lst.de>
Message-ID: <1422899790.2103.11.camel@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-02-02 at 17:26 +0100, hch at lst.de wrote:
> On Mon, Feb 02, 2015 at 03:30:27PM +0000, James Bottomley wrote:
> > Cc added for linux-scsi, since this is the origin of the problem.  How
> > important is bisectability in this?  It won't affect any non-embedded
> > user, since most don't build with UFS, so I can go either way on folding
> > or just applying as an extra patch.
> 
> The CRYPTO_DEV_QCOM_ICE symbol was never defined in the scsi trees, and
> would have needed something else from linux-next to even compile.  So I
> don't think the revert is a problem at all, and I'll add it to the
> scsi-for-3.20 branch ASAP.

Actually, on the revert of 

scsi: ufs-qcom-ice: add Inline Crypto Engine (ICE) support for UFS

Which isn't what this problem is (the exports still need adding), since
it's only in the misc tree, let's just drop the patches rather than
doing an add and revert.

James
