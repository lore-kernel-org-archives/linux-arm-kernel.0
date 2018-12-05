Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35684C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:10:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAC22082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DyEG4W3O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pbLQRMPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAC22082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Subject:To:From:
	Date:Message-id:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gVOKVDB8VX3uw2X9nqzMxo4soFYXCyO4nwGssK+OcaQ=; b=DyEG4W3OrEd72D
	FOgPXLJ+6QkRR1Ft/XfXitIKvnZNQDIiRA2v4QAzN/ZGss5c2Z1r9xMnCF23E15wZsjnEyBJ9tDEM
	YGcqYRwV/zdRnyo4iBBCaN787ZclCD0sqx8I89odHbzrztxhcB2z79CI3c5fujUFWbofHVRlp2RdI
	zgOok8NUcqCchbeTUyc1wHQsiORCWLmq7Q13jhSLU+RZMjTFiIKcPUWX756X1AkIA0HSS2dV0gLrQ
	oAvq7FOgmKMt8qOtyLDboIQeCg0YWArEY0x03SHQzIBzxsQ//HD4XO64eEnFk6HHq+6kJD4aFdJLb
	Yt1UmDC+YUmZHJXaoB3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUKlN-0007Km-22; Wed, 05 Dec 2018 00:10:01 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUKlI-0007Jd-Tj
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 00:09:59 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20181205000941epoutp03162469c6aa70d2b67fd03a3c23b48f86~tRz6sWV5d2161921619epoutp039;
 Wed,  5 Dec 2018 00:09:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20181205000941epoutp03162469c6aa70d2b67fd03a3c23b48f86~tRz6sWV5d2161921619epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543968581;
 bh=S+QT0DZsFYe1xVEY8vxx3e2XiJylriJ1xvs0T7i23kQ=;
 h=Date:From:To:Cc:Subject:In-reply-to:References:From;
 b=pbLQRMPYjhcf8AQw4oC2fVBTn3I5BGZlusoJ/xsQhp9sTWuYt98Kuz07SIf8pBaHz
 nvqByUlIBa2JuW8t3vOiVOJgycYWOwOftVSjmC+BiiuqBVBASlz8cXlAwMvSb8UhdB
 cI1GOS+C/Q7LpatVy2tcLcQG0qEtt/p0JONqpjH0=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20181205000938epcas1p3882db0e0d5885f6e74abcf818386dfe0~tRz3777Ei1857018570epcas1p3-;
 Wed,  5 Dec 2018 00:09:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 7C.3A.04060.247170C5; Wed,  5 Dec 2018 09:09:38 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181205000937epcas1p18e44f236dbc6ab59bd589cddda184591~tRz3LEkwy0638406384epcas1p1y;
 Wed,  5 Dec 2018 00:09:37 +0000 (GMT)
X-AuditID: b6c32a37-411ff70000000fdc-68-5c071742d415
Received: from epmmp1.local.host ( [203.254.227.16]) by
 epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F8.24.03601.147170C5; Wed,  5 Dec 2018 09:09:37 +0900 (KST)
