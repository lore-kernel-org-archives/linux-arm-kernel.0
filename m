Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB17C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:34:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4CE2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ow0ar2Lr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FfOWG/Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4CE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/xCcV/zvbdP/RJfpkFmX4wa1M+o4PDMH2V5vElhYepU=; b=ow0ar2LrEEkEIF
	p3rtAwxnQri5EvrGR5HXynKRfE+8YZZGgeoyM7zgph6IxMxaAjuYM7TIQATc/MogDJSjjXxXuaBvF
	QMd58gySV/oXTxxIzit3xm0rbl/N3HrVGPqpHeXW2ASN6gZ2zkMghOgbpPJZSdBoONDmuk29hIxPh
	oZrRGbG5rxWI2ktmIjfP08bh3s94So/kFGu11D40d+XEv6la41+HifO4ut90JK+NoSq9wShIcuMXD
	50qluD6jkzNNyRUc2Ejt4k3xcXG0vfMyrIEslWFO1LqRw1TpddjA4KopHXIFOZz7BD0+56vpTR6Bf
	JqwFXvRx8r0mi+SaL6mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVE5-0001kh-Te; Fri, 18 Jan 2019 14:34:29 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVE2-0001kL-42
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:34:28 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190118143423euoutp010dfb95c1c98db8b6dae3a2fe571fb577~69-c7wjph2756627566euoutp01_
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 14:34:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190118143423euoutp010dfb95c1c98db8b6dae3a2fe571fb577~69-c7wjph2756627566euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1547822063;
 bh=ufuwoIbKl1Zxgc5EsIyyv/AgH9b8Mu7sFow8Lo+Gq9A=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=FfOWG/BwnmXGo9jgwJQSYVck4Xh9bAfzUigpfi2DHoZlBkyNsNXVlhLp5vhaQMtnG
 Hzn2j6zInNz2aJQW3ea/Y+LnGMyqRQkFfrOPy91Zw9me4WyKwK1JbCkLebGTtaUOSH
 9QlX/OCEQhRXXEQHpBVdzw+LeCFrbvBYmsuzNRTo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190118143422eucas1p20562d2f7d8129e2d74907fd11393613e~69-b1x2ks0222302223eucas1p2h;
 Fri, 18 Jan 2019 14:34:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id DC.E9.04806.DE3E14C5; Fri, 18
 Jan 2019 14:34:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190118143420eucas1p11495282b806a7ca85bdbafaec46ac3b4~69-awO-_m3080730807eucas1p1Q;
 Fri, 18 Jan 2019 14:34:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190118143420eusmtrp2085312f9013703813b4e5d470cd16879~69-auNGlc1571915719eusmtrp2-;
 Fri, 18 Jan 2019 14:34:20 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-7a-5c41e3ed609f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.79.04284.CE3E14C5; Fri, 18
 Jan 2019 14:34:20 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190118143420eusmtip1c2d65852a9c8f718e8d46eeb0340fe09~69-aAE6gl1082410824eusmtip1T;
 Fri, 18 Jan 2019 14:34:20 +0000 (GMT)
