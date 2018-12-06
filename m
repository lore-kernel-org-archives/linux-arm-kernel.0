Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9E1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:31:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB4B20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vkfm3G5Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G0ApBWes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB4B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RD7Z1q37CL1WC7x4WxRNkJ/RK1xQIaR0QfBD37MI2l8=; b=Vkfm3G5QErz1At
	b7Y/zaVJhxmhDDSIS8nnDOcwHuCYIbU1TA4TLl/2pkIrEEEmQjwBtFNLTM9QkW+EZXmUF/ny5bayx
	bQnF96fe0RLG//yK0zMMJW11+qk7Je/Jk4xVb7GGtpIb0IEZz0F0iv/K/0N5tSQGhutxko7O2Ln77
	szDARhM96ph5TfmC7ac8xGUbYAZ5/BZNMUskWQZGk4wziWvCEt5ylUxTEv6mlZ6lOz9x0fv7AHzbl
	P/u4OCUbu10CQcPTfzDmjmKOhLsZFWWu03FDxYpoBnfQHnEr2OTQcIUX9Dn+LPvek++pCV/bUEMAU
	bz9qtYn1tGHQu+iYTc6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUiVS-0001pg-PB; Thu, 06 Dec 2018 01:31:10 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUiVM-0001nX-OO
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:31:09 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20181206013050epoutp03654c897569c028534e2b54cff78c01fe~tmkDUUYRT0968709687epoutp03F;
 Thu,  6 Dec 2018 01:30:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20181206013050epoutp03654c897569c028534e2b54cff78c01fe~tmkDUUYRT0968709687epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544059850;
 bh=6Gr1bmJzUWL64rFVd1bqGmgfe5R9n31yoLfNkjesgRM=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=G0ApBWes4rCc9+i2N8h96pwH5K/1AG2cwF7qrkbo5SCw6XgTE6kNykTEEoKmCaJNE
 mberMR6wPPLX2ZDogJkIMoswpGhzMNYIZJzA+/kotba/d/GNtaJbsGovPYy6tRoSSu
 wHcmas++aQ8Wg7bj9qYi9MWYiMlyYHVIOd8rt/2M=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181206013044epcas1p1a94c9a3550e3fe30e62f596ebf8dc6bc~tmj9v8ein3108331083epcas1p1w;
 Thu,  6 Dec 2018 01:30:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 EE.D8.04064.4CB780C5; Thu,  6 Dec 2018 10:30:44 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20181206013044epcas1p3df03d153eaf830ff2f35a9dab5755349~tmj9ccmsT3162731627epcas1p3s;
 Thu,  6 Dec 2018 01:30:44 +0000 (GMT)
X-AuditID: b6c32a39-011ff70000000fe0-95-5c087bc42b7b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
 (Symantec Messaging Gateway) with SMTP id 1E.E8.03601.3CB780C5; Thu,  6 Dec
 2018 10:30:44 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJA008KTK776720@mmp2.samsung.com>; Thu, 06 Dec 2018 10:30:43 +0900 (KST)
