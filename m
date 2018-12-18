Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2888AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:24:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD892184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tDh5Ildc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O0uZpXox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD892184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pHi4Fh5lhJmHEuTyCvjoRRM8E+k9jzy15gFM8I+yaLo=; b=tDh5IldcTmMFrg
	pEE9htfFtbjrdYaZzckBPL7KANSZZBAvZlWW7NyOugioWGUd5rUjW6AN46WUUVX7VeB9xEr2ItugP
	hBIk8PFkVtM1VuTPYrOt0bh89TmTOdUdLuU7gjjoX7rjGQ2XLGV1SC/ARUeyJdccYpsuHp5t02Xqz
	tC+P1wKkSlCkrm4V5TlD3GSE4S2FKHKl1twbhDSY0mg8ZlnCh8elOSb7yYTX6LBNy9dkaDnhQFfGZ
	l9BBYQfVB2yb9nXUPy0S1rnzs1hS5jmHNr7nXRAt0bfdIj4Rosh56s2MRhJMoB4G4A/lYWJRQYmhP
	+afP2T4duyMF9Iv6t2ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDTu-0005qT-Vy; Tue, 18 Dec 2018 11:24:10 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDTq-0005oJ-AO
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:24:08 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181218112351euoutp0290716f15695d8d3b46d67bbbb7cb5f2a~xaZQFgtWU1261112611euoutp02K
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 11:23:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181218112351euoutp0290716f15695d8d3b46d67bbbb7cb5f2a~xaZQFgtWU1261112611euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1545132231;
 bh=NKvXK1MeO0eV8j/6E9wS58HIqqN66Hhn9V6+QE8HPyg=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=O0uZpXox8sWhSXlaX5Hh0nTOQE4XBG5q2FHQEisIyKfHZ+Cm0KZv5UpIFlHj5g0xJ
 QnH0lUnL3UZ19NYLvgZ96U9lYirlGhyYHhH5+eil4XFQCfcVYEIXEhqdj/PeCXnJho
 LFmmJnjdRPQdwEs0wH2jwJGIVtc4AYyZusWiCwr8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181218112351eucas1p27a66e9dea27a1526287a03d021f724ff~xaZPs7p5l0905109051eucas1p2O;
 Tue, 18 Dec 2018 11:23:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id A8.C2.04441.6C8D81C5; Tue, 18
 Dec 2018 11:23:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181218112350eucas1p1b689ae88b6f9d0ed24b1bf9b53be4c2f~xaZOlt2FE1673916739eucas1p12;
 Tue, 18 Dec 2018 11:23:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181218112349eusmtrp1af386196ad1262bf1ad5f74158fac2ad~xaZOXCwtd0258502585eusmtrp1Z;
 Tue, 18 Dec 2018 11:23:49 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-dc-5c18d8c656cd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.9B.04284.5C8D81C5; Tue, 18
 Dec 2018 11:23:49 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181218112349eusmtip2c53e0aa0711150b09801e4ade0166dfa~xaZNw3Rzi3126731267eusmtip2j;
 Tue, 18 Dec 2018 11:23:49 +0000 (GMT)
