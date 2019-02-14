Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906AEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:36:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E757222D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GP+S/9/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E757222D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mngiPS101XHv5yRn5P83fyrrEvty95MFGIXBAAnjUBo=; b=GP+S/9/CHszKj1
	tBnntjtxhLBoE2ThqiIZS4VXqvMBbxuWoZRYaJhBtaE668QISpzH53rYMmI5kUuhgI4N2WXNlzXj0
	LYa2XWcDRXg005J18F2G4MGIAJIcuxhzzEO8pJK1w5YJCAmw8mAhj7viivQLg4E5XoHiRpet0nPtL
	95oM2Bj+bJlWFkTdjrdxeuvaEbbq4NP8Zvh/4MeYrfNQAd4RddzKMOF1fKoO0icm/DNwXF46hcnqb
	qAprVbImttue74PBZygEbsiAgpZXvxh49lTg+jHpAwLNnRMaNiaqEJsMC9b7qVWEsS1HBt0dqrGsn
	Wad1jqmiY0rCdkrRc+fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guENS-00077Q-N1; Thu, 14 Feb 2019 10:36:22 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guENQ-00076j-1p
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:36:21 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1EAa0rA026763; Thu, 14 Feb 2019 11:36:13 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qmwsujqr4-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 14 Feb 2019 11:36:13 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 364CC31;
 Thu, 14 Feb 2019 10:36:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11EB74EA2;
 Thu, 14 Feb 2019 10:36:13 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 11:36:11 +0100
Subject: Re: [PATCH 0/4] Add nvmem support on STM32
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
 <alexandre.torgue@st.com>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <4aaa83b2-35a6-e2c2-a3f4-6579b5d67038@st.com>
 <46a59513-a322-1e14-41b5-ecbd4c478286@linaro.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <46ae9e00-1cf6-0ac9-eb9d-540eae7c621b@st.com>
Date: Thu, 14 Feb 2019 11:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <46a59513-a322-1e14-41b5-ecbd4c478286@linaro.org>
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_023620_373558_82CD8D8F 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: mark.rutland@arm.com, lionel.debieve@st.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8xMy8xOSAxMTozNCBBTSwgU3Jpbml2YXMgS2FuZGFnYXRsYSB3cm90ZToKPiAKPiAKPiBP
biAxMy8wMi8yMDE5IDEwOjE1LCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6Cj4+IE9uIDEvMzAvMTkg
NTozOCBQTSwgRmFicmljZSBHYXNuaWVyIHdyb3RlOgo+Pj4gTm9uIHZvbGF0aWxlIG1lbW9yeSBh
cmVhIGlzIGF2YWlsYWJsZSBvbiBTVE0zMi4gSXQgY29udGFpbnMgdmFyaW91cwo+Pj4gZmFjdG9y
eSBwcm9ncmFtbWVkIGluZm9ybWF0aW9uIHN1Y2ggYXMgdW5pcXVlIGRldmljZSBJRCwgYW5hbG9n
Cj4+PiBjYWxpYnJhdGlvbi4uLgo+Pj4gVGhpcyBwYXRjaHNldCBhZGRzIE5WTUVNIHN1cHBvcnQg
dG8gYWNjZXNzIHRoZXNlIGRhdGEuCj4+Cj4+IEhlbGxvLAo+Pgo+PiBHZW50bGUgcmVtaW5kZXIg
Zm9yIHRoaXMgbmV3IGRyaXZlciByZXZpZXcKPiBOdm1lbSBwcm92aWRlciBkcml2ZXIgaXRzZWxm
IGxvb2tzIGZpbmUgZm9yIG1lLCBidXQgSSBhbSB1bmFibGUgdG8gdGFrZQo+IHRoaXMgYXMgNS4x
IG1hdGVyaWFsLCBhcyBJIG5vcm1hbGx5IHRha2UgbnZtZW0gcGF0Y2hlcyB3aGljaCBhcmUKPiBy
ZXZpZXdlZCBhbmQgcmVhZHkgYmVmb3JlIHJjNS4KPiAKCkhpIFNyaW5pLApUaGFua3MgZm9yIHRo
ZSBmZWVkYmFjay4KCj4gZHQgYmluZGluZ3MgcGF0Y2ggbmVlZHMgYW4gYWNrIGZyb20gRFQgbWFp
bnRhaW5lcnMuCgpJIGhvcGUgUm9iIGNhbnQgdGFrZSBhIGxvb2sgYXQgaXQuCgpCZXN0IFJlZ2Fy
ZHMsCkZhYnJpY2UKCj4gCj4gVGhhbmtzLAo+IHNyaW5pCj4+Cj4+IEJlc3QgUmVnYXJkcywKPj4g
RmFicmljZQo+Pgo+Pj4KPj4+IEZhYnJpY2UgR2FzbmllciAoNCk6Cj4+PiDCoMKgIGR0LWJpbmRp
bmdzOiBudm1lbTogQWRkIFNUTTMyIGZhY3RvcnktcHJvZ3JhbW1lZCByb21lbQo+Pj4gwqDCoCBu
dm1lbTogQWRkIGRyaXZlciBmb3IgU1RNMzIgZmFjdG9yeS1wcm9ncmFtbWVkIHJlYWQgb25seSBt
ZW0KPj4+IMKgwqAgbnZtZW06IHN0bTMyOiBhZGQgc3VwcG9ydCBmb3IgU1RNMzJNUDE1IEJTRUMg
dG8gY29udHJvbCBPVFAgZGF0YQo+Pj4gwqDCoCBBUk06IGR0czogc3RtMzI6IEFkZCByb21lbSBh
bmQgdGVtcGVyYXR1cmUgY2FsaWJyYXRpb24gb24gc3RtMzJtcDE1N2MKPj4+Cj4+PiDCoCAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9zdCxzdG0zMi1yb21lbS50eHTCoMKgIHzCoCAzMSAr
KysrCj4+PiDCoCBhcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy5kdHNpwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEzICsrCj4+PiDCoCBkcml2ZXJzL252bWVtL0tjb25m
aWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxMCArCj4+PiDCoCBkcml2ZXJzL252bWVtL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArCj4+PiDC
oCBkcml2ZXJzL252bWVtL3N0bTMyLXJvbWVtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMjAyCj4+PiArKysrKysrKysrKysrKysrKysrKysKPj4+IMKg
IDUgZmlsZXMgY2hhbmdlZCwgMjU4IGluc2VydGlvbnMoKykKPj4+IMKgIGNyZWF0ZSBtb2RlIDEw
MDY0NAo+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL3N0LHN0bTMy
LXJvbWVtLnR4dAo+Pj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbnZtZW0vc3RtMzIt
cm9tZW0uYwo+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
