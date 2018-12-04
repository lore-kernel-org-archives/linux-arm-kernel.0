Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:43:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A732082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aXa7dxkI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ecbQzlCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A732082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wx4LJkx3QPOoM9IspjLznKXcWNhJniNRBXoD1HSI6ek=; b=aXa7dxkI/0L1om
	5cydAkywmGFw9hZF+hC0X+HQIYemuBsmUi/OWAE1eiEoYDPeQIoqJkJkz5G3pxi5wOjGfmFbjFSny
	ERRv2frLd7SG/9uRqFFQTNbmWc+c/1+OJdRbc/FlsrnPnD5mzoZFj6wxJstKFkL5ixuf1tdGlZbJg
	DcM+Vhc0drluIk6XnQgtKfmIWmUt9KLUt7+jvHkj5HyDhuy2g+VkuJS2Cvjr5teaHXaVPOgM08bXC
	NfyFQOrOov5cxMjveEBj+0fAVVSFyDo15I/v/4LsIeFuFkJ5h42diSOfYVgUtAM+8YUW8JbHH4XgZ
	qbg98QwQmCToeWQn6UVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU3Ub-0005vB-MH; Tue, 04 Dec 2018 05:43:33 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU3UX-0005u9-O9
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 05:43:31 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20181204054315epoutp0151e3e8cbc264a4b79d071ce1b598e57f~tCt4CxDpb0647006470epoutp01N;
 Tue,  4 Dec 2018 05:43:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20181204054315epoutp0151e3e8cbc264a4b79d071ce1b598e57f~tCt4CxDpb0647006470epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543902195;
 bh=+9ztf+bV6r/gJ6qrM1G5w/aDE+1hLuUHZrAIGFmAf/Y=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=ecbQzlCDpEFPQAS3eXHNi/nGAeA40ZD7VPEzD6HAzTl5596MuPxHTk95Z3uDDkobD
 IwrgwY9xtXjto1hWFYV/QGZ3FoKRJ7Vl0yiKsozd85Ms1UQEt79g/+pLuMtoRaFYfa
 SWYpi71FSpUVdj+QWdXSwf1QxuZKRKrtOUa+9gYg=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20181204054311epcas1p3cafd58cbc339e0b4ae60edc5f784374c~tCt0AB10F3132131321epcas1p31;
 Tue,  4 Dec 2018 05:43:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 E3.08.04057.FE3160C5; Tue,  4 Dec 2018 14:43:11 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181204054311epcas1p194e62327afd8ea59388dea4f8b801f8d~tCtzq8cjC0754607546epcas1p1q;
 Tue,  4 Dec 2018 05:43:11 +0000 (GMT)
X-AuditID: b6c32a36-d19ff70000000fd9-2c-5c0613ef0278
Received: from epmmp1.local.host ( [203.254.227.16]) by
 epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B2.F1.03601.EE3160C5; Tue,  4 Dec 2018 14:43:11 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ700AS86JYCE40@mmp1.samsung.com>; Tue, 04 Dec 2018 14:43:10 +0900 (KST)