Message-id: <5C087BC3.1050405@samsung.com>
Date: Thu, 06 Dec 2018 10:30:43 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.6.0
To: Lukasz Luba <l.luba@partner.samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/5] devfreq: add devfreq_suspend/resume() functions
In-reply-to: <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRmVeSWpSXmKPExsWy7bCmnu6Rao4Yg5bzMhYHt2pabJyxntVi
 +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
 NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
 xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
 udrO4tG3ZRWjx4rV39k9Pm+SC+CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
 V1LIS8xNtVVy8QnQdcvMAXpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
 nJhbXJqXrpecn2tlaGBgZApUmJCd8W/aapaCfqmK83dXMDUwLhXtYuTkkBAwkdj+6ShjFyMX
 h5DADkaJnsU9UM53RonTjQsYYao+LnvLBJHYwCjx+MIasASvgKDEj8n3WLoYOTiYBeQljlzK
 BgkzC2hKvPgyiQWi/i6jxMGONhaIei2J1Wd+s4PYLAKqEot23gGbwwYU3//iBhuIzS+gKHH1
 x2OwuKhAhMTO+d/YQQaJCJxnlFizcw/YFcwCrcwS/z5sAesQFvCWuNW0hw3kCk4ge/13WZAa
 CYGf7BJv+nYxQbzgIrF241koW1ji1fEt7CD1EgLSEpeO2kLUtzNKfHnRzArhTGCU+HBqM1SD
 scSzhV1MEL/xSbz72sMK0cwr0dEmBGF6SNx5lwNSISRwn1Hi9xOfCYyys5DCaBYijGYhhdEC
 RuZVjGKpBcW56anFhgWmyLG3iRGc1LUsdzAeO+dziFGAg1GJh/fFA/YYIdbEsuLK3EOMEhzM
 SiK8DHocMUK8KYmVValF+fFFpTmpxYcYTYFBPJFZSjQ5H5hx8kriDU2NjI2NLUwMzUwNDZXE
 eZ9IzY0WEkhPLEnNTk0tSC2C6WPi4JRqYJzmf1IkerFj4+r30x77vpjkouZlqPRS2OpC54t/
 Hvl3Zrf/5/y+4+WGgp3+ookbKkOmC/n21nZ7GKe8WO/9a3Wb4rzeWOdnMSEPL/9rmTU3zm3D
 vN97ZW5NrJp7b6KNQWKof930re+nTmxraX/GmKmQlNi9auK2sLsOfTv+L//w8Xzz0qdVd4SU
 WIozEg21mIuKEwESmMPpAAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jQd0j1RwxBvNXcVgc3KppsXHGelaL
 7Ru/sVrMP3KO1aJ58Xo2izPduRb9j18zW5w/v4Hd4mzTG3aLWw0yFrOm7GWy2PT4GqvF5V1z
 2Cw+9x5htJhxfh+Txdojd9ktll6/yGRxu3EFm8XdU0eBZpy+xGrRuvcIu0Xb6g+sFm8u3GNx
 EPfYtnsbq8eaeWsYPWY3XGTxmND/idFj8Z6XTB6bVnWyeeyfu4bdY/OSeo9/x9g9Dr7bw+Sx
 5Wo7i0ffllWMHitWf2f3+LxJLoAvissmJTUnsyy1SN8ugSvj37TVLAX9UhXn765gamBcKtrF
 yMkhIWAi8XHZW6YuRi4OIYF1jBJL7q9hBknwCghK/Jh8j6WLkYODWUBe4silbAhTXWLKlFyI
 8vuMEocv7maEKNeSWH3mNzuIzSKgKrFo5x2wOBtQfP+LG2wgNr+AosTVH48ZQeaICkRIdJ+o
 BJkjInCeUeJgXycrSA2zQCuzxKO2LBBbWMBb4lbTHja4Zes3/GQFaeYESqz/LjuBUWAWkktn
 IVw6C+HSBYzMqxglUwuKc9Nzi40KDPNSy/WKE3OLS/PS9ZLzczcxAuN622Gtvh2M95fEH2IU
 4GBU4uF98YA9Rog1say4MvcQowQHs5IIL4MeR4wQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5
 xyKFBNITS1KzU1MLUotgskwcnFINjIL7BRfYLbQy4yt/wjXDferbJzFqlTHsadufLS9uyHfo
 OVjTLuXeHnCoysFFwMrCkelCp+KUp5yOuUUPrr9bwaSfqHx5qoer6V6PqxMZzuqErP38SWWD
 +DJ21ZOzpiwO0Q0pUim5+fXvlHuOQd8SO2zWs695m/Ce9xOnwU3FW2Jl3IsWzf3vpMRSnJFo
 qMVcVJwIAB1n177nAgAA
X-CMS-MailID: 20181206013044epcas1p3df03d153eaf830ff2f35a9dab5755349
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110622eucas1p23d788afd54ad34c0a2663efac8734648
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110622eucas1p23d788afd54ad34c0a2663efac8734648@eucas1p2.samsung.com>
 <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_173105_118143_1F24BF3A 
X-CRM114-Status: GOOD (  24.03  )
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

