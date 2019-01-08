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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E93C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098BB20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QCz+bgPI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZkVdldL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098BB20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A5T/bvksLt1fQ3FT+J5oALJCbFiniJxGh24YWOPAUkM=; b=QCz+bgPINgw2W6
	BgNNs4cp73xP9Pd9+rTEdfgFCNfrBeZ19zEDXFQ4TnrHPdjmZk62+75Ir2x+1iCCiyl3FUHMk0bCc
	6m8FtQljkgJjQpTXNdcJsqP2NkJ0S+7szVrztzTmujMiyOmkzG9/b6Ra5se4zcV3Km8l1OWzByKTA
	ruYo9HYsj/SovmERhwjASK/l+6ob0dYoG8YS2pt0LDu9DMfgcI3ukMN42gfzLS5Q/xtxyQvLyvnx7
	lfldAOJvaz8WsX3ZsHN8zdR3e2WkbE8BaqUJS4TZEiHog1MVaP/brG1QATCpS0j29GywSAU+pS72v
	AnuHgzc6cc2w2VVV5gQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggugt-0004Nb-3y; Tue, 08 Jan 2019 16:57:23 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggufn-0003HH-5B
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:56:24 +0000
Received: by mail-lf1-x144.google.com with SMTP id n18so3458856lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 08:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9OvXwhCxM1xt9LzERNCzqQZpA6Q4+BEkTsZDw6x8xAY=;
 b=FZkVdldLnxOjxCc/kM2yZ1u7C8PnG93EeYuHqIWVIbzRq//gDBuuXImP9AkoU3Z/uY
 nsxzzWVmtSi7KfKpOgLOSmIvhT0jB0F7hQ8LlFc4MBHN0+CwbhlkfDk27tBMkFvGz8K4
 N96fwkBPP8usIX0511fM6DtsFmjMm1pErvfaYXIx9TAqh9Qf6hw/TNsJJkHJ6UTfNJYf
 qOSw1d0h/4Qqgwq3iZ1q1jwH8fKRDmvd/PZIBN5y2p2wW3bc6TjOA1AmZJOwlIjGZFDj
 PCnyUSh0U3cbK0W6M8bq8T9Q06ZhwpIN2YxrfLuEKcUFL3jfOeoUYfnjXH25V1iBshkj
 IqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9OvXwhCxM1xt9LzERNCzqQZpA6Q4+BEkTsZDw6x8xAY=;
 b=Uk76XJ986tu9+/Y8h9W1FFKRTFCzyeXFJuYF0KtCmW/3aJlXTLPkXJTrka76Icagtd
 1dzjxI4O9lbqoUJ1n65ruLhslpiojriKpBESwRwmAY/m8rGO/iNyw2KKY8ZTQwSD9DNl
 EDf6+flNHh4MPcoQiaaB81Un8oGcvCT+KP/JWYu9HB+V4OxIDQ0ysfWP//OsCvFYK/Zj
 OvcUrihvsaIYYPBbYgTXRrHQEzR2qy63smgkA8aCgY3sSrnBM1O6PJbvGsmPlpqi4/0b
 fEBKmsRtMHd5PdaZN/EOZosarXuOW6FXtK9C37chFbW820eVfKUEcd2etCiBe0FqwoVp
 BVmA==
X-Gm-Message-State: AJcUuke5jVVldX/aKtzHAhFzV5utURM10nmnHpX09Njgp9ImmWAtttTE
 nfj390Vm0IcIXinTmdnIDYA=
X-Google-Smtp-Source: ALg8bN6zN9PKHP7RMlsjyM6/i6cKoC2Pn/kP532vlyE5Im2xZ/tntbC1JpqgRVvuWNwwKp/iSa/ykQ==
X-Received: by 2002:a19:f20:: with SMTP id e32mr1544783lfi.51.1546966573132;
 Tue, 08 Jan 2019 08:56:13 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 08:56:12 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH v2 4/4] ARM: defconfig: s5pv210: Enable more drivers present
 on Samsung Aries
