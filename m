Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC216C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:19:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E41C20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SUbpMyHZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDEhwt9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E41C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ee4FSG/xYzHYe9CIBwduaQAupkMz0QUsacJajzcw8Ls=; b=SUbpMyHZPc2R8C
	riZ/O7Oj17udZvADkIocsKyKfdJqbBViBn36uHcReMEVtda5lGQIEYqIKIIgsQhsV/b74wrF2JmO5
	1wyWOy1fDQ14uT7G5LrR77I/FQyZkTqith1RWVdNeRId4VaSZLYg6oXuOlTzEAJZSTfQi9SI+XA9N
	ICT3cN5JgXb3gSBsHSaGlKD5VB+rXqlW4IUBajvPNfZ0qJ0FRWAgwv5nNMter9kCf8Ag5FrHt1rW0
	pp6EX5H9ses6MOBH+VyQASrQoLqlg/8K7W3OdPOBcE9SIBMHkzx0Px9n5GAMHkQfQz0dbfrnSFwwq
	mI8rr+TiBOzsHMmLLGsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcurA-0004wA-LO; Fri, 28 Dec 2018 16:19:28 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuqV-0004Ew-Jo
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 16:18:51 +0000
Received: by mail-lf1-x143.google.com with SMTP id p86so14831104lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 08:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c77j7aD/DmGjVf2ggTd+wLasZg/BuGwrkqKrYB9JbP8=;
 b=cDEhwt9wG1QFCcJXIHxTwIV0NqOcdnAGoooCVKCfbtbqGquU3+OPDWK9iGyPVfa4nQ
 eE/egRt++mHX7vR8tHB/vRBiCe7+vmmAKjEyr540SKQTuneujk7iOLrBdgVeC59koDeK
 WWOdF790rAYmktb3S/7p3krU6yXyl569l/BuzSMqcEWjcWxihas14tbH1778ywnRaJT/
 8QusYQYnYwebW26hKhUJnCLdaRiejRgMu3iN0sFoyhRUdCSfppc9Nf3KZihfEOOvvDlX
 iEAgL6hu24mNLIhZOIr+KN+63IJwx4WKZta7bu8tU+PnK1HO73oGSMHTjF9KgrNFAeZZ
 aJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c77j7aD/DmGjVf2ggTd+wLasZg/BuGwrkqKrYB9JbP8=;
 b=nU7Y4Lp709oS40ma09iQusSq1S6MElJ+9SPM9hxQsjzSLZRKffmHl56NSHTKiF/fA7
 kmOdINoQv0SqDYA1lUJaOxFKAgSNNQ+bldv+ObHRd+a4/MVgr2dgHdCOEyb0KmzHhq0u
 DNaufJN5mbomFFdyMi2mlrS6DH0SY0i2dLweEuO2KM2etMznjah50VtKoEwwtHwnEtyX
 hZkRuZ+bvLZ5UFmb4qfAonBzxXrAqQDIYzSDHzPuqmIzJKGjcpqIPSm+j+344Coau+Uw
 mNlQkfappAY2pDmTDf/YvLr9bo0fwxL0WaW99jdUgkcyTWbr5YAZ09ianeGGkLp140So
 UkVQ==
X-Gm-Message-State: AA+aEWarntFAztG1EFvU8hN4ZwgtfxaFk5NdgmL5rO6ekGIWy0pB3+Jg
 4gibd5+ewPP/NewaysTdJGg=
X-Google-Smtp-Source: AFSGD/UyE61l113Mwb8+mzsJNmZ65GwhtxiJUdpSg7Ea4PYhR1wdq6X8HVcfFPJdk/Z/hQ4tb3hoWQ==
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr13572469lfe.4.1546013915790; 
 Fri, 28 Dec 2018 08:18:35 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 08:18:35 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH 3/6] ARM: dts: s5pv210: fascinate4g: Remove hardcoded bootargs
Date: Fri, 28 Dec 2018 17:18:16 +0100
Message-Id: <20181228161819.18931-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_081848_011295_6742B2DA 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, xc-racer2@live.ca, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org, pawel.mikolaj.chmiel@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

U2luY2Ugd2UgaGF2ZSB1Ym9vdCAoZmxhc2hlZCBpbiBwbGFjZSBvZiBzdG9jayBrZXJuZWwpLApp
dCdzIG5vdCBuZWVkZWQgYW55bW9yZSB0byBoYXJkY29kZSBib290YXJncy4KClNpZ25lZC1vZmYt
Ynk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KLS0tCiBh
cmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWZhc2NpbmF0ZTRnLmR0cyB8IDcgLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvczVwdjIxMC1mYXNjaW5hdGU0Zy5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWZh
c2NpbmF0ZTRnLmR0cwppbmRleCBjY2Y3NjFiMWJhYmYuLjA3YThkOWJiZTViOCAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1mYXNjaW5hdGU0Zy5kdHMKKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvczVwdjIxMC1mYXNjaW5hdGU0Zy5kdHMKQEAgLTExLDEzICsxMSw2IEBACiAK
IAljaG9zZW4gewogCQlzdGRvdXQtcGF0aCA9ICZ1YXJ0MjsKLQkJLyoKLQkJICogSXQncyBoYXJk
IHRvIGNoYW5nZSB0aG9zZSBwYXJhbWV0ZXJzIGluIHN0b2NrIGJvb3Rsb2FkZXIsCi0JCSAqIHNp
bmNlIGl0IHJlcXVpcmVzIHNwZWNpYWwgaGFyZHdhcmUvY2FibGUuCi0JCSAqIExldCdzIGhhcmRv
Y2RlIGJvb3RhcmdzIGZvciBub3csIHRpbGwgdS1ib290IHBvcnQgaXMgZmluaXNoZWQsCi0JCSAq
IHdpdGggd2hpY2ggaXQgc2hvdWxkIGJlIGVhc2llci4KLQkJICovCi0JCWJvb3RhcmdzID0gInJv
b3Q9L2Rldi9tbWNibGsxcDEgcncgcm9vdHdhaXQgaWdub3JlX2xvZ2xldmVsIGVhcmx5cHJpbnRr
IjsKIAl9OwogCiAJZ3Bpby1rZXlzIHsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
