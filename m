Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5743AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:49:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E74218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DCVOV/64";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Azk0MaUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E74218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6lOdzu0inlyXBxJau47IkC2yO4DpABY1ndvRwwQxrVU=; b=DCVOV/643TT7ID
	UWDztjhd/iYhfx+eiRbHms29jjrbSSGPubfEFt6Sl5gFdSnHjeHRUPXAXTl1uH2kLcS7UsLL9EGlk
	cxvQ7zccwAxhFKePE2piwWDna/qs4trOm54XEs8aZ8G6j1Mpjo1679ttiwGwfnQRoHiMWnqrnCWbO
	98wmscoXfZhkXwdH+6nsCqgVFGBMB4m8AEcziq2cs1/yyRVeRKJqJWLb2z+9bRfgBe42c0LRsiN9/
	duJF870seyMQRVbCbdGG4DZe6KzTpujLjmIl95XfX4dMUfagKbZY8hSvqz5+YkqAhWtFYKxOxTlXV
	ild0YEiyVJOaFoPhMKYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZCG-00086X-PL; Fri, 01 Feb 2019 13:49:32 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZCD-000868-D5
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 13:49:31 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190201134927euoutp028afc8020c8fd1b41233b72deb40f5198~-QaN-qBvF1908019080euoutp02S
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 13:49:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190201134927euoutp028afc8020c8fd1b41233b72deb40f5198~-QaN-qBvF1908019080euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549028967;
 bh=H98rDEzx0AhtIfssu+nCtmOZWdCn3y+4HBIFZLZdDeI=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Azk0MaUUz3rVQPBuO00l4Vy24LgpKVg7lwyRdmxHGDH3S1lVWM4ChnT11hqmL3G8e
 6sz/3Yy7SDRgDYZMtiDtcOM98jrGqa2xoudb24lK+z9ZjXZgCMTQOlTYUvPvFyVd1I
 3KtWX7bZ2NxM1fJuMPRNjY6n5PoTMaUlVwyWVsjE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190201134926eucas1p1d48bbbc3e1aa5391a71edd8c614ffdce~-QaNUhzWL0772007720eucas1p1t;
 Fri,  1 Feb 2019 13:49:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 63.9A.04294.66E445C5; Fri,  1
 Feb 2019 13:49:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190201134925eucas1p19a5a9243ee9ccd7983393ffa7e444d4a~-QaMWOPJQ0752107521eucas1p1t;
 Fri,  1 Feb 2019 13:49:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190201134925eusmtrp2f5ac3ada610ca9d8346471dd1ba1c4d4~-QaMG_oyc2522025220eusmtrp26;
 Fri,  1 Feb 2019 13:49:25 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-7d-5c544e663c74
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.2E.04128.56E445C5; Fri,  1
 Feb 2019 13:49:25 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190201134924eusmtip15d7dd71b7980fb6d87f753cb48dfe7fb~-QaLcDoX_2156221562eusmtip1b;
 Fri,  1 Feb 2019 13:49:24 +0000 (GMT)
