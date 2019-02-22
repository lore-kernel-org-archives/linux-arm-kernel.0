Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC20C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:22:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B482075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ja8Mhnu4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a1EgUQnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B482075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=u1lgvrNAuHvZYEGTRntl/4pGztz7wYlYFfdMSr6DLDo=; b=Ja8Mhnu4KfLGfG
	iOVwnf7cgvg56k97PULC/g64XPbl5V2RIie8/cBX9hDvc3ZuWwH99v73ibDjnzaAOO8cc6VZVXlR6
	Otljt0nZ3xsgrsWka/h18xyrMHoVrI5W248ULTrDggifpvtlzeXKoUn36omzbxR6rIPzy2gMi4Xet
	Fz7nww5aPKX9unt3jIG3MiVrmJAmw6VdlZDQQLH9PlYihcmc4T2sddm2HFJejHMFPoGEydsszM0n7
	wr69zKvsUV0RWgpp5HUlIEHqLLtNJciWM9gx7823hucyrKeFCMfdGSSt7HPko0DFQjVulF8xwZuOQ
	pHk5eSVi9211c6muxhCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9qW-0006Mq-KZ; Fri, 22 Feb 2019 12:22:28 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9qD-0005wK-Rn
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:22:15 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190222122205euoutp01e428c92064961d232ce68142944fdcef~Frw7l1UVo0034500345euoutp01j
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 12:22:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190222122205euoutp01e428c92064961d232ce68142944fdcef~Frw7l1UVo0034500345euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550838125;
 bh=gfZSE0eRKNyUpk/q2xrM1z9/4QrmLyW79y9kFH42N8A=;
 h=From:To:Cc:Subject:Date:References:From;
 b=a1EgUQnNYoN8xAKK9+ifrjslZUIO/EXaY56lsMPgnFl8e9HO5R8lBHwswA7P6nzkn
 Bh5ScLDtwOtGOeWEnJgkANOQtbtEo0I/HhGAlM216HnPG7sCIL0TZnQ6z7mrfzh+qz
 drKfUjG1ESGhrf41Lljn93X0BB/3IFdIEl3Qmfxc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190222122204eucas1p2cf57ccada7c4191f51c677dcba9fc154~Frw6lW43R2866028660eucas1p2H;
 Fri, 22 Feb 2019 12:22:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id BC.BF.04441.B69EF6C5; Fri, 22
 Feb 2019 12:22:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190222122203eucas1p1e87a8066d4348be4beb3ff035ea55828~Frw5wNn3N1242112421eucas1p1n;
 Fri, 22 Feb 2019 12:22:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190222122202eusmtrp1c54702f32321b1292e3651238f4be42c~Frw5hNirz1040810408eusmtrp10;
 Fri, 22 Feb 2019 12:22:02 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c2-5c6fe96b6cd5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.6F.04128.A69EF6C5; Fri, 22
 Feb 2019 12:22:02 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190222122202eusmtip197b10c3e5578b4b03e39d2a0177c472b~Frw43TpYR1185211852eusmtip17;
 Fri, 22 Feb 2019 12:22:02 +0000 (GMT)
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
To: k.konieczny@partner.samsung.com
Subject: [PATCH v4 0/3] add AES support for Exynos5433
Date: Fri, 22 Feb 2019 13:21:41 +0100
Message-Id: <20190222122144.19024-1-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7rZL/NjDF7MMrPYOGM9q8Wc8y0s
 FvOPnGO16H4lY9G37z+jRf/j18wW589vYLfY9Pgaq8X9ez+ZLC7vmsNmMeP8PiaLtUfuslss
 vX6RyaJ17xF2i/+/mpkd+D3WzFvD6LFl5U0mj20HVD02repk89i8pN7j38IpLB4H3+1h8ujb
 sorR4/MmuQDOKC6blNSczLLUIn27BK6M5y+b2AsmcVYsmtrE2MC4lr2LkZNDQsBEYuLrlUxd
 jFwcQgIrGCWW/fvKDuF8YZToXb8WyvnMKLHh32JmmJYlVxayQCSWM0rMbnrPCNfyf/40sCo2
 AXOJR9vPMIHYIgLKEpPvTWcGKWIWmM4icePHbLDtwgJmEpfXtoA1sAioSlx+NReogYODV8BF
 4tbZFIht8hLne9eBlfMKCEqcnPmEBcRmBoo3b50NNlNC4By7xMYL/WwQDS4S3zc/Y4WwhSVe
 Hd8C9amMxOnJPSwQdrnE7q3P2CGaWxgl5k5exASRsJY4fPwiK8gRzAKaEut36YOYEgKOEltv
 pUGYfBI33gpCnMAnMWkbyFsgYV6JjjYhiBm6EvP+n4E6QFqi6/86KNtD4vmHHWDHCAnESjRv
 O8w4gVFhFpLHZiF5bBbCCQsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJrfT/45/
 2sH49VLSIUYBDkYlHl6LjXkxQqyJZcWVuYcYJTiYlUR4GZ7nxwjxpiRWVqUW5ccXleakFh9i
 lOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpgTPJ7d+XJreD1XrG/PhmUfSm/cnmqwbrN
 R4yaueetVhS9mGYn4+wZ5LiMcV/djlvbryql/mjvrlh9yVnd6Vnj/bJd/89JXU1hO1PlLqV+
 rf165/WzZXMVma00hHknWJm7GxzaYXZg40wBkYXqyznftrfOu/Ez7OSsLp/9s7YIRHd+8rFV
 PHxFVYmlOCPRUIu5qDgRAMM/drlqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7pZL/NjDG42W1tsnLGe1WLO+RYW
 i/lHzrFadL+Ssejb95/Rov/xa2aL8+c3sFtsenyN1eL+vZ9MFpd3zWGzmHF+H5PF2iN32S2W
 Xr/IZNG69wi7xf9fzcwO/B5r5q1h9Niy8iaTx7YDqh6bVnWyeWxeUu/xb+EUFo+D7/YwefRt
 WcXo8XmTXABnlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllq
 kb5dgl7G85dN7AWTOCsWTW1ibGBcy97FyMkhIWAiseTKQhYQW0hgKaNE75IMiLi0ROPp1UwQ
 trDEn2tdbF2MXEA1nxglmnesZQNJsAmYSzzafgasSERAWWLyvenMIEXMAotZJA68+wCWEBYw
 k7i8toUZxGYRUJW4/GouUJyDg1fAReLW2RSIBfIS53vXgR3EKyAocXLmE7CDmIHizVtnM09g
 5JuFJDULSWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwKjaduznlh2MXe+CDzEKcDAq
 8fBabMyLEWJNLCuuzD3EKMHBrCTCy/A8P0aINyWxsiq1KD++qDQntfgQoynQrROZpUST84ER
 n1cSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgbFSTOOpF5tN5qlL
 HmK+NxI5WE7z7XNoDl8xMTb13OWCH5ZRibnB5zY73FpXun7ZGY5X0WLSe5VnaN04zbj31rqt
 /y9u87+peHNVn6NPsKXfwoXri/exRHQ4Zd7aMO9Gq9wCfgnHm18M9uet9FzBkDYvqKuq5IzG
 E8/VXpmbN7pLLnTcM03Avk+JpTgj0VCLuag4EQB4rgo9wAIAAA==