SGkgTHVrYXN6LAoKT24gMjAxOOuFhCAxMuyblCAwNeydvCAyMDowNSwgTHVrYXN6IEx1YmEgd3Jv
dGU6Cj4gVGhpcyBwYXRjaCBhZGRzIGltcGxlbWVudGF0aW9uIGZvciBnbG9iYWwgc3VzcGVuZC9y
ZXN1bWUgZm9yCj4gZGV2ZnJlcSBmcmFtZXdvcmsuIFN5c3RlbSBzdXNwZW5kIHdpbGwgbmV4dCB1
c2UgdGhlc2UgZnVuY3Rpb25zLgo+IAo+IFN1Z2dlc3RlZC1ieTogVG9iaWFzIEpha29iaSA8dGph
a29iaUBtYXRoLnVuaS1iaWVsZWZlbGQuZGU+Cj4gU3VnZ2VzdGVkLWJ5OiBDaGFud29vIENob2kg
PGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBMdWthc3ogTHViYSA8bC5s
dWJhQHBhcnRuZXIuc2Ftc3VuZy5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVx
LmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICBp
bmNsdWRlL2xpbnV4L2RldmZyZXEuaCAgIHwgIDYgKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwg
NTAgaW5zZXJ0aW9ucygrKQoKUmV2aWV3ZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNh
bXN1bmcuY29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyBi
L2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPiBpbmRleCA0NjUxN2I2Li4wYWUzZGU3IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPiArKysgYi9kcml2ZXJzL2RldmZy
ZXEvZGV2ZnJlcS5jCj4gQEAgLTkzNSw2ICs5MzUsNTAgQEAgaW50IGRldmZyZXFfcmVzdW1lX2Rl
dmljZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPiAgRVhQT1JUX1NZTUJPTChkZXZmcmVxX3Jl
c3VtZV9kZXZpY2UpOwo+ICAKPiAgLyoqCj4gKyAqIGRldmZyZXFfc3VzcGVuZCgpIC0gU3VzcGVu
ZCBkZXZmcmVxIGdvdmVybm9ycyBhbmQgZGV2aWNlcwo+ICsgKgo+ICsgKiBDYWxsZWQgZHVyaW5n
IHN5c3RlbSB3aWRlIFN1c3BlbmQvSGliZXJuYXRlIGN5Y2xlcyBmb3Igc3VzcGVuZGluZyBnb3Zl
cm5vcnMKPiArICogYW5kIGRldmljZXMgcHJlc2VydmluZyB0aGUgc3RhdGUgZm9yIHJlc3VtZS4g
T24gc29tZSBwbGF0Zm9ybXMgdGhlIGRldmZyZXEKPiArICogZGV2aWNlIG11c3QgaGF2ZSBwcmVj
aXNlIHN0YXRlIChmcmVxdWVuY3kpIGFmdGVyIHJlc3VtZSBpbiBvcmRlciB0byBwcm92aWRlCj4g
KyAqIGZ1bGx5IG9wZXJhdGluZyBzZXR1cC4KPiArICovCj4gK3ZvaWQgZGV2ZnJlcV9zdXNwZW5k
KHZvaWQpCj4gK3sKPiArCXN0cnVjdCBkZXZmcmVxICpkZXZmcmVxOwo+ICsJaW50IHJldDsKPiAr
Cj4gKwltdXRleF9sb2NrKCZkZXZmcmVxX2xpc3RfbG9jayk7Cj4gKwlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KGRldmZyZXEsICZkZXZmcmVxX2xpc3QsIG5vZGUpIHsKPiArCQlyZXQgPSBkZXZmcmVxX3N1
c3BlbmRfZGV2aWNlKGRldmZyZXEpOwo+ICsJCWlmIChyZXQpCj4gKwkJCWRldl9lcnIoJmRldmZy
ZXEtPmRldiwKPiArCQkJCSJmYWlsZWQgdG8gc3VzcGVuZCBkZXZmcmVxIGRldmljZVxuIik7Cj4g
Kwl9Cj4gKwltdXRleF91bmxvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsKPiArfQo+ICsKPiArLyoq
Cj4gKyAqIGRldmZyZXFfcmVzdW1lKCkgLSBSZXN1bWUgZGV2ZnJlcSBnb3Zlcm5vcnMgYW5kIGRl
dmljZXMKPiArICoKPiArICogQ2FsbGVkIGR1cmluZyBzeXN0ZW0gd2lkZSBTdXNwZW5kL0hpYmVy
bmF0ZSBjeWNsZSBmb3IgcmVzdW1pbmcgZ292ZXJub3JzIGFuZAo+ICsgKiBkZXZpY2VzIHRoYXQg
YXJlIHN1c3BlbmRlZCB3aXRoIGRldmZyZXFfc3VzcGVuZCgpLgo+ICsgKi8KPiArdm9pZCBkZXZm
cmVxX3Jlc3VtZSh2b2lkKQo+ICt7Cj4gKwlzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcTsKPiArCWlu
dCByZXQ7Cj4gKwo+ICsJbXV0ZXhfbG9jaygmZGV2ZnJlcV9saXN0X2xvY2spOwo+ICsJbGlzdF9m
b3JfZWFjaF9lbnRyeShkZXZmcmVxLCAmZGV2ZnJlcV9saXN0LCBub2RlKSB7Cj4gKwkJcmV0ID0g
ZGV2ZnJlcV9yZXN1bWVfZGV2aWNlKGRldmZyZXEpOwo+ICsJCWlmIChyZXQpCj4gKwkJCWRldl93
YXJuKCZkZXZmcmVxLT5kZXYsCj4gKwkJCQkgImZhaWxlZCB0byByZXN1bWUgZGV2ZnJlcSBkZXZp
Y2VcbiIpOwo+ICsJfQo+ICsJbXV0ZXhfdW5sb2NrKCZkZXZmcmVxX2xpc3RfbG9jayk7Cj4gK30K
PiArCj4gKy8qKgo+ICAgKiBkZXZmcmVxX2FkZF9nb3Zlcm5vcigpIC0gQWRkIGRldmZyZXEgZ292
ZXJub3IKPiAgICogQGdvdmVybm9yOgl0aGUgZGV2ZnJlcSBnb3Zlcm5vciB0byBiZSBhZGRlZAo+
ICAgKi8KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLmggYi9pbmNsdWRlL2xp
bnV4L2RldmZyZXEuaAo+IGluZGV4IGQ5ODUxOTkuLmZiZmZhNzQgMTAwNjQ0Cj4gLS0tIGEvaW5j
bHVkZS9saW51eC9kZXZmcmVxLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2RldmZyZXEuaAo+IEBA
IC0yMDUsNiArMjA1LDkgQEAgZXh0ZXJuIHZvaWQgZGV2bV9kZXZmcmVxX3JlbW92ZV9kZXZpY2Uo
c3RydWN0IGRldmljZSAqZGV2LAo+ICBleHRlcm4gaW50IGRldmZyZXFfc3VzcGVuZF9kZXZpY2Uo
c3RydWN0IGRldmZyZXEgKmRldmZyZXEpOwo+ICBleHRlcm4gaW50IGRldmZyZXFfcmVzdW1lX2Rl
dmljZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSk7Cj4gIAo+ICtleHRlcm4gdm9pZCBkZXZmcmVx
X3N1c3BlbmQodm9pZCk7Cj4gK2V4dGVybiB2b2lkIGRldmZyZXFfcmVzdW1lKHZvaWQpOwo+ICsK
PiAgLyoqCj4gICAqIHVwZGF0ZV9kZXZmcmVxKCkgLSBSZWV2YWx1YXRlIHRoZSBkZXZpY2UgYW5k
IGNvbmZpZ3VyZSBmcmVxdWVuY3kKPiAgICogQGRldmZyZXE6CXRoZSBkZXZmcmVxIGRldmljZQo+
IEBAIC0zMzEsNiArMzM0LDkgQEAgc3RhdGljIGlubGluZSBpbnQgZGV2ZnJlcV9yZXN1bWVfZGV2
aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+ICAJcmV0dXJuIDA7Cj4gIH0KPiAgCj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBkZXZmcmVxX3N1c3BlbmQodm9pZCkge30KPiArc3RhdGljIGlubGlu
ZSB2b2lkIGRldmZyZXFfcmVzdW1lKHZvaWQpIHt9Cj4gKwo+ICBzdGF0aWMgaW5saW5lIHN0cnVj
dCBkZXZfcG1fb3BwICpkZXZmcmVxX3JlY29tbWVuZGVkX29wcChzdHJ1Y3QgZGV2aWNlICpkZXYs
Cj4gIAkJCQkJICAgdW5zaWduZWQgbG9uZyAqZnJlcSwgdTMyIGZsYWdzKQo+ICB7Cj4gCgoKLS0g
CkJlc3QgUmVnYXJkcywKQ2hhbndvbyBDaG9pClNhbXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
