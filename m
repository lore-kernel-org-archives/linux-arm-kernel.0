Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AFCC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:52:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C6B2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dKOi62ZS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiAKLLJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C6B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+20UDlKh2Z7D+IqqszEbESdyvztG1LPlb7KiFz/E5OU=; b=dKOi62ZS7+gqMH
	c8BLmjG/ugWtiwaC7W1fzFDzCPXBSzeGynJ7QV2XPhRfVR4gadUodEHlORuUqgv64AA0RCa3D8xTQ
	9pA5I/NVxgJ79/rReIvP6Ul9wwMfDcwlhVk/n9jcnoPymNrddLBnFTzNyjmtqKfS97HT89brgZpGb
	RW4dJmQ6v143td7IXIMqT8UaNP3gIR12P9I5BFmxbfmQNR0gD81n/iaF+mBROM62wt1UBpSXISvyJ
	6F0RQMVSQ5EELi4uW1024hh3YaAKkUIr9iK91eaL9LLqohQ9BJPEdrduKu8BzikoNcSza/nSUnO+t
	oQeGRFWOf5cFYJMq8KOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpAsx-0004G5-4M; Thu, 31 Jan 2019 11:51:59 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpAst-0004E6-9r
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:51:56 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so2954260wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 03:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0enek0A8jDFsVAl11N/G0bNAcwpoDOHHfp9X7OErNIc=;
 b=UiAKLLJpMbaRW1WPDY7uU1MbIdFjJD642saDeJRF3+5ZBZjcCnMPkTh4kO9bpa7aFA
 ldUR4G771E1tbyWClkLhgjx50tZ7uBnLhe5ivTL6ZRyFBR/RTaPfL3Hg71ihd2x/hyIP
 M4oqCcbKyyuSET0lPnb21lxSkHf8GVoQqIlx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0enek0A8jDFsVAl11N/G0bNAcwpoDOHHfp9X7OErNIc=;
 b=Dnh3KPv2s+8QHvLyaCUe05sA4lCLoMMSWpwPQjyR4/l/q7nxie7b3dNbyNIQeJoAST
 OuOPFAbF0xVuSdZvW75fcU9o6d2/MgoH6kdl3JNffPa3c/CUlHiuJf1se3xwILIlT/yA
 5rvbwvPxs6fiDlcPJXPYhJvyEjT72VifSR0L34cs6O+GM0HJhFH4Va07S7MTeWO2pPcD
 68hNs/4eRIApCTzHBOMRbubap6BKojJiM5+Fwjom/2PWMpHBw+Uspl1sQSCOfBD9HKSH
 ajVRxqqj3/PwYNH5nme2OdxxjnCFcrB9cb9MZstpaVmy7jlg6IJsKxdAWh1oqEkwbnkw
 XU7g==
X-Gm-Message-State: AJcUukeqNtFXLrw3a0pNF+qNjwFyqGYR3pgVR4x8yMSmGBejQjrVlcuj
 dO+Gkq51Hc2OFFHF0e49YnrIQg==
X-Google-Smtp-Source: ALg8bN5CLUqtybYo/fEiBU45Kdz6zyOA6SI+vGezuHH3V8Xm4b1wCOOSOHm8/pLtK02jlYPI372BJA==
X-Received: by 2002:adf:fd50:: with SMTP id h16mr36589622wrs.231.1548935510469; 
 Thu, 31 Jan 2019 03:51:50 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-39-7.w90-86.abo.wanadoo.fr. [90.86.94.7])
 by smtp.gmail.com with ESMTPSA id w10sm5807714wmb.1.2019.01.31.03.51.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 03:51:49 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH v3 0/2] efi: arm: add support for earlycon on EFI framebuffer
Date: Thu, 31 Jan 2019 12:51:43 +0100
Message-Id: <20190131115145.4634-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_035155_354574_E1238D68 
X-CRM114-Status: GOOD (  14.25  )
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
 corbet@lwn.net, pjones@redhat.com, x86@kernel.org, linux-doc@vger.kernel.org,
 agraf@suse.de, leif.lindholm@linaro.org, mingo@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Repurpose the existing EFI earlyprintk code to implement support for
'earlycon=efi' for arm64 systems, allowing the graphical console
to be used instead of the serial port for early debug output.

Changes since v2:
- update patch #1 so that no attempts are made to build the memencrypt related
  early memremap routines for 32-bit x86
- update patch #2 so earlycon=efifb is not enabled on Itanium

Changes since v1:
- Rename earlycon= argument to 'efifb' to emphasize that this is specific
  to the EFI framebuffer.
- Replace earlyprintk=efi entirely, rather than keep it alongside earlycon.
  Since earlycon is typically enabled (along with the infrastructure), and
  earlyprintk isn't, this does not result in a lot more code to be included,
  but does make it more likely that a given [distro] kernel has support for
  this enabled out of the box.
- Switch to write-combine mappings by default. This is the default for efifb,
  and is actually required on arm64, since device attributes do not tolerate
  unaligned accesses or other operations (such as DC ZVA) that rely on memory
  semantics. This requires ARCH_USE_MEMREMAP_PROT to be wired up, which is
  why a new patch #1 has been added.
- Since adding the 'ram' parameter for framebuffers in shared memory on cache
  coherent devices is trivial after the switch to WC mappings, fold the change
  into the main patch.

If there are no objections, I will proceed to queue these in efi/next for v5.1

Cc: corbet@lwn.net
Cc: leif.lindholm@linaro.org
Cc: graeme.gregory@linaro.org
Cc: mingo@redhat.com
Cc: tglx@linutronix.de
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: agraf@suse.de
Cc: pjones@redhat.com

Ard Biesheuvel (2):
  x86: make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol
  efi: x86: convert x86 EFI earlyprintk into generic earlycon
    implementation

 Documentation/admin-guide/kernel-parameters.txt                         |   8 +-
 arch/Kconfig                                                            |   3 +
 arch/x86/Kconfig                                                        |   5 +-
 arch/x86/Kconfig.debug                                                  |  10 --
 arch/x86/include/asm/efi.h                                              |   1 -
 arch/x86/kernel/early_printk.c                                          |   4 -
 arch/x86/mm/ioremap.c                                                   |   4 +-
 arch/x86/platform/efi/Makefile                                          |   1 -
 drivers/firmware/efi/Kconfig                                            |   6 +
 drivers/firmware/efi/Makefile                                           |   1 +
 arch/x86/platform/efi/early_printk.c => drivers/firmware/efi/earlycon.c | 130 ++++++++------------
 11 files changed, 69 insertions(+), 104 deletions(-)
 rename arch/x86/platform/efi/early_printk.c => drivers/firmware/efi/earlycon.c (45%)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
