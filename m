From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jun 2011 18:20:51 +0200
Subject: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
In-Reply-To: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
Message-ID: <201106031820.51922.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 June 2011, zhangfei gao wrote:
> Here are patches to provide separate sdhci driver for mmp2 and pxa910
> based on sdhci-platfm.
> Rename to sdhci-pxav3.c and sdhci-pxav2.c
> Remove sdhci-pxa.c, which is used to share among pxa serious, since
> under this method, platform difference have to be put under arch/arm,
> which is not easy to track.
> As a result, mmp2 mmc resource should be updated accordingly.

Looks all good content-wise. I do have a few comments regarding the
style of submission, please follow that the next time:

* Make all patches a reply to the  [PATCH 0/x] email, so they show up
  as a single thread. This helps finding the emails when your mail 
  client sorts threads by last reply. The option in git-send-email
  is '--thread --no-chain-reply'.

* The changelog has extra spaces in it that shouldn't be there. I assume
  they come from using git-show instead of git-format-patch to create
  the emails.

* Make sure a series is bisectable. This means that each patch results
  in a working kernel without regressions when you apply only part of
  the series. There are multiple ways to get there. In this case, you
  could fold the patch that updates the resources into the patch that
  changes the format. Alternatively, you could first create the new driver
  in the new format, then change the resources, and finally remove the
  now obsolete driver.

	Arnd
