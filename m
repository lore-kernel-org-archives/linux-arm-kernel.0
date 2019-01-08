Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5785C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:43:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755EC2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dup1eJOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755EC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qwnFN45/w5uUxm4RFoieV2Cb99hBxVfkA0k3k6bUMPE=; b=dup1eJOq+ayDntR8JajgG57z3
	4dCHU3XK6EJpQ5yxQl70mewhD+6zc5x4rdDoukt+d/pzzx7KS0QikWsgd5vC3iaqVQpSflUj8WhQ3
	acoeLAkxhG02j6Jng33nH/azh1baDlNUu7ureUqjcFPyW8BDYJ0wurUG8NSmcBDuL+7uooa5VE96P
	3FAutseEAem+YSRUOmiXOVpbAnfFSfA/dkFeB/BCB2Y55VoTZtJC1+yvvVNQMxcLielqFNMOuOIXk
	5XumTCi8PWAYTwwppA44vpSOUP/e40GWtRtI8NtWhBO3pKF7D10C6NNr/VJUvhxh5lbx5/Imx8dUg
	8XQT9pE3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggmyW-0002HH-VD; Tue, 08 Jan 2019 08:43:04 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggmyT-0002Gk-JR
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 08:43:03 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x088ZmW5013401; Tue, 8 Jan 2019 09:42:55 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2ptybmv747-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 08 Jan 2019 09:42:55 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE27634;
 Tue,  8 Jan 2019 08:42:54 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9841C2751;
 Tue,  8 Jan 2019 08:42:54 +0000 (GMT)
Received: from [10.129.4.234] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 8 Jan
 2019 09:42:53 +0100
Subject: Re: [GIT PULL] STM32 DT changes for v4.21 #1
From: Alexandre Torgue <alexandre.torgue@st.com>
To: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
 <6a490c72-c76a-51ef-7c5d-2178d2adcc83@st.com>
Message-ID: <17acd15d-6fdb-c797-c37c-37bab49ac3b6@st.com>
Date: Tue, 8 Jan 2019 09:42:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6a490c72-c76a-51ef-7c5d-2178d2adcc83@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-08_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_004301_933681_7D7A025E 
X-CRM114-Status: GOOD (  19.89  )
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