Subject: Re: [PATCH v3 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To: Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <66b886d3-37af-dc54-9dd8-c56977709e2a@partner.samsung.com>
Date: Fri, 1 Feb 2019 14:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d6124295-cb72-0d5f-f887-438698cf48e1@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7ppfiExBjc/iVhsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
 uN24gs2ide8RdovDb9pZHfg91sxbw+ixaVUnm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqk
 b5fAlbH+1gOWgvuCFUeP6DcwnuHrYuTkkBAwkXj5dxVzFyMXh5DACkaJm7veskI4Xxgl+hZs
 YYNwPjNKXJ12jQmmZdGr11Atyxklvj/6xQ7hvGWUWLZsMSNIlbBAuMSxD/MZQRIiAosZJaau
 /A3Wziwwk0mi801ZFyMHB5uAnsSOVYUgYV4BN4k9016wgNgsAioS82/3gpWLCkRIHO59xwhR
 IyhxcuYTsBpOAXuJK1O3sUOMFJe49WQ+1Hh5ieats8GukxB4yy7x4sQOZoizXSTetb1hg7CF
 JV4d38IOYctI/N85H+q1YomzHaugamok2k/ugKqxljh8/CIryM3MApoS63fpQ4QdJd68vMgE
 EpYQ4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKo1JLb0XIBaJCaxfM009gmMSrOQPDYLyTOzkDwz
 C2HvAkaWVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHp7PS/4192MO76k3SIUYCDUYmH
 d8OvoBgh1sSy4srcQ4wSHMxKIrwrXEJihHhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJI
 TyxJzU5NLUgtgskycXBKNTDO6WfOLjlvZz3lUF1087b877rxaWuV725h0vwo6iP3+jf/Y0nz
 lPqSXT+9DVT3rNj2aXOCuWmcWMOUVypG6paii17W2X42n2fPIRf9766SzYmWPRIfdxdo5S17
 NXfWvF2bb78MDl3Y4r/sXG241pPy27+LXT8Fa7vb6kTLsndN3FIfaZzLd0aJpTgj0VCLuag4
 EQCwhy+QYwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7qpfiExBmvXcltsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
 uN24gs2ide8RdovDb9pZHfg91sxbw+ixaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCR
 X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7H+1gOWgvuCFUeP6Dcw
 nuHrYuTkkBAwkVj06jVzFyMXh5DAUkaJzlvTGSESYhKT9m1nh7CFJf5c62KDKHrNKLF+zntW
 kISwQLjEsQ/zwRpEBBYzSnxtrQYpYhaYySTxa9VqqLFTmCS+nwFp5+BgE9CT2LGqEKSBV8BN
 Ys+0FywgNouAisT8271MILaoQITEx6f7mCBqBCVOznwCVsMpYC9xZeo2sIuYBcwk5m1+yAxh
 i0vcejKfCcKWl2jeOpt5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6
 yfm5mxiBMbzt2M8tOxi73gUfYhTgYFTi4d3wKyhGiDWxrLgy9xCjBAezkgjvCpeQGCHelMTK
 qtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aXvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZ
 qakFqUUwfUwcnFINjCZz5TfNT+NxWVnjcWiRSsq5U+86pjrOvqMdl5zGWpPq0pBn/lBZ359H
 Om6r+qvAHmmDRTplD3avXPxnr1CL4uKPZlKWqQcFF6eXyAt+5Jg0f0nyQXe1xMIr6lM3MAdu
 +CK6UHexsuS2yFvvJ7Y07nm4YsGHnrK3Rn4nZ3655FthPD+Vo6YlQomlOCPRUIu5qDgRAHjw
 OeP3AgAA
X-CMS-MailID: 20190201134925eucas1p19a5a9243ee9ccd7983393ffa7e444d4a
X-Msg-Generator: CA
X-RootMTR: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7@eucas1p2.samsung.com>
 <1548924594-19084-2-git-send-email-l.luba@partner.samsung.com>
 <d6124295-cb72-0d5f-f887-438698cf48e1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_054929_748445_18118EEB 
X-CRM114-Status: GOOD (  17.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, b.zolnierkie@samsung.com,
 krzk@kernel.org, Rob Herring <robh+dt@kernel.org>, kyungmin.park@samsung.com,
 kgene@kernel.org, myungjoo.ham@samsung.com, s.nawrocki@samsung.com,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQ2hhbndvbywKCk9uIDIvMS8xOSA4OjQwIEFNLCBDaGFud29vIENob2kgd3JvdGU6Cj4gSGks
Cj4gCj4gT24gMTkuIDEuIDMxLiDsmKTtm4QgNTo0OSwgTHVrYXN6IEx1YmEgd3JvdGU6Cj4+IERl
ZmluZSBuZXcgSURzIGZvciBjbG9ja3MgdXNlZCBieSBEeW5hbWljIE1lbW9yeSBDb250cm9sbGVy
IGluCj4+IEV4eW5vczU0MjIgU29DLgo+Pgo+PiBDQzogU3lsd2VzdGVyIE5hd3JvY2tpIDxzLm5h
d3JvY2tpQHNhbXN1bmcuY29tPgo+PiBDQzogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3Vu
Zy5jb20+Cj4+IENDOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPgo+PiBDQzogTWFy
ayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4KPj4gQ0M6IEt1a2ppbiBLaW0gPGtnZW5l
QGtlcm5lbC5vcmc+Cj4+IENDOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+
Cj4+IENDOiBsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5vcmcKPj4gQ0M6IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnCj4+IENDOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKPj4gQ0M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPj4gU2lnbmVkLW9mZi1i
eTogTHVrYXN6IEx1YmEgPGwubHViYUBwYXJ0bmVyLnNhbXN1bmcuY29tPgo+PiAtLS0KPj4gICBp
bmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2V4eW5vczU0MjAuaCB8IDE4ICsrKysrKysrKysrKysr
KysrLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2V4eW5vczU0MjAu
aCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5bm9zNTQyMC5oCj4+IGluZGV4IDM1NWY0
NjkuLjE4MjdhNjQgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5
bm9zNTQyMC5oCj4+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5bm9zNTQyMC5o
Cj4+IEBAIC02MCw2ICs2MCw3IEBACj4+ICAgI2RlZmluZSBDTEtfTUFVX0VQTEwJCTE1OQo+PiAg
ICNkZWZpbmUgQ0xLX1NDTEtfSFNJQ18xMk0JMTYwCj4+ICAgI2RlZmluZSBDTEtfU0NMS19NUEhZ
X0lYVEFMMjQJMTYxCj4+ICsjZGVmaW5lIENMS19TQ0xLX0JQTEwJCTE2Mgo+PiAgIAo+PiAgIC8q
IGdhdGUgY2xvY2tzICovCj4+ICAgI2RlZmluZSBDTEtfVUFSVDAJCTI1Nwo+PiBAQCAtMTk1LDYg
KzE5NiwxNiBAQAo+PiAgICNkZWZpbmUgQ0xLX0FDTEs0MzJfQ0FNCQk1MTgKPj4gICAjZGVmaW5l
IENMS19BQ0xLX0ZMMTU1MF9DQU0JNTE5Cj4+ICAgI2RlZmluZSBDTEtfQUNMSzU1MF9DQU0JCTUy
MAo+PiArI2RlZmluZSBDTEtfQ0xLTV9QSFkwCQk1MjEKPj4gKyNkZWZpbmUgQ0xLX0NMS01fUEhZ
MQkJNTIyCj4+ICsjZGVmaW5lIENMS19BQ0xLX1BQTVVfRFJFWDBfMAk1MjMKPj4gKyNkZWZpbmUg
Q0xLX0FDTEtfUFBNVV9EUkVYMF8xCTUyNAo+PiArI2RlZmluZSBDTEtfQUNMS19QUE1VX0RSRVgx
XzAJNTI1Cj4+ICsjZGVmaW5lIENMS19BQ0xLX1BQTVVfRFJFWDFfMQk1MjYKPj4gKyNkZWZpbmUg
Q0xLX1BDTEtfUFBNVV9EUkVYMF8wCTUyNwo+PiArI2RlZmluZSBDTEtfUENMS19QUE1VX0RSRVgw
XzEJNTI4Cj4+ICsjZGVmaW5lIENMS19QQ0xLX1BQTVVfRFJFWDFfMAk1MjkKPj4gKyNkZWZpbmUg
Q0xLX1BDTEtfUFBNVV9EUkVYMV8xCTUzMAo+PiAgIAo+PiAgIC8qIG11eCBjbG9ja3MgKi8KPj4g
ICAjZGVmaW5lIENMS19NT1VUX0hETUkJCTY0MAo+PiBAQCAtMjE3LDYgKzIyOCwxMCBAQAo+PiAg
ICNkZWZpbmUgQ0xLX01PVVRfRVBMTAkJNjU3Cj4+ICAgI2RlZmluZSBDTEtfTU9VVF9NQVVfRVBM
TAk2NTgKPj4gICAjZGVmaW5lIENMS19NT1VUX1VTRVJfTUFVX0VQTEwJNjU5Cj4+ICsjZGVmaW5l
IENMS19NT1VUX0RQTEwJCTY2MAo+PiArI2RlZmluZSBDTEtfTU9VVF9BQ0xLX0czRAk2NjEKPiAK
PiBUaGUgc2Vjb25kIHBhdGNoIGRvbid0IGltcGxlbWVudCBzb21lIGNsb2Nrcwo+IGZvciBDTEtf
TU9VVF9EUExMLCBDTEtfTU9VVF9BQ0xLX0czRC4KPiAKPiBXaHkgZG8geW91IGRlZmluZSB0aGVt
PwpZb3UgYXJlIHJpZ2h0LCBpdCBpcyBhIG1pc3Rha2UuCkkgd2lsbCByZW1vdmUgaXQgaW4gdjIu
CgpSZWdhcmRzLApMdWthc3oKPiAKPiAoc25pcCkKPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