MIME-version: 1.0
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ800MV4LS0DG10@mmp1.samsung.com>; Wed, 05 Dec 2018 09:09:37 +0900 (KST)
Message-id: <5C071740.7090000@samsung.com>
Date: Wed, 05 Dec 2018 09:09:36 +0900
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
In-reply-to: <7662d626-5c3e-aec5-05e4-c6cd2e56ef49@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjOud+QlV2qyJF91bvMCKTApVaOxi5mI/NmI47EZB+MyO7gDkg/
 11vccEuGY+DGGGXikKGsLuBioIBWhhbqiLWoYZsoBreM1f3AEaYMO1DK4iBrezHj3/s+7/O8
 73mfcw6Dq0NUClNucUh2i2jiqHii/0Jqpva5ZLowa/9EBjr/XSo61dJLojOnFkjkClwhUXV7
 L4V+/MyMnJN3cDQ6epJGP300Q6Nfqx5HrYfOYcgzeYNE1weOUmj+8wBALaPfY6g7EKTR8Z+v
 YWhi/wkKBUeGIz1+GCNRzbkAjWq7QiSauXqT2JEs9A/2k4L7azcQjlRdI4RG5xwQ2n1/YoKn
 81NKGGpz08Lpjg+F5Yu0cH7Whwl94wcIoaGvEwgnusK0MO95Mj+hwLi9TBJLJLtGshRbS8ot
 pQbupd1Fzxfpt2TxWn4ryuE0FtEsGbjcvHztC+WmyPqcZq9oqohA+aIsc5nPbrdbKxySpswq
 OwycZCsx2bbaMmTRLFdYSjOKreZtfFZWtj5CfNNY9tvUA8IWznlvuGmWrAKHtXUgjoHsZtgx
 XUPVgXhGzZ4FsP66fyUJA9jcPQcesuavVtNKYRDApoGFWEHFJsLFpptEHWAYnH0KBsaMURhn
 U+H0vYOEwg8C2HJ3jlD4aTAU7MajMcE+A5cX/4rhVAQfmv6FisaPshvg+OJkrH8S+xr0uhZi
 g9eyowC6vT4smuBsDQ6XQ30xxRr2dTjS/kesaxy7E/puNZNREmSXaDjec4ZUdsiFF28rAsiu
 gbcv9dHRY0P2MTg2bFD4BwC8N129Im4EMDRyGlMEOjj1TR2mLJcAZ+/Xk4pYBT+pVSsUATbU
 96x49ACDS/96sUbwROsqm1r/t6l1lU3HAN4J1kk22VwqybxNt/oCPSD22tNyzoKTV/L8gGUA
 94gKHqIK1aS4V640+wFkcG6tKhCOQKoSsXKfZLcW2StMkuwH+ojLX+ApScXWyN+xOIp4fbZO
 p0Ob+S16nueSVbdS2t5Qs6WiQzJKkk2yP9RhTFxKFfhKqhm43OzeNT/8yqUd3sMN/m0f7/n7
 2+a8jmBhopMpuO9JX58+kX6H68DCLufTmbXH3tq0IZHeuZFeEgxf7vMYChzvT71bvTGpIWl9
 743stldntL7dL67bVJAwePloQNPZ9faFu/b4f1wOY63OPtfe8rLX6SI/eOc4sYcZ+r2nciSX
 I+QykU/D7bL4H+035w4DBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jAV1HcfYYg96zZhYHt2pabJyxntVi
 +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
 NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
 xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
 udrO4tG3ZRWjx4rV39k9Pm+SC+CL4rJJSc3JLEst0rdL4Mq48+w3S8F384qjk9+xNjBO1+1i
 5OSQEDCR+HyhmR3EFhLYyShxdrEYiM0rICjxY/I9li5GDg5mAXmJI5eyIUx1iSlTcrsYuYCq
 7zNKNJ7fzAZRriXx4e5aZhCbRUBV4t+PtywgNhtQfP+LG2A1/AKKEld/PGYEmSMqECHRfaIS
 ZI6IwHlGiYN9nawgNcwCrcwSj9qyQGxhgUiJU4ufMkMs+80ksewaRBGngLvEnifTWCcwCsxC
 cuoshFNnIZy6gJF5FaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZGYFxvO6zVt4Px/pL4
 Q4wCHIxKPLwKs9lihFgTy4orcw8xSnAwK4nwHvkOFOJNSaysSi3Kjy8qzUktPsQozcGiJM57
 O+9YpJBAemJJanZqakFqEUyWiYNTqoGxmvGA5+NFc1du3LNgEadt4M5MpRDGpXfuXhdQW8+7
 OZAvrqmWtzE+SrvyhW3siv91msm99hf2f+9+2PEiXjV1g/MVa7U8uYm8a0MLoi5f38zB+/SI
 t8/ig+c/r91tt01xcyIj64lglQp2zx0Mu/03SSRnVsdaCF1tOpC8d/uDR8WJvtz7KucosRRn
 JBpqMRcVJwIA60wOCecCAAA=
X-CMS-MailID: 20181205000937epcas1p18e44f236dbc6ab59bd589cddda184591
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com> <5C06140E.7010603@samsung.com>
 <5C061A57.7040002@samsung.com>
 <7662d626-5c3e-aec5-05e4-c6cd2e56ef49@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_160957_124870_9A5441C0 
X-CRM114-Status: GOOD (  28.38  )
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

