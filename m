Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E11C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:57:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80EF214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DwV4Pjd5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RinusaMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80EF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yNmDqELDv3jLEbfwsSJ5of7n3mUb+veYwv449PLqhwE=; b=DwV4Pjd5MUvGPv
	Kpq4V6UCaOgURbhDacyg4cl5qKpTt8R0PlaKfqeCrtX0/qZ4mKhVrIbtvZrSn3nspho1rEnxiNfaj
	k0n9PvBrnkeuBNrQwSJWz1o8OXC+yivPmmY22yX+zzXt/STTMWY+hFZnEX9qjdjx9VbMjv9gi4lr6
	S8PeXLSQij5yG1Fkih7AEDBZwR1zTrm2aynNGLluYcqGNv0RNmrjtWwpY/MBht5L7aBEiHtbpHe8W
	IqEdgWddothdkDXCu8Lr2I8ex12VQBuFKBXck7oJbylQouTaZ2QFg6iwzzAWLSfSk36c7MtXHtY7p
	CBGot3zEZlaJHB9AhjiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghapU-0000uW-2J; Thu, 10 Jan 2019 13:57:04 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghaoW-0008Rn-5Q
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:56:34 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ADu0kv034988;
 Thu, 10 Jan 2019 07:56:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547128561;
 bh=ZBVZc1gpXMHWV1iXwdK1iAEKJ0o2fborH/ZfAS920lw=;
 h=To:CC:From:Subject:Date;
 b=RinusaMje528447RgSUwQC6iZ/xC8ADnJbx/miJmLBKqV7F5AcLjiuu+I6HxR1UHb
 j2nTVSBQHQV5rboLym1LHiyqrhrWyckJx+xIniBQRJ5Qbm4dDHQIsslQf7c8TSk6a7
 ILW4EMjT1KWAvY2S+CplGpLvjETXUSVUiy7BqcRo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ADu0gt074039
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Jan 2019 07:56:00 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 07:56:00 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 07:56:00 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ADtwcV007353;
 Thu, 10 Jan 2019 07:55:59 -0600
To: ARM-SoC Maintainers <arm@kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
Subject: [GIT PULL] DaVinci fixes for v5.0
Message-ID: <0aa5fc18-67cf-be6f-d0ba-a8a4514e70f4@ti.com>
Date: Thu, 10 Jan 2019 19:25:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_055604_951823_44C4967E 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v5.0

for you to fetch changes up to c25748acc5c20786ecb7518bfeae8fcef93472d6:

  ARM: dts: da850-lcdk: Correct the sound card name (2019-01-10 13:32:51 +0530)

----------------------------------------------------------------
This pull request fixes some more regressions on legacy
DaVinci board support due to GPIO driver clean-up introduced
in v4.20 kernel. These are marked for stable.

Also has fixes for some long standing Audio issues on DA850
boards.

----------------------------------------------------------------
Bartosz Golaszewski (5):
      ARM: davinci: da830-evm: fix label names in GPIO lookup entries
      ARM: davinci: da850-evm: fix label names in GPIO lookup entries
      ARM: davinci: dm355-evm: fix label names in GPIO lookup entries
      ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries
      ARM: davinci: omapl138-hawk: fix label names in GPIO lookup entries

Peter Ujfalusi (4):
      ARM: dts: da850-evm: Correct the audio codec regulators
      ARM: dts: da850-evm: Correct the sound card name
      ARM: dts: da850-lcdk: Correct the audio codec regulators
      ARM: dts: da850-lcdk: Correct the sound card name

 arch/arm/boot/dts/da850-evm.dts             | 31 +++++++++++++++++++----
 arch/arm/boot/dts/da850-lcdk.dts            | 38 ++++++++++++++++++++++++++++-
 arch/arm/mach-davinci/board-da830-evm.c     |  4 +--
 arch/arm/mach-davinci/board-da850-evm.c     |  4 +--
 arch/arm/mach-davinci/board-dm355-evm.c     |  4 +--
 arch/arm/mach-davinci/board-dm644x-evm.c    |  4 +--
 arch/arm/mach-davinci/board-omapl138-hawk.c |  4 +--
 7 files changed, 73 insertions(+), 16 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
