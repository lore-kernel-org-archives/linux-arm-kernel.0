Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2C2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:20:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED9120856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nc15B6l0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S86XCxFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED9120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r8CxYYivNpCG1/VGeA2vXGtfyiv2/7gODkgRaBQjclA=; b=nc15B6l0/8Ijej
	jXYAxmC0980xZACB9L+28f/ERC8XuO6UaZMH569lj6YvozNRAAN4DAsFZDFv9KNDuK4eVmQXpQVPi
	eKFLgY5fFN2ccDQlqMKPXdBVjQhVWfEkl7Fd/o7eVC+vHdf7DJ+3HgYxkKV26t6+WjrEbFymduzdM
	askd4lPzpbej9Nd9qcrZpokem9mzXNJG52oUCqjVg1LgzX2afnBG5BGIQ0A//d8hOG7kyn4xEax9k
	x3iANnKqhZYAIDYDdk/HT2/yN/C3TyRPZ4uA62uQqgvA1KA/ecmwesje00CRSQID/msq2AmeVXWhc
	Gy7z2WR7SdSDsPE7iu5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcurn-0005jf-Ja; Fri, 28 Dec 2018 16:20:07 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuqb-0004F3-2W
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 16:18:57 +0000
Received: by mail-lj1-x244.google.com with SMTP id t18-v6so19071680ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TMSLDL48glwA1oH7bbsCQDglQ0bWOL5UXlljzhH70zo=;
 b=S86XCxFOlg49LKQKFnHrzBTfHNBFlvDLzosSpu20KQUI38zJh5yiiuXV/Jo96rHaez
 P+AEdovgvYzlj2ZmmmErJYa6DFXgIj2YDD9Kd/c9LvWZJnpRLdkId3jUzhE6hE5spqgq
 yCIPIjKaJzbq56KusZem7DRDJ21OwQAHlywD17C52ZnS/Hp9+We56PVN4cQh4e61JjFg
 3lsQzP5fdgbEu/ANDJnq+KoHOGq2UT5AQ+m2FnrahyB9dprWdYDi3Q/OYbLvMYCmuWVj
 brfN/qjwo3gPGgS8Y+IaeRNvLhJyO1/ungI9JCk/VI0r/QrTORBUxG7YEv3xFGDMjEaL
 tfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TMSLDL48glwA1oH7bbsCQDglQ0bWOL5UXlljzhH70zo=;
 b=ODh0/LxwZToLYF79gGeCwVQN1a2g4W72KxVMnSDmw/yt2eCyUOvE+2wkqikpIF/90S
 2tKXuym+ek+SM/Jh+3QEi4RreqJ7AVhZ+7EiZutc5us3LIb+gRJBp+xhY9BM4+v0Ncih
 Nu9MTtTg5RPkzZSdUBQz6WyfpJAToH5NI931fS7i81GmPoy3Pdmd/zJOrIgOvNVkfwJ/
 lI4TDtOWqli2+CuhB6V++t4X/laGFkYt06bzclg26WQxE2Yu73nbM0JPxkn8QqpoO8d9
 A7d9RCt5wmwl3GYKOGTtIGBEw0jx5g9miMLza8Q+59PizfYlVSMeM2scIPzNUeMTr3Af
 roew==
X-Gm-Message-State: AA+aEWa+KEh6J3B+qXocAGmG3fxne/yKs+odazfS1DBAc0GoZNe1JhKz
 kgNleFmAhnl24FDqY9ovnKI=
X-Google-Smtp-Source: ALg8bN6y3VVbBRWQepE2H4W+R13Viwmz9dAyOgeOQvoJ5IT2ho8COEoqMhJ2qFdDZqLjg1EwN6O9TQ==
X-Received: by 2002:a2e:9783:: with SMTP id
 y3-v6mr16123171lji.167.1546013921342; 
 Fri, 28 Dec 2018 08:18:41 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 08:18:40 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH 6/6] ARM: defconfig: s5pv210: Enable more drivers present on
 Samsung Aries
