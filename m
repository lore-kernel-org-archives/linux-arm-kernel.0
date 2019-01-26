Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69418C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:33:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28330218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UiCjpv6d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="MyfTV8wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28330218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=LnnncbcIFKd69SIXUaMJz3lymGsIaGG1XGgC0O1/lSk=; b=UiC
	jpv6dYpGfzeqVF4QGe8Dc+cSZtdOnfldXHieVPsEwkgMB6caqxVGW4dTrb++hyGII0W4nF3ro2khJ
	SkASt5LgAGPCjQFUzwQbM2AtEhqYDuaVyt9d25BoR23sR8q+jiKscic1dmnbKRjJIrgTq3xtBxqQp
	6P8dydtijDMkAs2iNHyqC9ZQHHeOuuqQnxYGTB+W7umroJbA/8meFJBhKWuwKO+Ufj4aiLAPTFyFS
	oNMeA+jqdWRbD1G2lXUMP5BWGQrvFijG149loFa7LXLkkKQG7Ncs2gOBOhMdUdmCpCqWzQy+w2Sed
	iqzxK8GsxLPYLbicZqrPKCDM5wYu1mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnHWR-0006oY-By; Sat, 26 Jan 2019 06:32:55 +0000
Received: from mx3.ucr.edu ([138.23.248.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnHWN-0006o9-Dp
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 06:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1548484371; x=1580020371;
 h=from:to:cc:subject:date:message-id;
 bh=spBmDIiF5jHQhSNgngoPo9qlEpmTF8uUh2cGxlBjoKg=;
 b=MyfTV8wp2dMLRKIE7JSmb30+wzg0omgA16/BCkt6ztcbPjuKgj/ad+o+
 JDfBq2NEuwgbAri608CsxuC1CZtvLhpqKJhoEV8CezaDFmGqYmmtgmpDV
 5AMehJed59oIrKRvLsjiX6hO76rSQ1tRT9IYtGjLhTxglylzJtC0mQzFt
 Zou3WIi8e8sou50trVBj3s9Plau033Nf1Ip/Awm/02EcfzsIiK6XNJpWo
 Vwc8cup/R71ya+vNtbfsbJfMbBm9XANd/7USw1UTGK+zzD5UGT8ro60w5
 Yc1jFx37SIGFDWy/uhfRX6YEXwt0Db4QZav06lChqpKAMfIEdwEBiIQlp Q==;
IronPort-PHdr: =?us-ascii?q?9a23=3ALMHQIhRa9oSGyIK0utbsLZA+89psv+yvbD5Q0YIu?=
 =?us-ascii?q?jvd0So/mwa69bRyN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR4BhJ?=
 =?us-ascii?q?detC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+?=
 =?us-ascii?q?KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxxXTv3BGYf?=
 =?us-ascii?q?5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM30u683wqRbD?=
 =?us-ascii?q?VwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xymp4rx1QxH0li?=
 =?us-ascii?q?gIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNMfRGpBRd1RVy1HAoOz?=
 =?us-ascii?q?coABEfMPNvtWr4n8uVQOqQaxDhSoCO7h1jNEg3n71rA43es8CwHLxAwuEcwTvn?=
 =?us-ascii?q?rar9v7M7wfXfypwKTS0TnOde9a1Sv75YPVch4hu/aMXbdofMXTyEkuFgPFjkiX?=
 =?us-ascii?q?qYf4OD6U1uUMs2iB4OphSe6jl2Aqphpsojez3McgkJfGiZ8Iyl3d8yhy3YU7Jc?=
 =?us-ascii?q?WgRUJlfdKpFIFcuiKaOodsXM8uXmFltDwnxrACvZO3ZDUGxZUjyhLFdfCKfYiF?=
 =?us-ascii?q?7gj9WOuQOzt1hn1odbSijBio60eg0PfzVsys3VZPqSpKj8fDu2gW1xzW9siHUv?=
 =?us-ascii?q?x9/lq92TqX1wDc9OVEIUcsmKreMZEhw7owmoMLsUTMAyP6gUv2gLKSe0gg4OSo?=
 =?us-ascii?q?5OPnYrLppp+YKYB4kB3xMqMrmsCnAOQ4NBYBX3SD9OiiyLHu+Vf1TbZKg/EsjK?=
 =?us-ascii?q?XVrZDXKd4GqqO9BwJZyoMj5Ay+Dzei3tQYh34HLFdddROHjonpO0vBIPHkAfuj?=
 =?us-ascii?q?jVmhiypryOzcPrH7HJrCM2XDnK/7fblh805c1BYzzddH6pJQC7EBJu/zW0DouN?=
 =?us-ascii?q?PCFB85NhW4w+X5B9Vn0IMRR2aPD7SdMKPTql+I+vkvL/ONZI8Ttjb9MeIq6OPw?=
 =?us-ascii?q?gnAjhFARZ66p3YEYaCPwMO5hJhCoYGjsn9BJRXYYvgM/FLSxoECJS3hea2vkDP?=
 =?us-ascii?q?F03S0yFI/zVdSLfYuqmrHUmXjjEw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ApAQDC/ktcgMfXVdFjHAECBAEIBAGBU?=
 =?us-ascii?q?gcBDAGEBQ+MG1+LFk8BAQEGimQYbYVXgnKFCoF7AQoBASyEQIMMIjQJDQEDAQE?=
 =?us-ascii?q?CAQECARMBAQkNCQgnMYI6KYJfgQiBFQEFATVbgkcBgXQNnVo8jEqIVwEHgUsJA?=
 =?us-ascii?q?QiHboRBgQ+BB4NuhH+DVIJDAoEsAQEBj2yRJAEGAgGBY4FCjnskgzGGcIgHAS2?=
 =?us-ascii?q?adAIEAgQFAgUPIYElgg5NJYFsCoFEglGOLB4zgQeHWoJNAQ?=
X-IPAS-Result: =?us-ascii?q?A2ApAQDC/ktcgMfXVdFjHAECBAEIBAGBUgcBDAGEBQ+MG1+?=
 =?us-ascii?q?LFk8BAQEGimQYbYVXgnKFCoF7AQoBASyEQIMMIjQJDQEDAQECAQECARMBAQkNC?=
 =?us-ascii?q?QgnMYI6KYJfgQiBFQEFATVbgkcBgXQNnVo8jEqIVwEHgUsJAQiHboRBgQ+BB4N?=
 =?us-ascii?q?uhH+DVIJDAoEsAQEBj2yRJAEGAgGBY4FCjnskgzGGcIgHAS2adAIEAgQFAgUPI?=
 =?us-ascii?q?YElgg5NJYFsCoFEglGOLB4zgQeHWoJNAQ?=
X-IronPort-AV: E=Sophos;i="5.56,525,1539673200"; d="scan'208";a="26052729"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
 by smtp3.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 25 Jan 2019 22:32:36 -0800
Received: by mail-pg1-f199.google.com with SMTP id i124so7762655pgc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 22:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yaf63aLCqjFpTNHGLnD1DlppPDZbRyd+ngLiTc70LIY=;
 b=VeBE+dy3XM0IZd7fG6Eflm20KeyGX/uSgkdNDEsMrEzWd2dEer8RvnieDMHkmDi2KN
 IqDfX6JrR5XejAgv4pIxlryPRnw9dfYTRgQSepsKF2DjtDKVJoCE0u9hKdYOEYAZZH7g
 CHM1yyNnTqyzj7mWurcrjc67uPE/hWxaDlttbommqZW5H1rLGSgrVYItgEgx9VyJznNs
 atZ3dB1Euc8h13opB329eS9funrDiKSoau91vxOOCsZYhIGJzqsYGoPiZOadSEAcfv6O
 na3zHakN7jYQFbEJU35leVONzDVd5yb8kL7i+UPZhscj08I5gLnK034rBoeMn9j51WuS
 JLLg==
X-Gm-Message-State: AJcUukchlDJn45nOauXcyohJk3kxBixUouiaAh7QzuWvBujHpataB3ob
 +6PTaB8pnYlGMcPUfkhm+b2LlguC85yH0U6ZMdD9hOxfrLFb9CH1m9Zqo3JTMd6yD4VWXe6Dw+b
 55oygJRaDXKubLdO7S8VVoHE9LJ3fz1zfe+em
X-Received: by 2002:a17:902:9691:: with SMTP id
 n17mr14442971plp.9.1548484354985; 
 Fri, 25 Jan 2019 22:32:34 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5YsCv7XKtB9I5a/bKPNYO+58A8UnKPAsilEc7mFrGw0e/Em5uRbQoHdzn94g45XXnYFhWVVA==
X-Received: by 2002:a17:902:9691:: with SMTP id
 n17mr14442948plp.9.1548484354611; 
 Fri, 25 Jan 2019 22:32:34 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
 by smtp.googlemail.com with ESMTPSA id c9sm51998403pfc.92.2019.01.25.22.32.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 22:32:33 -0800 (PST)
From: Yizhuo <yzhai003@ucr.edu>
To: 
Subject: [PATCH] ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads()
 could be uninitialized
Date: Fri, 25 Jan 2019 22:32:20 -0800
Message-Id: <20190126063221.8257-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_223251_508379_A43405B5 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: csong@cs.ucr.edu, Tony Lindgren <tony@atomide.com>, zhiyunq@cs.ucr.edu,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Yizhuo <yzhai003@ucr.edu>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In function omap4_dsi_mux_pads(), local variable "reg" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used directly in the later context, which
is potentially unsafe.
Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 arch/arm/mach-omap2/display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index b3f6eb5d04a2..6e7440ef503a 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -84,6 +84,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	u32 enable_mask, enable_shift;
 	u32 pipd_mask, pipd_shift;
 	u32 reg;
+	int ret;
 
 	if (dsi_id == 0) {
 		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
@@ -99,7 +100,11 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 		return -ENODEV;
 	}
 
-	regmap_read(omap4_dsi_mux_syscon, OMAP4_DSIPHY_SYSCON_OFFSET, &reg);
+	ret = regmap_read(omap4_dsi_mux_syscon,
+					  OMAP4_DSIPHY_SYSCON_OFFSET,
+					  &reg);
+	if (ret)
+		return ret;
 
 	reg &= ~enable_mask;
 	reg &= ~pipd_mask;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
