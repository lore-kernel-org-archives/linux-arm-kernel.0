Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B82C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E2520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EAIFdjdb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pr9MrsL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E2520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UkjUJ8WR6wS7m5zjtFNArG0hZBb945IQvCoEzX/tz3c=; b=EAIFdjdbhhfSkY
	zxA0Q5fh4Pf7A2Mqyl2Vy2LibPilN17RM+zRBFKeZFA/QhXABLNeJnJeD7gSc80+Zj5+w/NSlGmQ7
	xSCf9IKbuvfU+frRKsjEDAtD/lbS51bNwWqShd8irE+qLvKdRXlehiXMdR6b7yT/C9HsToO+RRPOf
	bJNsFKNXoTaLcBQvexeFeOohSVjcmthX2lhNk1T0pbZAioYT+T4gpqlXXmm8cqjUJEhGL1lhCHHVt
	XNs1NRgMreC6KRJaBdukpALMJo96ueJeh7U0hDzY78Yw2OAEMy3AluQWB8bP6n5IK2f1a2bkmVi/+
	zJPVSx9xagI89xlPDapw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4BN-0006sg-Jo; Fri, 25 Jan 2019 16:18:17 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4BJ-0006rm-98
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:18:14 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so7239608wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mlEUGJtL070jDMPMo2Bu+c8cyAqdFMB5zT4MczlHHlA=;
 b=Pr9MrsL60uOEouUSPJiGmukZZsq3LSecwCVeErVKaqNsSL5TiLar8NM7n1ehnqCzHI
 +XBMIdD5TMZyPjKgpkwJEx0n7xs3F4rdYPWwbarJQ0CA0BAYPEI55wepzs4CcdebYUk9
 39Fst+tUTouR6OUC1OB/Z8m05L99xj+fxuzeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mlEUGJtL070jDMPMo2Bu+c8cyAqdFMB5zT4MczlHHlA=;
 b=rs2dtU9legNsiW2Yx3qxUyUH2EdmID9xMj1jC9N0Eqvk4XjSK1x6l23SYqKxAepyif
 BxWoLQdQ6m8FthPQtdUvLckhuKbWpikXUCQOuJiaH8r3ezOX12ICTLLbVcT5yb6txoeA
 5gNdtMbULqNWzStqrAI6XwLA5Vc1we7ANxelQF0sKYkg5nnTuiQ7AzvUddB/adlp1gCc
 98rRfEW0DK+aySpcCBbUHCstJZ/gBgyvQod7elxOsJTFsz6P4KC/oqg2bnzxVzcsK3lQ
 fVVl6nk8jjL5VKhB1SOadrKu9dYusDK6HTy466+BMO2+Vni8dNdJEgxlcA0Mk82v61DQ
 21Gw==
X-Gm-Message-State: AJcUukfK46Hk3kIc7yv+KqXl1pi1trWOcE7s4U7HtiOdeRexvlNgsN9L
 VMnWdT2egWwIOnI/tW2aM2iMkQ==
X-Google-Smtp-Source: ALg8bN4vwTdYTRraS6pv0wiEcr/Ca8ALUmpPLIYmbpxKAhSv7JEpy0MICJz0TctWoxWtFOblfevfCw==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr7222032wmj.127.1548433090899; 
 Fri, 25 Jan 2019 08:18:10 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id t76sm68987212wme.33.2019.01.25.08.18.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 08:18:09 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH 0/2] efi: arm: add support for earlycon on EFI framebuffer
Date: Fri, 25 Jan 2019 17:18:04 +0100
Message-Id: <20190125161806.13472-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_081813_321618_D8C6616C 
X-CRM114-Status: UNSURE (   9.59  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, graeme.gregory@linaro.org,
 linux-doc@vger.kernel.org, pjones@redhat.com, corbet@lwn.net, agraf@suse.de,
 leif.lindholm@linaro.org, mingo@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Repurpose the existing EFI earlyprintk code to implement support for
'earlycon=efi' for arm64 systems, allowing the graphical console
to be used instead of the serial port for early debug output.

Ard Biesheuvel (2):
  efi: x86: move EFI earlyprintk code to shared location
  efi: arm64: Enable earlycon for the GOP framebuffer

 Documentation/admin-guide/kernel-parameters.txt                         |  9 ++-
 arch/arm64/include/asm/efi.h                                            |  6 ++
 arch/x86/Kconfig.debug                                                  |  2 +-
 arch/x86/include/asm/efi.h                                              |  6 ++
 arch/x86/platform/efi/Makefile                                          |  1 -
 drivers/firmware/efi/Kconfig                                            |  5 ++
 drivers/firmware/efi/Makefile                                           |  1 +
 arch/x86/platform/efi/early_printk.c => drivers/firmware/efi/earlycon.c | 62 ++++++++++++++------
 8 files changed, 70 insertions(+), 22 deletions(-)
 rename arch/x86/platform/efi/early_printk.c => drivers/firmware/efi/earlycon.c (76%)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
