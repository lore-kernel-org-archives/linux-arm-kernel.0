Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE74C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:38:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004AC2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FF3SEUoR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="obNtQILq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004AC2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FDsLNl6NTMTgdjceArp1MlK//yTWjCj20IUO3LFHQxE=; b=FF3SEUoRfJkhwx
	VWvyckvYMscAGrkZci291MVgvpK7exK7BJdBUQk1vRt/CuK9T2+YR6jRIf7qyhRomfiY+4jNKRiAp
	53Y++5LzQT80HezesiYytVlITRQxU4ssW82BbLa5YQSGlVEWHYrhTi6BeM8vP9AEIm3MbA6yVELTY
	OA+f4NdkixHOk2p6PjfYLWIDE/rFRDJp+0kWQvJujixq5TzSbfIte3dzVDZlIaz6TN0thSRsL2dJO
	1M+d8pFIYYgmu8Hswiy4nbmeUpa4E+Bqu4q31BQgYs3TZ6slBrrdfr/4SK4LtbbMv1Sal5JE+5qhV
	mWwAlf6mhj7tloKlPDBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvWwl-0001UI-EI; Mon, 18 Feb 2019 00:38:11 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvWwi-0001Tg-B2
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 00:38:09 +0000
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190218003806epoutp03ea0d8260ead5ee284f07c1ff74f8fa56~ETlIRWDm62744727447epoutp03F
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 00:38:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190218003806epoutp03ea0d8260ead5ee284f07c1ff74f8fa56~ETlIRWDm62744727447epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550450286;
 bh=7nj3ocltjNFOOTdf7p8rvZIU0Ljng0ibyFWeJV8weoE=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=obNtQILqqr4mlvWhNQFk+k7trPw1Mk+a37iqzhQ9TyVBkNbhVpysIA5qz7glxhjOZ
 858DaOYAY6Qz/HlJgIQcCeUSO51D0wxeYvh3/dLF9VcGtWoYBb8KEM4G63bXmxi2tC
 Dh31hMHinL6z/AosBq3lh+p9T6lWTGfePleVT9ok=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190218003803epcas1p28a1bec16e815efd09d0e6faf8116fa12~ETlGISyYU2120821208epcas1p2F;
 Mon, 18 Feb 2019 00:38:03 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 C3.BA.04206.B6EF96C5; Mon, 18 Feb 2019 09:38:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20190218003803epcas1p49ca0f5950bc44d66e6fc0d66120949d4~ETlFvV1z-0314903149epcas1p4e;
 Mon, 18 Feb 2019 00:38:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190218003803epsmtrp1b28ce2981cedff89a6ebc7a143c1b71b~ETlFt5I9R0257102571epsmtrp1C;
 Mon, 18 Feb 2019 00:38:03 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-fb-5c69fe6b11bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 56.45.03601.B6EF96C5; Mon, 18 Feb 2019 09:38:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190218003803epsmtip242bb766effc067fb63f7f56d6cfdf01b~ETlFfSwAC2560825608epsmtip2f;
 Mon, 18 Feb 2019 00:38:03 +0000 (GMT)
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
To: Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, heiko@sntech.de, thierry.reding@gmail.com,
 jonathanh@nvidia.com
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
Date: Mon, 18 Feb 2019 09:38:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190216151826.11584-4-tiny.windzz@gmail.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUwTURD2dbfbBa2uVXTEqLjEGIlY1lpcRIgJiDXyAyNGMSS40k2p9Mpu
 SxRJPEMFqUeMRqvInXhEiVgvIlZRJJXgGbzQeGAUkSCiEo3xaHcx8u/7Zr6Zed+890hM4yci
 SbPNyQs2zkIT4fiFG7O0sfm/zdlxv3q07J83H5XsDm81zrZv61WxDV2PlOzDxqME+8VzE7ED
 r/5gbMlXL8F2bj1OsD8aj+Fs+c+9xKKRhsveFyrDudrNBs/2PsKw23cSGS4+OoYZvjRMzSDW
 5C/M4zkjL0Txtly70WwzJdHLVuSk5Ojj45hYJoGdT0fZOCufRKemZ8SmmS3B49FRBZzFFQxl
 cKJIa5MXCnaXk4/Ks4vOJJp3GC2OBMcckbOKLptpTq7duoCJi5urDwrX5uf1PPUiR2f4hs+e
 MnwLekqWIpIEah5cK11bisJJDXUJQduPq5hMBhAEnjwgZDKI4HVla5CESRX1tb1DiSYE7V87
 FDL5hOCAuwaFVOOoNLjjvqcKJcZTlQjOlByQCEbVIShvGsBDKoKKAX/3E6nvGGo6dHzvkqrV
 VDK4d5/HQhinZkBVd7ukiaBWww1P35BmLAQOv5X6hFGJ0NTxTtJj1ER49rZCIeNpsP38EckR
 UPtV0HLKj8kmUuH9x/dIxuOgp9WnknEkfNhTPIQ3wYnATUIu3onA57+nlBM68NftV4T2h1Gz
 oL5RKw8bDX3fypTyWtWws1gjq6Ph4asXChlPghp3ydAeDXCopQbfi6Z7h9nxDrPgHWbB+39Y
 JcJPogm8Q7SaeJFx6IffdwOSHm9MwiV06056M6JIRI9S9xeYszVKrkDcaG1GQGL0eHX1YDCk
 NnIbC3nBniO4LLzYjPTBbe/DIiNy7cGvYHPmMPq5Op2OncfE6xmGnqiuX5SSraFMnJPP53kH
 L/yrU5BhkVtQ3acquztx+WNTvXCwe1M/njXzdth1fX80uz5xRPjs0xGZ31tO5VZXTFlcWPw8
 Nl63xDei3bbqSve5ilThflLRs20Vu+jJ61rVAaGwvDelK+ARBH9zW+fSpQ8yla1nsjLTFu+q
 NLb57l8f0J6NLlKv1BUlj7zrdxHLx2QRP9MHy17SuJjHMTGYIHJ/AWkAe4jSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvG72v8wYg833+S3+P3rNatEyaxGL
 xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFp8e/Ge26Pwyi83iduMKNoufu+axWMz9PYHNgdtj56y7
 7B6bl9R79Da/Y/Po27KK0WP7tXnMHp83yQWwRXHZpKTmZJalFunbJXBlvLo5i7HgNlfFx94e
 lgbGmxxdjJwcEgImEuuXvGHrYuTiEBLYzShx++Y+NoiEpMS0i0eZuxg5gGxhicOHiyFq3jJK
 TDt1iQmkRljATeJc+wV2kISIwAJGib8fX7CCJJgFljJK7H/DCtGxn1Fi672TYFPZBLQk9r+4
 AWbzCyhKXP3xmBHE5hWwk2jv28oMYrMIqEosfHEWrEZUIELi49N9TBA1ghInZz5hAbE5Bawl
 9l59xgyxTF3iz7xLULa4xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCc
 m55bbFhglJdarlecmFtcmpeul5yfu4kRHIFaWjsYT5yIP8QowMGoxMP7oSwzRog1say4MvcQ
 owQHs5II76JvQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTByc
 Ug2MjhaGsx54/m132mLu+Ejj8U5Bw30Tfuw7xp3Wcuu6l9NxOau41+xnl/BekvMK+zJzxufZ
 PyXOFzxcOq/h46lzBRu5//l/5zlU8PitAeeWCs+s+V3ascfaUi8Wbzmq+mb26/06x8/de+n8
 cdWiOM2zs192NxeuqlGsW54kp7NTefePauGO7Ko+PSWW4oxEQy3mouJEACdxfKy8AgAA
