Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB2C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:55:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F6420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vu+n1yD8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q1DMDQkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F6420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F4JVBl2PK68tBawXR2GPPrmz6pG4L7l5lKt3ketMUrw=; b=Vu+n1yD80kmBLL
	3MhCWkN+cDENqJ9vqdTC+qB6N9PsqmWm9WErw4UNtaTISRXOtblFL/V2DBRhDSuZTy4T1X4HLiyjB
	KY9cdgP/HgLUpr13pM2DhVdWLRxhDMJ+UI6LgqsOX2h7Cen2siBy3psuLqdE1hHYK0tbyEO+HM18/
	ZKlmuTELRrZbf5JgHfGCrc+z8KDyPvdS7u0llKzudQI57xow3/CqFSz2PdbC6c92haIYTQ+wlpX4U
	ckC4ApgyLx0XB79Vn0poC90ssOa8A15d29IIfrCFgR49IFDTOOEnV+wAv6VdH2xxKrIUQxXob9sRr
	LseUIls9HzSTvkLPmvaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goHgE-00089k-2a; Tue, 29 Jan 2019 00:55:10 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goHg9-00079J-E8
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 00:55:08 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190129005457epoutp03462b1db3efafea9dd1289786ddcf64ca~_K6JCQ73f1233712337epoutp03i
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 00:54:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190129005457epoutp03462b1db3efafea9dd1289786ddcf64ca~_K6JCQ73f1233712337epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548723297;
 bh=zLAibsdoFvMmWEbacdodHxeeG2Y32JVatu5Ty0jm96E=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Q1DMDQkqnLsbQXzLxVcBPVAMlpDoEx6/2XCDVpRvaynye8xF63Iv/sgUlRmq4v4OF
 P5ZvVvvI5Wo+tNoq6gAPT1AbAY/yTfJ/9RrQBb0QLDe/F+5DqZhKjKraWi5Q/e+ZRQ
 Cl+DswuXDKnQDjBD88llaG+2AaizZUgQupvtAA68=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20190129005450epcas1p32077770357f698a7c0b6ba2aade77fe5~_K6CEphDz0449004490epcas1p3v;
 Tue, 29 Jan 2019 00:54:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 53.A0.04206.A54AF4C5; Tue, 29 Jan 2019 09:54:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190129005449epcas1p25ed3cb1e476f164d6720f9c34aa49b7a~_K6BizHHD0902409024epcas1p2f;
 Tue, 29 Jan 2019 00:54:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190129005449epsmtrp23b61f0098ebecda13b6c4a6fc447d60a~_K6Bem85x1829418294epsmtrp2r;
 Tue, 29 Jan 2019 00:54:49 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-52-5c4fa45a8549
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 AA.A4.03601.954AF4C5; Tue, 29 Jan 2019 09:54:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190129005449epsmtip19de1b48c94645808bbbef57bd8b95e46~_K6BQ6K2b1774017740epsmtip1w;
 Tue, 29 Jan 2019 00:54:49 +0000 (GMT)
