Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE06EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:47:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9502083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DhzVKWzA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="b0xOLyxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9502083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1ZwYPZ0ZAEbT2zjRpzUrAXEfA6IFDrmcS0Pc8WtM0BM=; b=Dhz
	VKWzAvTUgscVV3/rJtnDdVC2jD2ntiXXTq3g6aOe+uVtEYEAV9TdA4LPBF86+RanQZDF//KlRc+Zg
	/UTXc1uNF/Y2p6Qtgy7Ywe1pzhM4YtvuKX6HTBbpp3S76IHzp745VSbntzU8Js3DZwjSB7tJdxhVj
	vjgUGvqXlyxrlynS0B259503Fpv5lTa3ht3W9qwvjtzq2LAHfiCAUtxqnM8WpRqRlYM3HUEx4zdAY
	mU+VbOqHlb74fTxElQqIUC/ih41uYqzkKxGlfEHUeqQ9E7+gO5AIvt/8t8/TL9rM6xL995ntKyGo7
	YR/boxVW5mZR1xRaCezJ2c6f09CeQAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grnlN-0000cs-Ls; Thu, 07 Feb 2019 17:47:01 +0000
Received: from mx2.ucr.edu ([138.23.62.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grnlK-0000cS-Is
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 17:46:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1549561618; x=1581097618;
 h=from:to:cc:subject:date:message-id;
 bh=wImntgiBJtk3wwGZmT6fv88DkNLi+LVBqQWMeTeg6K4=;
 b=b0xOLyxiyPaU5dQlptMt18G4gaJCNAJuJX7nAh+d7O4hl7ns6mSfTycA
 2xFunT90+4pZ5kDLodatwZhbZQ3qFa/v2UYqsYK9gT+5tyHGXnsI3ytsj
 ZlNxxEbUX2BQs4dNrdggITqn4Dsy1l6UdhqiWez0xxjFM3yWL/0Nc/42V
 /tFQCMkUASV+FnOpm/qrHItC2CBBzkBwJo6ionkurVsgssSJtV4CtoaA+
 +pGE0a7votzJPh62MKhe2TKDka3tAPtPRrYYdM3yjH75gJTCYh5l7z9mY
 aV6p/Mx/qZVwbZ35pENcVOWleQTeA0yqxZp2kETfsFY0z/JrdYPwDwOU/ Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3A3LcOEBAGF60XZWPDj3E6UyQJP3N1i/DPJgcQr6Af?=
 =?us-ascii?q?oPdwSPvyr8bcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBVcuqP?=
 =?us-ascii?q?49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6?=
 =?us-ascii?q?JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswRXTuHtIfO?=
 =?us-ascii?q?pWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBnM?=
 =?us-ascii?q?VhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qiqp4bt1RxD0iS?=
 =?us-ascii?q?cHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzfqbcfdMBXmpBX8BRVyNcCY2i?=
 =?us-ascii?q?doUEEuQBPedGoIn5ulQFsB+yCAewCO/qzDJDm3340rAg0+k5EQ/IwhEuEdwNvn?=
 =?us-ascii?q?rTt9j5KLseXPqpwKTS0TnPc/Vb0ir95ojSdRAhpOmBUrBxccvQyUkvCgTFhUiX?=
 =?us-ascii?q?pI3lPjKV1v4Cs2mH4+Z8W++ikHMnpB1rojS12Mgjl5TJi5sTx1vZ9it52J44Kc?=
 =?us-ascii?q?OkREN/e9KpE5tduzuEO4drQs4uWXxktSI+x7EepJK2fSwHxI45yxPRa/GLaZaE?=
 =?us-ascii?q?7xP5WOuTLjp1gm9udqiliBao60egz/XxVsyz0FlXsCVIisLMtnUR1xzL7ciHV+?=
 =?us-ascii?q?d98l+h2TmR0wDT7flJIUUumqraL54t26YwlpUOvUjaEC/6hUH7gauMekUr/eio?=
 =?us-ascii?q?7OvnYrH4qZOGK4B0jQT+Prwvmsy5H+s4LhADU3aH9em4zrHu/k30TK9UgvErkq?=
 =?us-ascii?q?TVqo3WKMAfq6KhBg9ayIcj6xKxDze819QYmGEKLVJEeRKHlYfpOk3CLOz2APqk?=
 =?us-ascii?q?nlSjjC1ry+rYMbL8H5XBNmLDn6v5fbZh905czxI+zdRe55JSF7EAL+v/VVXrtN?=
 =?us-ascii?q?zdFxM5MBK7w/zhCNpj0oMTQmaPAq6CMKPOql+E/OMvI++CZI8PojnyNuYq6OTz?=
 =?us-ascii?q?gnMjnl8dZ6apjtM5cne9S8VnMUWEZjK4k8UBGGZS5lEWUefwzlCOTGgAND6JQ6?=
 =?us-ascii?q?sg62RjW8qdBoDZS9Xo3+SM?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2B1AgCnblxcgMfXVdFkHAEBAQQBAQcEA?=
 =?us-ascii?q?QGBZYM8Sg+MfIsQUgaKfm2FWYJzhwoBCgEBLIRAgyoiSgEDAQECAQMBEwEBCQ0?=
 =?us-ascii?q?JCCcxgjopgl82UoEVAQUBNVuCSQGBdA2hWDyMFzOIWQEHgUsJAQiHcIRBgQ+BB?=
 =?us-ascii?q?4NuhH+DVIJDAoEsAQEBilCFPJFUAQYCAYFlgUOPESWBbYFKhwE4h2QBLZtPAgQ?=
 =?us-ascii?q?CBAUCBQ8hgzNNJYFsCoFEglKOLB4zgQeLJoJNAQ?=
X-IPAS-Result: =?us-ascii?q?A2B1AgCnblxcgMfXVdFkHAEBAQQBAQcEAQGBZYM8Sg+MfIs?=
 =?us-ascii?q?QUgaKfm2FWYJzhwoBCgEBLIRAgyoiSgEDAQECAQMBEwEBCQ0JCCcxgjopgl82U?=
 =?us-ascii?q?oEVAQUBNVuCSQGBdA2hWDyMFzOIWQEHgUsJAQiHcIRBgQ+BB4NuhH+DVIJDAoE?=
 =?us-ascii?q?sAQEBilCFPJFUAQYCAYFlgUOPESWBbYFKhwE4h2QBLZtPAgQCBAUCBQ8hgzNNJ?=
 =?us-ascii?q?YFsCoFEglKOLB4zgQeLJoJNAQ?=
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; d="scan'208";a="1055034903"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
 by smtp2.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 07 Feb 2019 09:46:38 -0800
Received: by mail-pg1-f199.google.com with SMTP id o187so418277pgo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 09:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2tzpVyPYpfdzliPB1oyDkazyBfCrViS9BIM/UOQo4PI=;
 b=eNtWzdzMVkq0CVorvoR2G8ROjzJrsZ3TwF100rfSsI10/UxBRTdYNqL4FSaviDbGOU
 sMA0qiP66NS6hsk8lG/fNYgtEe1ha2eGjMz9+AEMm8TqdRmUYLfEzrFqGsYpQ1jnBncm
 rEnPS3PHuNBjeyDQXM2odds6cGrzGJOyGKWOybhzzadC9UiKeEOL/V1xFNV8r9NKK3ak
 3TANRdoZ9CWU6EWiN4MP9ku4lv4qNx5ok65hm2q8jgU0Ej7osIaw6CxSz0CViMlY2ThP
 CT9dBzB/3dJPVBjJLNkahVDp6urdaH8xGVtC6hjlhG2wXva7Ihgk38zfIxdSwHLnzhkD
 F6ig==
X-Gm-Message-State: AHQUAubM0FshVo6gJnp/i08aBfLCmfh+kwlsfueccAdQf2VZWjXKE99S
 KEvmlhwJ6ckIAsFbz6ihD1nRPx8YPy8GCECVcIHNoN5aObsIaeIYxa4HsCDUbBl3DH+7SgTe//l
 MRVvRV8TO2qYsCgHcrvvsEEuQDDj/7ChJFb2y
X-Received: by 2002:a63:da14:: with SMTP id c20mr15338850pgh.233.1549561597765; 
 Thu, 07 Feb 2019 09:46:37 -0800 (PST)
X-Google-Smtp-Source: AHgI3IayrGVGwQ3ZjOg/wOj9tm31uHR4CdpsjffL6HoAIgRqtFTZ12maLg7c1SCwb6lANot4erlZ3A==
X-Received: by 2002:a63:da14:: with SMTP id c20mr15338773pgh.233.1549561597020; 
 Thu, 07 Feb 2019 09:46:37 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
 by smtp.googlemail.com with ESMTPSA id m67sm14007791pfm.73.2019.02.07.09.46.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Feb 2019 09:46:36 -0800 (PST)
From: Yizhuo <yzhai003@ucr.edu>
To: 
Subject: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
Date: Thu,  7 Feb 2019 09:46:23 -0800
Message-Id: <20190207174623.16712-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_094658_662581_640AA607 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: csong@cs.ucr.edu, Alexandre Torgue <alexandre.torgue@st.com>,
 netdev@vger.kernel.org, zhiyunq@cs.ucr.edu, linux-kernel@vger.kernel.org,
 Yizhuo <yzhai003@ucr.edu>, Chen-Yu Tsai <wens@csie.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In function sun8i_dwmac_set_syscon(), local variable "val" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the if statement, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 39c2122a4f26..50cfd6d83052 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -641,7 +641,12 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 	int ret;
 	u32 reg, val;
 
-	regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
+	ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
+	if (ret) {
+		dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
+		return ret;
+	}
+
 	reg = gmac->variant->default_syscon_value;
 	if (reg != val)
 		dev_warn(priv->device,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