Date: Fri, 28 Dec 2018 17:18:19 +0100
Message-Id: <20181228161819.18931-7-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_081853_561403_ED4FDCB4 
X-CRM114-Status: GOOD (  13.18  )
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
cnQxLCBidXQgaWYgd2Ugd2FudCB0byB1c2UKIGl0IG9uIEFyaWVzLCB3ZSB3b3VsZCBuZWVkIHRv
IHN3aXRjaCB1YXJ0MiwgdG8gZ2V0IGFueSBsb2dzLgoKU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENo
bWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBKb25h
dGhhbiBCYWtrZXIgPHhjLXJhY2VyMkBsaXZlLmNhPgotLS0KIGFyY2gvYXJtL2NvbmZpZ3MvczVw
djIxMF9kZWZjb25maWcgfCA0MSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9jb25maWdzL3M1cHYyMTBfZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9z
NXB2MjEwX2RlZmNvbmZpZwppbmRleCBhMDc3NTk3MzY5ZjEuLjk1MTE5NmJkZjAwOCAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vY29uZmlncy9zNXB2MjEwX2RlZmNvbmZpZworKysgYi9hcmNoL2FybS9j
b25maWdzL3M1cHYyMTBfZGVmY29uZmlnCkBAIC0xLDI0ICsxLDI0IEBACiBDT05GSUdfU1lTVklQ
Qz15CiBDT05GSUdfTk9fSFo9eQogQ09ORklHX0hJR0hfUkVTX1RJTUVSUz15CitDT05GSUdfUFJF
RU1QVD15CiBDT05GSUdfQ0dST1VQUz15CiBDT05GSUdfU1lTRlNfREVQUkVDQVRFRD15CiBDT05G
SUdfU1lTRlNfREVQUkVDQVRFRF9WMj15CiBDT05GSUdfQkxLX0RFVl9JTklUUkQ9eQogQ09ORklH
X0tBTExTWU1TX0FMTD15Ci1DT05GSUdfTU9EVUxFUz15Ci1DT05GSUdfTU9EVUxFX1VOTE9BRD15
Ci0jIENPTkZJR19CTEtfREVWX0JTRyBpcyBub3Qgc2V0Ci1DT05GSUdfUEFSVElUSU9OX0FEVkFO
Q0VEPXkKLUNPTkZJR19CU0RfRElTS0xBQkVMPXkKLUNPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJ
T049eQogQ09ORklHX0FSQ0hfUzVQVjIxMD15CiBDT05GSUdfVk1TUExJVF8yRz15Ci1DT05GSUdf
UFJFRU1QVD15CiBDT05GSUdfQVJNX0FQUEVOREVEX0RUQj15CiBDT05GSUdfQ01ETElORT0icm9v
dD0vZGV2L3JhbTAgcncgcmFtZGlzaz04MTkyIGluaXRyZD0weDIwODAwMDAwLDhNIGNvbnNvbGU9
dHR5U0FDMSwxMTUyMDAgaW5pdD0vbGludXhyYyIKIENPTkZJR19WRlA9eQogQ09ORklHX05FT049
eQorQ09ORklHX01PRFVMRVM9eQorQ09ORklHX01PRFVMRV9VTkxPQUQ9eQorIyBDT05GSUdfQkxL
X0RFVl9CU0cgaXMgbm90IHNldAorQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRD15CitDT05GSUdf
QlNEX0RJU0tMQUJFTD15CitDT05GSUdfU09MQVJJU19YODZfUEFSVElUSU9OPXkKIENPTkZJR19O
RVQ9eQogQ09ORklHX1BBQ0tFVD15CiBDT05GSUdfVU5JWD15CkBAIC0yNyw2ICsyNywxMSBAQCBD
T05GSUdfSVBfUE5QPXkKIENPTkZJR19JUF9QTlBfREhDUD15CiBDT05GSUdfSVBfUE5QX0JPT1RQ
PXkKIENPTkZJR19JUF9QTlBfUkFSUD15CitDT05GSUdfQlQ9bQorQ09ORklHX0JUX1JGQ09NTT15
CitDT05GSUdfQlRfQk5FUD15CitDT05GSUdfQlRfSENJVUFSVD1tCitDT05GSUdfQlRfSENJVUFS
VF9CQ009eQogQ09ORklHX0NGRzgwMjExPW0KIENPTkZJR19NQUM4MDIxMT1tCiBDT05GSUdfVUVW
RU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9ob3RwbHVnIgpAQCAtNDQsMjEgKzQ5LDM1IEBAIENPTkZJ
R19JTlBVVF9FVkRFVj15CiBDT05GSUdfS0VZQk9BUkRfR1BJTz15CiAjIENPTkZJR19JTlBVVF9N
T1VTRSBpcyBub3Qgc2V0CiBDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU49eQorQ09ORklHX1RPVUNI
U0NSRUVOX0FUTUVMX01YVD1tCitDT05GSUdfSU5QVVRfTUlTQz15CitDT05GSUdfSU5QVVRfUFdN
X1ZJQlJBPW0KIENPTkZJR19TRVJJQUxfODI1MD15CiBDT05GSUdfU0VSSUFMX1NBTVNVTkc9eQog
Q09ORklHX1NFUklBTF9TQU1TVU5HX0NPTlNPTEU9eQorQ09ORklHX1NFUklBTF9ERVZfQlVTPXkK
IENPTkZJR19IV19SQU5ET009eQogQ09ORklHX0kyQ19HUElPPXkKK0NPTkZJR19JMkNfUzNDMjQx
MD15CitDT05GSUdfUE9XRVJfUkVTRVQ9eQorQ09ORklHX1BPV0VSX1JFU0VUX1NZU0NPTl9QT1dF
Uk9GRj15CiBDT05GSUdfUE9XRVJfU1VQUExZPXkKIENPTkZJR19CQVRURVJZX01BWDE3MDQwPXkK
ICMgQ09ORklHX0hXTU9OIGlzIG5vdCBzZXQKIENPTkZJR19NRkRfTUFYODk5OD15CiBDT05GSUdf
UkVHVUxBVE9SPXkKK0NPTkZJR19SRUdVTEFUT1JfRklYRURfVk9MVEFHRT15CiBDT05GSUdfUkVH
VUxBVE9SX01BWDg5OTg9eQorQ09ORklHX01FRElBX1NVUFBPUlQ9bQorQ09ORklHX01FRElBX0NB
TUVSQV9TVVBQT1JUPXkKK0NPTkZJR19WNExfTUVNMk1FTV9EUklWRVJTPXkKK0NPTkZJR19WSURF
T19TQU1TVU5HX1M1UF9KUEVHPW0KK0NPTkZJR19WSURFT19TQU1TVU5HX1M1UF9NRkM9bQogQ09O
RklHX0RSTT15CiBDT05GSUdfRFJNX0VYWU5PUz15CiBDT05GSUdfRFJNX0VYWU5PU19GSU1EPXkK
IENPTkZJR19EUk1fRVhZTk9TX0RQST15CitDT05GSUdfRFJNX0VYWU5PU19ST1RBVE9SPXkKIENP
TkZJR19VU0I9eQogQ09ORklHX1VTQl9PVEc9eQogQ09ORklHX1VTQl9FSENJX0hDRD15CkBAIC03
Miw2ICs5MSw5IEBAIENPTkZJR19NTUNfU0RIQ0lfUzNDPXkKIENPTkZJR19NTUNfU0RIQ0lfUzND
X0RNQT15CiBDT05GSUdfUlRDX0NMQVNTPXkKIENPTkZJR19SVENfRFJWX01BWDg5OTg9bQorQ09O
RklHX0RNQURFVklDRVM9eQorQ09ORklHX1BXTT15CitDT05GSUdfUFdNX1NBTVNVTkc9eQogQ09O
RklHX1BIWV9TQU1TVU5HX1VTQjI9bQogQ09ORklHX1BIWV9TNVBWMjEwX1VTQjI9eQogQ09ORklH
X0VYVDJfRlM9eQpAQCAtODcsNiArMTA5LDcgQEAgQ09ORklHX05MU19DT0RFUEFHRV80Mzc9eQog
Q09ORklHX05MU19BU0NJST15CiBDT05GSUdfTkxTX0lTTzg4NTlfMT15CiBDT05GSUdfTkxTX1VU
Rjg9eQorQ09ORklHX0NSQ19DQ0lUVD15CiBDT05GSUdfREVCVUdfSU5GTz15CiBDT05GSUdfTUFH
SUNfU1lTUlE9eQogQ09ORklHX0RFQlVHX0tFUk5FTD15CkBAIC05Niw3ICsxMTksMyBAQCBDT05G
SUdfREVCVUdfU1BJTkxPQ0s9eQogQ09ORklHX0RFQlVHX01VVEVYRVM9eQogQ09ORklHX0RFQlVH
X0FUT01JQ19TTEVFUD15CiBDT05GSUdfREVCVUdfVVNFUj15Ci1DT05GSUdfREVCVUdfTEw9eQot
Q09ORklHX0RFQlVHX1MzQ19VQVJUMT15Ci1DT05GSUdfRUFSTFlfUFJJTlRLPXkKLUNPTkZJR19D
UkNfQ0NJVFQ9eQotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
