Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C4DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:38:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FF9206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DaCjRice";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CF0zNtDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FF9206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D8HGkgUQ20zi3iQb8UtAuuh/+EAvnHh6sURbWQtD4oA=; b=DaCjRicenEBGI2
	XEwB/XeHJB3HhTbGC1GHVxoo6quyWBZWnNAKycvf8RPMq3MHJ8iE0bjOPSq3V9rCSIB9ugE13k/3p
	109oU3ysiMMGqZQgzOXax1jIwA4FxeFw4cGdSKiPkbIsC/EunThS9K9lyXDg9h+sOc8Wdd+EcC2mx
	J6nxrGZ0kzQG6M36Q27q3kTNhX23QFHwekq6u8iV+mIBxkG3Ci92Iu6nKtgNMxdG9EBkqc23lAs+0
	7R7TwrW2LIKj1E1j6c/tWHmHmw9sXuD8iiMd7b/iCLWhkasbYXZoMC8Nz+wx560Pe18RZwo9GeKwk
	Jlqnu+aw9wngyA6jHfig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtM5L-0001wU-4h; Tue, 12 Feb 2019 00:38:03 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtM5H-0001u4-0x
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 00:38:01 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190212003753epoutp0357c03bfd67199b44ab294d2223d528fa~CdtPS8uFh2903229032epoutp03Z
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 00:37:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190212003753epoutp0357c03bfd67199b44ab294d2223d528fa~CdtPS8uFh2903229032epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549931873;
 bh=4XyHo45SpGrPV4PNliVSZO2CBEjWJuMP1/jvNTHdPOw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=CF0zNtDGyRCO9mbbo7x1fzpUUfvbcS/wzYLCYE7KaKXfxiVcWTwwGCA70D2KJqp5t
 In3SioMX73XgtonHd8lbDtXI9nTdyCUkIoYcu8Eh5CRinySSw+bTcEybP1mpKdKr02
 cKFo2csj1kxzS7S6LDgsOAw2eQ0rDjzGFRojzb6I=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20190212003750epcas1p465f654daff14b9020dbfb318c231dfb7~CdtMEXXs61031010310epcas1p4k;
 Tue, 12 Feb 2019 00:37:50 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 35.82.04288.E55126C5; Tue, 12 Feb 2019 09:37:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20190212003749epcas1p41338a6c7d612d741a179e9c8ba4351dc~CdtLYd2_W1031110311epcas1p4h;
 Tue, 12 Feb 2019 00:37:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190212003749epsmtrp2e690cdb78975c9377a33ecaa72f00f28~CdtLXOEu60267402674epsmtrp2N;
 Tue, 12 Feb 2019 00:37:49 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-c8-5c62155ef16e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8D.AA.03601.D55126C5; Tue, 12 Feb 2019 09:37:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190212003749epsmtip29ab10159ce3295f6e36e54b567f5c0d2~CdtLLpEoH1392213922epsmtip2X;
 Tue, 12 Feb 2019 00:37:49 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kukjin Kim
 <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester
 Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <effba950-8fcf-2d96-827d-25d20ae60f1d@samsung.com>
