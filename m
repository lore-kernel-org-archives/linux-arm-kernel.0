Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14874C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:50:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2B420684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwO9NVxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2B420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Zo588sCcXeEt1nGSzxbTj/tZ2iRNZ0+fVrSD3L5gpv4=; b=lwO
	9NVxoalB9wbMfJatjkJw8w7XWTWUAhBujWjIcuUN6hjpjXaSxtg3P8w89d+txX71W1Z2knFPKbkmO
	5iIEE4n+xs3v3dIgGjHCNRZKrcPoZCu/SMkdTeslq5c8ebCFE78/M7kWqiwMiniZoXe0x5YAJZzOX
	YB+Fi+kckrbmZv14ZGiv6fS+UtXjd0hFBY6j84p0qoOQhAb7FWzAxJoJcgp/e5XrTzJgCMqR4dcVz
	a31dK/8ASViAdrfGLAvg2nBbn3a9B1Kt0kyCkaut1Ij44bE7EFHJsJdm4P83MpwVdvlAupvAZSMm0
	z3PoH9QP15YyfR5U6KYil/YSw8RATSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxT0w-0001Qn-Oj; Sat, 23 Feb 2019 08:50:30 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxT0s-0001PS-6i; Sat, 23 Feb 2019 08:50:28 +0000
Received: from hc1.intern.sperl.org (account martin@sperl.org [10.10.10.59]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757388; Sat, 23 Feb 2019 08:50:05 +0000
From: kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] allow to define cs deassert times in us, ns and SCK-len
Date: Sat, 23 Feb 2019 08:49:47 +0000
Message-Id: <20190223084952.14758-1-kernel@martin.sperl.org>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_005026_420746_BFE39C4F 
X-CRM114-Status: UNSURE (   5.43  )
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
Cc: Martin Sperl <kernel@martin.sperl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Using spi_transfer.cs_change right now means that there is a hard-coded
10 us delay between deassert and re-assert of cs.

For some devices this is way too long and either wastes resources
unecessarily or the driver works arround this currently with multiple
spi messages.

So this patch set modifies the spie core and some drivers so that
in spi_transfer we now can now define the minimum delay in units of:
microseconds, nanoseconds or spi clock length.

But note that on lower specs machines those ns delays are not realistic.
Lower limits on the actual delay are put by the gpio framework latency
for setting gpio level.
On a Raspberry Pi 3 this overhead has been observed to be in the order
1.2us.

As an idea: the xfer->cs_change_delay_unit could become more generic
by renaming it to delay_unit and then also us it as a modifier when
using xfer->delay_usecs.

Martin Sperl (5):
  spi: core: allow defining time that cs is deasserted
  spi: core: allow reporting the effectivly used speed_hz for a transfer
  spi: core: allow defining time that cs is deasserted as a multiple of
    SCK
  spi: bcm2835: support effective_speed_hz
  spi: bcm2835aux: support effective_speed_hz

 drivers/spi/spi-bcm2835.c    |  5 ++--
 drivers/spi/spi-bcm2835aux.c |  5 ++--
 drivers/spi/spi.c            | 68 +++++++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h      | 13 +++++++++
 4 files changed, 75 insertions(+), 16 deletions(-)

--
2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