Subject: Re: [RFC/RFT 08/10] i2c: exynos5: use core helper to mark adapter
 suspended
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
Date: Tue, 18 Dec 2018 12:23:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzHfe957rnH6epx2H2Gal3Tph9+LKtHmtikm/6hP2qra7p4wuLo
 zinS2MyR+R1xF0VT7NZOOz8yxUIcaaf8zmQtNCkhtNlE7p4p/70+3/f7831/PtuHxITtXEcy
 Sh7PKOSyaDHBxxu7Vk1HukZB6jE7dIge05u49A9jCYfOm/yO0X19z3m0YXKYS2f+WUb0QHMZ
 QS/lvEF0w7efHLq0r5VD55rO+NlIDLq7hKSuKkUy3zpESHLrdUjytbIWlywZ9gQTF/knw5no
 qARG4e57hR853P0aj5uDW/rcIZSKZuyzkDUJlBekly5ysxCfFFI1CNRPRnC2WEZQOKUm2GIJ
 wTPdAL7VUr6wbmEhVY0g3ZDCmuYRVHws4JkFO+o81PSUY2a2p4Ihf6PSkoFRrRx4WZjKMQsE
 5QlZc1mEmQWUL7SslVgYp1xg/N2CxeNASWE6tRVnPbbQo5mysDUVCBkPB7lmxqi9kNbwAGNZ
 BGNTjzjmMKD6eZBuWkPs2AHw4lU+h2U7mDXW81h2ht572TjbkIYgo1TLY4tsBA1lTQTr8oEO
 44fNOHIzwhVqm93NCJQ/PG3Yx+JOGJ2zZWfYCYWNJRj7LIBMtZD94wBojfp/qW3v+7F8JNZu
 20y7bRvttm20/2MrEK5DIkaljIlglJ5y5qabUhajVMkj3MJiYwxo87J6142/mtBK/9V2RJFI
 vENg1S2SCrmyBGViTDsCEhPbC8ZUIBUKwmWJSYwiNlShimaU7ciJxMUiwW2rz5eEVIQsnrnO
 MHGMYkvlkNaOqSiUuTwZMkOaTGcdvlS1DCQJ/TTS3RrfEEFskL+rd9ix6qITcoeCiRBTwR2P
 Xd6LXacGz7nQ+pblw1Zt/NWRt2r1gDzZpq5Mnvc4dnw/LzDR58JR2/SeYpHnp878+6dz/Pnx
 TkW/O+qcO69NaFY2Ro9rbjjN9siLZwPWk+mgUq9pMa6MlHkexBRK2V+ibjCkVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pHb0jEGDRe0bK4te4cq8Wb49OZ
 LPofv2a2OH9+A7vFpsfXWC06/n5htLi8aw6bxefeI4wWW1++Y7KYcX4fk0XfOXcHbo9NqzrZ
 PDYvqfd4v+8qm0ffllWMHs8Wrmfx+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
 z9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j2okDLAVvJSrW9V1lbGB8IdLFyMkhIWAiMffDP5Yu
 Ri4OIYGljBLf161nhkjISJyc1sAKYQtL/LnWxQZR9JZRoqnvCCNIQlggTGLFyblgDSICfhKH
 lr0Ds5kF9jFJ7HhTCtFwlVGi7UYTG0iCTcBQouttF5jNK2AnsffPdDCbRUBV4s6ZD0xdjBwc
 ogIxEs8WVEOUCEqcnPmEBcTmFHCTaJ93hRVivrrEn3mXoHbJSzRvnQ1li0vcejKfaQKj0Cwk
 7bOQtMxC0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgTG67djPzTsYL20MPsQo
 wMGoxMPLcEI8Rog1say4MvcQowQHs5II761SiRgh3pTEyqrUovz4otKc1OJDjKZAv01klhJN
 zgemj7ySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYwlz4LKBdf7
 eH+49KvgdLGLpcZn07kV7L1MF9+1qE1hPBXnPJN/j/LXK64LFqV7/lD9HhVW/ulWzuSOi/35
 B+/l9BziYLOscL7aobK31EVd9/d5iZB6S8UNtismfd30KWbhhScp7HcN7/xJX75mt+zOVqWN
 +4M3HVdsWtekm7uNwd3k9QMXty4lluKMREMt5qLiRACdA0D65wIAAA==
X-CMS-MailID: 20181218112350eucas1p1b689ae88b6f9d0ed24b1bf9b53be4c2f
X-Msg-Generator: CA
X-RootMTR: 20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <CGME20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783@epcas5p2.samsung.com>
 <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_032406_493646_736971A0 
