Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA44DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:58:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A21320C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ME4dLWB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A21320C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UYt+6BWBctFeXH+xJ+HDbhxV/TKFQpchxdOWJDDUz/I=; b=ME4dLWB5X9D14o
	+qQ5JOmGVQXTwwkeqI5m7ICnK0d3ge9e7vC2sDUDfN/KXAmIjxSEmFJyaXP+n0jY8+G46ipGD0mMI
	ezYxfdqKdAfUklKIQGmJYMgDI6rzYqIDXpG9x/qiTvIwNG4thuRVwv2QGgQ9k8uPJxNvAImCM+dpW
	64mKTk8BQJ0hkKP3EpEfU0egMs3zo0z8A7pazJWU58NvJrCjad67ZkEA7UaMjtjgUYiJMi8u6IorB
	BQyEqhE+Wb+NNLHoCp/rDlQ4RHaP1WA7aIkEzM0AsKbYLKq/TmJQFGSHOh5V2x8xXsXaD8PGJfeF9
	9BjqdT8r0SmWqaozUmYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIdf-0005Rj-SE; Mon, 25 Feb 2019 15:57:55 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIdc-0005RC-49
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 15:57:54 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1PFuc2M003031; Mon, 25 Feb 2019 16:57:45 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qtvtwtqgq-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 25 Feb 2019 16:57:45 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D65338;
 Mon, 25 Feb 2019 15:57:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 01D435244;
 Mon, 25 Feb 2019 15:57:44 +0000 (GMT)
Received: from [10.48.0.160] (10.75.127.47) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Feb
 2019 16:57:44 +0100
Subject: Re: [PATCH v1 2/3] ARM: dts: stm32: enable Vivante GPU support on
 stm32mp157c-ed1 board
To: Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
 <1550246316-9747-3-git-send-email-pierre-yves.mordret@st.com>
 <1550247269.2546.58.camel@pengutronix.de>
From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <2cf49be6-474d-350b-8dfd-3fe1bf38af3a@st.com>
Date: Mon, 25 Feb 2019 16:57:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550247269.2546.58.camel@pengutronix.de>
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-25_08:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_075752_782218_D0EAD860 
X-CRM114-Status: GOOD (  14.68  )
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

