Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E7C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:19:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8FF2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bun/LeOu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aZH8dZaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8FF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vs/7bYBqiY4WZeNfAhz7GWkJ+xLDQ+qKtD2C//K1gp0=; b=Bun/LeOuDUR4Qv
	sQ/3EX+xMnabb8J0YbPAlmXxO7wXfBKhBiwUNWopTA1mg7OKU4xmzQ5i+TMF1Ud7Q9y/mZahI3G4n
	iPGWJqp4kgjS/eHA3S/OXIDPLLRyksUSh5LHln6DlAlF202XKbNx4ukpeG2AJF3QjESsYFURUQjt6
	BsnLP1fvgU4mCgHP3phugVaNZn+vOsY92fljdlp7srUEX2h9MgPR8LrY+fkX40P13GTxINSP1LTzD
	ot0re8IGgi/dbhOH2AVGJsU+WyH2bCBGaypc8XHQmZaoZubcO7B0XJk/HumJCj+O8T8dP6Hi/O1RB
	qFgkkAFwWGhw3kA1JtOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU43m-0001sB-C1; Tue, 04 Dec 2018 06:19:54 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU43i-0001iu-71
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 06:19:52 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20181204061936epoutp0347b1937a6968b8e23a17ef8fd9c93e8b~tDNm5rLKw3207632076epoutp038;
 Tue,  4 Dec 2018 06:19:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20181204061936epoutp0347b1937a6968b8e23a17ef8fd9c93e8b~tDNm5rLKw3207632076epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543904376;
 bh=KAWhR31NxtOmiWLfxm4iRJWBqukFe+N418flXq88B2A=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=aZH8dZaWNWd5u4ZRQHMwT/jNZ/UbRsT0i84oyay2e8nTQy+X28GRuq5tOqv+vQpvB
 vscvr7JyRMzLaXLtT6nSPG/ASI71bgukLNS3WjaJKdIO7xtw4LjAjvBD8PtAO2e0fg
 Sg7uCFDvpO2AZAlmaOpd42f27Kumg4LlxuzuBnpc=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.158]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181204061933epcas1p130cb84e1eea4741d9316db3419d2971f~tDNkQkuf52171421714epcas1p1V;
 Tue,  4 Dec 2018 06:19:33 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 29.F5.04055.57C160C5; Tue,  4 Dec 2018 15:19:33 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20181204061933epcas2p3fc013e7960266fcf9e3f1abab94bdd61~tDNjzxLcZ2199121991epcas2p39;
 Tue,  4 Dec 2018 06:19:33 +0000 (GMT)
X-AuditID: b6c32a45-711ff70000000fd7-69-5c061c75d631
Received: from epmmp1.local.host ( [203.254.227.16]) by
 epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 45.82.03627.47C160C5; Tue,  4 Dec 2018 15:19:33 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ700A4V88KCE60@mmp1.samsung.com>; Tue, 04 Dec 2018 15:19:32 +0900 (KST)
