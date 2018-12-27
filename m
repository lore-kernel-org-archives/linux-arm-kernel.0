Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F060C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADB62148D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kyl28fCK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/Iq3RXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADB62148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IfEpGH+vn1DFt/NtGhaoi1w6QpC/J9RH7oHHRRVH2JE=; b=Kyl28fCKjUMrBH
	qnn7VpwuIl1iy4jH/C+35w0yEKJOs39uyqq5kMyRkgdEi795tjXNGITmBnvoT9xzdozHCJvT9zzrm
	bsBA2ChVKnHIdeEdt2OtpHxhwOzBEeD5ePGw6m56V+KN2BrqzahOG3gniHBkgF7loy5OUS3tgtW1b
	lTxssixhDGdhTyMN9sqL5RwpjQ2+7hHaf5JWCjPSO51dIsP/w4kuxwU0JFRNUQOU92ebQzmR5cxmR
	O5mIFmeDD3s1TQChPAJofXSSNvmUF1l9ofewF4QxeATYliwzGiSk7/2Yri6DgWSHNCpiWR8NeBjzb
	i7MQZcm6O2AYJmgTLAWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcUIW-0006oV-6Z; Thu, 27 Dec 2018 11:57:56 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcUIS-0006nL-9B
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 11:57:53 +0000
Received: by mail-lf1-x143.google.com with SMTP id n18so12543016lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 03:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0u+t53wp3ovowzonqM8HJAMfjd+IqOrSRFovgYZHdmM=;
 b=p/Iq3RXeki+vvId89NEwssocj8L1S1kuWidCLyH0WkwN7fqzXot9XNJzpsFpfqRWi7
 Uo7aiPgHaIjgpLcRI9/i6bry20oDUW7/03e95gYVZZpYI1dUJRODzwi4X+Muhqi7+FXn
 A6xASCZ/Lbx7iq0Big0C7uwCwRtnEtv/qXO9yi8deDscu+Jov9HTgYsfdHG/d+Y4fSN5
 5gpaIjizaHbSH9w+Gme8C5pm9QErV4yjdNcsZyPFOrzvd3lXkFFOkZzXUTmrjyNjZoiV
 +Rdo7l271QG+a/fDMpVcp5i9h+1sVrqErO3kMCe4M28Mi+gdqpAYVZgcw/UBtvsGDPhD
 tjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0u+t53wp3ovowzonqM8HJAMfjd+IqOrSRFovgYZHdmM=;
 b=A6tprvIsDjvtxiHxufTp10pfS0FYl57/64Xij2bFZqK59M4T0XWHUmoOMbher2AP/i
 BLr5HMDzlxJBGU2q/UhcEDeFsZSKnx0KrjcTZKMAtZTRQq/XzQX1y4G4JzfzU+ZTh5vA
 9AFw9azGZJupVgrphvIl1knLUEYIbKqQCtnwzgTE6umm4WHfWcDAlEZ6PuFlmIptIXjV
 T22PCoZ66N0GW5vv0Cct0w2th7XLNjepqkCU6HxYot6ZgILUpLrkha9hffAKDCxF+Dg/
 w0op7wiVVSPI0zhDzo51gCjOHx87ahIKjnRp5oSLkJBxCyDTg46fOlW48OYbVDI+uNwp
 FIiA==
X-Gm-Message-State: AA+aEWYmvn8l/3ZGNG/Wu2+m7LcESsU544yXCWhKxJjeEdKmiGTUI2aa
 aaR0oZxwyWr3Hrf9yK2J5QA=
X-Google-Smtp-Source: AFSGD/XRKParsNAMKywnx/zABcWlwVKK4mUA7fT8fxwv1yeHGc39XBCGdas93ZOPhD7cX4EcP/rtKg==
X-Received: by 2002:a19:a9d2:: with SMTP id
 s201mr11302168lfe.154.1545911858376; 
 Thu, 27 Dec 2018 03:57:38 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:9009:87a3:91bb:333a])
 by smtp.gmail.com with ESMTPSA id
 o5-v6sm7916444ljh.75.2018.12.27.03.57.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Dec 2018 03:57:37 -0800 (PST)
