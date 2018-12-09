Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ECFC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C8A20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WeCq3lEz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHGemUyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C8A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kgI5/LPMuWUGdwwnWtEeNVJqHYVwQYlYaDbGjK3kfCQ=; b=WeCq3lEzktrJYT
	jqrbO9CIcbs7RQ4DLBPOkCvvH+9Qctj/NkjMcEvVMP5iKTygaaEUKdBbJpNShEGZCUv7ZQXOm4XXe
	uNNE32H/xedWASRBnpBbZdNH19ka2jADSze95Xu9nw9bw22y9C3am10p073dWWj7rse/SzccTFBde
	eLJy5nYkdQCCd5dOIMcmvlNut1/A/tgQdd+rVqMMb4JIPohwdVP4hhOM7mUVLmNdCJxCJQylCpLXR
	BEOB/5+dIdMmYba+HPvZPQBS33aslDDYMoGbrEhbZss2WcpE6RZGCCo0cOje+ft2+1qtd6r73rvJT
	5av9oAYIDq6MNh5MKNcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW7IN-0003Mr-6A; Sun, 09 Dec 2018 22:11:27 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW7II-0003Jm-Jf; Sun, 09 Dec 2018 22:11:24 +0000
Received: by mail-ed1-x543.google.com with SMTP id b3so7932660ede.1;
 Sun, 09 Dec 2018 14:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:openpgp:autocrypt:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=IK/sg+vpc9aAoUf/MZfy0MD1U1qqtAtgcrstqj+m3SY=;
 b=DHGemUyAFQGlMELKcpNzYYo9QAthPwFd26Nxa+t/kjf0hWmR3w9Q/Nks/5UGtzJPYX
 CuDPW9c+nUnHlWFObVNl7RGxSTMeh8oW3IRmfDCJv608M/crgXQBthNWFO0YLXxu+If/
 vhg9qAIjfZ0bLEWA+c1f6AHS/J0PBsG+PPoZP6H7pn+Jm9imiEmCfY8gMfKS4CFcDkpV
 sY7uyx0IRn+4/YP6ZZ3EUcoBws9c7xKMN2og/B8MyASCPPEHQAHICrN0hKM9qpGgiOks
 NCptxxusGNHxcPNfY40Cz2vz+8vGFIauUOswmLxOGaQfbx2wrfeRVwb9eAYr7LhWSODb
 FOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=IK/sg+vpc9aAoUf/MZfy0MD1U1qqtAtgcrstqj+m3SY=;
 b=NuQD2LwISI9X4p+UFop/MUVTvXzmvvrZ4T9KhednoIqt0WK72Bph5PGgjIyFBTzmgh
 n+4dATmxoKHb0jOc/Cq7TJ/5dVLNP5nJBtOKdY9dFamhqJQoU9JsMa9lRCBv+fg4CjpD
 12tmTEe03WpphvD+LdJRmVCeuM3R5BldBnfrb+d08b2qZAJaO9Q4pVwLA5bCEuD+3aem
 WGRfO50114oqXGCZGcUcRHex+5BPvhfCsqAKf81HI1g75Fi8cWxXQufna3FGRQrTIspb
 TiAEQyged3f9RAZwlG8tVSc5KraR7pTCPBTLzQSbJccbK89Dq9LcDRjn1nBP7uOcq76n
 jZWA==
X-Gm-Message-State: AA+aEWZJG6KXHM0y3RrpyFR7qxO7v8Qxy6oX8hcFxvI0ub+3AY28yR6v
 /9l5paIWietJ1IzpBVPHA4uBSvwa
X-Google-Smtp-Source: AFSGD/U0Jv5lB/FhRTdWgypEP33EeLmi698boHKrBgceVbrlLbeoTRKALNqM4o6B8OJOH1J9Zv5nVA==
X-Received: by 2002:a05:6402:8d2:: with SMTP id
 d18mr639744edz.119.1544393469278; 
 Sun, 09 Dec 2018 14:11:09 -0800 (PST)
Received: from ziggy.stardust ([93.176.153.35])
 by smtp.gmail.com with ESMTPSA id x58sm2863396edm.10.2018.12.09.14.11.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 14:11:08 -0800 (PST)
To: arm-soc <arm@kernel.org>
From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [GIT PULL] soc: mediatek: SoC driver changes for v4.21
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <123d92d6-2cee-cae7-42e6-77aabda91038@gmail.com>
Date: Sun, 9 Dec 2018 23:08:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_141122_650814_A331EEE5 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Houlong Wei <houlong.wei@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd and Olof,

Below the very only patch, please have a look :)

Regards,
Matthias

---

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.20-next-soc

for you to fetch changes up to 576f1b4bc80220e1f88f1de5ecb25d99a6e9fa04:

  soc: mediatek: Add Mediatek CMDQ helper (2018-12-02 20:46:10 +0100)

----------------------------------------------------------------
add helper functions to create and send commands to
the global command engine (GCE) device using the
command queue driver (cmdq).

----------------------------------------------------------------
Houlong Wei (1):
      soc: mediatek: Add Mediatek CMDQ helper

 drivers/soc/mediatek/Kconfig           |  12 ++
 drivers/soc/mediatek/Makefile          |   1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c | 300 +++++++++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  | 133 +++++++++++++++
 4 files changed, 446 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
