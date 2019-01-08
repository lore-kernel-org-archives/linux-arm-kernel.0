Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321B9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:29:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC5520700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="udP3O9MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC5520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F1cIswrDd+++sCMe45QCX1pw6dgPFwGwfhD3VWvjmFQ=; b=udP3O9MDqCC5BUewdYs7PLjQ1
	Oexhrws77O9LK+fPk+0lypbxWy8onUK4aDJegBO4UtQ67Q6hzx+0nBFtFYjfP4+68iVsckoh+yNow
	UtbSQK7RjOT4GqxwWD0mzSjAIeLo1zM+P+Q6L7rGdoFIlVyoEGToAbqZG37VDUGrSU7CwvomY6GVa
	ruTzTSz2jzwZWOLxQUbSKctaAeSsv5gMPboLVMSVOYZqrYEz8G5dvbKGgw8nUzleKZwDB7Y8ixQ74
	h1vn4vCI+mf9yTSkxcYHcmN4oP4fEuoQdgblIS+KkNE+T1yzZ2MO7xSLndMKkVxItFInbT0s+GoiP
	Pjg1qBp1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gglp8-0006Tf-Gq; Tue, 08 Jan 2019 07:29:18 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gglp4-0006T1-N1
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 07:29:16 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x087QFSL008442; Tue, 8 Jan 2019 08:29:07 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2ptt11w62f-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 08 Jan 2019 08:29:07 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43F5834;
 Tue,  8 Jan 2019 07:29:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 169CB24AE;
 Tue,  8 Jan 2019 07:29:06 +0000 (GMT)
Received: from [10.129.4.234] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 8 Jan
 2019 08:29:05 +0100
Subject: Re: [GIT PULL] STM32 DT changes for v4.21 #1
To: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <6a490c72-c76a-51ef-7c5d-2178d2adcc83@st.com>
Date: Tue, 8 Jan 2019 08:29:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-08_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_232915_093810_0ED21321 
X-CRM114-Status: GOOD (  20.33  )
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
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgZ3V5cwoKT24gMTIvMy8xOCAxMjoxOCBQTSwgQWxleGFuZHJlIFRvcmd1ZSB3cm90ZToKPiBI
aSBBcm5kLCBPbG9mIGFuZCBLZXZpbiwKPiAKPiBQbGVhc2UgY29uc2lkZXIgdGhpcyBmaXJzdCBy
b3VuZCBvZiBTVE0zMiBEVCB1cGRhdGVzIGZvciB2NC4yMS4KPiAKPiBUaGFua3MuCj4gQWxleAo+
CgpUaGlzIFBSIGhhcyBub3QgYmVlbiBtZXJnZWQgaW4gNS4wLXJjMS4gSXMgdGhlcmUgYW4gaXNz
dWUgKGV4Y2VwdCB0aGFuIAp2NC4yMSBkb2Vzbid0IGV4aXN0IDopKSA/CklmIG5vdCwgaXMgaXQg
cG9zc2libGUgdG8gZ2V0IGl0IGluIG5leHQgNS4wIHJjID8KClRoYW5rcyBpbiBhZHZhbmNlCkFs
ZXgKCgo+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgCj4gNjUxMDIyMzgyYzdm
OGRhNDZjYjQ4NzJhNTQ1ZWUxZGE2ZDA5N2QyYToKPiAKPiAgwqAgTGludXggNC4yMC1yYzEgKDIw
MTgtMTEtMDQgMTU6Mzc6NTIgLTA4MDApCj4gCj4gYXJlIGF2YWlsYWJsZSBpbiB0aGUgZ2l0IHJl
cG9zaXRvcnkgYXQ6Cj4gCj4gIMKgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9hdG9yZ3VlL3N0bTMyLmdpdCAKPiBzdG0zMi1kdC1mb3ItdjQuMjEtMQo+IAo+
IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA4OTE0YjYzYmFiM2M0M2E1MjkzMTZiYTI4
NTgxMzdiYzU3Yjc0ZmExOgo+IAo+ICDCoCBBUk06IGR0czogc3RtMzI6IGFkZCB0aGVybWFsIHNl
bnNvciBzdXBwb3J0IG9uIFNUTTMyTVAxNTdjIAo+ICgyMDE4LTEyLTAzIDEwOjQzOjI2ICswMTAw
KQo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPiBTVE0zMiBEVCB1cGRhdGVzIGZvciB2NC4yMSwgcm91bmQgMQo+IAo+
IEhpZ2hsaWdodHM6Cj4gLS0tLS0tLS0tLQo+IAo+IC1NUFUgU1RNMzJNUDE1NyBwbGF0Zm9ybSB1
cGRhdGU6Cj4gIMKgLURlY2xhcmUgRE1BcyBmb3IgdGltZXJzCj4gIMKgLUFkZCBzbGVlcCBzdXBw
b3J0IGZvciBDQU4KPiAgwqAtU3BsaXQgQ0FOIFJBTSBtYXBwaW5nIGJldHdlZW4gdGhlIDIgRkRD
QU4gaW5zdGFuY2VzCj4gIMKgLUFkZCBzdXBwb3J0IG9mIHRoZXJtYWwgc2Vuc29yIChEVFMpCj4g
Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+IEJpY2ggSEVNT04gKDMpOgo+ICDCoMKgwqDCoMKgIEFSTTogZHRzOiBzdG0z
MjogY2hhbmdlIENBTiBSQU0gbWFwcGluZyBvbiBzdG0zMm1wMTU3Ywo+ICDCoMKgwqDCoMKgIEFS
TTogZHRzOiBzdG0zMjogYWRkIGNhbjEgc2xlZXAgcGlucyBtdXhpbmcKPiAgwqDCoMKgwqDCoCBB
Uk06IGR0czogc3RtMzI6IGFkZCBjYW4xIHNsZWVwIHBpbnMgbXV4aW5nIG9uIHN0bTMybXAxNTdj
LWV2MSBib2FyZAo+IAo+IERhdmlkIEhlcm5hbmRleiBTYW5jaGV6ICgxKToKPiAgwqDCoMKgwqDC
oCBBUk06IGR0czogc3RtMzI6IGFkZCB0aGVybWFsIHNlbnNvciBzdXBwb3J0IG9uIFNUTTMyTVAx
NTdjCj4gCj4gRmFicmljZSBHYXNuaWVyICgzKToKPiAgwqDCoMKgwqDCoCBBUk06IGR0czogc3Rt
MzI6IEFkZCBkbWFzIHRvIHRpbWVyIG9uIHN0bTMybXAxNTdjCj4gIMKgwqDCoMKgwqAgQVJNOiBk
dHM6IHN0bTMyOiBkb24ndCB1c2UgdGltZXJzIGRtYXMgb24gc3RtMzJtcDE1N2MtZWQxCj4gIMKg
wqDCoMKgwqAgQVJNOiBkdHM6IHN0bTMyOiBkb24ndCB1c2UgdGltZXJzIGRtYXMgb24gc3RtMzJt
cDE1N2MtZXYxCj4gCj4gIMKgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1Ny1waW5jdHJsLmR0
c2kgfMKgIDcgKysrCj4gIMKgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MtZWQxLmR0c8Kg
wqDCoMKgIHzCoCAzICsKPiAgwqBhcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy1ldjEuZHRz
wqDCoMKgwqAgfCAxMCArKystCj4gIMKgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRz
acKgwqDCoMKgwqDCoMKgIHwgOTcgCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+
ICDCoDQgZmlsZXMgY2hhbmdlZCwgMTE0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
