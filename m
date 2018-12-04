Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253ADC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59912082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pDeUkxjn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Avc9zmM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59912082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4MCw2LHJJz0Lux5SFNaiaIS81VDsRdeNnj6/onVCX+0=; b=pDeUkxjnRH2CEh
	EQZQyyMZmes4LnDpLLDInUlFP/278ipkqIxkkvsRDLSbV1AtE2E9UIRVluARXxBRGxHzL+O7aHKqN
	/NYPmFIYong6XA9o8XseMculJ4V8VTxuFP2vCX3h12oMRMS8w037sdupFcoiPJtHgyQ5kEQI1kTp2
	oRTuQNcWa9XU9lLd/IKfnRipmg7iS1Y4ahfB/Q54mn0WvIso+9EcgEd6bwrT6EY9EQwn3In4aAYQV
	TmvUkZm/VosGzdtYnqtD/RsF7GXnDisQ5v//0nBQM0AnU8h6lyQetfA2uDhJ9894MBPghgHKRdui6
	2KdM1n6iYnMe+wGKhKLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7GO-0003JT-60; Tue, 04 Dec 2018 09:45:08 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7GJ-0002ZY-0c
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:45:05 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181204094451euoutp02f8d8cb38b9d051f6a9715aff88340e5a~tGAzxOxTo1434114341euoutp02J
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 09:44:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181204094451euoutp02f8d8cb38b9d051f6a9715aff88340e5a~tGAzxOxTo1434114341euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543916691;
 bh=f+WU9Gp86xU9qgTi6jNl25QiCGGFXV/6k5uQqb9i5No=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Avc9zmM6GBHcnjpNtUOITggKOu3Fabq2TadSCFmL0ZLrT5zPtFQCnp+RyjA7CpU9L
 cZSGShd0kx+cQQphHsS0d12yUtgi9o87ybPQSbCBxoZolYlRtwrvA7eucMTgDRLIe4
 qCKgcZrKUbAm+alLMCnPdrOQZdbjjrSqtjVszIJ8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181204094449eucas1p1e079a735091b9c12c7ea5f1f40ddddb9~tGAynlO_o2232222322eucas1p1B;
 Tue,  4 Dec 2018 09:44:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 61.03.04806.19C460C5; Tue,  4
 Dec 2018 09:44:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181204094448eucas1p2c7e2367dad1909b112b42df4de88fac5~tGAxyHJFc2425624256eucas1p2F;
 Tue,  4 Dec 2018 09:44:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181204094448eusmtrp105a67b802cb088e17d5b94b203168f22~tGAxiTLj41089810898eusmtrp1h;
 Tue,  4 Dec 2018 09:44:48 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-32-5c064c91ddfe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.1C.04284.09C460C5; Tue,  4
 Dec 2018 09:44:48 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181204094447eusmtip19cc51854e23421e50f2e2aa7f08d4fbe~tGAwkt-iM2933329333eusmtip1j;
 Tue,  4 Dec 2018 09:44:47 +0000 (GMT)