Date: Tue,  8 Jan 2019 17:56:01 +0100
Message-Id: <20190108165601.25708-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_085615_492950_1244CF69 
X-CRM114-Status: GOOD (  13.52  )
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

VGhpcyBjb21taXQgZW5hYmxlcyBmb2xsb3dpbmcgZHJpdmVyczoKLSBpMmMgc3VwcG9ydCAodXNp
bmcgczNjMjQxMCBkcml2ZXIpCi0gczVwLWpwZWcKLSBzNXAtbWZjCi0gZXh5bm9zIGRybSByb3Rh
dG9yCi0gcHdtIHN1cHBvcnQKLSBwd20gdmlicmF0b3IKLSBmaXhlZCByZWd1bGF0b3IKLSBzeXNj
b24gcG93ZXJvZmYKLSBBdG1lbCBtYVhUb3VjaCB0b3VjaHNjcmVlbgotIEJyb2FkY29tIEJDTTQz
MjkgYmx1ZXRvb3RoIG92ZXIgdWFydDAKLSBkbWEgZGV2aWNlcyAoc28gd2UgY2FuIHVzZSBwbDMz
MCBkbWEgZHJpdmVyKQoKRGlzYWJsZSBERUJVR19MTC4gSXQncyBjdXJyZW50bHkgc2V0IHRvIHVh
cnQxLCBidXQgaWYgd2Ugd2FudCB0byB1c2UgaXQKb24gQXJpZXMsIHdlIHdvdWxkIG5lZWQgdG8g
c3dpdGNoIGl0IHRvIHVhcnQyLCB0byBnZXQgYW55IGxvZ3MuCgpTaWduZWQtb2ZmLWJ5OiBQYXdl
xYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6
IEpvbmF0aGFuIEJha2tlciA8eGMtcmFjZXIyQGxpdmUuY2E+Ci0tLQogYXJjaC9hcm0vY29uZmln
cy9zNXB2MjEwX2RlZmNvbmZpZyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL3M1
cHYyMTBfZGVmY29uZmlnCmluZGV4IDAxNTk2MzZkNGMwZC4uOTUxMTk2YmRmMDA4IDEwMDY0NAot
LS0gYS9hcmNoL2FybS9jb25maWdzL3M1cHYyMTBfZGVmY29uZmlnCisrKyBiL2FyY2gvYXJtL2Nv
bmZpZ3MvczVwdjIxMF9kZWZjb25maWcKQEAgLTI3LDYgKzI3LDExIEBAIENPTkZJR19JUF9QTlA9
eQogQ09ORklHX0lQX1BOUF9ESENQPXkKIENPTkZJR19JUF9QTlBfQk9PVFA9eQogQ09ORklHX0lQ
X1BOUF9SQVJQPXkKK0NPTkZJR19CVD1tCitDT05GSUdfQlRfUkZDT01NPXkKK0NPTkZJR19CVF9C
TkVQPXkKK0NPTkZJR19CVF9IQ0lVQVJUPW0KK0NPTkZJR19CVF9IQ0lVQVJUX0JDTT15CiBDT05G
SUdfQ0ZHODAyMTE9bQogQ09ORklHX01BQzgwMjExPW0KIENPTkZJR19VRVZFTlRfSEVMUEVSX1BB
VEg9Ii9zYmluL2hvdHBsdWciCkBAIC00NCwyMSArNDksMzUgQEAgQ09ORklHX0lOUFVUX0VWREVW
PXkKIENPTkZJR19LRVlCT0FSRF9HUElPPXkKICMgQ09ORklHX0lOUFVUX01PVVNFIGlzIG5vdCBz
ZXQKIENPTkZJR19JTlBVVF9UT1VDSFNDUkVFTj15CitDT05GSUdfVE9VQ0hTQ1JFRU5fQVRNRUxf
TVhUPW0KK0NPTkZJR19JTlBVVF9NSVNDPXkKK0NPTkZJR19JTlBVVF9QV01fVklCUkE9bQogQ09O
RklHX1NFUklBTF84MjUwPXkKIENPTkZJR19TRVJJQUxfU0FNU1VORz15CiBDT05GSUdfU0VSSUFM
X1NBTVNVTkdfQ09OU09MRT15CitDT05GSUdfU0VSSUFMX0RFVl9CVVM9eQogQ09ORklHX0hXX1JB
TkRPTT15CiBDT05GSUdfSTJDX0dQSU89eQorQ09ORklHX0kyQ19TM0MyNDEwPXkKK0NPTkZJR19Q
T1dFUl9SRVNFVD15CitDT05GSUdfUE9XRVJfUkVTRVRfU1lTQ09OX1BPV0VST0ZGPXkKIENPTkZJ
R19QT1dFUl9TVVBQTFk9eQogQ09ORklHX0JBVFRFUllfTUFYMTcwNDA9eQogIyBDT05GSUdfSFdN
T04gaXMgbm90IHNldAogQ09ORklHX01GRF9NQVg4OTk4PXkKIENPTkZJR19SRUdVTEFUT1I9eQor
Q09ORklHX1JFR1VMQVRPUl9GSVhFRF9WT0xUQUdFPXkKIENPTkZJR19SRUdVTEFUT1JfTUFYODk5
OD15CitDT05GSUdfTUVESUFfU1VQUE9SVD1tCitDT05GSUdfTUVESUFfQ0FNRVJBX1NVUFBPUlQ9
eQorQ09ORklHX1Y0TF9NRU0yTUVNX0RSSVZFUlM9eQorQ09ORklHX1ZJREVPX1NBTVNVTkdfUzVQ
X0pQRUc9bQorQ09ORklHX1ZJREVPX1NBTVNVTkdfUzVQX01GQz1tCiBDT05GSUdfRFJNPXkKIENP
TkZJR19EUk1fRVhZTk9TPXkKIENPTkZJR19EUk1fRVhZTk9TX0ZJTUQ9eQogQ09ORklHX0RSTV9F
WFlOT1NfRFBJPXkKK0NPTkZJR19EUk1fRVhZTk9TX1JPVEFUT1I9eQogQ09ORklHX1VTQj15CiBD
T05GSUdfVVNCX09URz15CiBDT05GSUdfVVNCX0VIQ0lfSENEPXkKQEAgLTcyLDYgKzkxLDkgQEAg
Q09ORklHX01NQ19TREhDSV9TM0M9eQogQ09ORklHX01NQ19TREhDSV9TM0NfRE1BPXkKIENPTkZJ
R19SVENfQ0xBU1M9eQogQ09ORklHX1JUQ19EUlZfTUFYODk5OD1tCitDT05GSUdfRE1BREVWSUNF
Uz15CitDT05GSUdfUFdNPXkKK0NPTkZJR19QV01fU0FNU1VORz15CiBDT05GSUdfUEhZX1NBTVNV
TkdfVVNCMj1tCiBDT05GSUdfUEhZX1M1UFYyMTBfVVNCMj15CiBDT05GSUdfRVhUMl9GUz15CkBA
IC05Nyw2ICsxMTksMyBAQCBDT05GSUdfREVCVUdfU1BJTkxPQ0s9eQogQ09ORklHX0RFQlVHX01V
VEVYRVM9eQogQ09ORklHX0RFQlVHX0FUT01JQ19TTEVFUD15CiBDT05GSUdfREVCVUdfVVNFUj15
Ci1DT05GSUdfREVCVUdfTEw9eQotQ09ORklHX0RFQlVHX1MzQ19VQVJUMT15Ci1DT05GSUdfRUFS
TFlfUFJJTlRLPXkKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
