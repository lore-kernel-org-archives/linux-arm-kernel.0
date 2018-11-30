Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33E920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d+NnkMrd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="evOp1YEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33E920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=BP5LadqthWA/bOq+1Di7ipNhXP/YhPTWKmJeeN3/jGw=; b=d+N
	nkMrdJN7OTVd6IaiJQbrIBlg87IPMpS65lTqcauG7SVzPtYCxMazHkyIAHQuh4spZ6XyfNi54e1w5
	vYI0uI913T6ttLQTvp3e4o/2fD1CNxZqsbPcPp4fEPJoY574h8jTRgemVrtMayXJcJvZ+hCeGr2rd
	rYTcEpQDIXxNlb5xDl9/rHh/+Xq5Q7yZ3Bsux/tBcgFcJMBWSTvNI7kRyOQHNxVbh1Pbpr6TSSIZp
	HxHcdDyALAlZ3Z9s7uYLRBIVWl+0wyN2QXQYW8UVMyoQOnvRL6FDjDduwni4+tdADh/5JLdATD78+
	XhWyydQyCl6lmU2KmpmSmgMCHYJe6Xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnlF-0000N1-OU; Fri, 30 Nov 2018 18:43:33 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSnl2-00008Y-8v
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 18:43:21 +0000
Received: by mail-pg1-x544.google.com with SMTP id w7so2851104pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 10:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=IuJG8dqyGAPZbgMnZ9OXctTPnx97qwSN4XjbKObGexY=;
 b=evOp1YEz9bNcj27Qjdr7AK2/3VXM3M83NXM6p3a4hNTQrYk3uphVDJ5vQYWJAbW58I
 qvjC1ST4z8lDBprY84VxlxCvjXZBBkLm9qUlQqnAn9t0KQD5hjqseF9Z5DGl3H56DrN3
 xNC4tTxEdrisNYXG32aA/kxrqbwteJrJ0piqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=IuJG8dqyGAPZbgMnZ9OXctTPnx97qwSN4XjbKObGexY=;
 b=FeSado8v3d9D7RjkIyhNdHJ09dv87OLORmd3lbWlxs/aZ8kja9rlrgbREJWJEeWewg
 IawbkTS1a/6sJZ0Xe4wBE9qop1BcxaXbXxyFHu/bCtrWM+RLyskew4U1FSGnBd1bd8Kt
 90ApsZEUbqotFNw1S/4SXBO8AZ/5X/jcKOIcvJzxK3/F1QYwy1hOa3j7TrLWURQtrCDg
 m1o/7o0CWrASs477JAkvxkUcyVyVPM32u5lzKLZHQvcZvULj7CtzHh2UGIjK3nxacVog
 erL/lUluJlb87iDnCsDdqxLA2eMM6fOog0kPU0BHm72f44oY+AACvhxehApXW4uNObQo
 vqbQ==
X-Gm-Message-State: AA+aEWZgAWgAmZTtNVRG5ecHb+dPPlDb/8lCVJxotFATsoMuec1hZZ9H
 vskS94rcEqyA2WGQYD6i7Vm11g==
X-Google-Smtp-Source: AFSGD/VEia0xMGQNzik1oNGvDUgxjWWTTJkn0J9iDHXdyMh2a/5WSA7BYxtU6F+Eu32f9OB/3eedpw==
X-Received: by 2002:a62:f907:: with SMTP id o7mr6560772pfh.244.1543603389173; 
 Fri, 30 Nov 2018 10:43:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 30 Nov 2018 10:43:08 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 0/6] coresight: next v4.20-rc4 
Date: Fri, 30 Nov 2018 11:43:01 -0700
Message-Id: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_104320_361114_3A148FBC 
X-CRM114-Status: UNSURE (   9.51  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Good morning,

Please consider the following patches for inclusion in 4.21 cycle.  The set
applies cleanly on your char-misc-next branch (b5570ca7c475).

Regards,
Mathieu

Colin Ian King (1):
  coresight: fix spelling mistake "deffered" -> "deferred"

Leo Yan (1):
  coresight: tmc: Fix bad register address for CLAIM

Mathieu Poirier (4):
  coresight: etb10: Add support for CLAIM tag
  coresight: etf: Release CLAIM tag after disabling the HW
  coresight: etm3x: Deal with CLAIM tag before and after accessing HW
  coresight: etm3x: Release CLAIM tag when operated from perf

 drivers/hwtracing/coresight/coresight-etb10.c   | 23 +++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm3x.c   | 12 ++++++------
 drivers/hwtracing/coresight/coresight-stm.c     |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +-
 4 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
