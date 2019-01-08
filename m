Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9719220827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ekfqp+qg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1v9EDJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9719220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ybKHXGUaPFKLXGuIvCnx9NngBuARZ++XuXAC8w8q3QU=; b=Ekfqp+qgsIVHAA
	AbDN4FI7ebVnBqd3JHzfRhzWhKhJ067ZSnAQPMxvNSLi7YC0o62S4gJOcH4J1iclhZFfXDAx+nWgq
	68FpX24q08/FO+xK7pAWpCV0bgXyLQeKPN4hY/LHsd0M1PnKr6+3ZKg07Ln6yZ4n7Nvu40P308ewQ
	UnIpokLvjk8ZrT1v3LPGesAdlGpu+yGlhT+++pNPYrjOD5SuylMUrlIJGcMEp03or5phhfJhp7x60
	ZsMu0b9ek3JOs77+UKhY4YS3wgFhsVrRRTQxvdUKfoHuZwPk49g3yPta6xxwc2AbYWVzkdgSj3GMM
	x3Jium8k635PC+aN0dXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguge-00047y-7d; Tue, 08 Jan 2019 16:57:08 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggufl-0003Fq-QL
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:56:21 +0000
Received: by mail-lf1-x141.google.com with SMTP id n18so3458798lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O6vP2tUy9VuXRg7vgiWwWPbY3vNG9OBcmWv1+qDoTUA=;
 b=k1v9EDJvIVSooF3J5/a4H8cAszEGWnJ71U5Qj2RxHPonru18IdlJiRN2+qQ9MyOj8o
 QVtA/dxlgmJewngXIOliZLQ7GUMWCJytYrz3CuaDFJKhXiKAED8BVkNK6cccibABU/pf
 MOwkkLfx9ziTAyEDDkSZQYpMIzFiHSUYnFXuUa2a4sVaev9GjJOm7dEacAdaw/Q0+o6f
 4y+SQdh9WGd5Po7mQDDg/FIW9VtkJmseHfbCVzfobqwIrsF9YUjHD+IFFtsv+DFG/YZs
 Iobn5fVXH4CAWpMI94Bh5RIA29S8N/A8TisARNw6xCHKgZlaDtWm6n8xQL71dJ4NF6Xr
 6vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O6vP2tUy9VuXRg7vgiWwWPbY3vNG9OBcmWv1+qDoTUA=;
 b=s3Y7RlRVoTmjmLEqaJ6unfXz9icIM0h2Jg+sXaj9hjVn+EDrB46xT5R1TTxGvBSsvJ
 +kSN2B9vCmStDxet624CU0tnKcpddjts3r+4KyTE4AmgFDoyrn4HV+vqzBtG/rXizeBe
 hY5jRvNuJ7P390yjtVh8djySToW3elLLhRkuqlXrlFeDaXzl1hsRER4umXQZn/pJ3U8h
 B3/rVUH6hQThTJtmccZ0imM49cCbIr+nvUP8hnyr9dzR8zPo5cvf906KJXyveMzQg4EH
 rfMoCkrp1zusspQyX528m5nTUtNjkyUISnsaAb7RtyPybh1xyjBSlzi98MU5w34J0n86
 evCQ==
X-Gm-Message-State: AJcUukcjK61ZjAUeeNsP86X6mNdSiPitANbLDKRML0gFuNLnvxZYc8PW
 5ovazDbp9Ny1Q09fXrFz4RA=
X-Google-Smtp-Source: ALg8bN5JWkx9Iz6hBHw8buqUsoG7CsiONz/7/dji3w2ArYPNIW9f6S9k2uuUBpVYg3pHrzW4H7wWkg==
X-Received: by 2002:a19:200b:: with SMTP id g11mr1456972lfg.58.1546966571781; 
 Tue, 08 Jan 2019 08:56:11 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 08:56:11 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH v2 3/4] ARM: defconfig: s5pv210: Run make savedefconfig
Date: Tue,  8 Jan 2019 17:56:00 +0100
Message-Id: <20190108165601.25708-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_085614_083345_3FAD27ED 
X-CRM114-Status: GOOD (  11.88  )
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

