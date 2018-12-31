Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD01BC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:46:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C4E21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORlD5Xob";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="xBG5AoQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C4E21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=430E8qkF+1eFaQt9an56SkalQcGc94kSFC0cZpyMivI=; b=ORl
	D5Xob7v2kHBBpxB+UnsWiLLuWPredVfbOH4ngCL8bUar5UtzydXgYLzDwXxQKEZvlA8NjyjR01A8G
	AFzaltCfPKa5vDkQJcPgge8L1db21b7xdM6uU0dWEjJNMMmUG4XbJd315c/4DFXkGzY2+p4xeVHGJ
	nRhf7i+7O2p9/i2+QJlRrAvjtEd+5705ho5QYip/bTURC02wJ6lCZ+OnJNLLyAY12y36u/hhReYYY
	wpwxqYCbiXsaEdxo/BnH5H1+Qosd1w5Qj1tIak5GXPmdiW2q+XSz5nVPSxQQtCXEt66iv/ah2/SYZ
	PbzCaYNpNCjp6ggaFNtUTNjAd0G8tQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5Oi-0003dz-O3; Mon, 31 Dec 2018 21:46:56 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5Of-0003d9-3r
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:46:54 +0000
Received: by mail-pf1-x443.google.com with SMTP id b85so13580289pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=UAbdU6XVTBCbP4w0w6CO/i1BzYSDORh4ljdJvWCwdCQ=;
 b=xBG5AoQ9v4jFta9QDoH7mUJedhYMC5mZ+kvQlZkMHOL2Mod4rVtiOWy/4SBL9p7ALZ
 knloyJlMaFu37ioQT7r0p6H7f3++qCClo++8NLXq7HrRGRtcGA0+/VFLtrAPMohnF0HR
 4XL1YzF4aFsBY9QTdpcrJft+vXxAuQMcFbYQ9AK4y8BoRBuO5rXh8p9L6Sn8c8wBj9MS
 WqtaztQfmxvHVX6J82Qu5jd9s2sKr3Qbz5sHf0mAfPrcT9Ijj0h3lU6C5o/Q2SHClyjg
 izUkinXtuawGXsRK5VvTysIvVpHwuviO8F6oGQ7XFky8hnsZ3xxRHgQxdHTsD8BpCNCA
 DIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UAbdU6XVTBCbP4w0w6CO/i1BzYSDORh4ljdJvWCwdCQ=;
 b=dj4QuxW6n8grVsk6RnP4UZTJN5l06+LaFFZY4MtZD3PC/vgrxQ50G5fY3wXE5bGevL
 bygAm6bRgyJXC0Ga39a5RIukxJ9eRWqBIgRkoS+wtgPH6qgFZiZCqvAQgJ3LUH4AU6zJ
 Z3qoAtbCe6Axi2t9REBG0qV1MSjPYLM85CvkagW++wOJzkxnQRPBOt+Z4I5/O5l3dX2N
 bzFsCQr+BPNOhVQCfEcEpGVIZZlnMnvIziqkek6uEwh7Rymd0RKA3ndgwEJQrf5CQ8hc
 /OFoMsfOuD6Av/y4bqCIti3mZVQODNZlBNPRpalqF0YGQfEIPxKxud1OIWwyIdeEaM+H
 h4/Q==
X-Gm-Message-State: AJcUuke1oKAtA8d/aybwIDFm4i0Lm+JGTz9usDisA+jCkjMXwCk+o5ZV
 KGTO3+keeq7WbgrE1Po+TsPGWA==
X-Google-Smtp-Source: ALg8bN573ucsNushgoxWAuLqfz7C1ARcYqizBB+KGmFzHVMvKwDTY9pxaf7lgNrKs5n26RQo1hYw0w==
X-Received: by 2002:a63:4f20:: with SMTP id d32mr8735848pgb.47.1546292811466; 
 Mon, 31 Dec 2018 13:46:51 -0800 (PST)
Received: from localhost.localdomain
 (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
 by smtp.gmail.com with ESMTPSA id u126sm96477085pgb.2.2018.12.31.13.46.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 13:46:50 -0800 (PST)
From: Olof Johansson <olof@lixom.net>
To: torvalds@linux-foundation.org
Subject: [GIT PULL 0/4] ARM: SoC changes for v4.21
Date: Mon, 31 Dec 2018 13:46:36 -0800
Message-Id: <20181231214640.17015-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_134653_156895_E3D76C26 
X-CRM114-Status: UNSURE (   8.65  )
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
Cc: arm@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

Here's the batch of changes for arm-soc for this merge window. It's
arriving later than I had planned for, the holidays messed up schedules
and time availability a lot at my end this year.

As for the material itself, it's pretty straight forward. The only
branch with conflicts is the SoC one, I mention in that email how to
resolve them. Most of the new material is in the DT branch (as always),
and that pull request also contains the overview of new platforms, etc.

In addition to this we have a branch with some late-merged material that
I'm letting sit for a few days and might send in towards the end of the
merge window if things have been going smoothly.


Thanks,

-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
