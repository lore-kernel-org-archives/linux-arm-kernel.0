Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61B8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:44:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BD92146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S8VTxOxX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ONPukvUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BD92146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CUxWm7B94YU8cAHkt4LSskqkGGG66KVTwhxWhA/9BnQ=; b=S8VTxOxXsr70Cd
	aH0d+rW87rVjI8/1U9ySNXWw0dLcwAx2Oa4ZDCb4iAb0ZqTRhfSmIZ810ais4qgeaCyduE0EH1TOG
	AQP/y2r7o41impTk7kw2A14h62Css8Nj/vfV25fhFgSL8EGZR7CuEAGV76pwrLxfFXb8jmAfYaBfk
	8I8Mw2fxW7Zhw2EJg/t/uaQdERFAZRaZuiRGKeXHl1f/zTwhk6lLJz12iOj2PJ3i9ZSmbf52RPtLb
	QxyS/Cz4hF3goadREKUTgdaPUtkxt2apdeGR/QwCB304Y3SQMV0zerkADWpTCj5PsAWrwCbEEHKIP
	CbyCvRmrkOe7zicYRKHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU3VA-0006CE-2g; Tue, 04 Dec 2018 05:44:08 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU3V6-0006AB-EB
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 05:44:06 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20181204054345epoutp03734f363606dc8dc81e986c8e82c842f8~tCuT7H9M53159231592epoutp03d;
 Tue,  4 Dec 2018 05:43:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20181204054345epoutp03734f363606dc8dc81e986c8e82c842f8~tCuT7H9M53159231592epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543902225;
 bh=4oGW7XwCNxm94z+693eCu9Dv4VowqODy06ccceThHwc=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=ONPukvUkzNMngBdBy3vhrxWF+y0a9PG32P2DbAFgqCOSJwvDit+bq6fzqgIqMK0Wg
 PhKUUQhdYho0YJdus724sLz0/c+0fN88BzMOfll1a8MfXDVrsFz9GT2H/hYw3uIVKA
 E3QxPWn7rYJ/WtM058bC26cRPtKTHTepc7nkFB04=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.153]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20181204054343epcas1p41774334bea7be7ee7f19dd3773db0232~tCuRXEMzi1872718727epcas1p4X;
 Tue,  4 Dec 2018 05:43:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.59.04055.E04160C5; Tue,  4 Dec 2018 14:43:43 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20181204054342epcas2p1218e8b20b845499ef6a3aa4d930555c0~tCuQ-kB780880308803epcas2p1a;
 Tue,  4 Dec 2018 05:43:42 +0000 (GMT)
X-AuditID: b6c32a48-3a9ff70000000fd7-cc-5c06140e3379
Received: from epmmp1.local.host ( [203.254.227.16]) by
 epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 AD.71.03627.E04160C5; Tue,  4 Dec 2018 14:43:42 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ700AWX6KTGF40@mmp1.samsung.com>; Tue, 04 Dec 2018 14:43:42 +0900 (KST)
