Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95980C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:49:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A9A2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q1zMYMb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A9A2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=movteTssUQM7UxasSWONSP0Jwzj+isXVzOwivQreD2k=; b=Q1zMYMb2zuG32x
	VUMfcp1XxJJo+Goai6DnYyqfa07mmuqZvxWGQUMIpqPNE77sFlXBnd9lkdtkms2ZYCLeG9y5+jckH
	JeLD7oK7R4rSiCPrHQtFj60Ln0fjvm2YYlF/yGgEbAfjiHmxEKSaO3q9B5cwe8Ku7h+RMjalzxtSO
	rYR+p7dRN4221EMjSbwHDRp71PxMFjKGmisJaygvW8T0j7J1HhP9BcD8p3kvT95L7nGG4mkx83ZKL
	4ri6uba1ylkNQeP8zIobOp0u3bkwW89GrppfAnQ63c6swqyWYoRiaU3pL8EuJ79Z8r4ph12iiK0r/
	HCS8sNKWSuckoy5XJjIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGJd-00053m-TY; Mon, 10 Dec 2018 07:49:21 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGIY-0003v8-MG
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 07:48:21 +0000
Received: by mail-pl1-f169.google.com with SMTP id y1so4842449plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 23:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xBTszd9r+j+t3V/BYzwD7O+VsobuASmrDsYPrk3OSk0=;
 b=RFdjQzsUN0DSsquv0IgJV8KmRQlBsrKnv2rj0nSTLEug93vNytYOHoIEhDC0g4YQIO
 kDRfnzher1IiDeYdvBol4rMRK2PdgYu0XsYOkbCVh6K2UdTiz5DEgFhsczXe/klLjRS3
 Q6IDYI76Lk7qBPifshLUSIjyyEs3gfM97oyK419JazWi9CTdb0gZa46EHNVEF6WwOT0h
 xHWQ21DzaYgxdSIDBJBct/lbzwERlF8BEuQKzM904X7UW9l5mNLp1VZi2uUVL1mtMIAA
 n3vDdAR/oDzufs1gDxr8SpJJGXy0pIu0KNW/yqJxN4AfTJVUDQxyuaFMjiufRuQDsjcD
 XPQA==
X-Gm-Message-State: AA+aEWZdELiTEStSxj6TatCy+rTL98PvW2EfOF7C/e9xouSdZ6aZ+30K
 GlI0sz7hEF4ebPbdBC6jEsYR2g==
X-Google-Smtp-Source: AFSGD/WVSvuuScjpw/SdluargJMXh/DX9wCbfAvhH6SNqXohjO0i3MF8I3oSAVqAT3905l+Jf+R4Sw==
X-Received: by 2002:a17:902:6b83:: with SMTP id
 p3mr11127897plk.118.1544428083898; 
 Sun, 09 Dec 2018 23:48:03 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id c13sm14363809pfo.121.2018.12.09.23.48.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 23:48:02 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 7/7] i.MX defconfig update for 4.21
