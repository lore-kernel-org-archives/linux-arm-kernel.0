Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268CC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:33:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BAE20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VMfzi3QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BAE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gxpdSEhmAu64yMnXJfp6JrrtBHDOEDe7wfXyil9dfvU=; b=VMfzi3QYvypth8
	8Gy4doD2r13lKF7iy3PTJzrbbVqi5QZBVPZEISd12q3HYZHq868Q8JU/GYF/HDk0UVwFWq0mppHHl
	ktQZilTtVoPlYTkrEN0LTs0F1Z6WJ0WWFp6WhkflDL/t96/a4aXgJIW8kvKYYbz/YmXGhzERsFJEf
	OAtvVVuDjhtm8cLZS+7XKj36Qw+AOt3p/alF9VgxpQ0kCUI+dvKGanLx0iO9C2xHQI4VQlMCdSUk8
	YfoCcWlHuHShj21utk9I8qLT8SbfalcvTY9L/zBBWRt8/xzH69wx4EL04WX8WhgpjM7UP1zG1yrbZ
	2atIgXeyOPwz9xlDZBIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToME-0006fy-97; Mon, 03 Dec 2018 13:33:54 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToMA-0006c0-1n; Mon, 03 Dec 2018 13:33:51 +0000
X-UUID: a1efa8c13c7e4004971bf6d866b113d3-20181203
X-UUID: a1efa8c13c7e4004971bf6d866b113d3-20181203
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <qii.wang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 530171079; Mon, 03 Dec 2018 21:33:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 21:33:12 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 21:33:12 +0800
From: <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH 0/5] add i2c support for mt7629 and mt8183
Date: Mon, 3 Dec 2018 21:32:49 +0800
Message-ID: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8E072DB0354E077C2B99CB5FFAFCEA8DAD95B2F0D8AB772B76E6E2D277AF67DA2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_053350_212476_C7D3EB50 
X-CRM114-Status: UNSURE (   7.00  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series are based on 4.20-rc1 and provide five patches to support
mt7629 and mt8183 IC.

qii wang (5):
  dt-bindings: i2c: Add Mediatek MT7629 i2c binding
  i2c: mediatek: remove useless code and replace definitions
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT8183

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    8 +-
 drivers/i2c/busses/i2c-mt65xx.c                   |  299 ++++++++++++++++-----
 2 files changed, 239 insertions(+), 68 deletions(-)

-- 
1.7.9.5

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
