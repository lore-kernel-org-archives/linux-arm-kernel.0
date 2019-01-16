Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40262C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:08:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF4F20840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m/SYwzS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF4F20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7A1+qNcoCvX+J9K3z16HR42vOwHbv6Bgs+IfhLVupEU=; b=m/SYwzS5wYiOaw
	uda9l5lWzwrk6FKaIWDaCmfs3SRFxZqDRXnExMJzsYSc/K9rd9+92KsaopmqjO7SNE82fnr2vfXPE
	IBwU9iGDR8j8TUxbWOBtO5C5/0qsHAxEJvPks0WDGZBTC26mbm62PaAYnXdqJyjBzv/EgN/iiXzJN
	eBnwuTPWn0wSL7ZspS+A6CyT82Uffkfg1/s9/JFrsD31k5CbkBHZcFml5bLnEX+67CIWImIDqHizF
	MCpNkaevT6s3bXzQ+6095dkSPtmHxvYW1bFpYMXb9OkcD79ddp0+BIAFVEx0BsUVL+YaB4Z+UGMu5
	vS+ZvkDzE/Aa7+uRqMJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjdR3-0006Sf-Gi; Wed, 16 Jan 2019 05:08:17 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjdQK-0005e9-NT; Wed, 16 Jan 2019 05:07:34 +0000
X-UUID: cc58122b59ae40fabafcd4922187161d-20190115
X-UUID: cc58122b59ae40fabafcd4922187161d-20190115
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1207932403; Tue, 15 Jan 2019 21:07:26 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 21:07:25 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 13:07:22 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 16 Jan 2019 13:07:22 +0800
From: CK Hu <ck.hu@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Houlong Wei <houlong.wei@mediatek.com>
Subject: [PATCH 0/3] Remove self-implemented queue of Mediatek cmdq
Date: Wed, 16 Jan 2019 13:04:32 +0800
Message-ID: <20190116050435.11624-1-ck.hu@mediatek.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 40BE542FA8CC37D07A572001D38682359D0C9AD5F26DB401626979ACFB8570DA2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_210732_813343_5260653F 
X-CRM114-Status: GOOD (  11.68  )
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
Cc: srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mediatek mailbox controller implement its own data queue rather than using
mailbox framework's queue. This series let the framework provide abort
function and Mediatek mailbox controller implement the abort-function, so
it could use framework's queue.

The reason that Mediatek mailbox controller has to implement its own queue:
One client of Mediatek mailbox controller is display driver. When a cursor
is moving, display continuously update the register related to the cursor.
Display hardware has a limitation that register should be updated in the
vblank period which is a small interval. In tradition, display hardware
would trigger an interrupt when vblank start, and driver could update
register in this irq handler. But the interrupt handler has the risk that
it could be delayed by some reason so the handler may be postponed out of
this vblank interval. In order to reduce the risk, display driver use GCE
hardware to write register. If a cursor move 3 times before vblank,
display driver would send 3 messages sequentially to mailbox controller.
If the controller use framework's queue, controller just receive the
first message and the others is queued in framework. The first message
could be executed exactly in vblank interval but the other messages are
sent to controller when controller notify framework tx_done in interrupt
handler. The interrupt may be postponed by some reason this is what we
worried. So Mediatek mailbox controller has to implement its own queue to
make sure that all message execute in vblank interval.

The reason that abort-function could let Mediatek mailbox controller use
framework's queue:
The primary concept is to let display driver send at most one message to
mailbox controller. When it need to send the second message before the
first message is done, it should abort the first message and then send the
second message which should merge the first message. For other client
driver, it could still send multiple messages into framework's queue.

CK Hu (3):
  mailbox: Add ability for clients to abort data in channel
  mailbox: mediatek: Implement abort_data function.
  mailbox: mediatek: Remove busylist

 drivers/mailbox/mailbox.c          |  23 +++
 drivers/mailbox/mtk-cmdq-mailbox.c | 281 +++++++----------------------
 include/linux/mailbox_client.h     |   1 +
 include/linux/mailbox_controller.h |   4 +
 4 files changed, 90 insertions(+), 219 deletions(-)

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
