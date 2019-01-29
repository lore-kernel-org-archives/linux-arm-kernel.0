Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FF8C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:22:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0206820881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nIgyuuS1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TALLQTS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0206820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Qro3chBweCoptwEYV5azZg0l0+Rw96jQohowPRkgcyI=; b=nIgyuuS1ofmtJW
	U0BuY9YbEK5OZSCYLTaArsop424/MPY1vfIL1Mp09EBPWgeBC1X+PiRR6gqr52DWxrcRP8BRc6RFU
	GmKohTR6dQVGb+TovtIRpW5a0J7sdblhvCPA/4tAaPJfofn36Gu59HR3h5LcyZCdCxiLgi2SQ5sCV
	Uy0DuQ+K1j9lpCk2NhT2PMPld6E8DECW5eNiYcY3xplYogmOg40EwpHe7djDjE8n1tBvYZA1jFqnz
	n6v7S/BCVzkeZvkMZhRoDVtA77QA73TpzobT7IArPhWqZo4TBfpGkmuLRMBU91ypQgKQeE+3YKkWB
	LrInnQ4YngGiLqzUJa9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPam-0002jB-Bv; Tue, 29 Jan 2019 09:22:04 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPai-0002i3-Ol
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:22:02 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so21160889wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 01:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gn1pq3MddwvZOGlLmqAWA3iRRxW5w+1ECcW/4OIbJJ0=;
 b=TALLQTS0dcy3jFNV2ZCt7j8qMMbBNnVdUqdBFwNeL/GaNVzhdT/YlTGtTB9Xx5E1yH
 fZzZh8oYJBIvgkRqnjmaBFIX655AeqWohRevFTyRIGX1hAsmekf8kiDyizrZEz4mltYY
 THBNLOrHfPMF/nY0GT3BXMslUzQrSvZke7JEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gn1pq3MddwvZOGlLmqAWA3iRRxW5w+1ECcW/4OIbJJ0=;
 b=ehVfZgMYIXsJ9y6Lx8BqVbqPfOva9PaIbPJUiZJvKCPsPYEUucoih4zgHpURb0DcXY
 BRjWUnYqN9aOG18Ca3cn18gUoC8cbORFhSYNeYWFTob+brtCcIFl49sPXkXhCUAS3KGm
 UT/36LtcaKLKbVzJQHA8auRXmQdDfStaB+LnAtJvbh5t4hElFRsQ5cTxgaas4BmcYhMO
 awF0UCXngPrdhvuSkKNl1zMMEvFznM88kQ8+r/H2Fy2NNzQRBWQW3Rr0dIBN5stwr22Z
 wHj+jRb40vCX+t8IS+FBnaowue83sLfbbXtXTCn+ZOfJxjG4x/eo8FzMtE3pHWiyPBIb
 SVzg==
X-Gm-Message-State: AHQUAuYmrMHL8Qw09uv56lX2alw8Q9/fSZEC9IH8jp2TRc54qbbMQ/tV
 jSQO2rT9O5zvVSGGDI/ZAyVsyw==
X-Google-Smtp-Source: AHgI3IauClUJ0df71CQ8m03ONMoz9ZAWsPu6Km44jGpN0TjXehn3tKOyj/atoUigr9Z6lbJtcIxy5g==
X-Received: by 2002:adf:a58a:: with SMTP id g10mr3720338wrc.3.1548753718601;
 Tue, 29 Jan 2019 01:21:58 -0800 (PST)
Received: from sudo.home ([2a01:cb1d:112:6f00:61d3:a2fc:db63:aa38])
 by smtp.gmail.com with ESMTPSA id x1sm28751755wru.34.2019.01.29.01.21.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 01:21:57 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH v2 0/2] efi: arm: add support for earlycon on EFI framebuffer
Date: Tue, 29 Jan 2019 10:21:48 +0100
Message-Id: <20190129092150.15184-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012200_815464_CA377569 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: graeme.gregory@linaro.org, corbet@lwn.net, pjones@redhat.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-doc@vger.kernel.org,
 agraf@suse.de, leif.lindholm@linaro.org, mingo@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Repurpose the existing EFI earlyprintk code to implement support for
'earlycon=efi' for arm64 systems, allowing the graphical console
to be used instead of the serial port for early debug output.

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

 Documentation/admin-guide/kernel-parameters.txt |   8 +-
 arch/Kconfig                                    |   3 +
 arch/x86/Kconfig                                |   5 +-
 arch/x86/Kconfig.debug                          |  10 -
 arch/x86/include/asm/efi.h                      |   1 -
 arch/x86/kernel/early_printk.c                  |   4 -
 arch/x86/platform/efi/Makefile                  |   1 -
 arch/x86/platform/efi/early_printk.c            | 240 --------------------
 drivers/firmware/efi/Kconfig                    |   6 +
 drivers/firmware/efi/Makefile                   |   1 +
 drivers/firmware/efi/earlycon.c                 | 208 +++++++++++++++++
 11 files changed, 226 insertions(+), 261 deletions(-)
 delete mode 100644 arch/x86/platform/efi/early_printk.c
 create mode 100644 drivers/firmware/efi/earlycon.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
