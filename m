Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EE4C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:48:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B572087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TDJXR97W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B572087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uRtxcZ14i+Dqxmqol023eG3IZP1V+4SMK5jIv7m/EzY=; b=TDJXR97WmbVpLq
	qLbFEMufa9D2rXwFCtPtSy5sckqbpwuU1s+9Hlf59AFLoa50dxprcyqHKeIAdijFGpdk9M/7jc4vn
	S3PaShxqibqJ6d9jhntbZfYHOLyL5Udr5exGTRgLHu3UTHGWKaQBNRs5cTbS6pCfMoGa8OHt6z/Hh
	F22SVH9zHrqpJdLCfyTOmMOhlU+tSUHLm9B6l4ZGknviHCqyDASmoeSvhV9iv3wVlwyxPVcL6wLjf
	HgzbKaSmSoWuh/Qorzbi2k5k21D4Ll0QHSULFwfx374+ZQuhc0YwTQOUXRbdtMUirWg+OcaOmvUMM
	DYF7F4yRL7q0/9kp5EaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIUr-0000fj-5s; Mon, 25 Feb 2019 15:48:49 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIUn-0000cY-LJ
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 15:48:47 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1PFg3FD011731; Mon, 25 Feb 2019 16:48:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qtwxntjsw-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 25 Feb 2019 16:48:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 432E531;
 Mon, 25 Feb 2019 15:48:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 16F7F51FA;
 Mon, 25 Feb 2019 15:48:36 +0000 (GMT)
Received: from [10.48.0.160] (10.75.127.44) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Feb
 2019 16:48:35 +0100
Subject: Re: [PATCH v1 1/3] ARM: dts: stm32: Add Vivante GPU support on
 STM32MP157c
To: Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
 <1550246316-9747-2-git-send-email-pierre-yves.mordret@st.com>
 <1550247118.2546.56.camel@pengutronix.de>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <44bb72aa-8e49-4ec5-dd9a-5fce6f0bce29@st.com>
Date: Mon, 25 Feb 2019 16:48:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550247118.2546.56.camel@pengutronix.de>
Content-Language: en-US
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-25_08:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_074845_975125_178D6E08 
X-CRM114-Status: GOOD (  16.67  )
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
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Philippe Cornu <philippe.cornu@st.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTHVjYXMKCnNvcnJ5IGZvciB0aGUgZGVsYXkgOiB3aW50ZXIgc2Vhc29uIDopCgpPbiAyLzE1
LzE5IDU6MTEgUE0sIEx1Y2FzIFN0YWNoIHdyb3RlOgo+IEhpIFBpZXJyZS1ZdmVzLAo+IAo+IEFt
IEZyZWl0YWcsIGRlbiAxNS4wMi4yMDE5LCAxNjo1OCArMDEwMCBzY2hyaWViIFBpZXJyZS1ZdmVz
IE1PUkRSRVQ6Cj4+IEFwcGVuZCBWaXZhbnRlIEdQVSBEVCBjb25maWd1cmF0aW9uLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBQaWVycmUtWXZlcyBNT1JEUkVUIDxwaWVycmUteXZlcy5tb3JkcmV0QHN0
LmNvbT4KPj4gLS0tCj4+IMKgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaSB8IDEw
ICsrKysrKysrKysKPj4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaSBiL2FyY2gvYXJt
L2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kKPj4gaW5kZXggZjhiYmZmZi4uMjk1NDBiYyAxMDA2
NDQKPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaQo+PiArKysgYi9h
cmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy5kdHNpCj4+IEBAIC0xMTA2LDYgKzExMDYsMTYg
QEAKPj4+IMKgCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPj4+IMKgCQl9Owo+PiDCoAo+PiArCQln
cHU6IGdwdUA1OTAwMDAwMCB7Cj4+ICsJCQljb21wYXRpYmxlID0gInZpdmFudGUsZ2MiOwo+PiAr
CQkJcmVnID0gPDB4NTkwMDAwMDAgMHg4MDA+Owo+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDEwOSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKPj4gKwkJCWNsb2NrcyA9IDwmcmNjIEdQVT4sIDwm
cmNjIEdQVV9LPjsKPj4gKwkJCWNsb2NrLW5hbWVzID0gImJ1cyIgLCJjb3JlIjsKPiAKPiBJcyB0
aGlzIGEgMkQgb25seSBjb3JlPyBJZiBpdCBpcyBhbHNvIDNEIGNhcGFibGUgdGhlIGJpbmRpbmcg
c2F5cyB5b3UKPiBuZWVkIHRvIHNwZWNpZnkgdGhlIHNoYWRlciBjbG9jayAobWF5IGJlIHRoZSBz
YW1lIGNsb2NrIGZlZWRpbmcgdGhlCj4gY29yZSkuCgpZZXMsIHRoaXMgaXMgYSAzRCBjb3JlLgpB
cyBmb3IgInNoYWRlciIgY2xvY2sgYm90aCAiY29yZSIgYW5kICJzaGFkZXIiIGFyZSBjb25uZWN0
ZWQgaW50ZXJuYWxseS4gVGhpcyBpcwp3aHkgbm8gInNoYWRlciIgaW5wdXQgY2xvY2sgaXMgc2Vl
bi4KTm9uZXRoZWxlc3Mgd2UgbWF5IGFkZCBpdCBmb3IgYmluZGluZ3MgY29tcGxpYW5jZSBidXQg
ZnJvbSBTVE0zMk1QMSBwb3YgdGhpcwp3b24ndCBtYWtlIGFueSBjaGFuZ2VzLgoKSG9wZSBpdCBj
bGFyaWZpZXMuCgpSZWdhcmRzCj4gCj4gUmVnYXJkcywKPiBMdWNhcwo+IAo+PiArCQkJcmVzZXRz
ID0gPCZyY2MgR1BVX1I+Owo+PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPj4gKwkJfTsKPj4g
Kwo+PiDCoAkJZHNpOiBkc2lANWEwMDAwMDAgewo+PiDCoAkJCWNvbXBhdGlibGUgPSAic3Qsc3Rt
MzItZHNpIjsKPj4gwqAJCQlyZWcgPSA8MHg1YTAwMDAwMCAweDgwMD47CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
