Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ED9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:36:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD07A218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+B/KugB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eInQQm6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD07A218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dlHuOfX/9MmBwnHO5heu1sB+zn8nKoZjhSosT7GhLm8=; b=H+B/KugBg7Oq6N
	6Q3Tb82dmyyqHavvapeAqJhi1NEnCo97zjCbq6P+51Ah7ffhaiTsNdTE42xtDDk9sptrtqeuiGMnT
	629JUi99F8ozSsyikA8NyVYQ2WXpCyZDS/RCIp0beE+yOLa8ShDyQaTnbk7eKlb5aU+lGww5KNCme
	h3K7lNojCfGCHVGGSnx4ijmbewwlcxdN0x7rbpwuqQbfOiYhj/j6Puzq9nRDutwiPKnEPac+1iXAS
	VNmD/FFptF/XmK7b3W+JN/JnKFgTjfu+69w9PDpXpISSxpPnkVk7oGxhGyFxmoPu+o+MYENWuZDuL
	IUs/zgXcncRcqm2fmlkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gekRM-0005SH-0Q; Wed, 02 Jan 2019 17:36:24 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gekRH-0005PP-Ok
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 17:36:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id c14so31296178wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 09:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WqvxLRjs/8snQEsiyX94OkFXxMlQW9YzCnB6B4t2n8E=;
 b=eInQQm6sEDrSW8Ri+2HTk9tz3KWL9anV9aQzBFXwpIjQ4AslOvmf6JrAnCjVPVskuq
 ggP7jCm5cJAgtjJ/fZmLjKcm/Xveqors2DstMRikDY34EH2+KXOkbSK4m0kIaz6QLcbI
 otUByN5572pZdK9BeiJ9bovq8A4K9xoY6l8mD3nYm3QjXsnb16R2Wg/qaxZGqvXtEoc6
 UNb5Ta0RlReeCtasTgUG2dYzC6YmZAs1X6pvyDHur7RbcME8G/AXmy+Yrdw9M7dJ+YMs
 kqL+2tdPZkveGaEuzfj676vUysAAq7naoRF0853qdrcjSVmYRPA26o6RQaPkZzaIT0/V
 dC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WqvxLRjs/8snQEsiyX94OkFXxMlQW9YzCnB6B4t2n8E=;
 b=t8untBXh7w5dGx6IbuPgW8YY00dCfttlqLrHCmhpYjoE/11VXAPV17eqMmkIOLMog0
 AyCee/UligTThOFVGnKntUEIwgXJmudl3LuhVOFlTtHnlD0AFGwKAneN8v3x018Zjrpp
 vb33Rs9O0ge8hGerMa5EA+XgJKVthONrmpWLsvFtVvKSzfWxN6bP75cCvvrqKb2khsIm
 24mYJc44sTjMJ1hsDTDIM2ixElW9+651BIjyjbGAnbO/HD+iV292LBQn8aKEAVPchkIp
 k5pD1BVQ5HA53lM9dc12LvB9/u54xjuCswWH4wUxX3o7s5cDx4l+YQs64QVxWPJn/QR7
 3QvA==
X-Gm-Message-State: AJcUukf6dGuVpsF8u42i1UneN9Thku5G/170w2JrUkYFg9SY+0fgvLMh
 vthrZgEyiNlRsx6YhK7r6VVjIA==
X-Google-Smtp-Source: ALg8bN66RPF5pJV4sTABV8H6vo3c/v+grDb2wiefBxmR4QoVbGBAeb/TQmsmt/DjfRVG2/5x2PUzCA==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr38617647wrv.121.1546450573026; 
 Wed, 02 Jan 2019 09:36:13 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id t4sm45987076wrm.6.2019.01.02.09.36.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 09:36:11 -0800 (PST)
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
Subject: [PATCH v2 0/3] kasan: tag-based mode fixes
Date: Wed,  2 Jan 2019 18:36:05 +0100
Message-Id: <cover.1546450432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_093619_867207_14C3386D 
X-CRM114-Status: GOOD (  11.66  )
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

Hi Andrew,

This patchset includes an updated "kasan, arm64: use ARCH_SLAB_MINALIGN
instead of manual aligning" patch and fixes for two more issues that
were uncovered while testing with a variety of different config options
enabled.

Thanks!

Andrey Konovalov (3):
  kasan, arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
  kasan: make tag based mode work with CONFIG_HARDENED_USERCOPY
  kasan: fix krealloc handling for tag-based mode

 arch/arm64/include/asm/kasan.h |  4 ++++
 include/linux/kasan.h          | 14 +++++---------
 include/linux/slab.h           |  5 +++--
 mm/kasan/common.c              | 22 ++++++++++++----------
 mm/slab.c                      |  8 ++++----
 mm/slab_common.c               |  2 +-
 mm/slub.c                      | 12 +++++++-----
 7 files changed, 36 insertions(+), 31 deletions(-)

-- 
2.20.1.415.g653613c723-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
