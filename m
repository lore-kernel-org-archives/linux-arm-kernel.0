Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C1FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EE72147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VdeGFR6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EE72147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rWTYDq79FANVSYWPRuH6rRB0TaPH+8QnWyVq0IDbZTI=; b=VdeGFR6DinF/21
	9bh3Hp27zgh4hbubo+8vZvlJYBw/uuzX6SgjMYX6qTS/dDvvN0jL8Vsbdno/8Z9OYtxFPwBs9cnuK
	g8L+Qj2VXjFelZcNWs6dEPHo2g7enOwKnQsioPhq2kjOeGivwfj2PKVGzadP2jKR7pkXo6lPZ2eex
	CRg130w6gtgQxuwahZtF54uSWOot587E6ExxYJygCFrb6oUMRUFiyaHgzHWt6+y4RRksLRNFe88L7
	wR5zciGD03a9kpAKt0tOBStNT4wqvZkunBW7sKykFSrM6+pxiib66OB9QFSRuspPO8khIzG1vtT8x
	m0JrOwpXJVeWX+aPt6rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guOhc-0001nd-3G; Thu, 14 Feb 2019 21:37:52 +0000
Received: from gateway36.websitewelcome.com ([192.185.197.22])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guOhH-0001T2-0r
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 21:37:51 +0000
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway36.websitewelcome.com (Postfix) with ESMTP id EBAD7400DE6D1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 14:51:44 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id uOhEgWrVM2PzOuOhEg1320; Thu, 14 Feb 2019 15:37:28 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=41338 helo=[192.168.1.76])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1guOhE-000wD0-6l; Thu, 14 Feb 2019 15:37:28 -0600
Subject: Re: [PATCH] can: mark expected switch fall-throughs
To: Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de,
 davem@davemloft.net, alexandre.belloni@bootlin.com,
 Ludovic.Desroches@microchip.com
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 mQINBFssHAwBEADIy3ZoPq3z5UpsUknd2v+IQud4TMJnJLTeXgTf4biSDSrXn73JQgsISBwG
 2Pm4wnOyEgYUyJd5tRWcIbsURAgei918mck3tugT7AQiTUN3/5aAzqe/4ApDUC+uWNkpNnSV
 tjOx1hBpla0ifywy4bvFobwSh5/I3qohxDx+c1obd8Bp/B/iaOtnq0inli/8rlvKO9hp6Z4e
 DXL3PlD0QsLSc27AkwzLEc/D3ZaqBq7ItvT9Pyg0z3Q+2dtLF00f9+663HVC2EUgP25J3xDd
 496SIeYDTkEgbJ7WYR0HYm9uirSET3lDqOVh1xPqoy+U9zTtuA9NQHVGk+hPcoazSqEtLGBk
 YE2mm2wzX5q2uoyptseSNceJ+HE9L+z1KlWW63HhddgtRGhbP8pj42bKaUSrrfDUsicfeJf6
 m1iJRu0SXYVlMruGUB1PvZQ3O7TsVfAGCv85pFipdgk8KQnlRFkYhUjLft0u7CL1rDGZWDDr
 NaNj54q2CX9zuSxBn9XDXvGKyzKEZ4NY1Jfw+TAMPCp4buawuOsjONi2X0DfivFY+ZsjAIcx
 qQMglPtKk/wBs7q2lvJ+pHpgvLhLZyGqzAvKM1sVtRJ5j+ARKA0w4pYs5a5ufqcfT7dN6TBk
 LXZeD9xlVic93Ju08JSUx2ozlcfxq+BVNyA+dtv7elXUZ2DrYwARAQABtCxHdXN0YXZvIEEu
 IFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPokCPQQTAQgAJwUCWywcDAIbIwUJ
 CWYBgAULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRBHBbTLRwbbMZ6tEACk0hmmZ2FWL1Xi
 l/bPqDGFhzzexrdkXSfTTZjBV3a+4hIOe+jl6Rci/CvRicNW4H9yJHKBrqwwWm9fvKqOBAg9
 obq753jydVmLwlXO7xjcfyfcMWyx9QdYLERTeQfDAfRqxir3xMeOiZwgQ6dzX3JjOXs6jHBP
 cgry90aWbaMpQRRhaAKeAS14EEe9TSIly5JepaHoVdASuxklvOC0VB0OwNblVSR2S5i5hSsh
 ewbOJtwSlonsYEj4EW1noQNSxnN/vKuvUNegMe+LTtnbbocFQ7dGMsT3kbYNIyIsp42B5eCu
 JXnyKLih7rSGBtPgJ540CjoPBkw2mCfhj2p5fElRJn1tcX2McsjzLFY5jK9RYFDavez5w3lx
 JFgFkla6sQHcrxH62gTkb9sUtNfXKucAfjjCMJ0iuQIHRbMYCa9v2YEymc0k0RvYr43GkA3N
 PJYd/vf9vU7VtZXaY4a/dz1d9dwIpyQARFQpSyvt++R74S78eY/+lX8wEznQdmRQ27kq7BJS
 R20KI/8knhUNUJR3epJu2YFT/JwHbRYC4BoIqWl+uNvDf+lUlI/D1wP+lCBSGr2LTkQRoU8U
 64iK28BmjJh2K3WHmInC1hbUucWT7Swz/+6+FCuHzap/cjuzRN04Z3Fdj084oeUNpP6+b9yW
 e5YnLxF8ctRAp7K4yVlvA7kCDQRbLBwMARAAsHCE31Ffrm6uig1BQplxMV8WnRBiZqbbsVJB
 H1AAh8tq2ULl7udfQo1bsPLGGQboJSVN9rckQQNahvHAIK8ZGfU4Qj8+CER+fYPp/MDZj+t0
 DbnWSOrG7z9HIZo6PR9z4JZza3Hn/35jFggaqBtuydHwwBANZ7A6DVY+W0COEU4of7CAahQo
 5NwYiwS0lGisLTqks5R0Vh+QpvDVfuaF6I8LUgQR/cSgLkR//V1uCEQYzhsoiJ3zc1HSRyOP
 otJTApqGBq80X0aCVj1LOiOF4rrdvQnj6iIlXQssdb+WhSYHeuJj1wD0ZlC7ds5zovXh+FfF
 l5qH5RFY/qVn3mNIVxeO987WSF0jh+T5ZlvUNdhedGndRmwFTxq2Li6GNMaolgnpO/CPcFpD
 jKxY/HBUSmaE9rNdAa1fCd4RsKLlhXda+IWpJZMHlmIKY8dlUybP+2qDzP2lY7kdFgPZRU+e
 zS/pzC/YTzAvCWM3tDgwoSl17vnZCr8wn2/1rKkcLvTDgiJLPCevqpTb6KFtZosQ02EGMuHQ
 I6Zk91jbx96nrdsSdBLGH3hbvLvjZm3C+fNlVb9uvWbdznObqcJxSH3SGOZ7kCHuVmXUcqoz
 ol6ioMHMb+InrHPP16aVDTBTPEGwgxXI38f7SUEn+NpbizWdLNz2hc907DvoPm6HEGCanpcA
 EQEAAYkCJQQYAQgADwUCWywcDAIbDAUJCWYBgAAKCRBHBbTLRwbbMdsZEACUjmsJx2CAY+QS
 UMebQRFjKavwXB/xE7fTt2ahuhHT8qQ/lWuRQedg4baInw9nhoPE+VenOzhGeGlsJ0Ys52sd
 XvUjUocKgUQq6ekOHbcw919nO5L9J2ejMf/VC/quN3r3xijgRtmuuwZjmmi8ct24TpGeoBK4
 WrZGh/1hAYw4ieARvKvgjXRstcEqM5thUNkOOIheud/VpY+48QcccPKbngy//zNJWKbRbeVn
 imua0OpqRXhCrEVm/xomeOvl1WK1BVO7z8DjSdEBGzbV76sPDJb/fw+y+VWrkEiddD/9CSfg
 fBNOb1p1jVnT2mFgGneIWbU0zdDGhleI9UoQTr0e0b/7TU+Jo6TqwosP9nbk5hXw6uR5k5PF
 8ieyHVq3qatJ9K1jPkBr8YWtI5uNwJJjTKIA1jHlj8McROroxMdI6qZ/wZ1ImuylpJuJwCDC
 ORYf5kW61fcrHEDlIvGc371OOvw6ejF8ksX5+L2zwh43l/pKkSVGFpxtMV6d6J3eqwTafL86
 YJWH93PN+ZUh6i6Rd2U/i8jH5WvzR57UeWxE4P8bQc0hNGrUsHQH6bpHV2lbuhDdqo+cM9eh
 GZEO3+gCDFmKrjspZjkJbB5Gadzvts5fcWGOXEvuT8uQSvl+vEL0g6vczsyPBtqoBLa9SNrS
 VtSixD1uOgytAP7RWS474w==
