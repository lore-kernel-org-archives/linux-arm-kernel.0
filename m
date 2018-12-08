Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6FBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:34:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E35720700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 22:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gY9qBS40";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdjptZin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E35720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1vfgMz9ZEzpJDLX7UTClW3kv5LMxqOimSpQbbmYFJ6s=; b=gY9qBS40Gqcgfj
	ycC5ehjfptmd8Jqav6pCcXK2ELZMRQsckG3lsq+sef/v1TIPC1Fwyyo/hP+8fxAuzuq3RtTb90t3S
	2rA1aW6yYhbn1rYkflEKsmivLH+gfNrGQ5iazC0uKYSzBilKzDEDurf2G2Y6c8VBPmbka89BaSSqr
	vTFAO6D57oO59Rj9Dx0HOVc9+xaa95KhXwobyRqf60tgQ8XMDxtznAyvD9IineZFm3N1ugweH0Vk3
	jok9imXC24gx5oI9E7Pfq7WU5uZuIO9AC/KZ+97QE2AXWQmZJU6H+MRwOd3ZE1B17YAd9lTc4Nldg
	Uf4uuZHI5Hro6WS9NORQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVlB0-0001jh-3Q; Sat, 08 Dec 2018 22:34:22 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVlAv-0001iz-Sp
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 22:34:19 +0000
Received: by mail-lj1-x241.google.com with SMTP id v1-v6so6533539ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 14:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=MEMV07a2j3DwDrw81d0ofGhkdDA3LqftmQOaho5plkM=;
 b=HdjptZin//4gTigC9rriNAVRKkVZRb52xbSi5r93SBEl3aHpKF9ylHZvbb0EqaUooE
 mUvq9r76jUcEsqoVILMvCpEtphaXsGcukpnjih9XtnbNACgUEvfFpKyO8ia0LripFzVe
 ftZpx+7nJ7FQHjzeVmAj0EnHBZET8K71qE2Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=MEMV07a2j3DwDrw81d0ofGhkdDA3LqftmQOaho5plkM=;
 b=UMDryL2vvmBysLyL4xKwi2ZJIhm1lr/5/rRryD8CexvqW+HCr6kltZe54AHqYiDENO
 X4Gf2YqL8a9kLXzNt0BPvdotp9l1T8gfhH04mDYERlAVV1BDQvEVm3BiK8av0WDX2U4B
 Mrma4w1mls1r4i4ABaftC/KnZJLQ2ybNcMy4c0QITLeyTNlRa9VAJ9gP9kvKcpDTVwNf
 23pLvXLPfvVFGGsbyUr4DavZQQwN/ffRUndJb6TPazTTF9JFZSwpJ94XRqpj+p+F97Hl
 P0CtrBkW+yTZNwv+eg98Q6djheL6KJ4O9HAyiG7XzjR0zP1cbcSb6A/vsaR/J0o2yQRI
 JsVA==
X-Gm-Message-State: AA+aEWaAra80xGIAIqCG88if0oEDGrawp14AsnaD7ph4kiB0Rl63xKXr
 BS2+kCMdhCguPWJ6MK3tOvdbJ75tIGDIFJk5wr5Wmw==
X-Google-Smtp-Source: AFSGD/ULKFKlK0xGrW+HI8CscutbXJF49y7YjUJwi7f8IHGwgiTRSDa0O7nPeodoZsJ0EwGElFjGFz3IxWIa4W8FH1s=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr4137948ljk.4.1544308445717; 
 Sat, 08 Dec 2018 14:34:05 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 8 Dec 2018 23:33:54 +0100
Message-ID: <CACRpkdaoLLt6CZ0OT=cRgg0R0435hdx3hdTdEvW4Wk-6S80bwA@mail.gmail.com>
Subject: [GIT PULL] Gemini changes for v4.21
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_143417_937010_02769930 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC folks,

here are some Gemini patches for v4.21, mostly
related to me getting flash to alternate properly on
two routers and the USB bindings being in place so
we can at least register the blocks. Then some additional
flash-related partitioning and parsing fix-up.

Please pull it in on some appropriate DTS branch!

Yours,
Linus Walleij

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-dts

for you to fetch changes up to f18fd0f560eb3b798f9835fbd09fad1a27235e13:

  ARM: dts: Bump Gemini platforms to use 100ms debounce (2018-12-08
23:21:49 +0100)

----------------------------------------------------------------
Gemini DTS updates for v4.21:
- Fix the erroneous partition table on D-Link DIR-685
- Multiplex flash usage with other usage using pin control
  handling (merged to the MTD tree)
- Use the RedBoot partition parser on SQ201
- Add the USB blocks (DT bindings merged in the last merge
  window)
- Bump the debounce times a bit to avoid bouncing

----------------------------------------------------------------
Linus Walleij (5):
      ARM: dts: Fix up the D-Link DIR-685 MTD partition info
      ARM: dts: Enable Gemini flash access
      ARM: dts: Fix up SQ201 flash access
      ARM: dts: Add the FOTG210 USB host to Gemini boards
      ARM: dts: Bump Gemini platforms to use 100ms debounce

 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 63 +++++++++++++++---------
 arch/arm/boot/dts/gemini-dlink-dns-313.dts |  2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts      | 12 ++++-
 arch/arm/boot/dts/gemini-rut1xx.dts        | 22 ++++++++-
 arch/arm/boot/dts/gemini-sl93512r.dts      |  8 +++
 arch/arm/boot/dts/gemini-sq201.dts         | 78 ++++++++++++------------------
 arch/arm/boot/dts/gemini-wbd111.dts        | 10 +++-
 arch/arm/boot/dts/gemini-wbd222.dts        | 10 +++-
 arch/arm/boot/dts/gemini.dtsi              | 32 ++++++++++++
 9 files changed, 161 insertions(+), 76 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