From: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: gpu: samsung-rotator: Document s5pv210
 support
Date: Thu, 27 Dec 2018 12:57:35 +0100
Message-ID: <4331572.iOIAVLAcOa@acerlaptop>
In-Reply-To: <CAJKOXPfHHNUzQZu62btspC+6SwgoGPdAzusfSixXM7U9u3QP7A@mail.gmail.com>
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
 <20181219155704.15264-3-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPfHHNUzQZu62btspC+6SwgoGPdAzusfSixXM7U9u3QP7A@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_035752_325397_9DEDF53C 
X-CRM114-Status: GOOD (  17.21  )
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
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 jy0922.shim@samsung.com, airlied@linux.ie,
 Seung Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
 robh+dt@kernel.org, kyungmin.park@samsung.com, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG5pYSDFm3JvZGEsIDE5IGdydWRuaWEgMjAxOCAxNzoyMjo1MSBDRVQgS3J6eXN6dG9mIEtvemxv
d3NraSBwaXN6ZToKPiBPbiBXZWQsIDE5IERlYyAyMDE4IGF0IDE3OjA0LCBQYXdlxYIgQ2htaWVs
Cj4gPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gVGhpcyBj
b21taXQgZG9jdW1lbnRzIG5ldyBjb21wYXRpYmxlIGZvciBzNXB2MjEwIHNvYywKPiA+IHdoaWNo
IHdpbGwgYmUgYWxzbyBzdXBwb3J0ZWQgYnkgdGhpcyBkcml2ZXIuCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgo+ID4g
LS0tCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9zYW1zdW5nLXJv
dGF0b3IudHh0IHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ft
c3VuZy1yb3RhdG9yLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUv
c2Ftc3VuZy1yb3RhdG9yLnR4dAo+ID4gaW5kZXggODJjZDFlZDBiZTkzLi43ODY1OGRlYzY5NDEg
MTAwNjQ0Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L3Nh
bXN1bmctcm90YXRvci50eHQKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dAo+ID4gQEAgLTUsNiArNSw3IEBAIFJlcXVpcmVk
IHByb3BlcnRpZXM6Cj4gPiAgICAgICAgIChhKSAic2Ftc3VuZyxleHlub3M0MjEwLXJvdGF0b3Ii
IGZvciBSb3RhdG9yIElQIGluIEV4eW5vczQyMTAKPiA+ICAgICAgICAgKGIpICJzYW1zdW5nLGV4
eW5vczQyMTItcm90YXRvciIgZm9yIFJvdGF0b3IgSVAgaW4gRXh5bm9zNDIxMi80NDEyCj4gPiAg
ICAgICAgIChjKSAic2Ftc3VuZyxleHlub3M1MjUwLXJvdGF0b3IiIGZvciBSb3RhdG9yIElQIGlu
IEV4eW5vczUyNTAKPiA+ICsgICAgICAgKGQpICJzYW1zdW5nLHM1cHYyMTAtcm90YXRvciIgZm9y
IFJvdGF0b3IgSVAgaW4gUzVQVjIxMAo+IAo+IEhvdyBhYm91dCBwdXR0aW5nIGl0IGF0IGJlZ2lu
bmluZyBhcyB0aGUgb2xkZXN0IGNoaXBzZXQ/IFRoaXMgd291bGQKPiByZXF1aXJlIHJlb3JkZXJp
bmcgdGhlIGxpc3Qgc28gbWF5YmUgbGV0J3MgcmVtb3ZlIHRoZSBhL2IvYyBsaXN0Cj4gZW51bWVy
YXRpb25zPyBUaGV5IGFyZSBraW5kIG9mIHVzZWxlc3MuCk9rLCBpJ2xsIHNlbmQgdjIgb2YgcGF0
Y2hzZXQgd2l0aCB0aGlzIGNoYW5nZS4KPiAKPiBCZXN0IHJlZ2FyZHMsCj4gS3J6eXN6dG9mCgoK
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
