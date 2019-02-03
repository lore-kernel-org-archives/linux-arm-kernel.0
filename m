Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6EEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:03:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDFF620815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MPPKgHVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFF620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ocKOIeH7kR1tcRyzZ7kQRO0ybkv5/NSGhkxr3z1C348=; b=MPP
	KgHVnvfoJIL16YlvTvh9e/gDS1Dd2vG/fLg2aDFQ5e5ilxf9uj7FHz99l/RfEpMPqVBwixAFpaHcE
	mgZbjkmwogyBMaBrN01ohrMFAFktutKLtjL9PXPE/onz6a4IcVNHWbajX17dUFtJ0VF0GrqyNKWu7
	0av8e2mMP/uBDt8lfGV8FFL+Q50XTrPDKxpeUNlnjiVRGkkPsJn74aSvsWzjTiUuTSTaBLnFV+imD
	7zfzun0cK8n5Vj/3VsrMor8BgbR71IojIi53u9acdhFU7zhYX8TXeTD/t+ULpdFCcGMm3LFGQhIm/
	FCFv/FehxFu2vRsOrMj3NPiwinwySWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqHQr-00035b-C7; Sun, 03 Feb 2019 13:03:33 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqHQe-0002wJ-UF
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 13:03:22 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MC2sH-1h0QRW29Gv-00CTdB; Sun, 03 Feb 2019 14:03:11 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>
Subject: [PATCH V3 0/2] pinctrl: bcm2835: Improve generic behavior
Date: Sun,  3 Feb 2019 14:02:32 +0100
Message-Id: <1549198954-4711-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:1VQRvnyfF6PS4DNQaxFJcSiWahGXP1JEsA+fpXPUPhoMrpdAi/K
 Spx0Au2540Q06tdeHAFdCzXSjrbgSp/EouYTBZODL9rLfEV0KTHGgJaqt3v+iQcD0CPaRsE
 vCEWA2vhqbsfdqibKqE46WLALs+1GX2opZ3/Aac1c1P5NmQujAMud9yZ7/XgOQ+bD5yQl3X
 UCbekQ6Z7SfEniyDL9PGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VHaucq2oVy4=:J92HWmsK5tuAg/uDaGwowY
 NDAtPtDK3FBjjdm1Bo3aux+O5xcvOpTTX5/WklD4pz9Px51EftVRtzlZ5xcLy4UNeoQMNjPzO
 8jj+tDJsEdMePMmR6JLzYeEJHFtDdLCl4qPcb56QC/WtXe7k8kTNbISuPYxhxYF49B+7vHMIv
 h6te8s3AioZsw8z6Rex8JWVR+A/sjBe8XCDnq9/lbTQVUKEUIgWbjFzazJzxqsPsyisTUuClM
 b7QPYpgrSqF0jd/+jCAin+Wf4QoI3Ud9PS44Xv2wvuFNxNuPLYUsAOcfwd4ZWZcSo3c3+JBvx
 b3awic5UXCjBcvfjfUH2RnvmHjmOHULmSEH+7FevQ+4XUynGG1k25XoQPQc1iBZ7UczW3SE/P
 v7AxedTPgOg5oY2bvSI+USzyD4v/kDUzXA9YCSzmM8REsl+UEczSoIYNzUP7zNq9B46Jn0cV1
 xcOho04+HemfgOVzMqHH0dzepE2Iz0qaR90HbE+lU3jDMWkYFYYqjNwqIaBqKdDyVoIOQJhjI
 jZuFeWxI3ytf6LMB7e+wTqM9f9uqQVZnVlYeWDGkOLVsw+PEzBbPLk4wWvLvRmzXmiegbg3Ji
 g6/E9Eux5e+kTWEawGd4a57u68Tt8Yq945yTFIOtxNVKQE86abl4t5NtkUvQaXxJMGrsqbJ6C
 /i0N4H8jmX8FTaoQRj+szPkJJALmeYlToCVS08WG3Y0Xkr+nNG3qw8pZiYQcRnUb569E2snsl
 w28mEBWQcIymeyqe6p5YPS0LYncfNvCKxQcgKCjixEWFolCfQd1+8Oerwqw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_050321_267686_AD8CCB8A 
X-CRM114-Status: UNSURE (   9.21  )
X-CRM114-Notice: Please train this message.
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-gpio@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series is the non-controversial part of "pinctrl: bcm2835: improve
libgpiod output". It has been split up in order to apply for the next
kernel release.

Changes in V3:
- drop patches #3 and #4 from former series

Stefan Wahren (2):
  pinctrl: bcm2835: declare pin config as generic
  pinctrl: bcm2835: Direct GPIO config changes to generic pinctrl

 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
