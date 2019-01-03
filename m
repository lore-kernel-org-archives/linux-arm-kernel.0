Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7ABC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B05C2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N5a8NJ7Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="h7mND0Ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B05C2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kPidFei2IMASBiPd8rWV9gXPyZGUt1zNPxBS9rYe3dc=; b=N5a8NJ7ZZxsnK4
	DmR4Tx1tYMNJaBcALOumu81EeVj8u9R+g4UtkqdfZziSUPPnQW4WX5tMrafcKboO0u064xAXlzPRh
	ijS5lw2YrkezSurHszlMGEqMKvB8k61jPr3n0pyFKks0Smnra+b198gMRBziL+ziXkA5TLeQ78nXZ
	n8NZYuJqJSk2RYCDVnHy6k3vumWyFhf57YIOBkmcd7bSavNWlnVrYu7uZxw1k1/eOuLbs7xW+wXAN
	SBOMHGij1xlrH6Qpumr0ErLt8j6yrjAsJsI2GCq+MVM0NkIQMnwi4SfWpSIVxTSam0kBss4t0g3ch
	yFanxtqCHmZ1jn+qBbww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf7zo-00076M-Ae; Thu, 03 Jan 2019 18:45:32 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7zl-00074s-Hv
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:45:31 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so30097563wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ITHs4YFYCIBJqlnIEDmL4pdf24tyFGf+yxfC0Fh4pdM=;
 b=h7mND0Ja2CKX3WEOQZZNYqd9Wl32B4mOeHcoyNptcwaUsD1PDVzEu47VrmDVJUf5I/
 WypbBGhjGDrsNseH3LE81ezH6HRM+2k+CLcnghlohirns+/D5S+RzY88W5ncYB/QXGE4
 FbSucETcPMTEFkrY8hH7Ezrp+JFajaHzL+fEpNCZVUcWhEeCvstyL4ZBK2jmpnv3KX//
 zhlc96slJeXGPvl+PDvcNgEKSIZ3PYuexVQtTtCSTtMcJRwOKvVuipGRsELAuHweHeIM
 5kGT8cfnOeSShUJDPY4ZZYwnvDDgcJHkq2gdObP0PmXMvHEIam2ksYVYLTM8kno/zPM2
 fQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ITHs4YFYCIBJqlnIEDmL4pdf24tyFGf+yxfC0Fh4pdM=;
 b=pfHcmjU1osd3ry5AlkAmTvnJUTMDwEZvosjDaY1faQdnK77OPT+S4YaCMOyDjkSeGP
 9o4ye88ZsmxQC/GNOS2VBRG9/40DjHrIGQiZxECLrGmh7XzPsLqUMibyYHLRJwV7VQjw
 z1uS/DRbXV4NO+5ZNNzWLxJW9SjIS7cchip/rSpHsQ3wwEONvFAiQ8nd3XlsbjUXaA9l
 ZQ6SScI8ohcno0TH7vU21/+j/7PAAzfkTn0nn4sf7RacKd0BF7qMUjf1Y3BuumdO7mnr
 BVKmzHh9SEMdU2SRxU9LH5rzMmhSOg9WGw5htj8zZmjhHjNcI+TXy9ND0Jq3RRdAOBsI
 3DLQ==
X-Gm-Message-State: AJcUukeT1IcEhgWKx9C08/yUqb8YiuGzcARS3u2UOTOdI/Imyftuylj1
 d/C91F/fEnSjnwaIlfu633PfRw==
X-Google-Smtp-Source: ALg8bN6PfR1Ylu4w+0u4VmomLr/zJW+6Qt2xgzQ9hKBfW94sc2lkLW4VnkWuDt9Lz7DbH3yYH4+Q1w==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr37572044wmj.138.1546541125030; 
 Thu, 03 Jan 2019 10:45:25 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id t12sm52236944wrr.65.2019.01.03.10.45.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 10:45:23 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v3 0/3] kasan: tag-based mode fixes
Date: Thu,  3 Jan 2019 19:45:18 +0100
Message-Id: <cover.1546540962.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_104529_644788_F93D0059 
X-CRM114-Status: GOOD (  10.92  )
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
Cc: Vishwath Mohan <vishwath@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Jann Horn <jannh@google.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Kostya Serebryany <kcc@google.com>, Mark Brand <markbrand@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Changes in v3:
- Fixed krealloc tag assigning without changing kasan_kmalloc hook and
  added more comments to the assign_tag function while at it.
- Moved ARCH_SLAB_MINALIGN definition to arch/arm64/include/asm/cache.h.

Changes in v2:
- Added "kasan: make tag based mode work with CONFIG_HARDENED_USERCOPY"
  patch.
- Added "kasan: fix krealloc handling for tag-based mode" patch.

Andrey Konovalov (3):
  kasan, arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
  kasan: make tag based mode work with CONFIG_HARDENED_USERCOPY
  kasan: fix krealloc handling for tag-based mode

 arch/arm64/include/asm/cache.h |  6 ++++
 mm/kasan/common.c              | 65 ++++++++++++++++++++++------------
 mm/slub.c                      |  2 ++
 3 files changed, 51 insertions(+), 22 deletions(-)

-- 
2.20.1.415.g653613c723-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
