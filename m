From: kvalo@codeaurora.org (Kalle Valo)
Date: Sun, 26 Jul 2015 14:56:31 +0300
Subject: [PATCH] bcma: fix build error when build as module
In-Reply-To: <1437851427-7485-1-git-send-email-hauke@hauke-m.de> (Hauke
 Mehrtens's message of "Sat, 25 Jul 2015 21:10:27 +0200")
References: <1437851427-7485-1-git-send-email-hauke@hauke-m.de>
Message-ID: <87lhe3b09c.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hauke Mehrtens <hauke@hauke-m.de> writes:

> Currently of_default_bus_match_table is not exported so we can only use
> this feature when bcma is build into the kernel. This patch removes
> support for child buses when bcma is build as a module as a temporary
> fix for a build problem introduces in this commit:
>
> commit cae761b5a6bdc597ba476a040fdcd5b4bc559b85
> Author: Rafa? Mi?ecki <zajec5@gmail.com>
> Date:   Sun Jun 28 17:17:13 2015 +0200
>
>     bcma: populate bus DT subnodes as platform_device-s
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks, manually applied to wireless-drivers-next.git. (Still
patchwork.kernel.org has buggy utf-8 support, sigh.) I just added
Reported-by and Fixes lines to the commit log.

I wrote a similar patch but I'll drop that as your has better comments :)

-- 
Kalle Valo
