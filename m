Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C759C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:14:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4561420675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ei9hswa7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l/OVYs43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4561420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FExaB654Ouim146c0G6XI1cOe5r5aBcnmaprV6bubSI=; b=ei9hswa7wxV0dY
	zSL5VbfrNXwsDGx1uL6y5RAbdZpQ4YsHjjqjAwoQMfMgRoo+Uqkll2+SZls/7zq2LK5RWFCEt3ouV
	o6BkM86rztb2Vuf7yhQ9l0mR4sucXNbM2JO+PU6Bz2Mp9tCr/Rnpxmq5EEUI09aRUZt3JwuhoVXuf
	bL2NTa5ILtk3revcve/xUGTBw4wwS7HmAxT8oSVtGU+iR7Wu5XBuATLF+9hexz95Bu3sXsk3hxCa9
	Fv+pMvDIaNoKzRRjkV5xcs+TvQRFPT0TBMfPwO4HzxXx20odIK99yoAl9Br0EZpAzJIxNe44IT0DZ
	7KOJF3jsjFtGw9zcSmXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guR8s-0002BM-Vc; Fri, 15 Feb 2019 00:14:10 +0000
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guR8o-0002Av-PV
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:14:08 +0000
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x1F0DYBa003303
 for <linux-arm-kernel@lists.infradead.org>; Fri, 15 Feb 2019 09:13:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1F0DYBa003303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550189614;
 bh=MCdVTYrxWT51ahRDJrWzWV93+APa0whUUx6krSzdkzI=;
 h=From:Date:Subject:To:Cc:From;
 b=l/OVYs43FR056G7L8FNoh5dmEPjy6479+CjE3ufMDACzMbTPjseX2RSHqIc5GnmYl
 T3Eb4SO6f7CXF95j+6XUPBD/1PD1nkxGW1UrjWjJ3Elau8mXha4GaDQl/Z9SsReN5Y
 ++/DR+RBq2cDX4TDL5YqOdznNRJaia6MZHMNryqu/RFyLZmeq0X3wdB5yYYEcL/Qdp
 BMwb/q71/yB+DtSi2mxXNtY7JsyEffvu/bwMryC4hAbnLaMFo2BpXf9xyXyp1zpMZQ
 p7Mi/6FleFsEXLnZMvIbyd4A/3v3rxQRXfmQPVshDY3pcn1AWe0YcbudK561cU7xlm
 hFrsnTaIpRF6A==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id z18so4799791vso.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 16:13:34 -0800 (PST)
X-Gm-Message-State: AHQUAubCdAJ+uHUrX2MnpKR8OB3Tc6xFXnPNeBmEsv6p0PsSMnpYeVjf
 OaFSBAAmTZWGmHLgEIegO1C4AW18ZRTAhTo6XG4=
X-Google-Smtp-Source: AHgI3IaxjPC+fVyohsCGKpe3R9ayn9eioAAWkTvzLxzBJYAo+2nzUp0gZELZzZp9mkcVZbbkwt2KmQ2jSnWeRgVEC2A=
X-Received: by 2002:a67:485:: with SMTP id 127mr3551734vse.54.1550189613569;
 Thu, 14 Feb 2019 16:13:33 -0800 (PST)
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 09:12:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQOQ7KczCUP7hWWTX+9oRA3zycbBTDR7rXXkfhb0TG-Zg@mail.gmail.com>
Message-ID: <CAK7LNAQOQ7KczCUP7hWWTX+9oRA3zycbBTDR7rXXkfhb0TG-Zg@mail.gmail.com>
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.1
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_161407_060828_889A5BF6 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof,


Please pull UniPhier DT (64bit) updates for the v5.1 MW.

Thanks!




The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v5.1

for you to fetch changes up to 519904a42ff8c2ed23651f33c256d009c656a50b:

  arm64: dts: uniphier: sort labels in the same order as in dtsi
(2019-02-15 09:04:30 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v5.1

- Add PCI Express controller nodes

----------------------------------------------------------------
Kunihiko Hayashi (1):
      arm64: dts: uniphier: Add PCIe host controller and PHY nodes

Masahiro Yamada (1):
      arm64: dts: uniphier: sort labels in the same order as in dtsi

 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts |  4 +--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 47
++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    | 10 +++++---
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       | 47
++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 5 deletions(-)



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
