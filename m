Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B12B2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C/Rxhg6J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbKwWRVS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="psjC0YGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B12B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=wMBp4kfhTHFWBtwuL4wIRA2bFVu/XbxXLz+6VR5SwDM=; b=C/R
	xhg6J7o6uzggl0PHNsmOoKKgMgVpA+4pkqj+4s8iVXZwwtkhPbqRooZP5PreqXKMQf/6Z1u7h1fPz
	5bAwJSyxXfxoIx160R/NKR0CxbVAQLSKT7iSSuu1YtK4FG6fuqZ3o/0ouBEVagdBqEWliypdM4zU4
	D9vZZoIflJUApEUMikZm9CnjFaSoZvKcoLF3UCQ0Ck8w9SbAAP0AWyzETSBgNafWSGVez5pN+KEEB
	vFvU7worS3fE2K7hkvCj0cUPzOyRGSNrTtn4H5EyZzH+vF1n95yCNUpxApSBwgiZ39SVVkoF2PiRE
	3ZjOY8bNK71967lqknSfMdPvX19ATng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkmh-0002yo-LC; Thu, 06 Dec 2018 03:57:07 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkmK-0002cN-T6
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 03:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lRN46JcDLoD61gkb82CGphFU7C5zJzI8x8Wvhmkj0PE=; b=MbKwWRVSdPko/EvH9NXCtK6jq
 SclgOknDDSc9lshYG7AAvcwRGvUqjmGUVauFAlYKyS+IfVa20KRgq3gx7KVxbenpMxQSFZFDeqSYh
 p/wjNwxFPB3W461nREybvIn5YIe5q0q2SwV99iYAIwzoqh6MRBavBP6VQydcYH/PiqIDGzImysYSX
 po5kHUue/ndDuzzsIdMFG7IIXFcU7zll+xznEslwCjcLs7QUUfh4s7jtqtB/6rmauOx1HOXcBk7EX
 6dxnuDM/6rKXcMcpscmDllkxxWnBmH/TFN9LR9uZjGLfPGtwZVFh8oh79hhzUUR3CMXDKNvatuqAO
 S21lsj88Q==;
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUkmE-0003kj-6x
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:56:42 +0000
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id wB63trS5007398;
 Thu, 6 Dec 2018 12:55:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wB63trS5007398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544068554;
 bh=lRN46JcDLoD61gkb82CGphFU7C5zJzI8x8Wvhmkj0PE=;
 h=From:To:Cc:Subject:Date:From;
 b=psjC0YGngRd5CeuKbwq8jUOVO0vOC5vvG+mfV/UnsFl+3C+yYINUG38SrZ79DggR6
 kdor+r+CsgOu/kiCaNvoDL6DJLKibEDFcBFiEYJ/ZyC8I8iZJJZiPaqQ7aRD9+n6LT
 1edq/l5PAHCV3qGuAR0J15VQPuAeakrhyM/ppgUREpZUh94HKFKXQZjy/3HPC+AjG0
 WqkuqurfUJ61Eo1vxImciFEyrr2NyHKr2SseTafgxhXMi4nv4KHxQvNOCzuTeIc0hy
 yEYAKjlIhCesBbBCFj8uSp7YF9N9fMCzMCUXDnWOspeZR56XP2wSvgRDj3MWauX9oJ
 Kq2WMEMmT7W5A==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 0/4] UniPhier I2C fixes
Date: Thu,  6 Dec 2018 12:55:24 +0900
Message-Id: <1544068528-27657-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_225638_791180_76D2BBB9 
X-CRM114-Status: UNSURE (   8.51  )
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


Masahiro Yamada (4):
  i2c: uniphier-f: fix timeout error after reading 8 bytes
  i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
  i2c: uniphier: fix violation of tLOW requirement for Fast-mode
  i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

 drivers/i2c/busses/i2c-uniphier-f.c | 49 +++++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-uniphier.c   |  8 +++++-
 2 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