Message-id: <5C06140E.7010603@samsung.com>
Date: Tue, 04 Dec 2018 14:43:42 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
To: Lukasz Luba <l.luba@partner.samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <5C06124B.5030409@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmuS6/CFuMQeNWRouDWzUtNs5Yz2qx
 feM3Vov5R86xWjQvXs9mcaY716L/8Wtmi/PnN7BbnG16w25xq0HGYtaUvUwWmx5fY7W4vGsO
 m8Xn3iOMFjPO72OyWHvkLrvF0usXmSxuN65gs7h76ijQjNOXWC1a9x5ht2hb/YHV4s2FeywO
 4h7bdm9j9Vgzbw2jx+yGiyweE/o/MXos3vOSyWPTqk42j/1z17B7bF5S7/HvGLvHwXd7mDy2
 XG1n8ejbsorRY8Xq7+wenzfJBfBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
 KynkJeam2iq5+AToumXmAL2vpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNAr
 TswtLs1L10vOz7UyNDAwMgUqTMjOeDl7KntBr0bFt5NsDYxTFboYOTkkBEwkXk1aytLFyMUh
 JLCDUWLJ9ElsIAkhge+MEv2LKmCKGva9Y4Yo2s0o0Xr+NDtIgldAUOLH5HtA3RwczALyEkcu
 ZYOEmQU0JV58mQQ19C6jxM1l+9gg6rUk/nXuZwaxWQRUJQ68vwwWZwOK739xA8zmF1CUuPrj
 MSOILSoQIbFz/jd2kEEiAucZJdbs3MME4jALtDJL/PuwBaxDWCBS4tTip2BTOQW0JX4cXQx2
 qoTAT3aJ1a+vMUH84CKxcf5FdghbWOLV8S1QtrTEs1UbGSEa2hklvrxoZoVwJjBKfDi1Garb
 WOLZwi4miO/4JDoO/2UHeVpCgFeio00IosRDoq9nHTvE0/8YJV5/3ME8gVF2FlI4zUKE0yyk
 cFrAyLyKUSy1oDg3PbXYqMAEOf42MYITu5bHDsYD53wOMQpwMCrx8Do4sMYIsSaWFVfmHmKU
 4GBWEuEtKGSJEeJNSaysSi3Kjy8qzUktPsRoCgzmicxSosn5wKyTVxJvaGpkbGxsYWpuaWxg
 qSTO+1B6brSQQHpiSWp2ampBahFMHxMHp1QDY45PYv31dedK/aptlF+Gb964UDJ5RXd7k/M1
 nZMz6i8yqT+6IJngXnFy1fsaz1PXdn34aG3rtaY6Zf2XRN+/DUcXPXCV2K5d9st+74x07sXn
 Jr/9X9a8T4b9woTW1DnmRXWyKVtMzvXPfWTkMH9v/78TP//L8z3++vBa6W4PZeeVvYdOPlgf
 9kWJpTgj0VCLuag4EQBkjdewAgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jAV0+EbYYgy9HlCwObtW02DhjPavF
 9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
 bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
 iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
 crWdxaNvyypGjxWrv7N7fN4kF8AXxWWTkpqTWZZapG+XwJXxcvZU9oJejYpvJ9kaGKcqdDFy
 ckgImEg07HvH3MXIxSEksJNRovfcelaQBK+AoMSPyfdYuhg5OJgF5CWOXMqGMNUlpkzJhSi/
 zyjx59dqRohyLYl/nfuZQWwWAVWJA+8vs4HYbEDx/S9ugNn8AooSV388ZgSZIyoQIdF9ohJk
 jojAeUaJg32dYGuZBVqZJR61ZYHYwgKREqcWP4W67R+jxNlt7WALOAW0JX4cXcw8gVFgFpJT
 ZyGcOgvh1AWMzKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS83M3MQLjetthrf4djI+XxB9i
 FOBgVOLhdXBgjRFiTSwrrsw9xCjBwawkwltQyBIjxJuSWFmVWpQfX1Sak1p8iFGag0VJnJc/
 /1ikkEB6YklqdmpqQWoRTJaJg1OqgdHzkCbPhYmaut55mVFvjYo4tW7wZfr8KVK4MHHhl9ZC
 hZ1FmqucJgbmvfjs3OIuEFn++8zzBZtSV2+1tLCz5hKU73niUnjO4ETkai0LM/UQprwD71+Z
 n+yQSklMttmdX5WjzLnwcbbQU0313KBday5u92rjvH1mgoSUx/63vxJf6qRZ/nt1QYmlOCPR
 UIu5qDgRAEKpdrbnAgAA
X-CMS-MailID: 20181204054342epcas2p1218e8b20b845499ef6a3aa4d930555c0
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_214404_634698_F102CF71 
X-CRM114-Status: GOOD (  25.73  )
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