VGhpcyBpcyByZXN1bHQgb2YgcnVubmluZyBzYXZlZGVmY29uZmlnLiBJdCdzIHByZXBhcmF0aW9u
IGZvciBhZGRpbmcKc3VwcG9ydCBmb3IgbW9yZSBodyBwcmVzZW50IG9uIFNhbXN1bmcgQXJpZXMg
YmFzZWQgZGV2aWNlcy4KClNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29s
YWouY2htaWVsQGdtYWlsLmNvbT4KLS0tCiBhcmNoL2FybS9jb25maWdzL3M1cHYyMTBfZGVmY29u
ZmlnIHwgMTYgKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL3M1cHYyMTBf
ZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZwppbmRleCBhMDc3
NTk3MzY5ZjEuLjAxNTk2MzZkNGMwZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vY29uZmlncy9zNXB2
MjEwX2RlZmNvbmZpZworKysgYi9hcmNoL2FybS9jb25maWdzL3M1cHYyMTBfZGVmY29uZmlnCkBA
IC0xLDI0ICsxLDI0IEBACiBDT05GSUdfU1lTVklQQz15CiBDT05GSUdfTk9fSFo9eQogQ09ORklH
X0hJR0hfUkVTX1RJTUVSUz15CitDT05GSUdfUFJFRU1QVD15CiBDT05GSUdfQ0dST1VQUz15CiBD
T05GSUdfU1lTRlNfREVQUkVDQVRFRD15CiBDT05GSUdfU1lTRlNfREVQUkVDQVRFRF9WMj15CiBD
T05GSUdfQkxLX0RFVl9JTklUUkQ9eQogQ09ORklHX0tBTExTWU1TX0FMTD15Ci1DT05GSUdfTU9E
VUxFUz15Ci1DT05GSUdfTU9EVUxFX1VOTE9BRD15Ci0jIENPTkZJR19CTEtfREVWX0JTRyBpcyBu
b3Qgc2V0Ci1DT05GSUdfUEFSVElUSU9OX0FEVkFOQ0VEPXkKLUNPTkZJR19CU0RfRElTS0xBQkVM
PXkKLUNPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT049eQogQ09ORklHX0FSQ0hfUzVQVjIxMD15
CiBDT05GSUdfVk1TUExJVF8yRz15Ci1DT05GSUdfUFJFRU1QVD15CiBDT05GSUdfQVJNX0FQUEVO
REVEX0RUQj15CiBDT05GSUdfQ01ETElORT0icm9vdD0vZGV2L3JhbTAgcncgcmFtZGlzaz04MTky
IGluaXRyZD0weDIwODAwMDAwLDhNIGNvbnNvbGU9dHR5U0FDMSwxMTUyMDAgaW5pdD0vbGludXhy
YyIKIENPTkZJR19WRlA9eQogQ09ORklHX05FT049eQorQ09ORklHX01PRFVMRVM9eQorQ09ORklH
X01PRFVMRV9VTkxPQUQ9eQorIyBDT05GSUdfQkxLX0RFVl9CU0cgaXMgbm90IHNldAorQ09ORklH
X1BBUlRJVElPTl9BRFZBTkNFRD15CitDT05GSUdfQlNEX0RJU0tMQUJFTD15CitDT05GSUdfU09M
QVJJU19YODZfUEFSVElUSU9OPXkKIENPTkZJR19ORVQ9eQogQ09ORklHX1BBQ0tFVD15CiBDT05G
SUdfVU5JWD15CkBAIC04Nyw2ICs4Nyw3IEBAIENPTkZJR19OTFNfQ09ERVBBR0VfNDM3PXkKIENP
TkZJR19OTFNfQVNDSUk9eQogQ09ORklHX05MU19JU084ODU5XzE9eQogQ09ORklHX05MU19VVEY4
PXkKK0NPTkZJR19DUkNfQ0NJVFQ9eQogQ09ORklHX0RFQlVHX0lORk89eQogQ09ORklHX01BR0lD
X1NZU1JRPXkKIENPTkZJR19ERUJVR19LRVJORUw9eQpAQCAtOTksNCArMTAwLDMgQEAgQ09ORklH
X0RFQlVHX1VTRVI9eQogQ09ORklHX0RFQlVHX0xMPXkKIENPTkZJR19ERUJVR19TM0NfVUFSVDE9
eQogQ09ORklHX0VBUkxZX1BSSU5USz15Ci1DT05GSUdfQ1JDX0NDSVRUPXkKLS0gCjIuMTcuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