Subject: Re: [PATCH v2 3/5] devfreq: add devfreq_suspend/resume() functions
To: Chanwoo Choi <cw00.choi@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <bb7c2fd1-69e2-fdc6-ecb9-83ee22c2601e@partner.samsung.com>
Date: Tue, 4 Dec 2018 10:44:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C061C74.808@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeVCMYRzHPfuepc3Tin5yzew4yoxo+OMZjMEYXsOMzDCz2MHSOznalX0r
 woxFlxy5ZR3RhmaLtLatiUTXypbkiojI2eHKPU1pezP67/P9Pd/vPN/fMw9PqU6z/vwaQ6Ro
 NOjC1awn7Sj/fWfsgXmsdvzzvKHkZm4gyUnJZkhezg+G1H57x5DU0jsM2WnJZknlbj1Jbmym
 SHX1ZY5U7WjhiPlwoYLYGh8x5H7BSZa07S1FJKX6uoJcLK3nyLnaGgV5uj2DJfW3y7ryrnsM
 iSss5Uh85meGtNx9Tk/zExxXHYyQdToLCSdMNbSwP/krEizXPigEm3UXKxSdyuKEK+nbhI5y
 TrA/TKCFfXYrEjIyf3JCm21YiHKJ55RQMXxNtGgcN3WF5+qEX7u4iPbhm5wJrAl9HZSEPHjA
 E+FTUrsiCXnyKpyB4EGnk5bFNwSVJXZOFm0Iam+UKf5FYt8f6YlcQHD2WiUli1YEX0qaOLer
 P54LL2MrkfvAF7sQFBUVs25B4TgKOj7buwTPszgI8q0b3AElngVxmc3dYRqPAEdZMuvmAVgD
 iS8yWdnjAxXHX9Nu9sCj4XBcAeVmCvtB3etUhczDYWfuie5GgJ/x8Ke1k5J7z4SCcisjc39o
 cto5mYeA69AeWmYJqhKtrMxbIaEiv8czGUqcNYy7M4UDIbtgnDyeDkm5pu4xYG943OojV/CG
 g45jlDxWQmK8SnYHgH3P3Z5HHAgXso5y+5Ha3Gsxc69lzL2WMf+/9wyirchPjJL0YaI0wSBu
 DJJ0einKEBa0ar3ehrp+ravD+T0fXW9fWYwwj9ReypQZjFbF6KKlGH0xAp5S+yqfjWK1KmWo
 LmazaFy/3BgVLkrFaDBPq/2UW/o0LFXhMF2kuE4UI0Tjv1MF7+FvQjMOOdLn+IZ4f9ycaqvr
 LGyMcnktgwhfTYvpVaRl03kTHnDr3qczrxZpBjYHlCfmVY0c/bau3xDLGzH4kmXiwktpH7Ua
 e/3t2ertW3+tLXr5RBvvH6O5P31qaN9ow8HFV/mL+V5oSu6RlvkNSw4MjbVV/GgInryg71Pb
 pPHzmDd708xNalparQseQxkl3V+QAdKVsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec/ZuagNTtP0zQ9Z6yJFzebUvZaOCspD9iGoqMyooQe1Nmc7
 W2UFWbaGRm2Ggc3SyiRRS91M7aKVrEytlloK6UxRKNMudLNSRpsr2Lcf/J/fc4GHxkVWIpTO
 yNRx2kylSkz6Czpdbc4V5k1k8srp2gXo0e2lqK6ohkCNdT8J1Pf9HYFK7S8IlFtWQ6JnZ9TI
 NDKOI4ejlkLPT05QyFLYjCHrSC+Beu5eItG3s3aAihwtGLppd1KovK8LQ/0nKkjk7Hjs9ju7
 CWRotlPodNUXAk28HBSsCWEb7jUQbHVJNWCLc7oErNn0FbBl98cw1lqZR7IPLldTrO36cdb1
 hGLrXxsF7Ln6SsBWVE1S7DfrvM3CJEmcVqPXcfPTNbwuXrxLiiIl0lgkiYyKlUhl8t2rIqPF
 EYq4VE6VcZDTRij2StKNv/KorOmww21GMgd8nZsP/GjIRMFT7y9g+cCfFjHlAD4dLca9QTA8
 39JIeTkQTvfmk96icQCnnJ8xTxDIJMLhU8+AJwhiOgEsdHTMtMIZAw7HPl4DXuUPgPcKatw+
 TZOMBDZVHvDYQmYDNFSNz4wQMItgw2MT6eE5zA74fOwW8NbMhu0XRwUe9mPCYaHh7sx6OBMD
 S2zD/zgEvhktxbwcBnNvF+NmILL46BYfxeKjWHyUK0BQCYI4Pa9OU/NSCa9U8/rMNEmKRm0F
 7n9pePLb1gS667a0AoYG4lnConVEsohQHuSz1a0A0rg4SDiwhEwWCVOV2Uc4rWaPVq/i+FYQ
 7T6uAA+dk6Jxf1+mbo80WipHsVK5TC6LQeIQoWNldpKISVPquP0cl8Vp/3sY7ReaA+hgm1nx
 dvlCTQ+2+fCPq4OHEM6sjz8rvPFBvU3/9IzJPywhKWG9eHI4Zsm+irjEfnlBW79/2bmByeqA
 zsWtyavvuHbmWcuPBhiHp0H31hXqsWOqDblreZcpwzRg2rhwPin0G9p+nykL5x++OmIMmdrd
 bkto1g3Z60/Lgj/hio9iAZ+ulC7DtbzyL+dOnXVFAwAA