SGksCgpPbiAyMDE464WEIDEy7JuUIDA07J28IDE0OjM2LCBDaGFud29vIENob2kgd3JvdGU6Cj4g
SGkgTHVrYXN6LAo+IAo+IExvb2tzIGdvb2QgdG8gbWUuIEJ1dCwgSSBhZGQgdGhlIHNvbWUgY29t
bWVudHMuCj4gSWYgeW91IHdpbGwgZml4IGl0LCBmZWVsIGZyZWUgdG8gYWRkIG15IHRhZzoKPiBS
ZXZpZXdlZC1ieTogQ2hhbndvbyBjaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+CgpTb3JyeS4g
Rml4IHR5cG8gJ2Nob2knIHRvICdDaG9pJyBhcyBmb2xsb3dpbmcuClJldmlld2VkLWJ5OiBDaGFu
d29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KCj4gCj4gT24gMjAxOOuFhCAxMuyblCAw
M+ydvCAyMzozMSwgTHVrYXN6IEx1YmEgd3JvdGU6Cj4+IFRoZSBwYXRjaCBwcmVwYXJlcyBkZXZm
cmVxIGRldmljZSBmb3IgaGFuZGxpbmcgc3VzcGVuZC9yZXN1bWUKPj4gZnVuY3Rpb25hbGl0eS4g
IFRoZSBuZXcgZmllbGRzIHdpbGwgc3RvcmUgbmVlZGVkIGluZm9ybWF0aW9uIGR1cmluZyB0aGlz
Cj4gCj4gbml0cGljay4gUmVtb3ZlIHVubmVlZGVkIHNwYWNlLiBUaGVyZSBhcmUgdHdvIHNwYWNl
cyBiZXR3ZWVuICcuJyBhbmQgJ1RoZSBuZXcnLiAKPiAKPj4gcHJvY2Vzcy4gIERldmZyZXEgZnJh
bWV3b3JrIGhhbmRsZXMgb3BwLXN1c3BlbmQgRFQgZW50cnkgYW5kIHRoZXJlIGlzIG5vCj4gCj4g
ZGl0dG8uCj4gCj4+IG5lZWQgb2YgbW9keWZpY2F0aW9ucyBpbiB0aGUgZHJpdmVycyBjb2RlLiAg
SXQgdXNlcyBhdG9taWMgdmFyaWFibGVzIHRvCj4gCj4gZGl0dG8uCj4gCj4+IG1ha2Ugc3VyZSBu
byByYWNlIGNvbmRpdGlvbiBhZmZlY3RzIHRoZSBwcm9jZXNzLgo+Pgo+PiBUaGUgcGF0Y2ggaXMg
YmFzZWQgb24gZWFybGllciB3b3JrIGJ5IFRvYmlhcyBKYWtvYmkuCj4gCj4gUGxlYXNlIHJlbW92
ZSBpdCBmcm9tIGVhY2ggcGF0Y2ggZGVzY3JpcHRpb24uCj4gCj4+Cj4+IFN1Z2dlc3RlZC1ieTog
VG9iaWFzIEpha29iaSA8dGpha29iaUBtYXRoLnVuaS1iaWVsZWZlbGQuZGU+Cj4+IFN1Z2dlc3Rl
ZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEx1a2FzeiBMdWJhIDxsLmx1YmFAcGFydG5lci5zYW1zdW5nLmNvbT4KPj4gLS0tCj4+ICBk
cml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0KPj4gIGluY2x1ZGUvbGludXgvZGV2ZnJlcS5oICAgfCAgNyAr
KysrKysrCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVy
cy9kZXZmcmVxL2RldmZyZXEuYwo+PiBpbmRleCBhOWZkNjFiLi4zNmJlZDI0IDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9k
ZXZmcmVxLmMKPj4gQEAgLTMxNiw2ICszMTYsMTAgQEAgc3RhdGljIGludCBkZXZmcmVxX3NldF90
YXJnZXQoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsIHVuc2lnbmVkIGxvbmcgbmV3X2ZyZXEsCj4+
ICAJCQkiQ291bGRuJ3QgdXBkYXRlIGZyZXF1ZW5jeSB0cmFuc2l0aW9uIGluZm9ybWF0aW9uLlxu
Iik7Cj4+ICAKPj4gIAlkZXZmcmVxLT5wcmV2aW91c19mcmVxID0gbmV3X2ZyZXE7Cj4+ICsKPj4g
KwlpZiAoZGV2ZnJlcS0+c3VzcGVuZF9mcmVxKQo+PiArCQlkZXZmcmVxLT5yZXN1bWVfZnJlcSA9
IGN1cl9mcmVxOwo+PiArCj4+ICAJcmV0dXJuIGVycjsKPj4gIH0KPj4gIAo+PiBAQCAtNjY3LDYg
KzY3MSw5IEBAIHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxX2FkZF9kZXZpY2Uoc3RydWN0IGRldmlj
ZSAqZGV2LAo+PiAgCX0KPj4gIAlkZXZmcmVxLT5tYXhfZnJlcSA9IGRldmZyZXEtPnNjYWxpbmdf
bWF4X2ZyZXE7Cj4+ICAKPj4gKwlkZXZmcmVxLT5zdXNwZW5kX2ZyZXEgPSBkZXZfcG1fb3BwX2dl
dF9zdXNwZW5kX29wcF9mcmVxKGRldik7Cj4+ICsJYXRvbWljX3NldCgmZGV2ZnJlcS0+c3VzcGVu
ZF9jb3VudCwgMCk7Cj4+ICsKPj4gIAlkZXZfc2V0X25hbWUoJmRldmZyZXEtPmRldiwgImRldmZy
ZXElZCIsCj4+ICAJCQkJYXRvbWljX2luY19yZXR1cm4oJmRldmZyZXFfbm8pKTsKPj4gIAllcnIg
PSBkZXZpY2VfcmVnaXN0ZXIoJmRldmZyZXEtPmRldik7Cj4+IEBAIC04NjcsMTQgKzg3NCwyOCBA
QCBFWFBPUlRfU1lNQk9MKGRldm1fZGV2ZnJlcV9yZW1vdmVfZGV2aWNlKTsKPj4gICAqLwo+PiAg
aW50IGRldmZyZXFfc3VzcGVuZF9kZXZpY2Uoc3RydWN0IGRldmZyZXEgKmRldmZyZXEpCj4+ICB7
Cj4+ICsJaW50IHJldDsKPj4gKwo+PiAgCWlmICghZGV2ZnJlcSkKPj4gIAkJcmV0dXJuIC1FSU5W
QUw7Cj4+ICAKPj4gLQlpZiAoIWRldmZyZXEtPmdvdmVybm9yKQo+PiAtCQlyZXR1cm4gMDsKPj4g
KwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPj4gKwkJcmV0ID0gZGV2ZnJlcS0+Z292ZXJub3It
PmV2ZW50X2hhbmRsZXIoZGV2ZnJlcSwKPj4gKwkJCQkJREVWRlJFUV9HT1ZfU1VTUEVORCwgTlVM
TCk7Cj4+ICsJCWlmIChyZXQpCj4+ICsJCQlyZXR1cm4gcmV0Owo+PiArCX0KPj4gKwo+PiArCWlm
IChkZXZmcmVxLT5zdXNwZW5kX2ZyZXEpIHsKPj4gKwkJaWYgKGF0b21pY19pbmNfcmV0dXJuKCZk
ZXZmcmVxLT5zdXNwZW5kX2NvdW50KSA+IDEpCj4+ICsJCQlyZXR1cm4gMDsKPj4gKwo+PiArCQly
ZXQgPSBkZXZmcmVxX3NldF90YXJnZXQoZGV2ZnJlcSwgZGV2ZnJlcS0+c3VzcGVuZF9mcmVxLCAw
KTsKPj4gKwkJaWYgKHJldCkKPj4gKwkJCXJldHVybiByZXQ7Cj4+ICsJfQo+PiAgCj4+IC0JcmV0
dXJuIGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+IC0JCQkJREVW
RlJFUV9HT1ZfU1VTUEVORCwgTlVMTCk7Cj4+ICsJcmV0dXJuIDA7Cj4+ICB9Cj4+ICBFWFBPUlRf
U1lNQk9MKGRldmZyZXFfc3VzcGVuZF9kZXZpY2UpOwo+PiAgCj4+IEBAIC04ODgsMTQgKzkwOSwy
OCBAQCBFWFBPUlRfU1lNQk9MKGRldmZyZXFfc3VzcGVuZF9kZXZpY2UpOwo+PiAgICovCj4+ICBp
bnQgZGV2ZnJlcV9yZXN1bWVfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+PiAgewo+
PiArCWludCByZXQ7Cj4+ICsKPj4gIAlpZiAoIWRldmZyZXEpCj4+ICAJCXJldHVybiAtRUlOVkFM
Owo+PiAgCj4+IC0JaWYgKCFkZXZmcmVxLT5nb3Zlcm5vcikKPj4gLQkJcmV0dXJuIDA7Cj4+ICsJ
aWYgKGRldmZyZXEtPnJlc3VtZV9mcmVxKSB7Cj4+ICsJCWlmIChhdG9taWNfZGVjX3JldHVybigm
ZGV2ZnJlcS0+c3VzcGVuZF9jb3VudCkgPj0gMSkKPj4gKwkJCXJldHVybiAwOwo+PiAgCj4+IC0J
cmV0dXJuIGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+IC0JCQkJ
REVWRlJFUV9HT1ZfUkVTVU1FLCBOVUxMKTsKPj4gKwkJcmV0ID0gZGV2ZnJlcV9zZXRfdGFyZ2V0
KGRldmZyZXEsIGRldmZyZXEtPnJlc3VtZV9mcmVxLCAwKTsKPj4gKwkJaWYgKHJldCkKPj4gKwkJ
CXJldHVybiByZXQ7Cj4+ICsJfQo+PiArCj4+ICsJaWYgKGRldmZyZXEtPmdvdmVybm9yKSB7Cj4+
ICsJCXJldCA9IGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVyKGRldmZyZXEsCj4+ICsJ
CQkJCURFVkZSRVFfR09WX1JFU1VNRSwgTlVMTCk7Cj4+ICsJCWlmIChyZXQpCj4+ICsJCQlyZXR1
cm4gcmV0Owo+PiArCX0KPj4gKwo+PiArCXJldHVybiAwOwo+PiAgfQo+PiAgRVhQT1JUX1NZTUJP
TChkZXZmcmVxX3Jlc3VtZV9kZXZpY2UpOwo+PiAgCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2RldmZyZXEuaCBiL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+IGluZGV4IGU0OTYzYjAu
LmQ5ODUxOTkgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+ICsrKyBi
L2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+IEBAIC0xMzEsNiArMTMxLDkgQEAgc3RydWN0IGRl
dmZyZXFfZGV2X3Byb2ZpbGUgewo+PiAgICogQHNjYWxpbmdfbWluX2ZyZXE6CUxpbWl0IG1pbmlt
dW0gZnJlcXVlbmN5IHJlcXVlc3RlZCBieSBPUFAgaW50ZXJmYWNlCj4+ICAgKiBAc2NhbGluZ19t
YXhfZnJlcToJTGltaXQgbWF4aW11bSBmcmVxdWVuY3kgcmVxdWVzdGVkIGJ5IE9QUCBpbnRlcmZh
Y2UKPj4gICAqIEBzdG9wX3BvbGxpbmc6CSBkZXZmcmVxIHBvbGxpbmcgc3RhdHVzIG9mIGEgZGV2
aWNlLgo+PiArICogQHN1c3BlbmRfZnJlcToJIGZyZXF1ZW5jeSBvZiBhIGRldmljZSBzZXQgZHVy
aW5nIHN1c3BlbmQgcGhhc2UuCj4+ICsgKiBAcmVzdW1lX2ZyZXE6CSBmcmVxdWVuY3kgb2YgYSBk
ZXZpY2Ugc2V0IGluIHJlc3VtZSBwaGFzZS4KPj4gKyAqIEBzdXNwZW5kX2NvdW50Ogkgc3VzcGVu
ZCByZXF1ZXN0cyBjb3VudGVyIGZvciBhIGRldmljZS4KPj4gICAqIEB0b3RhbF90cmFuczoJTnVt
YmVyIG9mIGRldmZyZXEgdHJhbnNpdGlvbnMKPj4gICAqIEB0cmFuc190YWJsZToJU3RhdGlzdGlj
cyBvZiBkZXZmcmVxIHRyYW5zaXRpb25zCj4+ICAgKiBAdGltZV9pbl9zdGF0ZToJU3RhdGlzdGlj
cyBvZiBkZXZmcmVxIHN0YXRlcwo+PiBAQCAtMTY3LDYgKzE3MCwxMCBAQCBzdHJ1Y3QgZGV2ZnJl
cSB7Cj4+ICAJdW5zaWduZWQgbG9uZyBzY2FsaW5nX21heF9mcmVxOwo+PiAgCWJvb2wgc3RvcF9w
b2xsaW5nOwo+PiAgCj4+ICsJdW5zaWduZWQgbG9uZyBzdXNwZW5kX2ZyZXE7Cj4+ICsJdW5zaWdu
ZWQgbG9uZyByZXN1bWVfZnJlcTsKPj4gKwlhdG9taWNfdCBzdXNwZW5kX2NvdW50Owo+PiArCj4+
ICAJLyogaW5mb3JtYXRpb24gZm9yIGRldmljZSBmcmVxdWVuY3kgdHJhbnNpdGlvbiAqLwo+PiAg
CXVuc2lnbmVkIGludCB0b3RhbF90cmFuczsKPj4gIAl1bnNpZ25lZCBpbnQgKnRyYW5zX3RhYmxl
Owo+Pgo+IAo+IAoKCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53b28gQ2hvaQpTYW1zdW5nIEVsZWN0
cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
