Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BE2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:45:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5325A20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dk2Jzu9m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CP0PFPHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5325A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T2cMVM8Kh/7+9AV1PPxGRuDjiiwDS/dGDyfKy5pE30Y=; b=Dk2Jzu9mzzPBHa
	95WyLZPsex+dEHmo9qZlHviV+JP3OlLyr4VAHw0mimB8xS/0UPjMlz1GNCyaa3bMFaiY3aCLzzFm6
	KLiNmqN8mz9deQX1Z4+dg/aVNQ6iOLqwgnviMzFJEipQ8eWRtNNnDpbPSVW8hQ2+WuWpUkRFAMKnl
	XmXHfxSKGzUmcRNM4k/5Z/Kyg0ChqKkw8Hv2LqAJh/BwGEMXTpUcxR2rtprQ541tusgUQ2TORK5TP
	NBrigF4gdhOIFz74AZb98BfjZuE9iZmIJ0l1pV48v0FK9FDphcpXeQM4J5GSlremQIv37FJE3dc+3
	hJAFMrzTxi7KL+A6riZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSk2q-0006z6-VC; Fri, 30 Nov 2018 14:45:28 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSk2o-0006yH-9q
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 14:45:27 +0000
Received: by mail-oi1-x242.google.com with SMTP id u18so4889631oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 06:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+Xz2i0f4yjctFsVxdGJgYXpJUnPK4IN7smwaPVnsCeE=;
 b=CP0PFPHV+sIBUxo/tUHa+fgrUk6l6txNRKBOybSM9o+keff4+kuCo4BpaUIexZ2Qrf
 CboxWtSNZxKjgaMT22dS/NX3PylvCsg+vxcDbuCFHO28wlV4tsE+6IymOuCzmbQp5Ep9
 phj5qA4n1DN5AmkshZi4mlHq4KgImqg1BAagA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+Xz2i0f4yjctFsVxdGJgYXpJUnPK4IN7smwaPVnsCeE=;
 b=NtgiLTwz5IQ6/MpCNaBAmpEu3O3G8wtzJK6im6JOBHYb0cqht7jeOluq9ziW9GTyAv
 tynz84CzLpBT/VZBVGM9rqnFAdVDzaTcnR360gS6xeEmuvEX0Lah3zk+2rRdKdl3zr+v
 VdBRcIxQSSbwxPqdG7bs2CT+gmtUSPr2I/vpVnVgpA48FItpgyyWwOEz/bkqriynu83l
 pRMRBUQpBB13yuqv50ALAYwtpa00fF0BbFi95Z7yL6uVrDIQzEZGstNAIlaNa7ZsW/Vu
 TFKgKOKaZ7lMofMbBm6pBjzS1JSdWpPoE9v1c6icTDczZTCJAhggCluGmekX23c03b5T
 f+2w==
X-Gm-Message-State: AA+aEWZ8XwaA/50kgCEckEGWAFsEVTW04tanDEL965RugN8qCDSFeJbc
 zy9X0lc+Erl0bcikzAJQvff+6Medk2XdB+VyzqY7VA==
X-Google-Smtp-Source: AFSGD/UULX1jl9aq9vD0gtv/38NomqdoxhkUZslP3DU5zxHPDJ8GT6/SyyrfJohnQSK5zHt9xA2GeJOLPavH6gI4BDY=
X-Received: by 2002:aca:4282:: with SMTP id p124mr3337279oia.327.1543589114916; 
 Fri, 30 Nov 2018 06:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
