Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:58:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7F6206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AUb6xYKF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UruqTDwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7F6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:Date:Message-id:
	From:To:Subject:MIME-version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zRC83R8IdFKlZPydGhvfLNqupLyB6bF2xRzBoMEf/XY=; b=AUb6xYKF8Dvh3L
	z0vKuhdkC+1lo74sQvaM9zBa8JqY8QMYTdnB9gFFd+1kAPXGdq+W4qFQzjDtfTY8h10ZHP7oP0L2p
	D0CIVc3rcruDlLKewcEhi84Wv3t0Ojx56pq8daKySJYQabYDNT4ShK0ErZjrnmkOYNdcLWUKh99Zh
	+A9DslXhOLh8dB/Tut53qJSUYRMHPFkFHrNoIwnBbDqDLAEHbs9kVtctxIYJmPEae5fvhBpeXFfKi
	5rAlfSsaQaK4lO6ILta57tLRQc1MX/BYqeBoSXXO7zNXOJZ1HttRxtZSQ7w9T5fk9o4cY3F6HSsak
	/mJqBwI+g/eZ9MNDvZdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghX6f-00005p-IR; Thu, 10 Jan 2019 09:58:33 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghX6b-00005L-VX
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:58:32 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20190110095825epoutp01176f68009949863b5e17fb3f0d17ddac~4dEOZlFD83218732187epoutp01T;
 Thu, 10 Jan 2019 09:58:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20190110095825epoutp01176f68009949863b5e17fb3f0d17ddac~4dEOZlFD83218732187epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1547114305;
 bh=x5QnG5QWV4ikDkyVvItuyikbiv+1Rm7pJ0zkHbIZ7WU=;
 h=Subject:To:Cc:From:Date:In-reply-to:References:From;
 b=UruqTDwtQxThsCLBdx0WbAxZyQ8XYQC01dosn8dVKi2UhDrYORs5M6eQrOw/09izL
 kyEG8T1SuykcSDZvABRWSyFP5nO5S7hLhVNtOrV41dKK1edSBlKHFcGgjn1Zb9Bg3r
 diCAuLvmN/rUQrtF3ckjjTD99t20rC/rytn1Gqus=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20190110095824epcas2p4668cebecc31b71483dad197f278445ad~4dENT7adq0371003710epcas2p4R;
 Thu, 10 Jan 2019 09:58:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 FD.A2.04055.047173C5; Thu, 10 Jan 2019 18:58:24 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20190110095823epcas2p1936a8d201409b837f9cbd12497fb0e25~4dEMX922X2503425034epcas2p1a;
 Thu, 10 Jan 2019 09:58:23 +0000 (GMT)
X-AuditID: b6c32a48-3c1ff70000000fd7-90-5c3717405503
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
 (Symantec Messaging Gateway) with SMTP id 09.36.03627.F37173C5; Thu, 10 Jan
 2019 18:58:23 +0900 (KST)
MIME-version: 1.0
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PL40086D118YF10@mmp2.samsung.com>; Thu, 10 Jan 2019 18:58:23 +0900 (KST)
Subject: Re: [PATCH] media: s5p-jpeg: Correct step and max values for
 V4L2_CID_JPEG_RESTART_INTERVAL