SGkKCk9uIDEvOC8xOSA4OjI5IEFNLCBBbGV4YW5kcmUgVG9yZ3VlIHdyb3RlOgo+IEhpIGd1eXMK
PiAKPiBPbiAxMi8zLzE4IDEyOjE4IFBNLCBBbGV4YW5kcmUgVG9yZ3VlIHdyb3RlOgo+PiBIaSBB
cm5kLCBPbG9mIGFuZCBLZXZpbiwKPj4KPj4gUGxlYXNlIGNvbnNpZGVyIHRoaXMgZmlyc3Qgcm91
bmQgb2YgU1RNMzIgRFQgdXBkYXRlcyBmb3IgdjQuMjEuCj4+Cj4+IFRoYW5rcy4KPj4gQWxleAo+
Pgo+IAo+IFRoaXMgUFIgaGFzIG5vdCBiZWVuIG1lcmdlZCBpbiA1LjAtcmMxLiBJcyB0aGVyZSBh
biBpc3N1ZSAoZXhjZXB0IHRoYW4gCj4gdjQuMjEgZG9lc24ndCBleGlzdCA6KSkgPwo+IElmIG5v
dCwgaXMgaXQgcG9zc2libGUgdG8gZ2V0IGl0IGluIG5leHQgNS4wIHJjID8KPiAKClNvcnJ5IGZv
ciB0aGUgbGFzdCBwb3N0LiBJIGNvbXBsZXRlbHkgbWlzc2VkIE9sb2YgYW5zd2VyOgoKIkkgdGhp
bmsgeW91IG1pZ2h0IGhhdmUgbWlzc2VkIHB1c2hpbmcgdGhlIHRhZyB0byB0aGUgcmVtb3RlPwot
T2xvZgoiCgpNeSB0YWcgaXMgbm93IHB1c2hlZC4gSXMgdGhlcmUgYSBjaGFuY2UgdG8gZ2V0IGl0
IGluIG5leHQgUkMgPwoKU29ycnkgZm9yIGluY29udmVuaWVuY2UuCgpBbGV4Cgo+IFRoYW5rcyBp
biBhZHZhbmNlCj4gQWxleAo+IAo+IAo+PiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29t
bWl0IAo+PiA2NTEwMjIzODJjN2Y4ZGE0NmNiNDg3MmE1NDVlZTFkYTZkMDk3ZDJhOgo+Pgo+PiDC
oMKgIExpbnV4IDQuMjAtcmMxICgyMDE4LTExLTA0IDE1OjM3OjUyIC0wODAwKQo+Pgo+PiBhcmUg
YXZhaWxhYmxlIGluIHRoZSBnaXQgcmVwb3NpdG9yeSBhdDoKPj4KPj4gwqDCoCBnaXQ6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXRvcmd1ZS9zdG0zMi5naXQgCj4+
IHN0bTMyLWR0LWZvci12NC4yMS0xCj4+Cj4+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
byA4OTE0YjYzYmFiM2M0M2E1MjkzMTZiYTI4NTgxMzdiYzU3Yjc0ZmExOgo+Pgo+PiDCoMKgIEFS
TTogZHRzOiBzdG0zMjogYWRkIHRoZXJtYWwgc2Vuc29yIHN1cHBvcnQgb24gU1RNMzJNUDE1N2Mg
Cj4+ICgyMDE4LTEyLTAzIDEwOjQzOjI2ICswMTAwKQo+Pgo+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+IFNUTTMyIERU
IHVwZGF0ZXMgZm9yIHY0LjIxLCByb3VuZCAxCj4+Cj4+IEhpZ2hsaWdodHM6Cj4+IC0tLS0tLS0t
LS0KPj4KPj4gLU1QVSBTVE0zMk1QMTU3IHBsYXRmb3JtIHVwZGF0ZToKPj4gwqDCoC1EZWNsYXJl
IERNQXMgZm9yIHRpbWVycwo+PiDCoMKgLUFkZCBzbGVlcCBzdXBwb3J0IGZvciBDQU4KPj4gwqDC
oC1TcGxpdCBDQU4gUkFNIG1hcHBpbmcgYmV0d2VlbiB0aGUgMiBGRENBTiBpbnN0YW5jZXMKPj4g
wqDCoC1BZGQgc3VwcG9ydCBvZiB0aGVybWFsIHNlbnNvciAoRFRTKQo+Pgo+PiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+
IEJpY2ggSEVNT04gKDMpOgo+PiDCoMKgwqDCoMKgwqAgQVJNOiBkdHM6IHN0bTMyOiBjaGFuZ2Ug
Q0FOIFJBTSBtYXBwaW5nIG9uIHN0bTMybXAxNTdjCj4+IMKgwqDCoMKgwqDCoCBBUk06IGR0czog
c3RtMzI6IGFkZCBjYW4xIHNsZWVwIHBpbnMgbXV4aW5nCj4+IMKgwqDCoMKgwqDCoCBBUk06IGR0
czogc3RtMzI6IGFkZCBjYW4xIHNsZWVwIHBpbnMgbXV4aW5nIG9uIHN0bTMybXAxNTdjLWV2MSAK
Pj4gYm9hcmQKPj4KPj4gRGF2aWQgSGVybmFuZGV6IFNhbmNoZXogKDEpOgo+PiDCoMKgwqDCoMKg
wqAgQVJNOiBkdHM6IHN0bTMyOiBhZGQgdGhlcm1hbCBzZW5zb3Igc3VwcG9ydCBvbiBTVE0zMk1Q
MTU3Ywo+Pgo+PiBGYWJyaWNlIEdhc25pZXIgKDMpOgo+PiDCoMKgwqDCoMKgwqAgQVJNOiBkdHM6
IHN0bTMyOiBBZGQgZG1hcyB0byB0aW1lciBvbiBzdG0zMm1wMTU3Ywo+PiDCoMKgwqDCoMKgwqAg
QVJNOiBkdHM6IHN0bTMyOiBkb24ndCB1c2UgdGltZXJzIGRtYXMgb24gc3RtMzJtcDE1N2MtZWQx
Cj4+IMKgwqDCoMKgwqDCoCBBUk06IGR0czogc3RtMzI6IGRvbid0IHVzZSB0aW1lcnMgZG1hcyBv
biBzdG0zMm1wMTU3Yy1ldjEKPj4KPj4gwqDCoGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTct
cGluY3RybC5kdHNpIHzCoCA3ICsrKwo+PiDCoMKgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1
N2MtZWQxLmR0c8KgwqDCoMKgIHzCoCAzICsKPj4gwqDCoGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMy
bXAxNTdjLWV2MS5kdHPCoMKgwqDCoCB8IDEwICsrKy0KPj4gwqDCoGFyY2gvYXJtL2Jvb3QvZHRz
L3N0bTMybXAxNTdjLmR0c2nCoMKgwqDCoMKgwqDCoCB8IDk3IAo+PiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystCj4+IMKgwqA0IGZpbGVzIGNoYW5nZWQsIDExNCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