Message-ID: <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
Date: Thu, 14 Feb 2019 15:37:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1guOhE-000wD0-6l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.20]:41338
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_133731_781748_52F943B0 
X-CRM114-Status: GOOD (  14.89  )
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxLzMwLzE5IDI6MTEgQU0sIE5pY29sYXMuRmVycmVAbWljcm9jaGlwLmNvbSB3cm90ZToK
PiBPbiAyOS8wMS8yMDE5IGF0IDE5OjA2LCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOgo+PiBJ
biBwcmVwYXJhdGlvbiB0byBlbmFibGluZyAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoLCBtYXJrIHN3
aXRjaCBjYXNlcwo+PiB3aGVyZSB3ZSBhcmUgZXhwZWN0aW5nIHRvIGZhbGwgdGhyb3VnaC4KPj4K
Pj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOgo+Pgo+PiBkcml2ZXJz
L25ldC9jYW4vcGVha19jYW5mZC9wZWFrX3BjaWVmZF9tYWluLmM6NjY4OjM6IHdhcm5pbmc6IHRo
aXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQo+
PiBkcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXguYzo4NzU6Nzogd2FybmluZzogdGhpcyBzdGF0
ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4+IGRyaXZl
cnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYzo0MjI6Njogd2FybmluZzogdGhpcyBz
dGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCj4+IGRy
aXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jOjg5NTo2OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBt
YXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0KPj4gZHJpdmVycy9uZXQv
Y2FuL2F0OTFfY2FuLmM6OTUzOjE1OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0
aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0KPj4gZHJpdmVycy9uZXQvY2FuL3VzYi9w
ZWFrX3VzYi9wY2FuX3VzYi5jOiBJbiBmdW5jdGlvbiDigJhwY2FuX3VzYl9kZWNvZGVfZXJyb3Li
gJk6Cj4+IGRyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYzo0MjI6Njogd2Fy
bmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhy
b3VnaD1dCj4+ICAgICBpZiAobiAmIFBDQU5fVVNCX0VSUk9SX0JVU19MSUdIVCkgewo+PiAgICAg
ICAgXgo+PiBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmM6NDI4OjI6IG5v
dGU6IGhlcmUKPj4gICAgY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoKPj4gICAgXn5+fgo+
Pgo+PiBXYXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9Mwo+
Pgo+PiBUaGlzIHBhdGNoIGlzIHBhcnQgb2YgdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGlu
Zwo+PiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoLgo+Pgo+PiBOb3RpY2UgdGhhdCBpbiBzb21lIGNh
c2VzIHNwZWxsaW5nIG1pc3Rha2VzIHdlcmUgZml4ZWQuCj4+IEluIG90aGVyIGNhc2VzLCB0aGUg
LyogZmFsbCB0aHJvdWdoICovIGNvbW1lbnQgaXMgcGxhY2VkCj4+IGF0IHRoZSBib3R0b20gb2Yg
dGhlIGNhc2Ugc3RhdGVtZW50LCB3aGljaCBpcyB3aGF0IEdDQwo+PiBpcyBleHBlY3RpbmcgdG8g
ZmluZC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0Bl
bWJlZGRlZG9yLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmMgICAg
ICAgICAgICAgICAgICAgIHwgNiArKysrLS0KPiAKPiBGb3IgdGhpcyBvbmU6Cj4gQWNrZWQtYnk6
IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4KPiAKClRoYW5rcywg
Tmljb2xhcy4KCkRhdmU6CgpJIHdvbmRlciBpZiB5b3UgY2FuIHRha2UgdGhpcyBwYXRjaC4KClRo
YW5rcwotLQpHdXN0YXZvCgo+PiAgIGRyaXZlcnMvbmV0L2Nhbi9wZWFrX2NhbmZkL3BlYWtfcGNp
ZWZkX21haW4uYyB8IDIgKy0KPj4gICBkcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXguYyAgICAg
ICAgICAgICAgICAgfCAzICsrLQo+PiAgIGRyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNh
bl91c2IuYyAgICAgICB8IDIgKy0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9hdDkx
X2Nhbi5jIGIvZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmMKPj4gaW5kZXggZDk4YzY5MDQ1YjE3
Li4xNzE4YzIwZjljOTkgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5j
Cj4+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9hdDkxX2Nhbi5jCj4+IEBAIC05MDIsNyArOTAyLDgg
QEAgc3RhdGljIHZvaWQgYXQ5MV9pcnFfZXJyX3N0YXRlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
Cj4+ICAgCQkJCUNBTl9FUlJfQ1JUTF9UWF9XQVJOSU5HIDoKPj4gICAJCQkJQ0FOX0VSUl9DUlRM
X1JYX1dBUk5JTkc7Cj4+ICAgCQl9Cj4+IC0JY2FzZSBDQU5fU1RBVEVfRVJST1JfV0FSTklORzoJ
LyogZmFsbHRocm91Z2ggKi8KPj4gKwkJLyogZmFsbCB0aHJvdWdoICovCj4+ICsJY2FzZSBDQU5f
U1RBVEVfRVJST1JfV0FSTklORzoKPj4gICAJCS8qCj4+ICAgCQkgKiBmcm9tOiBFUlJPUl9BQ1RJ
VkUsIEVSUk9SX1dBUk5JTkcKPj4gICAJCSAqIHRvICA6IEVSUk9SX1BBU1NJVkUsIEJVU19PRkYK
Pj4gQEAgLTk1MSw3ICs5NTIsOCBAQCBzdGF0aWMgdm9pZCBhdDkxX2lycV9lcnJfc3RhdGUoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPj4gICAJCW5ldGRldl9kYmcoZGV2LCAiRXJyb3IgQWN0aXZl
XG4iKTsKPj4gICAJCWNmLT5jYW5faWQgfD0gQ0FOX0VSUl9QUk9UOwo+PiAgIAkJY2YtPmRhdGFb
Ml0gPSBDQU5fRVJSX1BST1RfQUNUSVZFOwo+PiAtCWNhc2UgQ0FOX1NUQVRFX0VSUk9SX1dBUk5J
Tkc6CS8qIGZhbGx0aHJvdWdoICovCj4+ICsJCS8qIGZhbGwgdGhyb3VnaCAqLwo+PiArCWNhc2Ug
Q0FOX1NUQVRFX0VSUk9SX1dBUk5JTkc6Cj4+ICAgCQlyZWdfaWRyID0gQVQ5MV9JUlFfRVJSQSB8
IEFUOTFfSVJRX1dBUk4gfCBBVDkxX0lSUV9CT0ZGOwo+PiAgIAkJcmVnX2llciA9IEFUOTFfSVJR
X0VSUlA7Cj4+ICAgCQlicmVhazsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9wZWFr
X2NhbmZkL3BlYWtfcGNpZWZkX21haW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9wZWFrX2NhbmZkL3Bl
YWtfcGNpZWZkX21haW4uYwo+PiBpbmRleCBjNDU4ZDVmZGM4ZDMuLmU0ZjRkNjVhNzZiNCAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3BlYWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5j
Cj4+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9wZWFrX2NhbmZkL3BlYWtfcGNpZWZkX21haW4uYwo+
PiBAQCAtNjY4LDcgKzY2OCw3IEBAIHN0YXRpYyBpbnQgcGNpZWZkX2Nhbl9wcm9iZShzdHJ1Y3Qg
cGNpZWZkX2JvYXJkICpwY2llZmQpCj4+ICAgCQlwY2llZmRfY2FuX3dyaXRlcmVnKHByaXYsIENB
TkZEX0NMS19TRUxfODBNSFosCj4+ICAgCQkJCSAgICBQQ0lFRkRfUkVHX0NBTl9DTEtfU0VMKTsK
Pj4gICAKPj4gLQkJLyogZmFsbHRob3VnaCAqLwo+PiArCQkvKiBmYWxsIHRocm91Z2ggKi8KPj4g
ICAJY2FzZSBDQU5GRF9DTEtfU0VMXzgwTUhaOgo+PiAgIAkJcHJpdi0+dWNhbi5jYW4uY2xvY2su
ZnJlcSA9IDgwICogMTAwMCAqIDEwMDA7Cj4+ICAgCQlicmVhazsKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeC5jIGIvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4
LmMKPj4gaW5kZXggZTkwODE3NjA4NjQ1Li4xNzI1N2M3M2MzMDIgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeC5jCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9zcGkv
bWNwMjUxeC5jCj4+IEBAIC04NzUsNyArODc1LDggQEAgc3RhdGljIGlycXJldHVybl90IG1jcDI1
MXhfY2FuX2lzdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpCj4+ICAgCQkJaWYgKG5ld19zdGF0ZSA+
PSBDQU5fU1RBVEVfRVJST1JfV0FSTklORyAmJgo+PiAgIAkJCSAgICBuZXdfc3RhdGUgPD0gQ0FO
X1NUQVRFX0JVU19PRkYpCj4+ICAgCQkJCXByaXYtPmNhbi5jYW5fc3RhdHMuZXJyb3Jfd2Fybmlu
ZysrOwo+PiAtCQljYXNlIENBTl9TVEFURV9FUlJPUl9XQVJOSU5HOgkvKiBmYWxsdGhyb3VnaCAq
Lwo+PiArCQkJLyogZmFsbCB0aHJvdWdoICovCj4+ICsJCWNhc2UgQ0FOX1NUQVRFX0VSUk9SX1dB
Uk5JTkc6Cj4+ICAgCQkJaWYgKG5ld19zdGF0ZSA+PSBDQU5fU1RBVEVfRVJST1JfUEFTU0lWRSAm
Jgo+PiAgIAkJCSAgICBuZXdfc3RhdGUgPD0gQ0FOX1NUQVRFX0JVU19PRkYpCj4+ICAgCQkJCXBy
aXYtPmNhbi5jYW5fc3RhdHMuZXJyb3JfcGFzc2l2ZSsrOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYi5jIGIvZHJpdmVycy9uZXQvY2FuL3VzYi9w
ZWFrX3VzYi9wY2FuX3VzYi5jCj4+IGluZGV4IDEzMjM4YTcyYTMzOC4uZWNhNzg1NTMyYjZiIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiLmMKPj4g
KysrIGIvZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYi5jCj4+IEBAIC00MjMs
NyArNDIzLDcgQEAgc3RhdGljIGludCBwY2FuX3VzYl9kZWNvZGVfZXJyb3Ioc3RydWN0IHBjYW5f
dXNiX21zZ19jb250ZXh0ICptYywgdTggbiwKPj4gICAJCQluZXdfc3RhdGUgPSBDQU5fU1RBVEVf
RVJST1JfV0FSTklORzsKPj4gICAJCQlicmVhazsKPj4gICAJCX0KPj4gLQkJLyogZWxzZTogZmFs
bCB0aHJvdWdoICovCj4+ICsJCS8qIGZhbGwgdGhyb3VnaCAqLwo+PiAgIAo+PiAgIAljYXNlIENB
Tl9TVEFURV9FUlJPUl9XQVJOSU5HOgo+PiAgIAkJaWYgKG4gJiBQQ0FOX1VTQl9FUlJPUl9CVVNf
SEVBVlkpIHsKPj4KPiAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