Subject: Re: [PATCH 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d6cbbeac-c15f-91b8-caf3-b22b8715665a@samsung.com>
Date: Tue, 29 Jan 2019 09:54:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548703299-15806-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmgW7UEv8Yg67zPBYbZ6xntZh/5Byr
 Rf/j18wW589vYLe41SBjsenxNVaLy7vmsFnMOL+PyWLp9YtMFrcbV7BZtO49wm5x+E07qwOP
 x5p5axg9Nq3qZPPYvKTe4+C7PUwefVtWMXp83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c
 7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKKSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4
 xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtjy9fLLAV3xCr+Nz5kbmB8INTFyMkh
 IWAiMeX3P6YuRi4OIYEdjBJ7Lt2Ccj4xSpyc3c4G4XxjlLizdCkLTMvZ1xNZIRJ7GSVe/r3P
 BpIQEnjPKPFrqg2ILSwQIrF9xR52EFtEwEPi9ecprCA2s8BJJommySYgNpuAlsT+FzfAevkF
 FCWu/njMCGLzCthJnPu+ixnEZhFQlbg2dy8TiC0qECFxuPcdVI2gxMmZT8AO4hTwllj0bx8T
 xHxxiVtP5kPZ8hLNW2czgxwqITCPXeLf24VMEB+4SPzf854dwhaWeHV8C5QtJfH53V42CLta
 YuXJI2wQzR2MElv2X2CFSBhL7F86GWgQB9AGTYn1u/QhlvFJvPvawwoSlhDglehog4avssTl
 B3eh1kpKLG7vhBrvIbFiUjPLBEbFWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwJT5Nje
 xAhOvlqWOxiPnfM5xCjAwajEw2vA5h8jxJpYVlyZe4hRgoNZSYR36nW/GCHelMTKqtSi/Pii
 0pzU4kOMpsDQnsgsJZqcD8wMeSXxhqZGxsbGFiaGZqaGhkrivOsdnGOEBNITS1KzU1MLUotg
 +pg4OKUaGI9vlfDrOsR9vOJUtP+sV2kXqlj22E4yt2s6p/9Qtu6ixanQ4z6Sxm9kbKLufcr5
 9+1NxY1fa65mbf384BpD1p/dzidtvE3ECoW9lE7ovylK2Pqb83ap6+Ir9y60FtvXWR5ydhC+
 v8i7OCWoxWiTh0o9R/BnkdZCB77TVa8iJMMKGRTsb5dvV2Ipzkg01GIuKk4EAOS/RZLUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSnG7kEv8Yg6kblC02zljPajH/yDlW
 i/7Hr5ktzp/fwG5xq0HGYtPja6wWl3fNYbOYcX4fk8XS6xeZLG43rmCzaN17hN3i8Jt2Vgce
 jzXz1jB6bFrVyeaxeUm9x8F3e5g8+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK2PL18ssBXfE
 Kv43PmRuYHwg1MXIySEhYCJx9vVE1i5GLg4hgd2MEo9nvWOHSEhKTLt4lLmLkQPIFpY4fLgY
 ouYto8SPv3vAaoQFQiS2r4CwRQQ8JF5/ngI2iFngJJNE87tJjCAJIYH7jBI7PimA2GwCWhL7
 X9xgA7H5BRQlrv54DFbDK2Ance77LmYQm0VAVeLa3L1MILaoQITEx6f7mCBqBCVOznzCAmJz
 CnhLLPoHEWcWUJf4M+8SM4QtLnHryXyouLxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRM
 LSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjkMtrR2MJ07EH2IU4GBU4uE1YPOPEWJNLCuu
 zD3EKMHBrCTCO/W6X4wQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUw
 WSYOTqkGRuFsl23xv2Ln7uUIVNjNHDKX19YwYc/cj3ur455/rXm7q09pS+v23+2fr1g5C4Wf
 Z3ddaf3n2vWp6nduHA3LlRfQ0S682jbh1a8duXMZ60L/TT739NnaysaW6/1PIhpXGs9997Ke
 ze3u3oTIT4ceB65Ljtpca9Y399rhX4kXmaSWx9qwPd319LQSS3FGoqEWc1FxIgCpKem1vwIA
 AA==
X-CMS-MailID: 20190129005449epcas1p25ed3cb1e476f164d6720f9c34aa49b7a
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96@eucas1p1.samsung.com>
 <1548703299-15806-2-git-send-email-l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_165505_648684_FB69A390 
X-CRM114-Status: GOOD (  18.61  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-samsung-soc@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, b.zolnierkie@samsung.com,
 linux-kernel@vger.kernel.org, krzk@kernel.org,
 Rob Herring <robh+dt@kernel.org>, myungjoo.ham@samsung.com,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTHVrYXN6LAoKVGhpcyBwYXRjaHNldCBkb24ndCBjb250YWluIHRoZSBjb3Zlci1sZXR0ZXIu
IFBsZWFzZSBzZW5kIHRoZQpjb3Zlci1sZXR0ZXIgd2hpY2ggZXhwbGFpbnMgd2hhdCB0byBkbyBv
biB0aGlzIHBhdGNoc2V0LgoKQW5kIGlzIGl0IHN1cHBvcnRpbmcgYWxsIEV4eW5vczUgZm9yIGJv
dGggMzJiaXQoNTQyMCw1NDIyKQphbmQgNjRiaXQoNTQzMykgb3Igb25seSBFeHlub3M1NDJ4KDMy
Yml0KT8gSWYgaXQgb25seSBzdXBwb3J0CnRoZSBFeHlub3MgNTQyeCBzZXJpZXMsIHlvdSBoYXZl
IHRvIGNoYW5nZSB0aGUgZHJpdmVyIG5hbWUKZnJvbSAnZXh5bm9zNS1kbWMuYycgdG8gJ2V4eW5v
czU0MjAtZG1jLmMnIG9yICdleHlub3M1NDIyLWRtYy5jJwppbiBvcmRlciB0byBwcmV2ZW50IHRo
ZSBjb25mdXNpb24gYWNjb3JkaW5nIHRvIHRoZSBkcml2ZXIgbmFtZS4KCgpPbiAxOS4gMS4gMjku
IOyYpOyghCA0OjIxLCBMdWthc3ogTHViYSB3cm90ZToKPiBEZWZpbmUgbmV3IElEcyBmb3IgY2xv
Y2tzIHVzZWQgYnkgRHluYW1pYyBNZW1vcnkgQ29udHJvbGxlciBpbgo+IEV4eW5vczU0MjIgU29D
Lgo+IAo+IENDOiBTeWx3ZXN0ZXIgTmF3cm9ja2kgPHMubmF3cm9ja2lAc2Ftc3VuZy5jb20+Cj4g
Q0M6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo+IENDOiBSb2IgSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPgo+IENDOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBh
cm0uY29tPgo+IENDOiBLdWtqaW4gS2ltIDxrZ2VuZUBrZXJuZWwub3JnPgo+IENDOiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Cj4gQ0M6IGxpbnV4LXNhbXN1bmctc29jQHZn
ZXIua2VybmVsLm9yZwo+IENDOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZwo+IENDOiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDQzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZwo+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1YmFAcGFydG5lci5z
YW1zdW5nLmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9leHlub3M1NDIw
LmggfCAxOCArKysrKysrKysrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9leHlub3M1NDIwLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2V4eW5vczU0
MjAuaAo+IGluZGV4IDM1NWY0NjkuLjE4MjdhNjQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9kdC1i
aW5kaW5ncy9jbG9jay9leHlub3M1NDIwLmgKPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Ns
b2NrL2V4eW5vczU0MjAuaAo+IEBAIC02MCw2ICs2MCw3IEBACj4gICNkZWZpbmUgQ0xLX01BVV9F
UExMCQkxNTkKPiAgI2RlZmluZSBDTEtfU0NMS19IU0lDXzEyTQkxNjAKPiAgI2RlZmluZSBDTEtf
U0NMS19NUEhZX0lYVEFMMjQJMTYxCj4gKyNkZWZpbmUgQ0xLX1NDTEtfQlBMTAkJMTYyCj4gIAo+
ICAvKiBnYXRlIGNsb2NrcyAqLwo+ICAjZGVmaW5lIENMS19VQVJUMAkJMjU3Cj4gQEAgLTE5NSw2
ICsxOTYsMTYgQEAKPiAgI2RlZmluZSBDTEtfQUNMSzQzMl9DQU0JCTUxOAo+ICAjZGVmaW5lIENM
S19BQ0xLX0ZMMTU1MF9DQU0JNTE5Cj4gICNkZWZpbmUgQ0xLX0FDTEs1NTBfQ0FNCQk1MjAKPiAr
I2RlZmluZSBDTEtfQ0xLTV9QSFkwCQk1MjEKPiArI2RlZmluZSBDTEtfQ0xLTV9QSFkxCQk1MjIK
PiArI2RlZmluZSBDTEtfQUNMS19QUE1VX0RSRVgwXzAJNTIzCj4gKyNkZWZpbmUgQ0xLX0FDTEtf
UFBNVV9EUkVYMF8xCTUyNAo+ICsjZGVmaW5lIENMS19BQ0xLX1BQTVVfRFJFWDFfMAk1MjUKPiAr
I2RlZmluZSBDTEtfQUNMS19QUE1VX0RSRVgxXzEJNTI2Cj4gKyNkZWZpbmUgQ0xLX1BDTEtfUFBN
VV9EUkVYMF8wCTUyNwo+ICsjZGVmaW5lIENMS19QQ0xLX1BQTVVfRFJFWDBfMQk1MjgKPiArI2Rl
ZmluZSBDTEtfUENMS19QUE1VX0RSRVgxXzAJNTI5Cj4gKyNkZWZpbmUgQ0xLX1BDTEtfUFBNVV9E
UkVYMV8xCTUzMAo+ICAKPiAgLyogbXV4IGNsb2NrcyAqLwo+ICAjZGVmaW5lIENMS19NT1VUX0hE
TUkJCTY0MAo+IEBAIC0yMTcsNiArMjI4LDEwIEBACj4gICNkZWZpbmUgQ0xLX01PVVRfRVBMTAkJ
NjU3Cj4gICNkZWZpbmUgQ0xLX01PVVRfTUFVX0VQTEwJNjU4Cj4gICNkZWZpbmUgQ0xLX01PVVRf
VVNFUl9NQVVfRVBMTAk2NTkKPiArI2RlZmluZSBDTEtfTU9VVF9EUExMCQk2NjAKPiArI2RlZmlu
ZSBDTEtfTU9VVF9BQ0xLX0czRAk2NjEKPiArI2RlZmluZSBDTEtfTU9VVF9TQ0xLX1NQTEwJNjYy
Cj4gKyNkZWZpbmUgQ0xLX01PVVRfTVhfTVNQTExfQ0NPUkVfUEhZCTY2Mwo+ICAKPiAgLyogZGl2
aWRlciBjbG9ja3MgKi8KPiAgI2RlZmluZSBDTEtfRE9VVF9QSVhFTAkJNzY4Cj4gQEAgLTI0OCw4
ICsyNjMsOSBAQAo+ICAjZGVmaW5lIENMS19ET1VUX0NDTEtfRFJFWDAJNzk0Cj4gICNkZWZpbmUg
Q0xLX0RPVVRfQ0xLMlhfUEhZMAk3OTUKPiAgI2RlZmluZSBDTEtfRE9VVF9QQ0xLX0NPUkVfTUVN
CTc5Ngo+ICsjZGVmaW5lIENMS19GRl9ET1VUX1NQTEwyCTc5Nwo+ICAKPiAgLyogbXVzdCBiZSBn
cmVhdGVyIHRoYW4gbWF4aW1hbCBjbG9jayBpZCAqLwo+IC0jZGVmaW5lIENMS19OUl9DTEtTCQk3
OTcKPiArI2RlZmluZSBDTEtfTlJfQ0xLUwkJNzk4Cj4gIAo+ICAjZW5kaWYgLyogX0RUX0JJTkRJ
TkdTX0NMT0NLX0VYWU5PU181NDIwX0ggKi8KPiAKCgotLSAKQmVzdCBSZWdhcmRzLApDaGFud29v
IENob2kKU2Ftc3VuZyBFbGVjdHJvbmljcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