Date: Mon, 10 Dec 2018 15:46:38 +0800
Message-Id: <20181210074638.27873-7-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210074638.27873-1-shawnguo@kernel.org>
References: <20181210074638.27873-1-shawnguo@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_234815_464882_E3252685 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2NTEwMjIzODJjN2Y4ZGE0NmNiNDg3
MmE1NDVlZTFkYTZkMDk3ZDJhOgoKICBMaW51eCA0LjIwLXJjMSAoMjAxOC0xMS0wNCAxNTozNzo1
MiAtMDgwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoKICBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc2hhd25ndW8vbGludXgu
Z2l0IHRhZ3MvaW14LWRlZmNvbmZpZy00LjIxCgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAg
dG8gYmI5YzkwYWI0ZWRkZjgzZTFhYTA0MTQ5OGY2NWI4YmY4YmU2ODAyZjoKCiAgQVJNOiBpbXhf
djZfdjdfZGVmY29uZmlnOiBhZGQgaW14N3VscCBzdXBwb3J0ICgyMDE4LTEyLTA2IDIyOjU1OjIw
ICswODAwKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQppLk1YIGRlZmNvbmZpZyB1cGRhdGUgZm9yIDQuMjE6CiAtIEVuYWJs
ZSBidWlsZCBvZiBpLk1YN1VMUCBTb0Mgc3VwcG9ydC4KIC0gRW5hYmxlIEdvb2RpeCB0b3VjaHNj
cmVlbiBkcml2ZXIgd2hpY2ggaXMgbmVlZGVkIGJ5IENvbm5lY3RDb3JlIDZVTAogICBTQkMgUHJv
IChjY2lteDZ1bHNiY3BybykgYm9hcmQgc3VwcG9ydC4KIC0gRW5hYmxlIFVTQl9BTk5PVU5DRV9O
RVdfREVWSUNFUyB0byBoZWxwIFVTQiBpc3N1ZSBkZWJ1Z2dpbmcgYW5kCiAgIEJUX0JORVAgdG8g
c3VwcG9ydCBuZXR3b3JrIG92ZXIgYmx1ZXRvb3RoLgogLSBSZW1vdmUgZXhwbGljaXQgQVJNX1VO
V0lORCBkaXNhYmxpbmcgYXMgaXQncyBzZWxlY3RlZCBieSBBUk0gRUFCSQogICBzdXBwb3J0Lgog
LSBFbmFibGUgREE5MDYzIFBNSUMgZm9yIGVtdHJpb24gaS5NWDYgYm9hcmRzIHN1cHBvcnQuCiAt
IEVuYWJsZSBkcml2ZXIgc3VwcG9ydCBmb3IgUGl4ZWwgUGlwZWxpbmUgKFBYUCkgYW5kIERDUCBj
cnlwdG8gYmxvY2sKICAgd2hpY2ggYXJlIGZvdW5kIG9uIGkuTVg2IGFuZCBpLk1YNyBTb0NzLgoK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpBLnMuIERvbmcgKDEpOgogICAgICBBUk06IGlteF92Nl92N19kZWZjb25maWc6IGFk
ZCBpbXg3dWxwIHN1cHBvcnQKCkFsZXggR29uemFsZXogKDEpOgogICAgICBBUk06IGlteF92Nl92
N19kZWZjb25maWc6IFNlbGVjdCBUT1VDSFNDUkVFTl9HT09ESVgKCkFuZHJlYXMgTcO8bGxlciAo
Mik6CiAgICAgIEFSTTogaW14X3Y2X3Y3X2RlZmNvbmZpZzogRW5hYmxlIEJUX0JORVAKICAgICAg
QVJNOiBpbXhfdjZfdjdfZGVmY29uZmlnOiBFbmFibGUgVVNCX0FOTk9VTkNFX05FV19ERVZJQ0VT
CgpGYWJpbyBFc3RldmFtICgxKToKICAgICAgQVJNOiBpbXhfdjZfdjdfZGVmY29uZmlnOiBTZWxl
Y3QgdGhlIFBYUCBkcml2ZXIKCkphbiBUdWVyayAoMSk6CiAgICAgIEFSTTogaW14X3Y2X3Y3X2Rl
ZmNvbmZpZzogRW5hYmxlIERBOTA2MyBQTUlDIHN1cHBvcnQKCkxlb25hcmQgQ3Jlc3RleiAoMSk6
CiAgICAgIEFSTTogaW14X3Y2X3Y3X2RlZmNvbmZpZzogRW5hYmxlIENSWVBUT19ERVZfTVhTX0RD
UAoKT3RhdmlvIFNhbHZhZG9yICgxKToKICAgICAgQVJNOiBpbXhfdjZfdjdfZGVmY29uZmlnOiBS
ZW1vdmUgZXhwbGljaXQgQVJNX1VOV0lORCBkaXNhYmxlCgogYXJjaC9hcm0vY29uZmlncy9pbXhf
djZfdjdfZGVmY29uZmlnIHwgMTAgKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
