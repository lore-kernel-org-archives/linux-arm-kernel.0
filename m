Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1696EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:29:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD6E20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RF1y+A5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD6E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hvkNRUGOFSZUst/kZOo3nkqEhNR4GFD0pKNM/Qb79JU=; b=RF1y+A5gg0oLbxGHit/IteR0uf
	xVx7OpUcbCxhIxLcrNySBoyeN0rShDRBx/50hLzqQ6fJRyScJDU/rN0NshA7cTRAzFeONzgSUFT1d
	L2RDD9498To4+OhSS7K4smzl9Y7zItojGIDVcO6fgQzAsNePza2Ryhlj4DhC830OC2fIUTEKKlkgd
	/YWDJ33Cxz18QwYPfvVl2RGZxlRThVocY7EMm4yKBslJ5V09FSgcL9T6TzpGI7gK3hgDAc5p4QLjx
	2ZfQBiAUp0Weg1GMTdLiDLzCifSpbKg0H7QESxGcL9RtFtWMwwE0fRUAbdZp8NvZHPOWRAi0B/QUr
	nFHVD4Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyOz-0004sD-AC; Thu, 06 Dec 2018 18:29:33 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOu-0004om-Pl
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:30 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6pck-1gYpkB0GvG-008N2O; Thu, 06 Dec 2018 19:29:09 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/10] staging: bcm2835-audio: use module_platform_driver()
 macro
Date: Thu,  6 Dec 2018 19:28:57 +0100
Message-Id: <1544120940-13716-8-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:OWnA9d9J+HDWzhJmyqCNKOPwrDFw9AW2VQy+1nSI0tNNUA2UcNS
 9KlkwKvhH1KAymEjrpaCgHq1SNgU5FVQts4l3Zni+wNnfaBIn9WqOvehk0HY5GGmXhkWIUd
 TJJeabQkQrY0TsnfiWthnP+z88FoTwPe3oyNZqneWQ5O57LtWIH/EvrUwN5/VALM0JzMLFR
 hjeynlZqWLkOlV4aF/JeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NoUZOmwLpsU=:XLFea0/HG80mPYp+73C9En
 vz2m3l/YwGgNLSpuZrtMLqtOHPHpc/ojHI0OR/AmyBKJn3EEm06VpYqGACcZ85BDz0Fuq47Xj
 7KvLnKueJXcaS8BhcRJvep0aoKwkf4K4BL1BXrkr08NdSrMSKSX440ib79ieQ+DrrCVnG9p1V
 2v440Arwst3ePPNtHtaESTlWANNeRL0/qlFA4stIMnmbLiSNnoucQjgzA7BRb6ZLfrEnbxuJj
 yxOJOb8h6exByWv9R/j4EdDIyEMyYN5udF5bzwo26WzFc3Is2MlEnjy6iehPWFhC8vfjbPLPb
 VP23F4hujqB/1NoH7fyxqcuZqXh4HoqGFXDEdpxjxO12UiRxRZB9AerBEDqGH7e2ElMSF8bSd
 12rU3oA9voB5yV3ESPfrn2DvtGpggABx9sZGHd6+Md8I9rJLHnmu80ujbPHElqINjBbam8r9X
 veFLqXWwvd5NJm6LuKbwY+6NHpVz3AgW9G2MssUtN52sdUCbo6dzHnRwVYImTAoc8FThgmZwN
 s7jl4ddRMFrFK7yTMPU28XkTYtbV0gFWMKS70w1rq+mjLRnbnQsGCy6l6OB6zUDQOPZYChNod
 N9ETyWha4cZoSDyIpM4mFAQ/2spl2Um+BJoR3x9lyD/z9v4YiDhBpe/OoPO2EPd1/QkxXEwjB
 /FD1YZ729qKzBjEIog8iFMgOfHy0vKvvQklfgzXDdXJI8gNiHh1Jv5jf5HWewjou06iUE0FCc
 nYfukQCSVWJEOv6ygo9WttlIhEgEZwF8N/dyXYrz+qbxq+G916Vda2ks4Fg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_161920_5031948F 
X-CRM114-Status: GOOD (  11.82  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Stefan Wahren <stefan.wahren@i2se.com>,
 Takashi Iwai <tiwai@suse.de>, Eric Anholt <eric@anholt.net>,
 linux-arm-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is not much value behind this boilerplate, so use
module_platform_driver() instead.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/bcm2835-audio/bcm2835.c    | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index e14b7c5..86b9210 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -354,25 +354,7 @@ static struct platform_driver bcm2835_alsa_driver = {
 		.of_match_table = snd_bcm2835_of_match_table,
 	},
 };
-
-static int bcm2835_alsa_device_init(void)
-{
-	int retval;
-
-	retval = platform_driver_register(&bcm2835_alsa_driver);
-	if (retval)
-		pr_err("Error registering bcm2835_audio driver %d .\n", retval);
-
-	return retval;
-}
-
-static void bcm2835_alsa_device_exit(void)
-{
-	platform_driver_unregister(&bcm2835_alsa_driver);
-}
-
-late_initcall(bcm2835_alsa_device_init);
-module_exit(bcm2835_alsa_device_exit);
+module_platform_driver(bcm2835_alsa_driver);
 
 MODULE_AUTHOR("Dom Cobley");
 MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