Subject: Re: [PATCH 1/6] include/drm: color_mgmt: Add enum labels
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Christoph Manszewski <c.manszewski@samsung.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b9cfbae1-b24e-96bf-f3b0-ff6d25cd16bb@samsung.com>
Date: Fri, 18 Jan 2019 15:34:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117194722.GJ20097@intel.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe3c/Xc2uU9uhomiQpJXLMnwhqQSJSxAoEUQJtfSikq7cUjMp
 yyKs9WFqpCv8zIplqPMjW6Wm4lJRsyRNCAWF0twszZWklre7yP9+zznnOe954GUJ5Ti1ko3V
 nRL0Om2cmpaTta0z3ZvtwyERW+aNvvh6V5sMV+aWU9j2vBTh3ukJGt+fscrwzeEvBO7urmBw
 Z/o4gy3D7yn8znqPxrnd9TL8pOUjg4dGGxD+mN2CcG72KI1/zBfJdnN8flkqn/OrkuIt5is0
 /9Q5RPH5beH8oNEm46vup/E26wDD36g2I37KsiZMfkgeHCXExSYJes3Oo/KY3sv7TmZxpy2j
 /cx5VKC4itxY4AIhPdPIXEVyVsk9QtBX9YGQxHcExrEuShJTCDovvEX/LH3NdpflIYKxhnKX
 sCO40pdJiVOeXAhc65/76/DikmH8npMQmeAekOC8GSkyzfnCXNUHWmQFtxMqSqYZkUluPeRN
 lpEie3MHIWPwsWvGA9ryRv7W3TgNNObccu1cCxdr7rpYBQMjBTLxIOBusTDkGF0wsAsiFG7b
 t0sJPGHMVs1IvBp+PxPnRU6D9LxeQvJmIHhd8pCWGjug2dZDiXuIhaPLrRqpHAIvW7sYab07
 9Ns9pBPcIav2DiGVFZBxWSlNr4PBzhpCYhWUvpmmM5HatCiYaVEY06Iwpv/vFiLSjFRCoiE+
 WjBs0wnJ/gZtvCFRF+0feSLeghb+YMe8bboO1c8ea0Ici9TLFJ9rd0coKW2SISW+CQFLqL0U
 8kchEUpFlDbljKA/cUSfGCcYmtAqllSrFKlLhg4ruWjtKeG4IJwU9P+6MtZt5Xm0aSJ66pVP
 o7Fol7n4mmOwtMD7rmM/WbjPoe7pSKpz4vam2U9cS0JPT8fMwKesAwHIHLBRXuQdaHoR1BqY
 4EdsJX0zNc2hvZOnVcEtazrScgIPLfcJKtaER12adLb6fKsMy/95LqogZ8/eKvfrS7+u2PHe
 rz51CV0mJK3a0H420ltNGmK0AX6E3qD9A15eyCh/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Xd03jx1jDP7e0rLoPXeSyWLjjPWs
 Fsd3L2W0uPL1PZvFkp+7mCz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLNYeuctu
 8eDlfkaLu5OPMFrMmPySzeL7v4VMDgIe89ZUe0z5vZHVY9OqTjaP7d8esHrMOxnocb/7OJPH
 5iX1Hsd33WL36NuyitHj8ya5AK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsj
 UyV9O5uU1JzMstQifbsEvYwrbb4FkwQqNr28wd7AOJ+3i5GTQ0LAROL64bfsXYxcHEICSxkl
 fk77xwyREJfYPf8tlC0s8edaFxtE0WtGiUdH57CBJIQFHCV6bvxlBLFFBMoldm9vApvELLCK
 ReLGvjMsEB3/GCXe/FwD1sEmoCnxd/NNMJtXwE5iw+Kv7CA2i4CqxMxPa1hAbFGBCImzL9cx
 QtQISpyc+QQszimgL3FgykSwk5gF1CX+zLsEZctLNG+dDWWLS9x6Mp9pAqPQLCTts5C0zELS
 MgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiB0b/t2M/NOxgvbQw+xCjAwajEw/ti
 m0OMEGtiWXFl7iFGCQ5mJRFerhWOMUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0xMeSXx
 hqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGDs9njMd3zxtXsv/5ZEW
 uQGJNefLFZnyfixdpNKXYTvJUciCfYV1ToyAjYycs8/dBJ2/87t5t5RYfdD4vyjJ70cft5n7
 ZYW7Lg6K94QYDm9IumW4SGHmLI0XJ6TLBMJbt5b6Ox2pjXftmiQQ8fvlbSteXwuGYzcibonl
 X5aSc/NJPLXg6JbvSizFGYmGWsxFxYkAh3k2HRQDAAA=
X-CMS-MailID: 20190118143420eucas1p11495282b806a7ca85bdbafaec46ac3b4
X-Msg-Generator: CA
X-RootMTR: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6
References: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
 <CGME20181214121032eucas1p24af580721ebd6f86a4f9ddf701957ab6@eucas1p2.samsung.com>
 <1544789421-5265-2-git-send-email-c.manszewski@samsung.com>
 <20190117194722.GJ20097@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_063426_468532_C8ECCFBD 
X-CRM114-Status: GOOD (  20.06  )
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
Cc: linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 'Hans Verkuil' <hans.verkuil@cisco.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