To: =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <146706fc-007a-c4f9-7ecf-b1bd893bb79d@samsung.com>
Date: Thu, 10 Jan 2019 10:58:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-reply-to: <20190109180041.31052-1-pawel.mikolaj.chmiel@gmail.com>
Content-language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCmua6DuHmMwayvkha3t25gsdj0+Bqr
 xeVdc9gsejZsZbWYcX4fk8WyTX+YLH4c72N2YPfYOesuu8emVZ1sHpuX1Ht83iQXwBLFZZOS
 mpNZllqkb5fAlXHhomDBKZaKVZvnszYwvmXuYuTkkBAwkbjcO5+1i5GLQ0hgB6PEz6aNTBDO
 d0aJNXM3sHQxcoBV7Z+QCdIgJLCBUeJRoziIzSsgKPFj8j0WEJtZQFPixZdJLBA19xklnlxV
 AbGFBdIkLt2dAbZMRMBJonfrK2aQ+cwCu4Bqvv0Da2ATMJToPdrHCDHUTuLp3u9MIHtZBFQl
 PnyrAgmLCkRIdNxfzQYS5hRwkbjzthxirbjEsfs3GSFseYmDV56zQPx1hk1i3iFrCNtForfn
 BBOELSzx6vgWdghbWuLZqo2MEHa1xK7t3WCnSQh0MEq0XNgODSBricPHL7JCLOCT6Dj8lx0S
 JLwSHW1CECUeEluXLmSHBNt0RomlV0+xTGCUnYUURLOQgmgWkrtnIbl7ASPLKkax1ILi3PTU
 YqMCE73ixNzi0rx0veT83E2M4ESh5bGD8cA5n0OMAhyMSjy8CsvNYoRYE8uKK3MPMUpwMCuJ
 8N4BCfGmJFZWpRblxxeV5qQWH2KU5mBREud9KD03WkggPbEkNTs1tSC1CCbLxMEp1cBooefB
 zlJTs3BH1667wW/zmucEyakc1nSrNb1X0Dn9pFJ1/RcHRl6+fHVD85yq0gPPTyxuXnTLQjvf
 WE/ywsuA6/bO/6ae6H4QNI//ZcmlcteuKWvLZtg0Vu7msQ/bt/RH6tyWybE5u6e9MU7c8/Wg
 Yl360bD7Qsu6M60zv/Lfi7/JohifE6bEUpyRaKjFXFScCADxK3mjEAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t9jQV17cfMYg0e9sha3t25gsdj0+Bqr
 xeVdc9gsejZsZbWYcX4fk8WyTX+YLH4c72N2YPfYOesuu8emVZ1sHpuX1Ht83iQXwBLFZZOS
 mpNZllqkb5fAlXHhomDBKZaKVZvnszYwvmXuYuTgkBAwkdg/IbOLkYtDSGAdo8Sb6ZdYuxg5
 OXgFBCV+TL7HAlLDLKAuMWVKLkTNQ0aJGfcns4HUCAukSVy6O4MZxBYRcJLo3fqKGaSIWWAX
 o8TlM5/BEkICzhKb521jArHZBAwleo/2MUIssJN4uvc7E8gCFgFViQ/fqkDCogIREmdfrmME
 CXMKuEjceVsOEmYWEJc4dv8mI4QtL3HwynOWCYwCs5BcOgvh0llIOmYh6VjAyLKKUTK1oDg3
 PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMw4Lcd1urfwfh4SfwhRgEORiUe3oR/pjFCrIllxZW5
 hxglOJiVRHjvLDeLEeJNSaysSi3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1tSC1CCbL
 xMEp1cA437vmM4dswOepDKbz+xM29XXuPNn1SrVK6eYEyb5He9P1/prM3vC/+42F+sxVql2O
 7TMMnXwcVDNDpec93v1tBZ+5j+Q3S01eiyN7Vl1q73+W8vrA+0vsqed23yoqvdv6R1/6qKWj
 8i/bcw8s3QQ/BjqscDY3qnQVv9gYvnaixeGpcWJpptxKLMUZiYZazEXFiQCT4vQudAIAAA==
X-CMS-MailID: 20190110095823epcas2p1936a8d201409b837f9cbd12497fb0e25
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20190110095823epcas2p1936a8d201409b837f9cbd12497fb0e25
References: <20190109180041.31052-1-pawel.mikolaj.chmiel@gmail.com>
 <CGME20190110095823epcas2p1936a8d201409b837f9cbd12497fb0e25@epcas2p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_015830_346252_C8CB9DD7 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 jacek.anaszewski@gmail.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMS85LzE5IDE5OjAwLCBQYXdlxYIgQ2htaWVsIHdyb3RlOgo+IFRoaXMgY29tbWl0IGNvcnJl
Y3RzIG1heCBhbmQgc3RlcCB2YWx1ZXMgZm9yIHY0bDIgY29udHJvbCBmb3IKPiBWNEwyX0NJRF9K
UEVHX1JFU1RBUlRfSU5URVJWQUwuIE1heCBzaG91bGQgYmUgMHhmZmZmIGFuZCBzdGVwIHNob3Vs
ZCBiZSAxLgo+IEl0IHdhcyBmb3VuZCBieSB1c2luZyB2NGwyLWNvbXBsaWFuY2UgdG9vbCBhbmQg
Y2hlY2tpbmcgcmVzdWx0IG9mCj4gVklESU9DX1FVRVJZX0VYVF9DVFJML1FVRVJZTUVOVSB0ZXN0
Lgo+IFByZXZpb3VzbHkgaXQgd2FzIGNvbXBsYWluaW5nIHRoYXQgc3RlcCB3YXMgYmlnZ2VyIHRo
YW4gZGlmZmVyZW5jZQo+IGJldHdlZW4gbWF4IGFuZCBtaW4uCj4gCj4gRml4ZXM6IDE1ZjRiYzNi
MWY0MiAoIlttZWRpYV0gczVwLWpwZWc6IEFkZCBKUEVHIGNvbnRyb2xzIHN1cHBvcnQiKQo+IFNp
Z25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNv
bT4KClJldmlld2VkLWJ5OiBTeWx3ZXN0ZXIgTmF3cm9ja2kgPHMubmF3cm9ja2lAc2Ftc3VuZy5j
b20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
