Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:54:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B46F218DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MaqaL9SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B46F218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4TSECCsu9Hg47uWnqoAZJlrw0y1ZEjox9YZLiaXVNuo=; b=MaqaL9SSQbWR13
	SoMqFWNCKwEiadq8sNMzxFK0MHWi4I28zmJwz4ChEcijRIkOp7CnQc3gEEvaaCjF8URCCtHvhTCaC
	8uDJhx8V05+lb9N9BQdAmiEcdXp4AYBgzCtevu5HRUFIVrXiqktccc37QfMc0VOwwbgOF8oyh8I7K
	LnvB0wZf9o+DaGQ4ox2O7lhWCZEI7ueoZVoowqRhqfpjdMbaNx6YOq9sIWpHDthSm5Y7tXv5vews1
	bKG4bP03lTNYVcGxYpuvFAqVvubLhdGSG5RXxhnnbMg+y3Doh+mpxub4JD8wiNY6ZBJcyK762Q+Dr
	7gBtzsx6PnANuGBy5d9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4jq-0000Mg-38; Fri, 08 Feb 2019 11:54:34 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4jn-0000Lg-FE
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:54:33 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 420E5FB06;
 Fri,  8 Feb 2019 12:54:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5a3au22ECbLC; Fri,  8 Feb 2019 12:54:28 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 88C77402F3; Fri,  8 Feb 2019 12:54:27 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Mixel Inc
Date: Fri,  8 Feb 2019 12:54:25 +0100
Message-Id: <790562475ac47c7f80d41a9d7ed754e20409c87a.1549626136.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549626136.git.agx@sigxcpu.org>
References: <cover.1549626136.git.agx@sigxcpu.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_035431_667833_0AB65BCF 
X-CRM114-Status: UNSURE (   8.16  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QWRkIHZlbmRvciBwcmVmaXggIm1peGVsIiBmb3IgTWl4ZWwgSW5jLiBXaWxsIGJlIHVzZWQgZm9y
IGEgTUlQSSBEU0kKUEhZIGRyaXZlci4KClNpZ25lZC1vZmYtYnk6IEd1aWRvIEfDvG50aGVyIDxh
Z3hAc2lneGNwdS5vcmc+Ci0tLQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Zl
bmRvci1wcmVmaXhlcy50eHQgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoK
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJl
Zml4ZXMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVm
aXhlcy50eHQKaW5kZXggODhkY2RjMDRjOGM5Li5hNzRjMTA1NzZmYjkgMTAwNjQ0Ci0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0CisrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0CkBA
IC0yNDcsNiArMjQ3LDcgQEAgbWlrcm9lCQlNaWtyb0VsZWt0cm9uaWthIGQuby5vLgogbWluaXgJ
TUlOSVggVGVjaG5vbG9neSBMdGQuCiBtaXJhbWVtcwlNaXJhTUVNUyBTZW5zaW5nIFRlY2hub2xv
Z3kgQ28uLCBMdGQuCiBtaXRzdWJpc2hpCU1pdHN1YmlzaGkgRWxlY3RyaWMgQ29ycG9yYXRpb24K
K21peGVsCU1peGVsLCBJbmMuCiBtb3NhaXh0ZWNoCU1vc2FpeCBUZWNobm9sb2dpZXMsIEluYy4K
IG1vdG9yb2xhCU1vdG9yb2xhLCBJbmMuCiBtb3hhCU1veGEgSW5jLgotLSAKMi4yMC4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
