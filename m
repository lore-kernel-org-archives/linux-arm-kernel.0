Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B66FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:16:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D77222E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 12:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PhTCNH2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D77222E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidjohnsummers.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qX9fH74FTta6wIswaok30QVCRm0REtxw0rI0nvk2eiQ=; b=PhTCNH2EJoo1n6
	DKHjkq2iYgTxktxOvcArAchH1u2LkOi49mpcgt3wDXe3pYRm9k5f0l29k6jshZd3LV9ftrjnkGaGQ
	LOa8wgdmveeHmU7NQhJ8G9llhZzNuYND0WpWAGrrGIl9BbkpFdUyzjEeEXc8UNTlEYylD+YwqcBfV
	DJ8UlZnjLaKEKkhdCCgXMF3c1pFY1hwkZGRBwDkwnq0nu/bBaO0lGh4Z0ZXtOO/cnWldvPXVN2GuR
	q3hTEmITXrGADGaqnuTbbWEXhK3cLXmTWSbCHF5aggXbzKsKHB+ihquRSoFBnFzVWSZEgAMzfcdej
	66oytvzGLUffAG3f5pwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvLMs-0007AC-9w; Sun, 17 Feb 2019 12:16:22 +0000
Received: from avasout06.plus.net ([212.159.14.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvLMo-00077t-EG
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 12:16:20 +0000
Received: from localhost.localdomain ([87.114.170.31]) by smtp with ESMTP
 id vLLzgM2tCHd2LvLM0gaQA4; Sun, 17 Feb 2019 12:15:29 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=FK01Odgs c=1 sm=1 tr=0
 a=IwDniP0DpuMObaUqJdRMiQ==:117 a=IwDniP0DpuMObaUqJdRMiQ==:17 a=V5NFcaBHAAAA:8
 a=0NS0URispb6Ii0WxUNAA:9 a=sJ-dsXpog5ekix5Z:21 a=WKcxsw4WtVgA:10
 a=hpaLWXtm7LEA:10 a=AIFGTXQOaoIMFke0skzX:22
From: David Summers <beagleboard@davidjohnsummers.uk>
To: heiko@sntech.de,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH 0/3] ARM: dts: rk3288 Tinker Board (S) updates
Date: Sun, 17 Feb 2019 12:15:10 +0000
Message-Id: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CMAE-Envelope: MS4wfHXtZ7GeeRFtYWlPgE5diYJM8CJJ9NsocycdcWIvZ1f2kmzw7F2LSvCHKLTYz47RytzAfKdlqxDHYd93ZW6gtCNwvgCdHf1dUY/n0lq3U6iIvpZulQrw
 tY4sLBW27iLJ2d/oX098efujCyOF8aj+n4tbK4rZh7B9HnvHcuViQEpC9YsQthA4wWacGcjANjWtUI3JslbOSokIzOPb2VIKO1g=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_041618_619672_F3C71B2C 
X-CRM114-Status: UNSURE (   5.67  )
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
Cc: linux-rockchip@lists.infradead.org,
 David Summers <beagleboard@davidjohnsummers.uk>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Find in the following patches 3 sets of updates to the rk3288 ASUS
Tinker Board (S) device tree. The patches consist of:

       1) Changes to sd card, to remove error
       2) Add WiFi to the device tree
       3) Add an outline for Bluetooth to the device tree

The patches have been developed by both Stefan and myself, and hence
have both our sign off.

The patches have been extensivly tested by TheSaint on ArchLinux Arm
Forum, details:

https://archlinuxarm.org/forum/viewtopic.php?f=44&t=13064&start=90

Each patch has more details on what is covered.

David.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
