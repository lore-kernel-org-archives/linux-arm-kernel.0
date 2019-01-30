Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1573C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:55:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAA32087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X1jZsFgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAA32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=iB1THQccGWLEb6anWAEz6KrEbiTJK2atd2dJ2Hjr2ns=; b=X1j
	ZsFgP+JqsGjmAXEsVN3bwWx2Bky+u92ZLRJb2CU0VYFjxDdV452Ef+tFhHOG5xs5DdkHoDcE2kzP/
	+26ceJavH+nQ7jRa7QcBt4oiG2Urj+1WlgQme3nKi8+Ukqp1Chwrs151nlK9KuvxU3FiSsSdN4pPD
	QEw3xaocqtNrurH/UCjDeYHYV37ssyhU/MP8KkEE39vzjJ+gDEn3k9QVCQBVSoc01A6uDXsDDutwR
	6BeLGqV+XOHB+eVQUnugasDdUgp3yMfgs9yM7neSbcTJJ5s1A5yEm34Z+/hmjLvLOhWySNJq1L15s
	l5f4HfEuW9kgsFd3sqNT8qUtyQPkydQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomar-0006Ni-70; Wed, 30 Jan 2019 09:55:41 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomao-0006Hx-PX
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:55:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C882DA78;
 Wed, 30 Jan 2019 01:55:37 -0800 (PST)
Received: from bc-d3-1-12.euhpc.arm.com. (bc-d3-1-12.euhpc.arm.com
 [10.6.16.77])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D32DB3F557;
 Wed, 30 Jan 2019 01:55:36 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-serial@vger.kernel.org
Subject: [PATCH v2 0/2] serial: mps2-uart: minor improvements
Date: Wed, 30 Jan 2019 09:55:13 +0000
Message-Id: <1548842115-14782-1-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_015538_837272_C1910A73 
X-CRM114-Status: UNSURE (   7.71  )
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
Cc: greg@kroah.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This mini series is supposed to improve MPS2 uart driver for:
 1. platforms with number of virtual serial ports, like MPS3
 2. platforms with combined irq

Vladimir Murzin (2):
  serial: mps2-uart: move to dynamic port allocation
  serial: mps2-uart: support combined irq

 drivers/tty/serial/mps2-uart.c | 138 ++++++++++++++++++++++++++++-------------
 1 file changed, 96 insertions(+), 42 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