X-CMS-MailID: 20190222122203eucas1p1e87a8066d4348be4beb3ff035ea55828
X-Msg-Generator: CA
X-RootMTR: 20190222122203eucas1p1e87a8066d4348be4beb3ff035ea55828
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190222122203eucas1p1e87a8066d4348be4beb3ff035ea55828
References: <CGME20190222122203eucas1p1e87a8066d4348be4beb3ff035ea55828@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_042210_597648_2EA8E3FC 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Vladimir Zapolskiy <vz@mleia.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add slimSSS node to DT and crypto AES support for Exynos5433. Tested on
Exynos5433 board with crypto run-time self tests and with tcrypt with
command insmod tcrypt.ko mode=500 sec=1

Changes since v3:
- moved bindings documentation out from samsung-sss.txt into separate file
  samsung-slimsss.txt

Changes since v2:
- address Corentine Labbe note: add "const" to char* in declaration of
  struct samsung_aes_variant

Changes since v1:
- address Krzysztof Kozlowski review: add missing comma in struct
  definition, add goto for error code path, correct indentation,
  in documentation add that Exynos5433 has both slimSSS and SSS IPs.

Kamil Konieczny (3):
  arm64: dts: exynos: add SlimSSS for Exynos5433
  dt-bindings: crypto: document Exynos5433 SlimSSS
  crypto: s5p: add AES support for Exynos5433

 .../bindings/crypto/samsung-slimsss.txt       | 19 +++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  9 ++++
 drivers/crypto/s5p-sss.c                      | 50 +++++++++++++++++--
 3 files changed, 74 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/samsung-slimsss.txt

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