Date: Tue, 12 Feb 2019 09:37:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211181531.GA3238@embeddedor>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmrm6caFKMwfTdkhZb96hanOnOteh/
 /JrZ4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyuHjK1eLwm3ZWi3/XNrJYrNr1h9GBx+P9
 jVZ2j9kNF1k81h1U9dg56y67x6ZVnWwem5fUe/RtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5K
 Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtClSgpliTmlQKGAxOJiJX07m6L8
 0pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjGtnQgt+CVRs2uPRwPiX
 t4uRk0NCwETi1Icmli5GLg4hgR2MEocmP2aHcD4xSqw4dpMVwvnGKLFw025GmJZXizYzQST2
 Mkp8ebwdquU9o8SzZeuAWjg4hAX8JZ4/ZwaJiwjMY5K4MHsx2ChmgdWMEhM23WMHGcUmoCWx
 /8UNNhCbX0BR4uqPx2AreAXsJHb23GYFsVkEVCU2LPvFDGKLCkRIHO59B1UjKHFy5hMWEJtT
 QF/iwvp3YPXMAuISt57MZ4Kw5SWat84Gu0JCYBW7xPZPj5ghfnCReHPzBTuELSzx6vgWKFtK
 4vO7vWwQdrXEypNH2CCaOxgltuy/wAqRMJbYv3QyE8ibzAKaEut36UMs45N497UH7HsJAV6J
 jjYhiGplicsP7jJB2JISi9s7ocZ7SKz9c4NlAqPiLCTvzELywiwkL8xCWLaAkWUVo1hqQXFu
 emqxYYEJcmxvYgSnYi2LHYx7zvkcYhTgYFTi4VXITYwRYk0sK67MPcQowcGsJMJrIJwUI8Sb
 klhZlVqUH19UmpNafIjRFBjaE5mlRJPzgXkiryTe0NTI2NjYwsTQzNTQUEmcd72Dc4yQQHpi
 SWp2ampBahFMHxMHp1QDY2X21o1fkv1fzJGdfJ7D4boT6+2p5rb3812KMhn38B4WXXNNtNr9
 sv+VlQ6vtFmqv8wwyRf9sJD9osrK70dV7Jol8tm2mk/2fu+e+T7akt/7dUT717dvOX56K6w9
 2bbpUdbx4Mxl6nt9goSMz0yI95/ZuEzaymX1VaYXyR4HJOS9N+zUbebhUGIpzkg01GIuKk4E
 ABF2UJnbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvG6saFKMwY9XahZb96hanOnOteh/
 /JrZ4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyuHjK1eLwm3ZWi3/XNrJYrNr1h9GBx+P9
 jVZ2j9kNF1k81h1U9dg56y67x6ZVnWwem5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
 tTOhBb8EKjbt8Whg/MvbxcjJISFgIvFq0WamLkYuDiGB3YwSWx58ZoJISEpMu3iUuYuRA8gW
 ljh8uBii5i2jxI7ZDxhBaoQFfCWW3lnCApIQEVjAJLHlRwsziMMssJpRYsPBDywQLU2MEl/e
 TWMBaWET0JLY/+IGG4jNL6AocfXHY7BRvAJ2Ejt7brOC2CwCqhIblv1iBrFFBSIkPj7dxwRR
 IyhxcuYTsDmcAvoSF9a/A6tnFlCX+DPvEjOELS5x68l8JghbXqJ562zmCYzCs5C0z0LSMgtJ
 yywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHpZbWDsYTJ+IPMQpwMCrx
 8CrkJsYIsSaWFVfmHmKU4GBWEuE1EE6KEeJNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkgg
 PbEkNTs1tSC1CCbLxMEp1cDoG2MRuV9S5+PptTs2czFvF09a957jbXK2YdZj45KwK+ahl/59
 Cvqz+pva6fgysR2ee7aw/dgfUGIUsZQ/IfFpyW0X7sdv4i84PVDx2Myy8/Dhjzm/a1IYLj+1
 ktbXWfJUiW9nucxaE/67Iq4/l90RuGLet/qHYOCT3R1dRzO6o3eumyB07ct5JZbijERDLeai
 4kQAztz8GcYCAAA=
X-CMS-MailID: 20190212003749epcas1p41338a6c7d612d741a179e9c8ba4351dc
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190211181544epcas4p1d899221776a647a5bdf21372304bf0d7
References: <CGME20190211181544epcas4p1d899221776a647a5bdf21372304bf0d7@epcas4p1.samsung.com>
 <20190211181531.GA3238@embeddedor>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_163759_577189_FA879B09 
