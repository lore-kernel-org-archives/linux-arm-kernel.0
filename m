Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3743CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74AC20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qt8B6iVr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH2FfnmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74AC20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VZy0PrMCjEXWyD3vKAdSpbtLTsYCx8o355Zjv2CdISI=; b=Qt8
	B6iVrXRTkgkvYGA6En60GdRvctWRwVxk+Dg8JhmLwhVKXY3w/tLL/fk6PV3qZmxi7g7eEtif36zvp
	WIJQMEdilnjedifFiQZcmulDF74ETakOJgNOens2vATt54bMNStGlZo1lI0NvEniSmYfpZnzYWO+W
	qq3GkrwSpes1DDLZFtDwVw5rhy9dcLyTLLinfaGlXPb4Y6Vwa6177oQz+FCMnjujhmE3Lx4X+ch4s
	sGP9uioKt1ekeDvfTHRQPKa+r23P8B9A5b4gWASeA3zNZFzDv8fexjEVg3GjdbqpO/qmLkNCE8HPW
	nXaGTuEdRSEIFqb8gH7+ZJQ+zZ84psQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmJ4-0003u7-Rn; Mon, 18 Feb 2019 17:02:14 +0000
Received: from mail-it1-x136.google.com ([2607:f8b0:4864:20::136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmJ1-0003tN-Du
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:02:12 +0000
Received: by mail-it1-x136.google.com with SMTP id g137so307359ita.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=8giBFLa/6EJULGKbVseEpa5JgyJ5hnHBS5FmwtBLcvo=;
 b=nH2FfnmEMYbVA5JGK+Ii5TNJNGtPIeft3XTi60B2+FhIjVBDXzL9C9LWIfZg+Zb57R
 m5b6F1+lh8HI0QxXWjWyCwm2UKjAUKJHzEcOcPfH7inLBhOZdnZ7jC+j3RGW0umjuG5L
 MC6VXZp2SefY6cd54cF4RGOsHJK/Yk84nf3/uKZpafBkBE5h1UYu4zWBM/sKsO2PkX1g
 wCvISVOHpbs50hyJboeAf1PjocFgCwrtyTFi9Xb6gy4RLV77zGvSY4LcwTa3tcyed2Pi
 Lgz1KPSNS4RBOuLiUghZWMaCEkx7ubI0CpgKPyQ3XOvhSq15lKoS26b9uKrnp04taeHh
 JXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=8giBFLa/6EJULGKbVseEpa5JgyJ5hnHBS5FmwtBLcvo=;
 b=aiHoDU58Mid2PNJWX2RntQF6ZQyTZsEB1AEHNsyxUSyKOcNioBFE59jjzIfIz13gwr
 lqw9/igOO53EqgZq1t0hkR6j/1n5cOgYyJ+Ju/aVVzc4jc8nfHENkPLQlg8dUGFG2lZC
 dAbKHORqwxs4SVVLyLAVrvCBvSfA4uXTiD3svLxbv9Q4VaP09nbgN1UCIJoiyTR3fc3X
 V2WJmtRmGyk5+c8H+i5EOE+plCgahWxVmyaklehuv7QSM6xzgnqqjNTEeESmGP12pPnc
 H8hgag3XNyw++3u/Rai0ep9iJxJ61RYiEBYBiycqS00Qc+LGRmHRoMJw737jqArS2zFT
 XMMA==
X-Gm-Message-State: AHQUAuZ4H73shecFV3XcT+fhazUJNEyMsAzC60EW539cKY+zPVEDXzQt
 7z12Y2QY1wEiip8sYaPb4+HeY0BfPVG3NC+3wzs=
X-Google-Smtp-Source: AHgI3IYSMpmkE/KaLQCY1dJwB5T55Q4SPc++viyH62BASZZ//WnbYPiPAdNtkQo6EOuP8/Chvnq1pBJFVy958rgl1gI=
X-Received: by 2002:a24:5608:: with SMTP id o8mr11834924itb.35.1550509328514; 
 Mon, 18 Feb 2019 09:02:08 -0800 (PST)
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 18 Feb 2019 11:01:57 -0600
Message-ID: <CABb+yY2SrgwFNgKa4+ossU3i3U76m2sa63r1=QsRg=PGGWAPxw@mail.gmail.com>
Subject: [GIT PULL] Mailbox fixes for v5.0
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090211_470668_BC93864A 
X-CRM114-Status: GOOD (  10.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

The following changes since commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438:

  Linux 5.0-rc7 (2019-02-17 18:46:40 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-fixes-v5.0-rc7

for you to fetch changes up to d7bf31a0f85faaf63c63c39d55154825a1eaaea9:

  mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue
(2019-02-18 10:40:58 -0600)

----------------------------------------------------------------
- API: Fix build breakge by exporting the function mbox_flush
- BRCM: Fix FlexRM ring flush timeout issue

----------------------------------------------------------------
Rayagonda Kokatanur (1):
      mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue

Thierry Reding (1):
      mailbox: Export mbox_flush()

 drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
 drivers/mailbox/mailbox.c            | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