K0NDOiBIYW5zCgpPbiAxNy4wMS4yMDE5IDIwOjQ3LCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6Cj4g
T24gRnJpLCBEZWMgMTQsIDIwMTggYXQgMDE6MTA6MTZQTSArMDEwMCwgQ2hyaXN0b3BoIE1hbnN6
ZXdza2kgd3JvdGU6Cj4+IFJhbmdlIHNldHRpbmcgbWFrZXMgc2Vuc2UgZm9yIFlDYkNyIGFuZCBS
R0IgYnVmZmVycy4gQ3VycmVudAo+PiBkcm1fY29sb3JfcmFuZ2UgZW51bSBsYWJlbHMgc3VnZ2Vz
dCB1c2Ugd2l0aCBZQ2JDciBidWZmZXJzLgo+PiBDcmVhdGUgZW51bSBsYWJlbHMgd2l0aG91dCBj
b2xvcnNwYWNlIHNwZWNpZmljYXRpb24uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBN
YW5zemV3c2tpIDxjLm1hbnN6ZXdza2lAc2Ftc3VuZy5jb20+Cj4+IC0tLQo+PiAgaW5jbHVkZS9k
cm0vZHJtX2NvbG9yX21nbXQuaCB8IDIgKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9jb2xvcl9tZ210LmggYi9p
bmNsdWRlL2RybS9kcm1fY29sb3JfbWdtdC5oCj4+IGluZGV4IDkwZWY5OTk2ZDlhNC4uNTJmNmQ1
MjIxYTBkIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2RybS9kcm1fY29sb3JfbWdtdC5oCj4+ICsr
KyBiL2luY2x1ZGUvZHJtL2RybV9jb2xvcl9tZ210LmgKPj4gQEAgLTYyLDYgKzYyLDggQEAgZW51
bSBkcm1fY29sb3JfcmFuZ2Ugewo+PiAgCURSTV9DT0xPUl9ZQ0JDUl9MSU1JVEVEX1JBTkdFLAo+
PiAgCURSTV9DT0xPUl9ZQ0JDUl9GVUxMX1JBTkdFLAo+PiAgCURSTV9DT0xPUl9SQU5HRV9NQVgs
Cj4+ICsJRFJNX0NPTE9SX0xJTUlURURfUkFOR0UgPSBEUk1fQ09MT1JfWUNCQ1JfTElNSVRFRF9S
QU5HRSwKPj4gKwlEUk1fQ09MT1JfRlVMTF9SQU5HRSA9IERSTV9DT0xPUl9ZQ0JDUl9GVUxMX1JB
TkdFLAo+IFRoZXNlIGVudW0gdmFsdWVzIGRvbid0IG1lYW4gYW55dGhpbmcgcmVhbGx5LiBUaGUg
c3RyaW5ncyBhcmUgd2hhdAo+IG1hdHRlciBmb3IgdGhlIHVhcGkuCj4KPiBUaGUgZGVmYXVsdCBm
b3IgWUNiQ3IgbmVlZHMgdG8gYmUgbGltaXRlZCByYW5nZSwgdGhlIGRlZmF1bHQgZm9yIFJHQgo+
IG5lZWRzIHRvIGJlIGZ1bGwgcmFuZ2UuIFNvIEkgdGhpbmsgdGhpcyB3b3VsZCByZWFsbHkgcmVx
dWlyZSBhIHNlcGFyYXRlCj4gcHJvcCBmb3IgZWFjaC4KPgo+IEJ1dCBpcyB0aGVyZSBhbiBhY3R1
YWwgdXNlY2FzZSBmb3IgdGhpcyBzdHVmZj8KCgpZZXMsIGZvciBleGFtcGxlIEhETUkgcGF0aCAo
RGlzcGxheSBDb250cm9sbGVyIGFuZCBIRE1JIGVuY29kZXIpIGluCkV4eW5vczU0MzMgd29ya3Mg
b24gUkdCIGJ1ZmZlcnMgYW5kIGRvIG5vdCBwZXJmb3JtIGFueSBjb252ZXJzaW9uIGlmIHRoZQpv
dXRwdXQgaXMgYWxzbyBSR0IsIG9uIHRoZSBvdGhlciBzaWRlIENFQTg2MSBzcGVjcyBzYXlzIHRo
YXQgaW4gY2FzZSBvZgpDRUEgbW9kZXMgb3V0cHV0IFJHQiBzaG91bGQgYmUgaW4gbGltaXRlZCBy
YW5nZSwgaW4gY2FzZSBvZiBub24gQ0VBCm1vZGVzIGl0IHNob3VsZCBiZSBmdWxsIHJhbmdlLgoK
VGhlIGlkZWEgd2FzIHRvIGFsbG93IHVzZXJzcGFjZSB0byBjaGVjayAoYXRvbWljX2NoZWNrKSB3
aGljaCByYW5nZXMgYXJlCmFjY2VwdGFibGUgaW4gZ2l2ZW4gbW9kZSBhbmQgdG8gc2V0IGRlc2ly
ZWQgb25lIGlmIHBvc3NpYmxlLgoKQW55IGJldHRlciBzb2x1dGlvbiBpcyB3ZWxjb21lPwoKClJl
Z2FyZHMKCkFuZHJ6ZWoKCgoKPgo+PiAgfTsKPj4gIAo+PiAgaW50IGRybV9wbGFuZV9jcmVhdGVf
Y29sb3JfcHJvcGVydGllcyhzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwKPj4gLS0gCj4+IDIuNy40
Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+
IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