Message-id: <5C061C74.808@samsung.com>
Date: Tue, 04 Dec 2018 15:19:32 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
To: Lukasz Luba <l.luba@partner.samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] devfreq: add devfreq_suspend/resume() functions
In-reply-to: <1543847475-7600-4-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xbVRjNfa/vB8uKb2VsV5hbfcZlkLC11MrFrEbdNC92USL+sSgGn/AC
 rL+efS2KjlAGjK3LXJXF1G6IA4YTuhRYxxiwkZU6kg1XwYCLkyUOM4EthIyFTZ1oXx8q/53z
 fee7955z76VxzRyZRpfZXYLTzltZcpWqZygjJ8u9gSzQfR5k0aWzGajLHyLQua5FAjVFrxGo
 piVEopFDNnRk6g6OYrFOCn237y6FfvJsQIGjFzDUPTVBoB/6jpNo4XAUIH/sIoZORycpdPLH
 UQzdqD5Foskr38bXuDpGoLoLUQrt75gn0N3vb6peWM/19PcQXPDLIOCOeUZVnO/IPcC1DMxg
 XHf7QZIbbAxS3JnWKm7pMsVdmhvAuPB4vYr7JNwOuFMdDyhuoXtjXvJblu2lAl8sOLWCvchR
 XGYvMbHm/MIdhcZndfosfS7KYbV23iaY2J278rJeKbPG7bPact7qjpfyeElitz2/3elwuwRt
 qUNymVhBLLaKueJWibdJbnvJ1iKH7Tm9TpdtjAvftZR2NTwuHtv44RdtU8ADYtALkmjIPAN7
 /AdJL1hFa5heAP1tzZRCHgDY+atMllWLh4DS6Aewdt8sITfUzBr4sOGmygtoGmc2weiYRS7j
 TAacvv+ZStFPAjgW6AOyRs1shr0TH8saFfM0PDd6mZQxyWTCwenrCfwY8yQcfzgFZJzK7Ibn
 mxYTB1rLxAAMnh/AZIIzdThcmg8nJlIYM/yldiQxkcS8CsNNdxI7Q6aahh0XD5OKhZ1wYrZ/
 2U4KnB0OL+N0eLu9CygD9QDen64hFOIDcP7KGUxRGeDtE15MMZcMDwz9Rcl+IKOGB/ZrFMjB
 E3Nr/rP89x+zwAeeCKxIKfB/SoEVKX0F8HawThAlW4kgZYv6ldfXDRJvPfPlXuC/tisCGBqw
 q9X+l4gCDcGXSxW2CIA0zq5Vi++rCjTqYr7iI8HpKHS6rYIUAcZ4yp/iaalFjvjPsbsK9cZs
 g8GAjDm5Bl0uu159K73xbQ1TwrsEiyCIgvPfOYxOSvOAVG/zN62v8ebGdabVFSHPXtvpoXf8
 u09u2rKFv7XgE4vSQ8cfvdd0NTg+8jOhflReZf6gz1I93PLi0ps3fJV/1t8brP56z1LNTDhy
 9o2UzLoGOrk1ULlnqK5ZO5zv68PCuOn12tQZyt2646nebddDVeHa39gZYGgz741FNuf/XtnJ
 qqRSXp+JOyX+H7PD5F8BBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t9jAd1SGbYYgzldnBYHt2pabJyxntVi
 +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
 NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
 xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
 udrO4tG3ZRWjx4rV39k9Pm+SC+CL4rJJSc3JLEst0rdL4MrYOFmyYLZcxcxljxkbGM9LdDFy
 ckgImEhs+9bN2MXIxSEksJNR4vm5u6wgCV4BQYkfk++xdDFycDALyEscuZQNYapLTJmSC1F+
 n1Fi1t9mZpA4r4CaxI5r1SCdLAKqEtsvHmMDsdkEtCT2v7gBZvMLKEpc/fGYEaRcVCBCovtE
 JcgYEYHzjBIH+zrBtjILtDJLPGrLArGFBbwlHracgTrtLqPE1Y+vmEESnAJeElvmv2aZwCgw
 C8mlsxAunYVw6QJG5lWMkqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIFRve2wVv8OxsdL
 4g8xCnAwKvHwOjiwxgixJpYVV+YeYpTgYFYS4S0oZIkR4k1JrKxKLcqPLyrNSS0+xCjNwaIk
 zsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwDi1xry+ennK1/t2fi+7q9y+7nixknfijOATUqdc
 GBbOms11/3XlbsEJThnTSj9YhLWekf4vOyn93vGl+QbRpbq72fYsXXnS7OqiVSfjCvmeyUw7
 2n4/edYKE1NrN1vfvv+KsTcTG//niG1Rq08slI24cbi768xBn1V3zcuvyZn8NlY8utx5p4ES
 S3FGoqEWc1FxIgAdFJyt5gIAAA==
X-CMS-MailID: 20181204061933epcas2p3fc013e7960266fcf9e3f1abab94bdd61
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143132eucas1p128c029a7c7461e1127924a08e4a71811@eucas1p1.samsung.com>
 <1543847475-7600-4-git-send-email-l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_221950_574771_313A436E 
X-CRM114-Status: GOOD (  25.42  )
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
Cc: mark.rutland@arm.com, len.brown@intel.com, tony.luck@intel.com,
 keescook@chromium.org, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
 anton@enomsg.org, rjw@rjwysocki.net, robh+dt@kernel.org,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com,
 myungjoo.ham@samsung.com, kgene@kernel.org, pavel@ucw.cz, ccross@android.com,
 krzk@kernel.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTHVrYXN6LAoKT24gMjAxOOuFhCAxMuyblCAwM+ydvCAyMzozMSwgTHVrYXN6IEx1YmEgd3Jv