SGkgTHVrYXN6LAoKT24gMjAxOOuFhCAxMuyblCAwNOydvCAxODo1MywgTHVrYXN6IEx1YmEgd3Jv
dGU6Cj4gSGkgQ2hhbndvbywKPiAKPiBPbiAxMi80LzE4IDc6MTAgQU0sIENoYW53b28gQ2hvaSB3
cm90ZToKPj4gSGkgTHVrYXN6LAo+Pgo+PiBJIGFkZCB0aGUgY29tbWVudCBhYm91dCAnc3VzcGVu
ZF9jb3VudCcuCj4+Cj4+IE9uIDIwMTjrhYQgMTLsm5QgMDTsnbwgMTQ6NDMsIENoYW53b28gQ2hv
aSB3cm90ZToKPj4+IEhpLAo+Pj4KPj4+IE9uIDIwMTjrhYQgMTLsm5QgMDTsnbwgMTQ6MzYsIENo
YW53b28gQ2hvaSB3cm90ZToKPj4+PiBIaSBMdWthc3osCj4+Pj4KPj4+PiBMb29rcyBnb29kIHRv
IG1lLiBCdXQsIEkgYWRkIHRoZSBzb21lIGNvbW1lbnRzLgo+Pj4+IElmIHlvdSB3aWxsIGZpeCBp
dCwgZmVlbCBmcmVlIHRvIGFkZCBteSB0YWc6Cj4+Pj4gUmV2aWV3ZWQtYnk6IENoYW53b28gY2hv
aSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo+Pj4KPj4+IFNvcnJ5LiBGaXggdHlwbyAnY2hvaScg
dG8gJ0Nob2knIGFzIGZvbGxvd2luZy4KPj4+IFJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3
MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4+Cj4+Pj4KPj4+PiBPbiAyMDE464WEIDEy7JuUIDAz7J28
IDIzOjMxLCBMdWthc3ogTHViYSB3cm90ZToKPj4+Pj4gVGhlIHBhdGNoIHByZXBhcmVzIGRldmZy
ZXEgZGV2aWNlIGZvciBoYW5kbGluZyBzdXNwZW5kL3Jlc3VtZQo+Pj4+PiBmdW5jdGlvbmFsaXR5
LiAgVGhlIG5ldyBmaWVsZHMgd2lsbCBzdG9yZSBuZWVkZWQgaW5mb3JtYXRpb24gZHVyaW5nIHRo
aXMKPj4+Pgo+Pj4+IG5pdHBpY2suIFJlbW92ZSB1bm5lZWRlZCBzcGFjZS4gVGhlcmUgYXJlIHR3
byBzcGFjZXMgYmV0d2VlbiAnLicgYW5kICdUaGUgbmV3Jy4KPj4+Pgo+Pj4+PiBwcm9jZXNzLiAg
RGV2ZnJlcSBmcmFtZXdvcmsgaGFuZGxlcyBvcHAtc3VzcGVuZCBEVCBlbnRyeSBhbmQgdGhlcmUg
aXMgbm8KPj4+Pgo+Pj4+IGRpdHRvLgo+Pj4+Cj4+Pj4+IG5lZWQgb2YgbW9keWZpY2F0aW9ucyBp
biB0aGUgZHJpdmVycyBjb2RlLiAgSXQgdXNlcyBhdG9taWMgdmFyaWFibGVzIHRvCj4+Pj4KPj4+
PiBkaXR0by4KPj4+Pgo+Pj4+PiBtYWtlIHN1cmUgbm8gcmFjZSBjb25kaXRpb24gYWZmZWN0cyB0
aGUgcHJvY2Vzcy4KPj4+Pj4KPj4+Pj4gVGhlIHBhdGNoIGlzIGJhc2VkIG9uIGVhcmxpZXIgd29y
ayBieSBUb2JpYXMgSmFrb2JpLgo+Pj4+Cj4+Pj4gUGxlYXNlIHJlbW92ZSBpdCBmcm9tIGVhY2gg
cGF0Y2ggZGVzY3JpcHRpb24uCj4+Pj4KPj4+Pj4KPj4+Pj4gU3VnZ2VzdGVkLWJ5OiBUb2JpYXMg
SmFrb2JpIDx0amFrb2JpQG1hdGgudW5pLWJpZWxlZmVsZC5kZT4KPj4+Pj4gU3VnZ2VzdGVkLWJ5
OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4+Pj4gU2lnbmVkLW9mZi1i
eTogTHVrYXN6IEx1YmEgPGwubHViYUBwYXJ0bmVyLnNhbXN1bmcuY29tPgo+Pj4+PiAtLS0KPj4+
Pj4gICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPj4+Pj4gICBpbmNsdWRlL2xpbnV4L2RldmZyZXEu
aCAgIHwgIDcgKysrKysrKwo+Pj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJl
cS9kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jCj4+Pj4+IGluZGV4IGE5ZmQ2
MWIuLjM2YmVkMjQgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMK
Pj4+Pj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+Pj4+PiBAQCAtMzE2LDYgKzMx
NiwxMCBAQCBzdGF0aWMgaW50IGRldmZyZXFfc2V0X3RhcmdldChzdHJ1Y3QgZGV2ZnJlcSAqZGV2
ZnJlcSwgdW5zaWduZWQgbG9uZyBuZXdfZnJlcSwKPj4+Pj4gICAJCQkiQ291bGRuJ3QgdXBkYXRl
IGZyZXF1ZW5jeSB0cmFuc2l0aW9uIGluZm9ybWF0aW9uLlxuIik7Cj4+Pj4+ICAgCj4+Pj4+ICAg
CWRldmZyZXEtPnByZXZpb3VzX2ZyZXEgPSBuZXdfZnJlcTsKPj4+Pj4gKwo+Pj4+PiArCWlmIChk
ZXZmcmVxLT5zdXNwZW5kX2ZyZXEpCj4+Pj4+ICsJCWRldmZyZXEtPnJlc3VtZV9mcmVxID0gY3Vy
X2ZyZXE7Cj4+Pj4+ICsKPj4+Pj4gICAJcmV0dXJuIGVycjsKPj4+Pj4gICB9Cj4+Pj4+ICAgCj4+
Pj4+IEBAIC02NjcsNiArNjcxLDkgQEAgc3RydWN0IGRldmZyZXEgKmRldmZyZXFfYWRkX2Rldmlj
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+Pj4+ICAgCX0KPj4+Pj4gICAJZGV2ZnJlcS0+bWF4X2Zy
ZXEgPSBkZXZmcmVxLT5zY2FsaW5nX21heF9mcmVxOwo+Pj4+PiAgIAo+Pj4+PiArCWRldmZyZXEt
PnN1c3BlbmRfZnJlcSA9IGRldl9wbV9vcHBfZ2V0X3N1c3BlbmRfb3BwX2ZyZXEoZGV2KTsKPj4+
Pj4gKwlhdG9taWNfc2V0KCZkZXZmcmVxLT5zdXNwZW5kX2NvdW50LCAwKTsKPj4+Pj4gKwo+Pj4+
PiAgIAlkZXZfc2V0X25hbWUoJmRldmZyZXEtPmRldiwgImRldmZyZXElZCIsCj4+Pj4+ICAgCQkJ
CWF0b21pY19pbmNfcmV0dXJuKCZkZXZmcmVxX25vKSk7Cj4+Pj4+ICAgCWVyciA9IGRldmljZV9y
ZWdpc3RlcigmZGV2ZnJlcS0+ZGV2KTsKPj4+Pj4gQEAgLTg2NywxNCArODc0LDI4IEBAIEVYUE9S
VF9TWU1CT0woZGV2bV9kZXZmcmVxX3JlbW92ZV9kZXZpY2UpOwo+Pj4+PiAgICAqLwo+Pj4+PiAg
IGludCBkZXZmcmVxX3N1c3BlbmRfZGV2aWNlKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxKQo+Pj4+
PiAgIHsKPj4+Pj4gKwlpbnQgcmV0Owo+Pj4+PiArCj4+Pj4+ICAgCWlmICghZGV2ZnJlcSkKPj4+
Pj4gICAJCXJldHVybiAtRUlOVkFMOwo+Pj4+PiAgIAo+Pj4+PiAtCWlmICghZGV2ZnJlcS0+Z292
ZXJub3IpCj4+Pj4+IC0JCXJldHVybiAwOwo+Pj4+PiArCWlmIChkZXZmcmVxLT5nb3Zlcm5vcikg
ewo+Pj4+PiArCQlyZXQgPSBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVx
LAo+Pj4+PiArCQkJCQlERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKTsKPj4+Pj4gKwkJaWYgKHJl
dCkKPj4+Pj4gKwkJCXJldHVybiByZXQ7Cj4+Pj4+ICsJfQo+Pj4+PiArCj4+Pj4+ICsJaWYgKGRl
dmZyZXEtPnN1c3BlbmRfZnJlcSkgewo+Pj4+PiArCQlpZiAoYXRvbWljX2luY19yZXR1cm4oJmRl
dmZyZXEtPnN1c3BlbmRfY291bnQpID4gMSkKPj4+Pj4gKwkJCXJldHVybiAwOwo+Pj4+PiArCj4+
Pj4+ICsJCXJldCA9IGRldmZyZXFfc2V0X3RhcmdldChkZXZmcmVxLCBkZXZmcmVxLT5zdXNwZW5k
X2ZyZXEsIDApOwo+Pj4+PiArCQlpZiAocmV0KQo+Pj4+PiArCQkJcmV0dXJuIHJldDsKPj4+Pj4g
Kwl9Cj4+Cj4+IEluIHRoaXMgcGF0Y2gsIGlmIHNvbWUgdXNlcnMgY2FsbCAnZGV2ZnJlcV9zdXNw
ZW5kX2RldmljZScgdHdpY2UsCj4+ICdkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihk
ZXZmcmVxLCBERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKScKPj4gaXMgY2FsbGVkIHR3aWNlIGJ1
dCBkZXZmcmVxX3NldF90YXJnZXQoKSBpcyBjYWxsZWQgb25seSBvbmUuCj4+IEkga25ldyB0aGF0
IGl0IGlzIG5vIHByb2JsZW0gZm9yIG9wZXJhdGlvbi4KPj4KPj4gQnV0LAo+PiBJIHRoaW5rIHRo
YXQgeW91IGJldHRlciB0byB1c2UgJ3N1c3BlbmRfY291bnQnIGFzIHRoZSByZWZlcmVuY2UgY291
bnQKPj4gb2YgZGV2ZnJlcV9zdXNwZW5kL3Jlc3VtZV9kZXZpY2UoKS4gQnV0LCBpZiB5b3UgdXNl
ICdzdXNwZW5kX2NvdW50Jwo+PiBpbiBvcmRlciB0byBjaGVjayB3aGV0aGVyIHRoaXMgZGV2ZnJl
cSBpcyBzdXNwZW5kZWQgb3Igbm90LAo+PiB3ZSBjYW4gcmVkdWNlIHRoZSB1bm5lZWRlZCByZWR1
bmRhbnQgY2FsbCB3aGVuIGNhbGxpbmcgaXQgdHdpY2UuCj4+Cj4+IGNsb2NrIGFuZCByZWd1bGF0
b3IgdXNlZCB0aGUgJ3JlZmVyZW5jZSBjb3VudCcgbWV0aG9kIGluIG9yZGVyIHRvCj4+IHJlbW92
ZSB0aGUgcmVkdW5kYW50IGNhbGwuCj4gCj4gSSB0aGluayBJJ3ZlIGdvdCB0aGUgcG9pbnQuIEkg
d2lsbCBtb3ZlIHRoZSBhdG9taWMgY2hlY2sganVzdAo+IGFmdGVyIHRoZSAhZGV2ZnJlcSBjaGVj
ay4gU29tZXRoaW5nIGxpa2UgdGhlIGNvZGUgYmVsbG93IGlzIHdoYXQgeW91Cj4gd291bGQgbGlr
ZSB0byBzZWU/Cj4gLS0tODwtLS0tLQo+IGlmICghZGV2ZnJlcSkKPiAJcmV0dXJuIC1FSU5WQUw7
Cj4gaWYgKGF0b21pY19pbmNfcmV0dXJuKCZkZXZmcmVxLT5zdXNwZW5kX2NvdW50KSA+IDEpCj4g
CXJldHVybjA7CgpMb29rcyBnb29kIHRvIG1lLiBJIGFncmVlLgoKPiAKPiAtLS0tPjgtLS0tLS0t
Cj4+Cj4+Cj4+Pj4+ICAgCj4+Pj4+IC0JcmV0dXJuIGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9o
YW5kbGVyKGRldmZyZXEsCj4+Pj4+IC0JCQkJREVWRlJFUV9HT1ZfU1VTUEVORCwgTlVMTCk7Cj4+
Pj4+ICsJcmV0dXJuIDA7Cj4+Pj4+ICAgfQo+Pj4+PiAgIEVYUE9SVF9TWU1CT0woZGV2ZnJlcV9z
dXNwZW5kX2RldmljZSk7Cj4+Pj4+ICAgCj4+Pj4+IEBAIC04ODgsMTQgKzkwOSwyOCBAQCBFWFBP
UlRfU1lNQk9MKGRldmZyZXFfc3VzcGVuZF9kZXZpY2UpOwo+Pj4+PiAgICAqLwo+Pj4+PiAgIGlu
dCBkZXZmcmVxX3Jlc3VtZV9kZXZpY2Uoc3RydWN0IGRldmZyZXEgKmRldmZyZXEpCj4+Pj4+ICAg
ewo+Pj4+PiArCWludCByZXQ7Cj4+Pj4+ICsKPj4+Pj4gICAJaWYgKCFkZXZmcmVxKQo+Pj4+PiAg
IAkJcmV0dXJuIC1FSU5WQUw7Cj4+Pj4+ICAgCj4+Pj4+IC0JaWYgKCFkZXZmcmVxLT5nb3Zlcm5v
cikKPj4+Pj4gLQkJcmV0dXJuIDA7Cj4+Pj4+ICsJaWYgKGRldmZyZXEtPnJlc3VtZV9mcmVxKSB7
Cj4+Pj4+ICsJCWlmIChhdG9taWNfZGVjX3JldHVybigmZGV2ZnJlcS0+c3VzcGVuZF9jb3VudCkg
Pj0gMSkKPj4+Pj4gKwkJCXJldHVybiAwOwo+Pgo+PiBkaXR0by4KPiBTYW1lIGFwcHJvYWNoIGhl
cmU6Cj4gLS0tODwtLS0tLQo+IGlmICghZGV2ZnJlcSkKPiAJcmV0dXJuIC1FSU5WQUw7Cj4gaWYg
KGF0b21pY19kZWNfcmV0dXJuKCZkZXZmcmVxLT5zdXNwZW5kX2NvdW50KSA+PSAxKQo+IAlyZXR1
cm4gMDsKCkxvb2tzIGdvb2QgdG8gbWUuCgo+IC0tLS0+OC0tLS0tLS0KPiAKPiBSZWdhcmRzLAo+
IEx1a2Fzego+Pgo+Pj4+PiAgIAo+Pj4+PiAtCXJldHVybiBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZl
bnRfaGFuZGxlcihkZXZmcmVxLAo+Pj4+PiAtCQkJCURFVkZSRVFfR09WX1JFU1VNRSwgTlVMTCk7
Cj4+Pj4+ICsJCXJldCA9IGRldmZyZXFfc2V0X3RhcmdldChkZXZmcmVxLCBkZXZmcmVxLT5yZXN1
bWVfZnJlcSwgMCk7Cj4+Pj4+ICsJCWlmIChyZXQpCj4+Pj4+ICsJCQlyZXR1cm4gcmV0Owo+Pj4+
PiArCX0KPj4+Pj4gKwo+Pj4+PiArCWlmIChkZXZmcmVxLT5nb3Zlcm5vcikgewo+Pj4+PiArCQly
ZXQgPSBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+Pj4+PiArCQkJ
CQlERVZGUkVRX0dPVl9SRVNVTUUsIE5VTEwpOwo+Pj4+PiArCQlpZiAocmV0KQo+Pj4+PiArCQkJ
cmV0dXJuIHJldDsKPj4+Pj4gKwl9Cj4+Pj4+ICsKPj4+Pj4gKwlyZXR1cm4gMDsKPj4+Pj4gICB9
Cj4+Pj4+ICAgRVhQT1JUX1NZTUJPTChkZXZmcmVxX3Jlc3VtZV9kZXZpY2UpOwo+Pj4+PiAgIAo+
Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kZXZmcmVxLmggYi9pbmNsdWRlL2xpbnV4
L2RldmZyZXEuaAo+Pj4+PiBpbmRleCBlNDk2M2IwLi5kOTg1MTk5IDEwMDY0NAo+Pj4+PiAtLS0g
YS9pbmNsdWRlL2xpbnV4L2RldmZyZXEuaAo+Pj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L2RldmZy
ZXEuaAo+Pj4+PiBAQCAtMTMxLDYgKzEzMSw5IEBAIHN0cnVjdCBkZXZmcmVxX2Rldl9wcm9maWxl
IHsKPj4+Pj4gICAgKiBAc2NhbGluZ19taW5fZnJlcToJTGltaXQgbWluaW11bSBmcmVxdWVuY3kg
cmVxdWVzdGVkIGJ5IE9QUCBpbnRlcmZhY2UKPj4+Pj4gICAgKiBAc2NhbGluZ19tYXhfZnJlcToJ
TGltaXQgbWF4aW11bSBmcmVxdWVuY3kgcmVxdWVzdGVkIGJ5IE9QUCBpbnRlcmZhY2UKPj4+Pj4g
ICAgKiBAc3RvcF9wb2xsaW5nOgkgZGV2ZnJlcSBwb2xsaW5nIHN0YXR1cyBvZiBhIGRldmljZS4K
Pj4+Pj4gKyAqIEBzdXNwZW5kX2ZyZXE6CSBmcmVxdWVuY3kgb2YgYSBkZXZpY2Ugc2V0IGR1cmlu
ZyBzdXNwZW5kIHBoYXNlLgo+Pj4+PiArICogQHJlc3VtZV9mcmVxOgkgZnJlcXVlbmN5IG9mIGEg
ZGV2aWNlIHNldCBpbiByZXN1bWUgcGhhc2UuCj4+Pj4+ICsgKiBAc3VzcGVuZF9jb3VudDoJIHN1
c3BlbmQgcmVxdWVzdHMgY291bnRlciBmb3IgYSBkZXZpY2UuCj4+Pj4+ICAgICogQHRvdGFsX3Ry
YW5zOglOdW1iZXIgb2YgZGV2ZnJlcSB0cmFuc2l0aW9ucwo+Pj4+PiAgICAqIEB0cmFuc190YWJs
ZToJU3RhdGlzdGljcyBvZiBkZXZmcmVxIHRyYW5zaXRpb25zCj4+Pj4+ICAgICogQHRpbWVfaW5f
c3RhdGU6CVN0YXRpc3RpY3Mgb2YgZGV2ZnJlcSBzdGF0ZXMKPj4+Pj4gQEAgLTE2Nyw2ICsxNzAs
MTAgQEAgc3RydWN0IGRldmZyZXEgewo+Pj4+PiAgIAl1bnNpZ25lZCBsb25nIHNjYWxpbmdfbWF4
X2ZyZXE7Cj4+Pj4+ICAgCWJvb2wgc3RvcF9wb2xsaW5nOwo+Pj4+PiAgIAo+Pj4+PiArCXVuc2ln
bmVkIGxvbmcgc3VzcGVuZF9mcmVxOwo+Pj4+PiArCXVuc2lnbmVkIGxvbmcgcmVzdW1lX2ZyZXE7
Cj4+Pj4+ICsJYXRvbWljX3Qgc3VzcGVuZF9jb3VudDsKPj4+Pj4gKwo+Pj4+PiAgIAkvKiBpbmZv
cm1hdGlvbiBmb3IgZGV2aWNlIGZyZXF1ZW5jeSB0cmFuc2l0aW9uICovCj4+Pj4+ICAgCXVuc2ln
bmVkIGludCB0b3RhbF90cmFuczsKPj4+Pj4gICAJdW5zaWduZWQgaW50ICp0cmFuc190YWJsZTsK
Pj4+Pj4KPj4+Pgo+Pj4+Cj4+Pgo+Pj4KPj4KPj4KPiAKPiAKCgotLSAKQmVzdCBSZWdhcmRzLApD
aGFud29vIENob2kKU2Ftc3VuZyBFbGVjdHJvbmljcwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