Message-id: <5C0613EE.9000208@samsung.com>
Date: Tue, 04 Dec 2018 14:43:10 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
To: Lukasz Luba <l.luba@partner.samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] devfreq: refactor set_target frequency function
In-reply-to: <5C060511.8020802@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxbVRz1vm8WCm9llRucrD7nH8Uw+2Bld0iNsMU8A38wZ6JxmPoCL0Do
 x7OvzE0TrSJDGNtwMwtBNrYxB0JJBSofAhKwkwTd6lCUYcAPdOJARl3ZWHRo2zcj/53fyfmd
 3HPuvQyuXaSSmFK7S3LaRStHbSB6PjMYU28kUAXGilAyGvnYgDrrvSTq7bxFoib/ZRJVNHsp
 9OVhGzo2t4CjQOAjGl16a5FG0+7NqOG9IQx1zX1Loq8/aaTQzSN+gOoDn2Kowz9Dow++u4Kh
 799spdDM+MWwxxcTJKoc8tPoUPsyiRa/miWeTBR6BnpIwXPaA4T33VcIoe7Yn0BoHvwdE7ra
 qilh+JSHFrrPvyGsfU4LI0uDmOCbrCKEo742ILS236aFm13J+XEvlGWVSGKR5NRL9kJHUam9
 2Mzl7rXsspgyjHwqvxPt4PR20SaZud15+alPlVrD8Tn9ftFaHqbyRUXhHnsiy+kod0n6Eofi
 MnOSXGSVd8rbFNGmlNuLtxU6bJm80ZhmCgtfKivxBa9i8kjygeE7uW6wAmtADAPZ7fDC0jJZ
 AzYwWrYPwKGFNUIdbgN44uRdUAOYqCp4VafyA2F+tYWObGvYjXD1xCwR0eDsFuifKIvQOGuA
 86Hj93xmAOxsGgOqPgVOD3xIRjDBPgL/CXZHMRXmh+enqAiOZx+Ck6tzUb2OfR72N92iI0ab
 2ACAnv5BLDLgbCUO15Z90Y0ENheef/sPIoJj2Eeh9/oUpma7S0Nf6HEV74aNh0OEihPg9TEf
 rSZ7AE5cNEc8IVsFYGi+glSHOgCXx7vvGaXDa2drMDVbHFxaqSXVZQ1855BWlQhwcqU/eh4t
 uwZgsC+7DjzYsK6khv9LalhX0hmAt4H7JVmxFUsKL6etv7wuEH3pKRl94NzlvFHAMoCL1dTn
 kAVaUtyvHLSNAsjg3CaN/DJRoNUUiQdflZwOi7PcKimjwBTu+F08SVfoCP8bu8vCm9LS09PR
 dj7DxPNcouaXpFP7tGyx6JLKJEmWnP/tYUxMkhtkbtGZp6qPtx65lvYzQqNnfg3onutw5c2f
 rm30bF0BBwK1hm+kyt657Bd1G3uP7qr1tCT+eKdqPJjI6DJvyDmvv/Js876xHClujyd2z29c
 fpa+/cLDHX/nvqa/z/s0+4N3itoc/5NzVq4Y6+z76xmD5dyllrMJoWpzrMadnbkQP72DI5QS
 kU/BnYr4L6EsSQ3/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t9jAd33wmwxBgc62C0ObtW02DhjPavF
 9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
 bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
 iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
 crWdxaNvyypGjxWrv7N7fN4kF8AXxWWTkpqTWZZapG+XwJWx5eNNpoKDchX7f3o3MH6V6GLk
 4JAQMJH4eFO0i5GLQ0hgJ6NE44nrrF2MnBy8AoISPybfYwGpYRaQlzhyKRvCVJeYMiUXpEJI
 4D6jRM9FLYhqLYlbu1eCdbIIqEr8/7gZzGYDiu9/cYMNxOYXUJS4+uMxI8gYUYEIie4TlSBb
 RQTOM0oc7OsEq2cWaGWWeNSWBWILC3hLLGl5ywJx2j9Gic4vP8CKOAW0Jda/usE0gVFgFpJL
 ZyFcOgvh0gWMzKsYJVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS83M3MQJjetthrb4djPeXxB9i
 FOBgVOLhneHEGiPEmlhWXJl7iFGCg1lJhLegkCVGiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/t
 vGORQgLpiSWp2ampBalFMFkmDk6pBsa2oxf8ddyCd+8OiPDPal0S3iDToChm5J9VJ/Rs3tND
 2dqzT27uMHr9VOmH0Y6V5+IjKn91nDl97KXX+2U2T4PnXWQTquqdkqAYfSnONrq+/VyX1nLW
 Ta4fC71udTK6dYbxvtkdIPR55e7dzyWq1wdz37Ji/rnj4e0ohqy4dY+ijeatKTTbYKHEUpyR
 aKjFXFScCABcEovl5QIAAA==
X-CMS-MailID: 20181204054311epcas1p194e62327afd8ea59388dea4f8b801f8d
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
 <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
 <5C060511.8020802@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_214329_945748_E31260B0 
X-CRM114-Status: GOOD (  25.57  )
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