X-CRM114-Status: GOOD (  24.86  )
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
Cc: Kees Cook <keescook@chromium.org>, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3VzdGF2bywKCk9uIDE5LiAyLiAxMi4g7Jik7KCEIDM6MTUsIEd1c3Rhdm8gQS4gUi4gU2ls
dmEgd3JvdGU6Cj4gSW4gcHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhy
b3VnaCwgbWFyayBzd2l0Y2gKPiBjYXNlcyB3aGVyZSB3ZSBhcmUgZXhwZWN0aW5nIHRvIGZhbGwg
dGhyb3VnaC4KPiAKPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZ3M6Cj4g
Cj4gZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstczNjMjQ0My5jOiBJbiBmdW5jdGlvbiDigJhzM2My
NDQzX2NvbW1vbl9jbGtfaW5pdOKAmToKPiBkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1zM2MyNDQz
LmM6MzkwOjM6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1w
bGljaXQtZmFsbHRocm91Z2g9XQo+ICAgIHNhbXN1bmdfY2xrX3JlZ2lzdGVyX2FsaWFzKGN0eCwg
czNjMjQ1MF9hbGlhc2VzLAo+ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fgo+ICAgICAgQVJSQVlfU0laRShzM2MyNDUwX2FsaWFzZXMpKTsKPiAgICAg
IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiBkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1z
M2MyNDQzLmM6MzkzOjI6IG5vdGU6IGhlcmUKPiAgIGNhc2UgUzNDMjQxNjoKPiAgIF5+fn4KPiAK
PiBXYXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9Mwo+IAo+
IE5vdGljZSB0aGF0LCBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgIHRoZSBjb2RlIGNvbW1lbnQg
aXMgbW9kaWZpZWQKPiBpbiBhY2NvcmRhbmNlIHdpdGggd2hhdCBHQ0MgaXMgZXhwZWN0aW5nIHRv
IGZpbmQuCj4gCj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8g
ZW5hYmxlCj4gLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4KCkV4Y2VwdCBmb3IgbGV2ZWwgNSBvZiAt
V2ltcGxpY2l0LWZhbGx0aHJvdWdoLApsZXZlbCA0IGlzIG1vcmUgc3RyaWN0IHRvIHNob3cgdGhl
IHdhcm5pbmdzLgpXaHkgZG9uJ3QgeW91IHN1cHBvcnQgbGV2ZWwgNCBmb3IgLVdpbXBsaWNpdC1m
YWxsdGhyb3VnaD8KSSB0aGluayB0aGF0IHlvdSB3YW50IHRvIGZpeCBmb3IgLVdpbXBsaWNpdC1m
YWxsdGhyb3VnaCB3YXJuaW5nLAp5b3UgYmV0dGVyIHRvIHN1cHBvcnQgbGV2ZWwgNC4gV2hhdCBk
byB5b3UgdGhpbms/CgoKPiAKPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxn
dXN0YXZvQGVtYmVkZGVkb3IuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1z
M2MyNDQzLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1zM2MyNDQz
LmMgYi9kcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1zM2MyNDQzLmMKPiBpbmRleCA4ODQwNjdlNGYx
YTEuLmYzOGYwZTI0ZTNiNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1z
M2MyNDQzLmMKPiArKysgYi9kcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1zM2MyNDQzLmMKPiBAQCAt
Mzg5LDcgKzM4OSw3IEBAIHZvaWQgX19pbml0IHMzYzI0NDNfY29tbW9uX2Nsa19pbml0KHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnAsIHVuc2lnbmVkIGxvbmcgeHRpX2YsCj4gIAkJCQlBUlJBWV9TSVpF
KHMzYzI0NTBfZ2F0ZXMpKTsKPiAgCQlzYW1zdW5nX2Nsa19yZWdpc3Rlcl9hbGlhcyhjdHgsIHMz
YzI0NTBfYWxpYXNlcywKPiAgCQkJCUFSUkFZX1NJWkUoczNjMjQ1MF9hbGlhc2VzKSk7Cj4gLQkJ
LyogZmFsbCB0aHJvdWdoLCBhcyBzM2MyNDUwIGV4dGVuZHMgdGhlIHMzYzI0MTYgY2xvY2tzICov
Cj4gKwkJLyogZmFsbCB0aHJvdWdoIC0gYXMgczNjMjQ1MCBleHRlbmRzIHRoZSBzM2MyNDE2IGNs
b2NrcyAqLwo+ICAJY2FzZSBTM0MyNDE2Ogo+ICAJCXNhbXN1bmdfY2xrX3JlZ2lzdGVyX2Rpdihj
dHgsIHMzYzI0MTZfZGl2aWRlcnMsCj4gIAkJCQlBUlJBWV9TSVpFKHMzYzI0MTZfZGl2aWRlcnMp
KTsKPiAKCgotLSAKQmVzdCBSZWdhcmRzLApDaGFud29vIENob2kKU2Ftc3VuZyBFbGVjdHJvbmlj
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