X-CRM114-Status: GOOD (  20.02  )
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
Cc: Andrzej Hajda <a.hajda@samsung.com>, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAyMDE4LTEyLTEwIDIyOjAzLCBXb2xmcmFtIFNhbmcgd3JvdGU6Cj4gUmVqZWN0aW5n
IHRyYW5zZmVycyBzaG91bGQgYmUgaGFuZGxlZCBieSB0aGUgY29yZS4gQWxzbywgdGhpcyB3aWxs
Cj4gZW5zdXJlIHByb3BlciBsb2NraW5nIHdoaWNoIHdhcyBmb3Jnb3R0ZW4gaW4gdGhpcyBvcGVu
IGNvZGVkIHZlcnNpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5l
c2FzQHNhbmctZW5naW5lZXJpbmcuY29tPgoKVGVzdGVkLWJ5OiBNYXJlayBTenlwcm93c2tpIDxt
LnN6eXByb3dza2lAc2Ftc3VuZy5jb20+CgpXb3JrcyBmaW5lIG9uIFRNMmUgYW5kIE9kcm9pZFhV
My4gVGhlIG9ubHkgbWlub3IgaXNzdWUgaXMgdGhlIGZvbGxvd2luZwp3YXJuaW5nOgoKV0FSTklO
RzogQ1BVOiA0IFBJRDogMjggYXQgZHJpdmVycy9pMmMvaTJjLWNvcmUtYmFzZS5jOjE4NjkKX19p
MmNfdHJhbnNmZXIrMHg0MjgvMHg1ZTAKTW9kdWxlcyBsaW5rZWQgaW46CkNQVTogNCBQSUQ6IDI4
IENvbW06IGNwdWhwLzQgVGFpbnRlZDogR8KgwqDCoMKgwqDCoMKgIFfCoMKgwqDCoMKgwqDCoMKg
CjQuMjAuMC1yYzEtMDAwMzEtZ2ExYzc3NzkwZDAzZiAjNTEzMApIYXJkd2FyZSBuYW1lOiBTYW1z
dW5nIFRNMkUgYm9hcmQgKERUKQpwc3RhdGU6IDIwMDAwMDA1IChuekN2IGRhaWYgLVBBTiAtVUFP
KQpwYyA6IF9faTJjX3RyYW5zZmVyKzB4NDI4LzB4NWUwCmxyIDogaTJjX3RyYW5zZmVyKzB4NjQv
MHhiOAouLi4KQ2FsbCB0cmFjZToKwqBfX2kyY190cmFuc2ZlcisweDQyOC8weDVlMArCoGkyY190
cmFuc2ZlcisweDY0LzB4YjgKwqByZWdtYXBfaTJjX3JlYWQrMHg1Yy8weGEwCsKgX3JlZ21hcF9y
YXdfcmVhZCsweGFjLzB4MmE4CsKgX3JlZ21hcF9idXNfcmVhZCsweDNjLzB4NzAKwqBfcmVnbWFw
X3JlYWQrMHg2NC8weDFhMArCoHJlZ21hcF9yZWFkKzB4NDgvMHg3MArCoHJlZ3VsYXRvcl9pc19l
bmFibGVkX3JlZ21hcCsweDM4LzB4YjgKwqBfcmVndWxhdG9yX2lzX2VuYWJsZWQucGFydC4xKzB4
MWMvMHgzMArCoGNyZWF0ZV9yZWd1bGF0b3IrMHgyNjQvMHgyNzAKwqBfcmVndWxhdG9yX2dldCsw
eDkwLzB4MmIwCsKgcmVndWxhdG9yX2dldF9vcHRpb25hbCsweDEwLzB4MTgKwqBkZXZfcG1fb3Bw
X3NldF9yZWd1bGF0b3JzKzB4YjgvMHgxZTgKwqBjcHVmcmVxX2luaXQrMHhkMC8weDJmOArCoGNw
dWZyZXFfb25saW5lKzB4YzAvMHg2NjAKwqBjcHVocF9jcHVmcmVxX29ubGluZSsweGMvMHgxOArC
oGNwdWhwX2ludm9rZV9jYWxsYmFjaysweGFjLzB4N2IwCsKgY3B1aHBfdGhyZWFkX2Z1bisweGVj
LzB4MTgwCsKgc21wYm9vdF90aHJlYWRfZm4rMHgxZjAvMHgyOTAKwqBrdGhyZWFkKzB4ZmMvMHgx
MjgKwqByZXRfZnJvbV9mb3JrKzB4MTAvMHgxYwotLS1bIGVuZCB0cmFjZSBiZWE1NDEyYmMyMWRl
YjgxIF0tLS0KClNpbWlsYXIgd2FybmluZyB3YXMgYWxyZWFkeSB0aGVyZSAoJ0hTLUkyQyBpcyBu
b3QgaW5pdGlhbGl6ZWQnIG1lc3NhZ2UsCndpdGhvdXQgYmFja3RyYWNlKSBkdXJpbmcgc3lzdGVt
IHN1c3BlbmQvcmVzdW1lLiBJdCBsb29rcyB0aGF0IGNwdSBmcmVxCmlzIHJlc3VtZWQgdG9vIGVh
cmx5LCBiZWZvcmUgYW55IGRldmljZSBkcml2ZXJzLCBidXQgdGhpcyBpcyBub3QgYW4KaXNzdWUg
Zm9yIHRoaXMgcGF0Y2hzZXQuCgo+IC0tLQo+ICBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWV4eW5v
czUuYyB8IDExICsrLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1l
eHlub3M1LmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWV4eW5vczUuYwo+IGluZGV4IGMxY2Uy
Mjk5YTc2ZS4uZmUyZjIwMzFlYTM2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtZXh5bm9zNS5jCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1leHlub3M1LmMKPiBA
QCAtMTgzLDcgKzE4Myw2IEBAIGVudW0gaTJjX3R5cGVfZXh5bm9zIHsKPiAgCj4gIHN0cnVjdCBl
eHlub3M1X2kyYyB7Cj4gIAlzdHJ1Y3QgaTJjX2FkYXB0ZXIJYWRhcDsKPiAtCXVuc2lnbmVkIGlu
dAkJc3VzcGVuZGVkOjE7Cj4gIAo+ICAJc3RydWN0IGkyY19tc2cJCSptc2c7Cj4gIAlzdHJ1Y3Qg
Y29tcGxldGlvbgltc2dfY29tcGxldGU7Cj4gQEAgLTcxNSwxMSArNzE0LDYgQEAgc3RhdGljIGlu
dCBleHlub3M1X2kyY194ZmVyKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcCwKPiAgCXN0cnVjdCBl
eHlub3M1X2kyYyAqaTJjID0gYWRhcC0+YWxnb19kYXRhOwo+ICAJaW50IGksIHJldDsKPiAgCj4g
LQlpZiAoaTJjLT5zdXNwZW5kZWQpIHsKPiAtCQlkZXZfZXJyKGkyYy0+ZGV2LCAiSFMtSTJDIGlz
IG5vdCBpbml0aWFsaXplZC5cbiIpOwo+IC0JCXJldHVybiAtRUlPOwo+IC0JfQo+IC0KPiAgCXJl
dCA9IGNsa19lbmFibGUoaTJjLT5jbGspOwo+ICAJaWYgKHJldCkKPiAgCQlyZXR1cm4gcmV0Owo+
IEBAIC04NDcsOCArODQxLDcgQEAgc3RhdGljIGludCBleHlub3M1X2kyY19zdXNwZW5kX25vaXJx
KHN0cnVjdCBkZXZpY2UgKmRldikKPiAgewo+ICAJc3RydWN0IGV4eW5vczVfaTJjICppMmMgPSBk
ZXZfZ2V0X2RydmRhdGEoZGV2KTsKPiAgCj4gLQlpMmMtPnN1c3BlbmRlZCA9IDE7Cj4gLQo+ICsJ
aTJjX21hcmtfYWRhcHRlcl9zdXNwZW5kZWQoJmkyYy0+YWRhcCwgdHJ1ZSk7Cj4gIAljbGtfdW5w
cmVwYXJlKGkyYy0+Y2xrKTsKPiAgCj4gIAlyZXR1cm4gMDsKPiBAQCAtODcxLDcgKzg2NCw3IEBA
IHN0YXRpYyBpbnQgZXh5bm9zNV9pMmNfcmVzdW1lX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikK
PiAgCj4gIAlleHlub3M1X2kyY19pbml0KGkyYyk7Cj4gIAljbGtfZGlzYWJsZShpMmMtPmNsayk7
Cj4gLQlpMmMtPnN1c3BlbmRlZCA9IDA7Cj4gKwlpMmNfbWFya19hZGFwdGVyX3N1c3BlbmRlZCgm
aTJjLT5hZGFwLCBmYWxzZSk7Cj4gIAo+ICAJcmV0dXJuIDA7Cj4gIH0KCkJlc3QgcmVnYXJkcwot
LSAKTWFyZWsgU3p5cHJvd3NraSwgUGhEClNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