In-Reply-To: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 30 Nov 2018 15:45:03 +0100
Message-ID: <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support of STM32 hwspinlock
To: Ohad Ben Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandre Torgue <alexandre.torgue@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_064526_358510_D771AF81 
X-CRM114-Status: GOOD (  13.36  )
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
Cc: devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgbWVyLiAxNCBub3YuIDIwMTggw6AgMTA6MDAsIEJlbmphbWluIEdhaWduYXJkCjxiZW5qYW1p
bi5nYWlnbmFyZEBsaW5hcm8ub3JnPiBhIMOpY3JpdCA6Cj4KPiBUaGlzIHNlcmllIGFkZHMgdGhl
IHN1cHBvcnQgb2YgdGhlIGhhcmR3YXJlIHNlbWFwaG9yZSBibG9jayBmb3Igc3RtMzJtcDEgU29D
Lgo+Cj4gdmVyc2lvbiA0Ogo+IC0gYWRkIExpbmFybyBTb0IKCkdlbnRsZSBwaW5nIG9uIHRoaXMg
c2VyaWVzCgpSZWdhcmRzLApCZW5qYW1pbgoKPgo+IHZlcnNpb24gMzoKPiAtIGZpeCBjbG9jayBu
YW1lIGluIHByb3BlcnRpZXMgZGVzY3JpcHRpb24uCj4gLSB1c2UgcG9zdGNvcmVfaW5pdGNhbGwo
KSBpbnN0ZWFkIG9mIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoKQo+Cj4gdmVyc2lvbiAyOgo+IC0g
Zml4IGNvbW1lbnRzIGRvbmUgYnkgQmpvcm4gYWJvdXQgY2xvY2sgbmFtaW5nLCBsaWNlbnNlIHRl
cm1zIGluIGhlYWRlciwKPiAgIGFscGhhYmV0aWMgb3JkZXJpbmcgaW4gTWFrZWZpbGUgYW5kIEtj
b25maWcgYW5kIHJlbW92ZSBmdW5jdGlvbgo+IC0gRG8gbm90IHB1c2ggdGVzdCBtb2R1bGUgaW4g
dGhpcyB2ZXJzaW9uIHdoaWxlIHdhaXRpbmcgZm9yIGZlZWRiYWNrcyBhYm91dCBpdAo+Cj4gQmVu
amFtaW4gR2FpZ25hcmQgKDQpOgo+ICAgZHQtYmluZGluZ3M6IGh3bG9jazogRG9jdW1lbnQgU1RN
MzIgaHdzcGlubG9jayBiaW5kaW5ncwo+ICAgaHdzcGlubG9jazogYWRkIFNUTTMyIGh3c3Bpbmxv
Y2sgZGV2aWNlCj4gICBBUk06IGR0czogc3RtMzI6IEFkZCBod3NwaW5sb2NrIG5vZGUgZm9yIHN0
bTMybXAxNTcgU29DCj4gICBBUk06IGR0czogc3RtMzI6IGVuYWJsZSBod3NwaW5sb2NrIG9uIHN0
bTMybXAxNTdjLWVkMQo+Cj4gIC4uLi9iaW5kaW5ncy9od2xvY2svc3Qsc3RtMzItaHdzcGlubG9j
ay50eHQgICAgICAgIHwgIDIzICsrKwo+ICBhcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy1l
ZDEuZHRzICAgICAgICAgICAgICB8ICAgNCArCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAx
NTdjLmR0c2kgICAgICAgICAgICAgICAgIHwgICA5ICsrCj4gIGRyaXZlcnMvaHdzcGlubG9jay9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsrCj4gIGRyaXZlcnMvaHdzcGlu
bG9jay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKPiAgZHJpdmVycy9o
d3NwaW5sb2NrL3N0bTMyX2h3c3BpbmxvY2suYyAgICAgICAgICAgICAgfCAxNTYgKysrKysrKysr
KysrKysrKysrKysrCj4gIDYgZmlsZXMgY2hhbmdlZCwgMjAyIGluc2VydGlvbnMoKykKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od2xvY2sv
c3Qsc3RtMzItaHdzcGlubG9jay50eHQKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaHdz
cGlubG9jay9zdG0zMl9od3NwaW5sb2NrLmMKPgo+IC0tCj4gMi4xNS4wCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