dGU6Cj4gVGhpcyBwYXRjaCBhZGRzIGltcGxlbWVudGF0aW9uIGZvciBnbG9iYWwgc3VzcGVuZC9y
ZXN1bWUgZm9yCj4gZGV2ZnJlcSBmcmFtZXdvcmsuIFN5c3RlbSBzdXNwZW5kIHdpbGwgbmV4dCB1
c2UgdGhlc2UgZnVuY3Rpb25zLgo+IAo+IFRoZSBwYXRjaCBpcyBiYXNlZCBvbiBlYXJsaWVyIHdv
cmsgYnkgVG9iaWFzIEpha29iaS4KClBsZWFzZSByZW1vdmUgaXQgZnJvbSBlYWNoIHBhdGNoIGRl
c2NyaXB0aW9uLgoKPiAKPiBTdWdnZXN0ZWQtYnk6IFRvYmlhcyBKYWtvYmkgPHRqYWtvYmlAbWF0
aC51bmktYmllbGVmZWxkLmRlPgo+IFN1Z2dlc3RlZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNo
b2lAc2Ftc3VuZy5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTHVrYXN6IEx1YmEgPGwubHViYUBwYXJ0
bmVyLnNhbXN1bmcuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgNDIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIGluY2x1ZGUvbGlu
dXgvZGV2ZnJlcS5oICAgfCAgNiArKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRp
b25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgYi9kcml2
ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4gaW5kZXggMzZiZWQyNC4uN2Q2MDQyMyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2Rl
dmZyZXEuYwo+IEBAIC05MzUsNiArOTM1LDQ4IEBAIGludCBkZXZmcmVxX3Jlc3VtZV9kZXZpY2Uo
c3RydWN0IGRldmZyZXEgKmRldmZyZXEpCj4gIEVYUE9SVF9TWU1CT0woZGV2ZnJlcV9yZXN1bWVf
ZGV2aWNlKTsKPiAgCj4gIC8qKgo+ICsgKiBkZXZmcmVxX3N1c3BlbmQoKSAtIFN1c3BlbmQgZGV2
ZnJlcSBnb3Zlcm5vcnMgYW5kIGRldmljZXMKPiArICoKPiArICogQ2FsbGVkIGR1cmluZyBzeXN0
ZW0gd2lkZSBTdXNwZW5kL0hpYmVybmF0ZSBjeWNsZXMgZm9yIHN1c3BlbmRpbmcgZ292ZXJub3Jz
Cj4gKyAqIGFuZCBkZXZpY2VzIHByZXNlcnZpbmcgdGhlIHN0YXRlIGZvciByZXN1bWUuIE9uIHNv
bWUgcGxhdGZvcm1zIHRoZSBkZXZmcmVxCj4gKyAqIGRldmljZSBtdXN0IGhhdmUgcHJlY2lzZSBz
dGF0ZSAoZnJlcXVlbmN5KSBhZnRlciByZXN1bWUgaW4gb3JkZXIgdG8gcHJvdmlkZQo+ICsgKiBm
dWxseSBvcGVyYXRpbmcgc2V0dXAuCj4gKyAqLwo+ICt2b2lkIGRldmZyZXFfc3VzcGVuZCh2b2lk
KQo+ICt7Cj4gKwlzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcTsKPiArCWludCByZXQ7Cj4gKwo+ICsJ
bXV0ZXhfbG9jaygmZGV2ZnJlcV9saXN0X2xvY2spOwo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShk
ZXZmcmVxLCAmZGV2ZnJlcV9saXN0LCBub2RlKSB7Cj4gKwkJcmV0ID0gZGV2ZnJlcV9zdXNwZW5k
X2RldmljZShkZXZmcmVxKTsKPiArCQlpZiAocmV0KQo+ICsJCQlkZXZfd2FybigmZGV2ZnJlcS0+
ZGV2LCAiZGV2aWNlIHN1c3BlbmQgZmFpbGVkXG4iKTsKCldoZW4gSSBjaGVja2VkIHRoZSBjcHVm
cmVxX3N1c3BlbmQoKSwgY3B1ZnJlcV9zdXNwZW5kKCkgcHJpbnRzIG1lc3NhZ2UgYXMgJ2Vycicg
bGV2ZWwuCkkgdGhpbmsgdGhhdCBkZXZfZXJyIGlzIG1vcmUgcHJvcGVyIHRoYW4gZGV2X3dhcm4u
CgpJJ20gbm90IHN1cmUgd2hhdCBpcyBtb3JlIGNvcnJlY3QgbG9nLgpCdXQsICdkZXZmcmVxLT5k
ZXYnIGRldmljZSBoYXMgdGhlIHNlcGFyYXRlIHN1c3BlbmQvcmVzdW1lIGZ1bmN0aW9uLgpTbywg
SSB0aGluayB0aGF0IGRldmZyZXFfc3VzcGVuZCgpIHNob3VsZCBwcmludCBlcnJvciBsb2cgY29u
dGFpbmluZwp0aGF0IGl0IGlzIGVycm9yIGJ5IGRldmZyZXEgZnJhbWV3b3JrLgoKImRldmljZSBz
dXNwZW5kIGZhaWxlZCIKLT4gImZhaWxlZCB0byBzdXNwZW5kIGRldmZyZXEgZGV2aWNlIgoKPiAr
CX0KPiArCW11dGV4X3VubG9jaygmZGV2ZnJlcV9saXN0X2xvY2spOwo+ICt9Cj4gKwo+ICsvKioK
PiArICogZGV2ZnJlcV9yZXN1bWUoKSAtIFJlc3VtZSBkZXZmcmVxIGdvdmVybm9ycyBhbmQgZGV2
aWNlcwo+ICsgKgo+ICsgKiBDYWxsZWQgZHVyaW5nIHN5c3RlbSB3aWRlIFN1c3BlbmQvSGliZXJu
YXRlIGN5Y2xlIGZvciByZXN1bWluZyBnb3Zlcm5vcnMgYW5kCj4gKyAqIGRldmljZXMgdGhhdCBh
cmUgc3VzcGVuZGVkIHdpdGggZGV2ZnJlcV9zdXNwZW5kKCkuCj4gKyAqLwo+ICt2b2lkIGRldmZy
ZXFfcmVzdW1lKHZvaWQpCj4gK3sKPiArCXN0cnVjdCBkZXZmcmVxICpkZXZmcmVxOwo+ICsJaW50
IHJldDsKPiArCj4gKwltdXRleF9sb2NrKCZkZXZmcmVxX2xpc3RfbG9jayk7Cj4gKwlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGRldmZyZXEsICZkZXZmcmVxX2xpc3QsIG5vZGUpIHsKPiArCQlyZXQgPSBk
ZXZmcmVxX3Jlc3VtZV9kZXZpY2UoZGV2ZnJlcSk7Cj4gKwkJaWYgKHJldCkKPiArCQkJZGV2X3dh
cm4oJmRldmZyZXEtPmRldiwgImRldmljZSByZXN1bWUgZmFpbGVkXG4iKTsKCmRpdHRvLgoKImRl
dmljZSByZXN1bWUgZmFpbGVkIgotPiAiZmFpbGVkIHRvIHJlc3VtZSBkZXZmcmVxIGRldmljZSIK
Cgo+ICsJfQo+ICsJbXV0ZXhfdW5sb2NrKCZkZXZmcmVxX2xpc3RfbG9jayk7Cj4gK30KPiArCj4g
Ky8qKgo+ICAgKiBkZXZmcmVxX2FkZF9nb3Zlcm5vcigpIC0gQWRkIGRldmZyZXEgZ292ZXJub3IK
PiAgICogQGdvdmVybm9yOgl0aGUgZGV2ZnJlcSBnb3Zlcm5vciB0byBiZSBhZGRlZAo+ICAgKi8K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLmggYi9pbmNsdWRlL2xpbnV4L2Rl
dmZyZXEuaAo+IGluZGV4IGQ5ODUxOTkuLmZiZmZhNzQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9kZXZmcmVxLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2RldmZyZXEuaAo+IEBAIC0yMDUs
NiArMjA1LDkgQEAgZXh0ZXJuIHZvaWQgZGV2bV9kZXZmcmVxX3JlbW92ZV9kZXZpY2Uoc3RydWN0
IGRldmljZSAqZGV2LAo+ICBleHRlcm4gaW50IGRldmZyZXFfc3VzcGVuZF9kZXZpY2Uoc3RydWN0
IGRldmZyZXEgKmRldmZyZXEpOwo+ICBleHRlcm4gaW50IGRldmZyZXFfcmVzdW1lX2RldmljZShz
dHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSk7Cj4gIAo+ICtleHRlcm4gdm9pZCBkZXZmcmVxX3N1c3Bl
bmQodm9pZCk7Cj4gK2V4dGVybiB2b2lkIGRldmZyZXFfcmVzdW1lKHZvaWQpOwo+ICsKPiAgLyoq
Cj4gICAqIHVwZGF0ZV9kZXZmcmVxKCkgLSBSZWV2YWx1YXRlIHRoZSBkZXZpY2UgYW5kIGNvbmZp
Z3VyZSBmcmVxdWVuY3kKPiAgICogQGRldmZyZXE6CXRoZSBkZXZmcmVxIGRldmljZQo+IEBAIC0z
MzEsNiArMzM0LDkgQEAgc3RhdGljIGlubGluZSBpbnQgZGV2ZnJlcV9yZXN1bWVfZGV2aWNlKHN0
cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+ICAJcmV0dXJuIDA7Cj4gIH0KPiAgCj4gK3N0YXRpYyBp
bmxpbmUgdm9pZCBkZXZmcmVxX3N1c3BlbmQodm9pZCkge30KPiArc3RhdGljIGlubGluZSB2b2lk
IGRldmZyZXFfcmVzdW1lKHZvaWQpIHt9Cj4gKwo+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCBkZXZf
cG1fb3BwICpkZXZmcmVxX3JlY29tbWVuZGVkX29wcChzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gIAkJ
CQkJICAgdW5zaWduZWQgbG9uZyAqZnJlcSwgdTMyIGZsYWdzKQo+ICB7Cj4gCgotLSAKQmVzdCBS
ZWdhcmRzLApDaGFud29vIENob2kKU2Ftc3VuZyBFbGVjdHJvbmljcwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
