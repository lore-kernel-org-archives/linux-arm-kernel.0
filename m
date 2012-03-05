From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 11:52:10 +0000
Subject: [PATCH 2/2] mmc: sdhci-s3c: Enable runtime power management
In-Reply-To: <4F549A0A.5020402@samsung.com>
References: <4F51697C.40408@samsung.com>
 <1330735602-22409-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1330735602-22409-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F549A0A.5020402@samsung.com>
Message-ID: <20120305115209.GA3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 07:48:42PM +0900, Jaehoon Chung wrote:
> On 03/03/2012 09:46 AM, Mark Brown wrote:

> > +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);

> Could you explain why use 50ms? 

It's essentially a random number, some other devices use the same one.
We're just trying to avoid suspending between back to back requests.

> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +	pm_suspend_ignore_children(&pdev->dev, 1);

> Is there reason that ignore_children use to set the true?

So that we can suspend the host without having to have the MMC card
suspended (the host suspend is not visible to the card).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/08d6b487/attachment.sig>