SGkgYWdhaW4sCgpPbiAyLzE1LzE5IDU6MTQgUE0sIEx1Y2FzIFN0YWNoIHdyb3RlOgo+IEFtIEZy
ZWl0YWcsIGRlbiAxNS4wMi4yMDE5LCAxNjo1OCArMDEwMCBzY2hyaWViIFBpZXJyZS1ZdmVzIE1P
UkRSRVQ6Cj4+IEVuYWJsZSBWaXZhbnRlIEdQVSBkcml2ZXIgZm9yIHN0bTMybXAxNTdjLWVkMSBi
b2FyZC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogUGllcnJlLVl2ZXMgTU9SRFJFVCA8cGllcnJlLXl2
ZXMubW9yZHJldEBzdC5jb20+Cj4+IC0tLQo+PiDCoGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAx
NTdjLWVkMS5kdHMgfCAxNiArKysrKysrKysrKysrKysrCj4+IMKgMSBmaWxlIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMy
bXAxNTdjLWVkMS5kdHMKPj4gYi9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy1lZDEuZHRz
Cj4+IGluZGV4IDk4ZWY3YTAuLjc5MmY0MDIgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3N0bTMybXAxNTdjLWVkMS5kdHMKPj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJt
cDE1N2MtZWQxLmR0cwo+PiBAQCAtMjAsNiArMjAsMTcgQEAKPj4gwqAJCXJlZyA9IDwweEMwMDAw
MDAwIDB4NDAwMDAwMDA+Owo+PiDCoAl9Owo+PiDCoAo+PiArCXJlc2VydmVkLW1lbW9yeSB7Cj4+
ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Owo+PiArCQkjc2l6ZS1jZWxscyA9IDwxPjsKPj4gKwkJ
cmFuZ2VzOwo+PiArCj4+ICsJCWdwdV9yZXNlcnZlZDogZ3B1QGY4MDAwMDAwIHsKPj4gKwkJCXJl
ZyA9IDwweGY4MDAwMDAwIDB4ODAwMDAwMD47Cj4+ICsJCQluby1tYXA7Cj4+ICsJCX07Cj4+ICsJ
fTsKPj4gKwo+IAo+IEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdGhpcy4gVGhlIEdQVSBkcml2ZXIg
dXNlcyB2ZXJ5IGxpdHRsZSBjb250aWcgZG1hCj4gbWVtb3J5LiBNb3N0IG9mIHRoZSBHUFUgbWVt
b3J5IGlzIG9yZGluYXJ5IHBhZ2VkIG1lbW9yeSwgc28gc2V0dGluZwo+IGFzaWRlIGEgcHJpdmF0
ZSBtZW1vcnkgcmVnaW9uIG9mIHRoaXMgc2l6ZSBpcyBhIHdhc3RlIG9mIG1lbW9yeS4gTW9zdAo+
IGxpa2VseSB5b3UgY2FuIGp1c3QgYWxsb3cgdGhlIEdQVSBkcml2ZXIgdG8gdXNlIHRoZSBzeXN0
ZW0gZ2xvYmFsIENNQQo+IHJlZ2lvbi4KClRoYXQncyBjb3JyZWN0LCBidXQgdGhpcyBtZW1vcnkg
YXJlYSBpcyBhbHNvIHVzZWQgZm9yIFUtQk9PVCBzcGxhc2ggc2NyZWVuCnJlbmRlcmluZy4KTW9y
ZW92ZXIsIGV2ZW4gaWYgd2UgbGFjayBvZiBwcm9vZiBhcyBmb3IgdG9kYXksIGl0IHR1cm5zIG91
dCBwZXJmb3JtYW5jZXMgYXJlCmJldHRlciB3aXRoIHRoaXMgcmVnaW9uIGFzIHJlZHVjZXMgTU1V
IGFjY2Vzc2VzICh3aXRoIFZpdmFudGUgZHJpdmVyKQpFdmVudHVhbGx5IHVzaW5nIEFuZHJvaWQg
ZnJhbWV3b3JrIGFwcGxpY2F0aW9uIGlzIHN0YXJ0ZWQgbW9yZSBnZW50bHkgd2hhdGV2ZXIKcHJl
dmlvdXMgYXBwbGljYXRpb24gYW5kIENNQSBzdGF0dXMoZnJhZ21lbnRhdGlvbikuClByb3ZpZGVk
IHRoaXMgbWVtb3J5LCBDTUEgcmVnaW9uIGlzIGRlY3JlYXNlZCBhY2NvcmRpbmdseS4KCkhvcGUg
aXQgY2xhcmlmaWVzLgoKUmVnYXJkcwo+IAo+IFJlZ2FyZHMsCj4gTHVjYXMKPiAKPiAKPj4gwqAJ
YWxpYXNlcyB7Cj4+IMKgCQlzZXJpYWwwID0gJnVhcnQ0Owo+PiDCoAl9Owo+PiBAQCAtNTMsNiAr
NjQsMTEgQEAKPj4gwqAJc3RhdHVzID0gIm9rYXkiOwo+PiDCoH07Cj4+IMKgCj4+ICsmZ3B1IHsK
Pj4gKwljb250aWd1b3VzLWFyZWEgPSA8JmdwdV9yZXNlcnZlZD47Cj4+ICsJc3RhdHVzID0gIm9r
YXkiOwo+PiArfTsKPj4gKwo+PiDCoCZpMmM0IHsKPj4gwqAJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsKPj4gwqAJcGluY3RybC0wID0gPCZpMmM0X3BpbnNfYT47CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