X-CMS-MailID: 20190218003803epcas1p49ca0f5950bc44d66e6fc0d66120949d4
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190216151918epcas1p25c2971b063cc66981fda6a67a8276585
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
 <20190216151826.11584-4-tiny.windzz@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_163808_547342_57FAEA1B 
X-CRM114-Status: GOOD (  23.26  )
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
Cc: linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTkuIDIuIDE3LiDsmKTsoIQgMTI6MTgsIFlhbmd0YW8gTGkgd3JvdGU6Cj4gVGhpcyB2YXJp
YWJsZSBpcyBub3QgdXNlZCBhZnRlciBpbml0aWFsaXphdGlvbiwgc28KPiByZW1vdmUgaXQuIEFu
ZCBpbiBvcmRlciB0byB1bmlmeSB0aGUgY29kZSBzdHlsZSwKPiBtb3ZlIHRoZSBsb2NhdGlvbiB3
aGVyZSB0aGUgZGV2X2dldF9kcnZkYXRhIGlzIGNhbGxlZAo+IGJ5IHRoZSB3YXkuCj4gCj4gU2ln
bmVkLW9mZi1ieTogWWFuZ3RhbyBMaSA8dGlueS53aW5kenpAZ21haWwuY29tPgo+IC0tLQo+ICBk
cml2ZXJzL2RldmZyZXEvdGVncmEtZGV2ZnJlcS5jIHwgNyArKy0tLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZGV2ZnJlcS90ZWdyYS1kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEvdGVncmEtZGV2
ZnJlcS5jCj4gaW5kZXggYzU5ZDJlZWU1ZDMwLi5jODliYTdiODM0ZmYgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9kZXZmcmVxL3RlZ3JhLWRldmZyZXEuYwo+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS90
ZWdyYS1kZXZmcmVxLmMKPiBAQCAtNTczLDEwICs1NzMsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2dv
dmVybm9yX2dldF90YXJnZXQoc3RydWN0IGRldmZyZXEgKmRldmZyZXEsCj4gIHN0YXRpYyBpbnQg
dGVncmFfZ292ZXJub3JfZXZlbnRfaGFuZGxlcihzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwKPiAg
CQkJCQl1bnNpZ25lZCBpbnQgZXZlbnQsIHZvaWQgKmRhdGEpCj4gIHsKPiAtCXN0cnVjdCB0ZWdy
YV9kZXZmcmVxICp0ZWdyYTsKPiAtCWludCByZXQgPSAwOwo+IC0KPiAtCXRlZ3JhID0gZGV2X2dl
dF9kcnZkYXRhKGRldmZyZXEtPmRldi5wYXJlbnQpOwo+ICsJc3RydWN0IHRlZ3JhX2RldmZyZXEg
KnRlZ3JhID0gZGV2X2dldF9kcnZkYXRhKGRldmZyZXEtPmRldi5wYXJlbnQpOwo+ICAKPiAgCXN3
aXRjaCAoZXZlbnQpIHsKPiAgCWNhc2UgREVWRlJFUV9HT1ZfU1RBUlQ6Cj4gQEAgLTYwMCw3ICs1
OTcsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2dvdmVybm9yX2V2ZW50X2hhbmRsZXIoc3RydWN0IGRl
dmZyZXEgKmRldmZyZXEsCj4gIAkJYnJlYWs7Cj4gIAl9Cj4gIAo+IC0JcmV0dXJuIHJldDsKPiAr
CXJldHVybiAwOwo+ICB9Cj4gIAo+ICBzdGF0aWMgc3RydWN0IGRldmZyZXFfZ292ZXJub3IgdGVn
cmFfZGV2ZnJlcV9nb3Zlcm5vciA9IHsKPiAKClJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3
MDAuY2hvaUBzYW1zdW5nLmNvbT4KCi0tIApCZXN0IFJlZ2FyZHMsCkNoYW53b28gQ2hvaQpTYW1z
dW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