X-CMS-MailID: 20181204094448eucas1p2c7e2367dad1909b112b42df4de88fac5
X-Msg-Generator: CA
X-RootMTR: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143132eucas1p128c029a7c7461e1127924a08e4a71811@eucas1p1.samsung.com>
 <1543847475-7600-4-git-send-email-l.luba@partner.samsung.com>
 <5C061C74.808@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_014503_196415_4D9B3F47 
X-CRM114-Status: GOOD (  22.99  )
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

SGkgQ2hhbndvbywKCk9uIDEyLzQvMTggNzoxOSBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhp
IEx1a2FzeiwKPiAKPiBPbiAyMDE464WEIDEy7JuUIDAz7J28IDIzOjMxLCBMdWthc3ogTHViYSB3
cm90ZToKPj4gVGhpcyBwYXRjaCBhZGRzIGltcGxlbWVudGF0aW9uIGZvciBnbG9iYWwgc3VzcGVu
ZC9yZXN1bWUgZm9yCj4+IGRldmZyZXEgZnJhbWV3b3JrLiBTeXN0ZW0gc3VzcGVuZCB3aWxsIG5l
eHQgdXNlIHRoZXNlIGZ1bmN0aW9ucy4KPj4KPj4gVGhlIHBhdGNoIGlzIGJhc2VkIG9uIGVhcmxp
ZXIgd29yayBieSBUb2JpYXMgSmFrb2JpLgo+IAo+IFBsZWFzZSByZW1vdmUgaXQgZnJvbSBlYWNo
IHBhdGNoIGRlc2NyaXB0aW9uLgpPSwo+IAo+Pgo+PiBTdWdnZXN0ZWQtYnk6IFRvYmlhcyBKYWtv
YmkgPHRqYWtvYmlAbWF0aC51bmktYmllbGVmZWxkLmRlPgo+PiBTdWdnZXN0ZWQtYnk6IENoYW53
b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBMdWthc3og
THViYSA8bC5sdWJhQHBhcnRuZXIuc2Ftc3VuZy5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZGV2
ZnJlcS9kZXZmcmVxLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPj4gICBpbmNsdWRlL2xpbnV4L2RldmZyZXEuaCAgIHwgIDYgKysrKysrCj4+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+PiBpbmRleCAz
NmJlZDI0Li43ZDYwNDIzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5j
Cj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4gQEAgLTkzNSw2ICs5MzUsNDgg
QEAgaW50IGRldmZyZXFfcmVzdW1lX2RldmljZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPj4g
ICBFWFBPUlRfU1lNQk9MKGRldmZyZXFfcmVzdW1lX2RldmljZSk7Cj4+ICAgCj4+ICAgLyoqCj4+
ICsgKiBkZXZmcmVxX3N1c3BlbmQoKSAtIFN1c3BlbmQgZGV2ZnJlcSBnb3Zlcm5vcnMgYW5kIGRl
dmljZXMKPj4gKyAqCj4+ICsgKiBDYWxsZWQgZHVyaW5nIHN5c3RlbSB3aWRlIFN1c3BlbmQvSGli
ZXJuYXRlIGN5Y2xlcyBmb3Igc3VzcGVuZGluZyBnb3Zlcm5vcnMKPj4gKyAqIGFuZCBkZXZpY2Vz
IHByZXNlcnZpbmcgdGhlIHN0YXRlIGZvciByZXN1bWUuIE9uIHNvbWUgcGxhdGZvcm1zIHRoZSBk
ZXZmcmVxCj4+ICsgKiBkZXZpY2UgbXVzdCBoYXZlIHByZWNpc2Ugc3RhdGUgKGZyZXF1ZW5jeSkg
YWZ0ZXIgcmVzdW1lIGluIG9yZGVyIHRvIHByb3ZpZGUKPj4gKyAqIGZ1bGx5IG9wZXJhdGluZyBz
ZXR1cC4KPj4gKyAqLwo+PiArdm9pZCBkZXZmcmVxX3N1c3BlbmQodm9pZCkKPj4gK3sKPj4gKwlz
dHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcTsKPj4gKwlpbnQgcmV0Owo+PiArCj4+ICsJbXV0ZXhfbG9j
aygmZGV2ZnJlcV9saXN0X2xvY2spOwo+PiArCWxpc3RfZm9yX2VhY2hfZW50cnkoZGV2ZnJlcSwg
JmRldmZyZXFfbGlzdCwgbm9kZSkgewo+PiArCQlyZXQgPSBkZXZmcmVxX3N1c3BlbmRfZGV2aWNl
KGRldmZyZXEpOwo+PiArCQlpZiAocmV0KQo+PiArCQkJZGV2X3dhcm4oJmRldmZyZXEtPmRldiwg
ImRldmljZSBzdXNwZW5kIGZhaWxlZFxuIik7Cj4gCj4gV2hlbiBJIGNoZWNrZWQgdGhlIGNwdWZy
ZXFfc3VzcGVuZCgpLCBjcHVmcmVxX3N1c3BlbmQoKSBwcmludHMgbWVzc2FnZSBhcyAnZXJyJyBs
ZXZlbC4KPiBJIHRoaW5rIHRoYXQgZGV2X2VyciBpcyBtb3JlIHByb3BlciB0aGFuIGRldl93YXJu
Lgo+IAo+IEknbSBub3Qgc3VyZSB3aGF0IGlzIG1vcmUgY29ycmVjdCBsb2cuCj4gQnV0LCAnZGV2
ZnJlcS0+ZGV2JyBkZXZpY2UgaGFzIHRoZSBzZXBhcmF0ZSBzdXNwZW5kL3Jlc3VtZSBmdW5jdGlv
bi4KPiBTbywgSSB0aGluayB0aGF0IGRldmZyZXFfc3VzcGVuZCgpIHNob3VsZCBwcmludCBlcnJv
ciBsb2cgY29udGFpbmluZwo+IHRoYXQgaXQgaXMgZXJyb3IgYnkgZGV2ZnJlcSBmcmFtZXdvcmsu
Cj4gCj4gImRldmljZSBzdXNwZW5kIGZhaWxlZCIKPiAtPiAiZmFpbGVkIHRvIHN1c3BlbmQgZGV2
ZnJlcSBkZXZpY2UiCk9LLCBjaGFuZ2VkIGluIG5leHQgdjMgcGF0Y2ggc2V0Lgo+IAo+PiArCX0K
Pj4gKwltdXRleF91bmxvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsKPj4gK30KPj4gKwo+PiArLyoq
Cj4+ICsgKiBkZXZmcmVxX3Jlc3VtZSgpIC0gUmVzdW1lIGRldmZyZXEgZ292ZXJub3JzIGFuZCBk
ZXZpY2VzCj4+ICsgKgo+PiArICogQ2FsbGVkIGR1cmluZyBzeXN0ZW0gd2lkZSBTdXNwZW5kL0hp
YmVybmF0ZSBjeWNsZSBmb3IgcmVzdW1pbmcgZ292ZXJub3JzIGFuZAo+PiArICogZGV2aWNlcyB0
aGF0IGFyZSBzdXNwZW5kZWQgd2l0aCBkZXZmcmVxX3N1c3BlbmQoKS4KPj4gKyAqLwo+PiArdm9p
ZCBkZXZmcmVxX3Jlc3VtZSh2b2lkKQo+PiArewo+PiArCXN0cnVjdCBkZXZmcmVxICpkZXZmcmVx
Owo+PiArCWludCByZXQ7Cj4+ICsKPj4gKwltdXRleF9sb2NrKCZkZXZmcmVxX2xpc3RfbG9jayk7
Cj4+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShkZXZmcmVxLCAmZGV2ZnJlcV9saXN0LCBub2RlKSB7
Cj4+ICsJCXJldCA9IGRldmZyZXFfcmVzdW1lX2RldmljZShkZXZmcmVxKTsKPj4gKwkJaWYgKHJl
dCkKPj4gKwkJCWRldl93YXJuKCZkZXZmcmVxLT5kZXYsICJkZXZpY2UgcmVzdW1lIGZhaWxlZFxu
Iik7Cj4gCj4gZGl0dG8uCj4gCj4gImRldmljZSByZXN1bWUgZmFpbGVkIgo+IC0+ICJmYWlsZWQg
dG8gcmVzdW1lIGRldmZyZXEgZGV2aWNlIgo+IApBQ0sKClJlZ2FyZHMsCkx1a2Fzego+IAo+PiAr
CX0KPj4gKwltdXRleF91bmxvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsKPj4gK30KPj4gKwo+PiAr
LyoqCj4+ICAgICogZGV2ZnJlcV9hZGRfZ292ZXJub3IoKSAtIEFkZCBkZXZmcmVxIGdvdmVybm9y
Cj4+ICAgICogQGdvdmVybm9yOgl0aGUgZGV2ZnJlcSBnb3Zlcm5vciB0byBiZSBhZGRlZAo+PiAg
ICAqLwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLmggYi9pbmNsdWRlL2xp
bnV4L2RldmZyZXEuaAo+PiBpbmRleCBkOTg1MTk5Li5mYmZmYTc0IDEwMDY0NAo+PiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2RldmZyZXEuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RldmZyZXEuaAo+
PiBAQCAtMjA1LDYgKzIwNSw5IEBAIGV4dGVybiB2b2lkIGRldm1fZGV2ZnJlcV9yZW1vdmVfZGV2
aWNlKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4gICBleHRlcm4gaW50IGRldmZyZXFfc3VzcGVuZF9k
ZXZpY2Uoc3RydWN0IGRldmZyZXEgKmRldmZyZXEpOwo+PiAgIGV4dGVybiBpbnQgZGV2ZnJlcV9y
ZXN1bWVfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKTsKPj4gICAKPj4gK2V4dGVybiB2
b2lkIGRldmZyZXFfc3VzcGVuZCh2b2lkKTsKPj4gK2V4dGVybiB2b2lkIGRldmZyZXFfcmVzdW1l
KHZvaWQpOwo+PiArCj4+ICAgLyoqCj4+ICAgICogdXBkYXRlX2RldmZyZXEoKSAtIFJlZXZhbHVh
dGUgdGhlIGRldmljZSBhbmQgY29uZmlndXJlIGZyZXF1ZW5jeQo+PiAgICAqIEBkZXZmcmVxOgl0
aGUgZGV2ZnJlcSBkZXZpY2UKPj4gQEAgLTMzMSw2ICszMzQsOSBAQCBzdGF0aWMgaW5saW5lIGlu
dCBkZXZmcmVxX3Jlc3VtZV9kZXZpY2Uoc3RydWN0IGRldmZyZXEgKmRldmZyZXEpCj4+ICAgCXJl
dHVybiAwOwo+PiAgIH0KPj4gICAKPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBkZXZmcmVxX3N1c3Bl
bmQodm9pZCkge30KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBkZXZmcmVxX3Jlc3VtZSh2b2lkKSB7
fQo+PiArCj4+ICAgc3RhdGljIGlubGluZSBzdHJ1Y3QgZGV2X3BtX29wcCAqZGV2ZnJlcV9yZWNv
bW1lbmRlZF9vcHAoc3RydWN0IGRldmljZSAqZGV2LAo+PiAgIAkJCQkJICAgdW5zaWduZWQgbG9u
ZyAqZnJlcSwgdTMyIGZsYWdzKQo+PiAgIHsKPj4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
