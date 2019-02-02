Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552E2C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:22:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229F22083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BL2zhOHi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhNxTv01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229F22083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HnWuY0QZw2Wm3lASyViuRAJ0ir+zNIX/nHx/KQ1/ASc=; b=BL2zhOHijc+DDL
	yd2tA4fTmdPNWawzJEYhf5uhtrFYkOMFutE/HQiM37PAtPSxoLTZrSPmCZMY79maRQkpf+p9sD2bt
	693rKHqETaJofMiKCIIVnix+LZFiXwRFzq6ctpBL1Si7IHmz9+YBzw76fBOhOjlk7OE7QELU/AzWH
	7sCBVDKYWUTUHSNSGtVj0DS+1OcpyXno5mv9JTR0TKaxgA0PTNab1r/pSaXmL39fa3ARRpMbTvS0P
	rihJNBzK6hmRLCbeImbg/CerHtGKC1Gkbk2JqZKqHP695FerV1qG8GWhlAgsAOiFOf+svuRU3+rNn
	8cPxcieWxRBll0QZpnUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpz0B-0002gR-GP; Sat, 02 Feb 2019 17:22:47 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpz08-0002fs-Mh
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 17:22:46 +0000
Received: by mail-oi1-x242.google.com with SMTP id r62so8463781oie.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 09:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KPEmvyCe2zgJ5KyM+DVVL8DrDd+VETfEVwcHEJKvT9E=;
 b=MhNxTv01hgYVXwZUL/4lTfadvL6S72lOe4d4rZdav11pZGbhRlAQDf3MNpVh6K3Kk7
 KkiUVQqVN/k61ReHJjy2lgJNPXuZMKEDsB1HQBI5UDJ1xFhUNwHZ4yp8QG2I1dZ1yRt7
 M/pDDZ82n0gPZKiBsWhn2YWnu/3yzRkiEGkk8Sy/v28LxrgpJlaAQOdVNoGWd/O8zd0M
 1J6XkDBd3LTETBGylWQ1eiRJ80kIf+eDWnscRRLwxppqzDYFDQki6NZpvsfTC3r1wMml
 NozV/lzvESoDU7Vgxd9QeSO6/fBkuZkkDAflRAKzh0D8a668HrqPUU14FsJ0tIj6CxxL
 6i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KPEmvyCe2zgJ5KyM+DVVL8DrDd+VETfEVwcHEJKvT9E=;
 b=Lze4XBumrcfBsl5kg3tx7hASMHsIbbiEUFu7an6v2sI460e4WHRIZDHV10b3cF+dxv
 RGKd7Ge/YrjnUu5Y9L2FJwoHK0keAsaa0vjk3roNYcu6EpZQFDMTZRJnhPn3fTHHvJ6q
 ty+y/tx8cZh+VYObEbNyL0esBprATZyBUXhJTArOxU/B/gqzw53oh2E+eDgnLwyEsYWs
 mr2uFQvtlDxtW+YN70CXPWrFQJrmFmDTHfh4Ol3T1JrrNZnxcKoK1JFJKHkQJGtLKvSc
 iR4xt63P/H9ZcqPdClzBif+SocU+5RwwQHeCi/kMKsejyeOusqy8FBPkHmFWumZ6Fy+1
 L0rQ==
X-Gm-Message-State: AJcUukdrLbjlyGglVOdEMDySoyHSep0440QRo02USX37v5nVFg3nbWcH
 v85/qhp1fb5xWVmDGxnqA44=
X-Google-Smtp-Source: ALg8bN7lQRNAy2HaTmdKe04X6K6MbCMvKybDBkpt+TU/rF7hKdsw3Gnr+07GuLN+ym7ZGiS92vV5OQ==
X-Received: by 2002:a54:4486:: with SMTP id v6mr22310894oiv.233.1549128162588; 
 Sat, 02 Feb 2019 09:22:42 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id n185sm5056815oih.18.2019.02.02.09.22.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 09:22:41 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 1/4] Broadcom defconfig changes for 5.1
Date: Sat,  2 Feb 2019 09:22:34 -0800
Message-Id: <20190202172237.11147-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_092244_741499_F640BB23 
X-CRM114-Status: GOOD (  10.53  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, arnd@arndb.de, khilman@kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 olof@lixom.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-5.1/defconfig

for you to fetch changes up to 6e2111e72e8279ebd6efcaf3e579a2afbd1dbf7a:

  Merge tag 'tags/bcm2835-defconfig-next-2018-11-27' into defconfig/next (2019-01-31 21:04:22 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs defconfig file
updates for 5.1, please pull the following:

- Stefan enables the MMAL-based V4L2 camera driver for the Raspberry Pi
  devices

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'tags/bcm2835-defconfig-next-2018-11-27' into defconfig/next

Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver

 arch/arm/configs/bcm2835_defconfig | 3 +++
 1 file changed, 3 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
