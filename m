Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53726C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:21:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251D8218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EVJNdlD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251D8218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nJPQb2NHRihpdjjs7U82FUVs1cXHPWvYtzyuL6jfusE=; b=EVJNdlD8v1TLPB
	uP7cLly6omc+MPHg23ZuSvJVt9AH2TjfyBTu3GN1BpPo5ZJdADGSrEkjjda1dzOun1Zc1cUuNcdK8
	uFR5e2n00kSWLcZYU556a2kdJ6BLBnqQ5B2d6bevLNKHJN4n/Ioy6pA/feNlyBvmwBHRVGbIEbx4a
	iLOFotUy0gvQmvtn3Y67x2VbeDOOKhhntPTFTZVvEp83QpRir1tTamgNqWVnY6OY+ZUD6coF2KJ2a
	IO5Z9iVFKac8vw9Qihk7izqpTnQbl59YiFd2dA81W8vLGuSNc70GhHw62Hw2scX3ihbhxRtdnwfAv
	Uuw8ZDjYmmLPmIdV2d9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBWp-00015x-18; Mon, 11 Feb 2019 13:21:43 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBWl-00015B-C5
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:21:41 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1BDKqv5004947; Mon, 11 Feb 2019 14:21:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qhurut5qx-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 11 Feb 2019 14:21:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7751C31;
 Mon, 11 Feb 2019 13:21:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34B122D79;
 Mon, 11 Feb 2019 13:21:27 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.51) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 Feb
 2019 14:21:26 +0100
Subject: Re: [PATCH 4/4] iio: counter: stm32-lptimer: Add power management
 support
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Jonathan Cameron <jic23@kernel.org>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
 <20190209162133.65e6fd93@archlinux>
 <20190210213320.fs5kzezyzwd6akpx@pengutronix.de>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <7abbd3e2-4a33-975a-39ee-dcf608633b36@st.com>
Date: Mon, 11 Feb 2019 14:21:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210213320.fs5kzezyzwd6akpx@pengutronix.de>
Content-Language: en-US
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-11_09:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_052139_709669_6A7875F6 
X-CRM114-Status: GOOD (  10.46  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, vilhelm.gray@gmail.com,
 thierry.reding@gmail.com, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8xMC8xOSAxMDozMyBQTSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6Cj4gT24gU2F0LCBG
ZWIgMDksIDIwMTkgYXQgMDQ6MjE6MzNQTSArMDAwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToK
Pj4gT24gVHVlLCA1IEZlYiAyMDE5IDEzOjQwOjI5ICswMTAwCj4+IEZhYnJpY2UgR2FzbmllciA8
ZmFicmljZS5nYXNuaWVyQHN0LmNvbT4gd3JvdGU6Cj4+Cj4+PiBBZGQgc3VzcGVuZC9yZXN1bWUg
UE0gc2xlZXAgb3BzLiBXaGVuIGdvaW5nIHRvIGxvdyBwb3dlciwgZGlzYWJsZQo+Pj4gYWN0aXZl
IGNvdW50ZXIuIE9ubHkgYWN0aXZlIGNvdW50ZXIgc2hvdWxkIGJlIHJlc3VtZWQ6IGRvbid0IHRv
dWNoCj4+PiBkaXNhYmxlZCBjb3VudGVyLCBhcyBpdCBtYXkgYmUgdXNlZCBieSBvdGhlciBMUFRp
bWVyIE1GRCBjaGlsZCBkcml2ZXIuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRmFicmljZSBHYXNu
aWVyIDxmYWJyaWNlLmdhc25pZXJAc3QuY29tPgo+PiBJIHRoaW5rIHRoaXMgbG9va3MgZmluZS4g
IEknbSBub3QgdG90YWxseSBzdXJlIGlmIHBhdGNoZXMgMyw0IGFyZQo+PiBzZXBhcmFibGUgZnJv
bSAxLDIgdGhvdWdoIHNvIHBsZWFzZSBsZXQgbWUga25vdyB3aGV0aGVyIEkgc2hvdWxkIHRha2UK
Pj4gdGhlc2Ugbm93LCBvciBsZXQgYWxsIDQgZ28gaW4gdG9nZXRoZXIgdmlhIHNvbWUgcGF0aD8K
PiAKPiBJJ2Qgc2F5IHRoZXNlIGFyZSBvcnRob2dvbmFsLCBzbyBpZiB5b3UgYXJlIGhhcHB5IHdp
dGggcGF0Y2hlcyAzIGFuZCA0Cj4geW91IGNhbiB0YWtlIHRoZW0gd2l0aG91dCBib3RoZXJpbmcg
Zm9yIHBhdGNoZXMgMSBhbmQgMi4KCkhpIFV3ZSwgSm9uYXRoYW4sCgpUaGFua3MgZm9yIHJldmll
d2luZy4gSSBjb25maXJtIHlvdSBjYW4gdGFrZSBwYXRjaGVzIDMgYW5kIDQuIEknbGwgc2VuZAph
IHYyIGZvciBwYXRjaGVzIDEgYW5kIDIgc2VwYXJhdGVseS4KCkJlc3QgcmVnYXJkcywKRmFicmlj
ZQoKPiAKPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