SGksCgpPbiAyMDE464WEIDEy7JuUIDA07J28IDEzOjM5LCBDaGFud29vIENob2kgd3JvdGU6Cj4g
SGkgTHVrYXN6LAo+IAo+IE9uIDIwMTjrhYQgMTLsm5QgMDPsnbwgMjM6MzEsIEx1a2FzeiBMdWJh
IHdyb3RlOgo+PiBUaGUgcmVmYWN0b3JpbmcgaXMgbmVlZGVkIGZvciB0aGUgbmV3IGNsaWVudCBp
biBkZXZmcmVxOiBzdXNwZW5kLgo+PiBUbyBhdm9pZCBjb2RlIGR1cGxpY2F0aW9uLCBtb3ZlIGl0
IHRvIHRoZSBuZXcgbG9jYWwgZnVuY3Rpb24KPj4gZGV2ZnJlcV9zZXRfdGFyZ2V0Lgo+Pgo+PiBU
aGUgcGF0Y2ggaXMgYmFzZWQgb24gZWFybGllciB3b3JrIGJ5IFRvYmlhcyBKYWtvYmkuCj4gCj4g
QXMgSSBhbHJlYWR5IGNvbW1lbnRlZCwgUGxlYXNlIHJlbW92ZSBpdC4gWW91IGFscmVhZHkgbWVu
dGlvbmVkIGl0IG9uIGNvdmVyLWxldHRlci4KPiBJZiB5b3Ugd2FudCB0byBjb250YWluIHRoZSBj
b250cmlidXRpb24gaGlzdG9yeSBvZiBUb2JpYXMsIHlvdSBtaWdodCBiZXR0ZXIKPiB0byBhZGQg
J1NpZ25lZC1vZmYtYnknIG9yIG90aGVycy4KCklmIHlvdSB3aWxsIGZpeCBpdCwgZmVlbCBmcmVl
IHRvIGFkZCBteSB0YWc6ClJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1z
dW5nLmNvbT4KCj4gCj4+Cj4+IFN1Z2dlc3RlZC1ieTogVG9iaWFzIEpha29iaSA8dGpha29iaUBt
YXRoLnVuaS1iaWVsZWZlbGQuZGU+Cj4+IFN1Z2dlc3RlZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAw
LmNob2lAc2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1YmFA
cGFydG5lci5zYW1zdW5nLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5j
IHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEv
ZGV2ZnJlcS5jCj4+IGluZGV4IDE0MTQxMzAuLmE5ZmQ2MWIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+
PiBAQCAtMjg1LDYgKzI4NSw0MCBAQCBzdGF0aWMgaW50IGRldmZyZXFfbm90aWZ5X3RyYW5zaXRp
b24oc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4+ICAJcmV0dXJuIDA7Cj4+ICB9Cj4+ICAKPj4g
K3N0YXRpYyBpbnQgZGV2ZnJlcV9zZXRfdGFyZ2V0KHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxLCB1
bnNpZ25lZCBsb25nIG5ld19mcmVxLAo+PiArCQkJICAgICAgdTMyIGZsYWdzKQo+PiArewo+PiAr
CXN0cnVjdCBkZXZmcmVxX2ZyZXFzIGZyZXFzOwo+PiArCXVuc2lnbmVkIGxvbmcgY3VyX2ZyZXE7
Cj4+ICsJaW50IGVyciA9IDA7Cj4+ICsKPj4gKwlpZiAoZGV2ZnJlcS0+cHJvZmlsZS0+Z2V0X2N1
cl9mcmVxKQo+PiArCQlkZXZmcmVxLT5wcm9maWxlLT5nZXRfY3VyX2ZyZXEoZGV2ZnJlcS0+ZGV2
LnBhcmVudCwgJmN1cl9mcmVxKTsKPj4gKwllbHNlCj4+ICsJCWN1cl9mcmVxID0gZGV2ZnJlcS0+
cHJldmlvdXNfZnJlcTsKPj4gKwo+PiArCWZyZXFzLm9sZCA9IGN1cl9mcmVxOwo+PiArCWZyZXFz
Lm5ldyA9IG5ld19mcmVxOwo+PiArCWRldmZyZXFfbm90aWZ5X3RyYW5zaXRpb24oZGV2ZnJlcSwg
JmZyZXFzLCBERVZGUkVRX1BSRUNIQU5HRSk7Cj4+ICsKPj4gKwllcnIgPSBkZXZmcmVxLT5wcm9m
aWxlLT50YXJnZXQoZGV2ZnJlcS0+ZGV2LnBhcmVudCwgJm5ld19mcmVxLCBmbGFncyk7Cj4+ICsJ
aWYgKGVycikgewo+PiArCQlmcmVxcy5uZXcgPSBjdXJfZnJlcTsKPj4gKwkJZGV2ZnJlcV9ub3Rp
ZnlfdHJhbnNpdGlvbihkZXZmcmVxLCAmZnJlcXMsIERFVkZSRVFfUE9TVENIQU5HRSk7Cj4+ICsJ
CXJldHVybiBlcnI7Cj4+ICsJfQo+PiArCj4+ICsJZnJlcXMubmV3ID0gbmV3X2ZyZXE7Cj4+ICsJ
ZGV2ZnJlcV9ub3RpZnlfdHJhbnNpdGlvbihkZXZmcmVxLCAmZnJlcXMsIERFVkZSRVFfUE9TVENI
QU5HRSk7Cj4+ICsKPj4gKwlpZiAoZGV2ZnJlcV91cGRhdGVfc3RhdHVzKGRldmZyZXEsIG5ld19m
cmVxKSkKPj4gKwkJZGV2X2VycigmZGV2ZnJlcS0+ZGV2LAo+PiArCQkJIkNvdWxkbid0IHVwZGF0
ZSBmcmVxdWVuY3kgdHJhbnNpdGlvbiBpbmZvcm1hdGlvbi5cbiIpOwo+PiArCj4+ICsJZGV2ZnJl
cS0+cHJldmlvdXNfZnJlcSA9IG5ld19mcmVxOwo+PiArCXJldHVybiBlcnI7Cj4+ICt9Cj4+ICsK
Pj4gIC8qIExvYWQgbW9uaXRvcmluZyBoZWxwZXIgZnVuY3Rpb25zIGZvciBnb3Zlcm5vcnMgdXNl
ICovCj4+ICAKPj4gIC8qKgo+PiBAQCAtMjk2LDggKzMzMCw3IEBAIHN0YXRpYyBpbnQgZGV2ZnJl
cV9ub3RpZnlfdHJhbnNpdGlvbihzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwKPj4gICAqLwo+PiAg
aW50IHVwZGF0ZV9kZXZmcmVxKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+PiAgewo+PiAtCXN0
cnVjdCBkZXZmcmVxX2ZyZXFzIGZyZXFzOwo+PiAtCXVuc2lnbmVkIGxvbmcgZnJlcSwgY3VyX2Zy
ZXEsIG1pbl9mcmVxLCBtYXhfZnJlcTsKPj4gKwl1bnNpZ25lZCBsb25nIGZyZXEsIG1pbl9mcmVx
LCBtYXhfZnJlcTsKPj4gIAlpbnQgZXJyID0gMDsKPj4gIAl1MzIgZmxhZ3MgPSAwOwo+PiAgCj4+
IEBAIC0zMzMsMzEgKzM2Niw4IEBAIGludCB1cGRhdGVfZGV2ZnJlcShzdHJ1Y3QgZGV2ZnJlcSAq
ZGV2ZnJlcSkKPj4gIAkJZmxhZ3MgfD0gREVWRlJFUV9GTEFHX0xFQVNUX1VQUEVSX0JPVU5EOyAv
KiBVc2UgTFVCICovCj4+ICAJfQo+PiAgCj4+IC0JaWYgKGRldmZyZXEtPnByb2ZpbGUtPmdldF9j
dXJfZnJlcSkKPj4gLQkJZGV2ZnJlcS0+cHJvZmlsZS0+Z2V0X2N1cl9mcmVxKGRldmZyZXEtPmRl
di5wYXJlbnQsICZjdXJfZnJlcSk7Cj4+IC0JZWxzZQo+PiAtCQljdXJfZnJlcSA9IGRldmZyZXEt
PnByZXZpb3VzX2ZyZXE7Cj4+IC0KPj4gLQlmcmVxcy5vbGQgPSBjdXJfZnJlcTsKPj4gLQlmcmVx
cy5uZXcgPSBmcmVxOwo+PiAtCWRldmZyZXFfbm90aWZ5X3RyYW5zaXRpb24oZGV2ZnJlcSwgJmZy
ZXFzLCBERVZGUkVRX1BSRUNIQU5HRSk7Cj4+ICsJcmV0dXJuIGRldmZyZXFfc2V0X3RhcmdldChk
ZXZmcmVxLCBmcmVxLCBmbGFncyk7Cj4+ICAKPj4gLQllcnIgPSBkZXZmcmVxLT5wcm9maWxlLT50
YXJnZXQoZGV2ZnJlcS0+ZGV2LnBhcmVudCwgJmZyZXEsIGZsYWdzKTsKPj4gLQlpZiAoZXJyKSB7
Cj4+IC0JCWZyZXFzLm5ldyA9IGN1cl9mcmVxOwo+PiAtCQlkZXZmcmVxX25vdGlmeV90cmFuc2l0
aW9uKGRldmZyZXEsICZmcmVxcywgREVWRlJFUV9QT1NUQ0hBTkdFKTsKPj4gLQkJcmV0dXJuIGVy
cjsKPj4gLQl9Cj4+IC0KPj4gLQlmcmVxcy5uZXcgPSBmcmVxOwo+PiAtCWRldmZyZXFfbm90aWZ5
X3RyYW5zaXRpb24oZGV2ZnJlcSwgJmZyZXFzLCBERVZGUkVRX1BPU1RDSEFOR0UpOwo+PiAtCj4+
IC0JaWYgKGRldmZyZXFfdXBkYXRlX3N0YXR1cyhkZXZmcmVxLCBmcmVxKSkKPj4gLQkJZGV2X2Vy
cigmZGV2ZnJlcS0+ZGV2LAo+PiAtCQkJIkNvdWxkbid0IHVwZGF0ZSBmcmVxdWVuY3kgdHJhbnNp
dGlvbiBpbmZvcm1hdGlvbi5cbiIpOwo+PiAtCj4+IC0JZGV2ZnJlcS0+cHJldmlvdXNfZnJlcSA9
IGZyZXE7Cj4+IC0JcmV0dXJuIGVycjsKPj4gIH0KPj4gIEVYUE9SVF9TWU1CT0wodXBkYXRlX2Rl
dmZyZXEpOwo+PiAgCj4+Cj4gCj4gCgoKLS0gCkJlc3QgUmVnYXJkcywKQ2hhbndvbyBDaG9pClNh
bXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
