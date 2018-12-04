Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F68C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:55:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5544B2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCQ/SZBx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3i94abwr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F2aR87bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5544B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kt29wf+lhRhWozuwUJHrRGSvEY+o2k/KjVuNK6X0AQU=; b=RCQ/SZBxR0Bp4W
	xpLzSawPWZ2L0jvQIDayg/xCZwP/vPoL0XC5RrkXqsZVh8x4rvEZT5IzG4t4ybiN3UvlxLFLEvK40
	LiSOQk7VGjN38MOxdHxRLK1NRr7ptgU0112zdky0wgy33XJaUW0dW79jqVQM/pJ+d1hVAIjzQH2z7
	It9/cRlheLqzmLRCMfdYoeerm+eog3Qxyte/KznHf6xjpbAfy1cqZ5zDOhgBJW+8DPLsbPiHHbpkB
	nLkygS7DSk+e71RaYh2qIXWmowVr5qmuTJSPLuAHTEJ2YsGiUA3qu+/0aZe1iA4kYyQc3ShqK6psG
	magYVI771E+h3m+gtxGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7QK-0000Sw-0X; Tue, 04 Dec 2018 09:55:24 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7QI-0000Sp-6F
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 09:55:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:Content-Type:
 Content-Transfer-Encoding:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:To
 :Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X11KD8/OnWuY3VZejmzvr+fMzr/vWkgerT/hAHvNABw=; b=3i94abwr4lyQKOmS3M3/lQa0k
 Xgai13iSRmgjsyFTTE50/sm0aO+nb2zNfDhD8jknLiVJgxQPUGYFLnsI1WRMt/nO7OHWm3XucRLnN
 uf4xCkt7Xeo8Uv5wTAOaH/GrjGkHpv4hAEuYxSpdN9QtKxCsQQ6FzC+yCSPxUuzmV2hStL6wOP6lb
 ZgYwA9oohdljvJcLE9WErZ6aqx+KU1qPiFsgHWVqvkyMwWCE0p1EAG9XkIYymnEuA6NCVOtyXsvHN
 Ouav5JqS9P2djRHL+P5Rwi4uYYcwrt3OF9yk0CWT5NIpnGe/qRVSMYkw4PUQ4vbnE/dF9FIEuVXy0
 TdN+CUjVg==;
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7QF-0000C0-1U
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:55:20 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20181204095329euoutp0218bca2e71194a7f887f1604f33af52e7~tGIWUyJey1827318273euoutp02Y
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 09:53:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20181204095329euoutp0218bca2e71194a7f887f1604f33af52e7~tGIWUyJey1827318273euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543917209;
 bh=X11KD8/OnWuY3VZejmzvr+fMzr/vWkgerT/hAHvNABw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=F2aR87bYpgIqDcs5+cDUiMHybE987tRyM6wbNh6nHnIw/WoSzJwttr0wQzaoj3CIR
 j7+O/MSa8LzfomFyVigI5rlrdB5CqXcsnfsYhTTFhvNI1M4YRCYTzuiVb7KB+UVv0F
 11neoeepScZ3rnznYp0xtotnB11T/knm0hbS3mls=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181204095328eucas1p151fbacdbf340b22cb385b040b95167e4~tGIVgARhs0348503485eucas1p1a;
 Tue,  4 Dec 2018 09:53:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 97.32.04294.89E460C5; Tue,  4
 Dec 2018 09:53:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181204095327eucas1p2d50b5ff6000b959fbd6929ed26369292~tGIUxV0E92231822318eucas1p2F;
 Tue,  4 Dec 2018 09:53:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181204095327eusmtrp1ea6b7ce8ef01de4e8eeecd1bc6ada374~tGIUhpg5f1349913499eusmtrp1g;
 Tue,  4 Dec 2018 09:53:27 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-d6-5c064e98d9c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.53.04128.79E460C5; Tue,  4
 Dec 2018 09:53:27 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181204095326eusmtip239a607085920ad679072e052515b4644~tGITn1MwD2938229382eusmtip2a;
 Tue,  4 Dec 2018 09:53:26 +0000 (GMT)
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
To: Chanwoo Choi <cw00.choi@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <7662d626-5c3e-aec5-05e4-c6cd2e56ef49@partner.samsung.com>
Date: Tue, 4 Dec 2018 10:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C061A57.7040002@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa2yLYRj1fveN8iqzJ+aS1AjDXCNvQsRE5IuE+GcYU/YZsXb02zAkakZr
 bBMTqi4bI53uUpuulrLNahSd3dwvYzOXMENscYss1n4T+3fO85zznvMkr0Crz3DDhY36JMmg
 1yZouGDGdetX3WTLEi5mamUmR6rLJpASi4MlV0q+s+Rx13uW5NTUsWRvnoMjtQd1JKutnSb1
 9Zd4ci/1E0+sRysoUtr2iCX33ac40plRg4ilvpIiRTXNPLnwuJEiz/fkc6T57s0ev6+JJfsq
 aniyv+ArSz41vGTmhYquqy5WLDxTiMSTxkZGPJz1DYl51z5QYqn9ACdWnS7kxcvnd4vdt3jR
 +dDEiJlOOxLzC37wYmfpqKWqFcFz4qSEjVslw5S5a4I3vDTnUpufz9x+sCjMiK5HpKMgAfBM
 OP9uD0pHwYIa5yOoTL3AKKQLgb21iVNIJ4Ly9GL0z9Le9YRWFjYEv80NvEI6evxnjYxfNQQv
 h7t5bwOqodiHoKrKE3iLxvto6P7q7CGCwOFIKLdv8RtUeCHUZXQEIhgcDrcz2lg/DsHRYH5V
 wCmawXDnxJtAQBCeCPdzn1F+TONQePYmpxePhr1lJwPBgFsE+GJLZZTeC+DAWQ+r4CHw0evk
 FTwCfNmHejUy3DPbOQXvAtOd8l7NbLjhbWT9nWk8ARzuKco4ChznfJR/DHggPOkYrFQYCEdc
 x2llrALzfrWiHg/OQw2UgoeBrfAYfxhprH0Os/Y5xtrnGOv/3FzE2FGolCzr4iV5ul7aFilr
 dXKyPj5yXaKuFPX8Wl+3t6scuf+s9SAsIM0AlWU+G6NmtVvlFJ0HgUBrhqpejONi1Ko4bcoO
 yZAYa0hOkGQPChMYTahqZ7+WlWocr02SNknSZsnwb0sJQcONyLY6z3Qz+u10i61fRIz24qDY
 B1xxSqslCYccmZNarE+rfTqtaIZ6WVgc425t8S7eXp2VnRYdFbVi9tPasTn0ukfVsQtHjslQ
 y4n15oo04rpd1t9s1YV7Jy0CMDUvDTc9jMz+8tlUETL2xCq3Y1YHMf5c357dVP06GX8vycQr
 czWMvEE7LYI2yNq/0P2lJLEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsVy+t/xe7rT/dhiDH418Foc3KppsXHGelaL
 7Ru/sVpc//Kc1WL+kXOsFs2L17NZnOnOteh//JrZ4vz5DewWZ5vesFvMmrKXyWLT42usFpd3
 zWGz+Nx7hNFixvl9TBZrj9xlt1h6/SKTxe3GFWwWd08dBeo/fYnVonXvEXaLttUfWC3eXLjH
 4iDusW33NlaPNfPWMHrMbrjI4jGh/xOjx+I9L5k8Nq3qZPPYP3cNu8fmJfUe/46xe2y52s7i
 0bdlFaPHitXf2T0+b5IL4I3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
 s0lJzcksSy3St0vQy7jXsYCp4LZJRfda6QbGA1pdjJwcEgImEq+/3GDuYuTiEBJYyijRN38e
 C0RCTGLSvu3sELawxJ9rXWwQRa8ZJbrnzmcESQgLREqcWvwUrFtE4DSjxJTzp5hAHGaBVmaJ
 l28XMUK07GOSuLLyMVCGg4NNQE9ix6pCkG5eATeJc71vwSaxCKhInOh9zApiiwpESJx9uY4R
 okZQ4uTMJ2AncQpoS1xecIsJxGYWMJOYt/khM4QtLnHryXyouLxE89bZzBMYhWYhaZ+FpGUW
 kpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECEwv24793LKDsetd8CFGAQ5GJR7e
 GU6sMUKsiWXFlbmHGCU4mJVEeO+oscUI8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4w9eWV
 xBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDs3stlJXP4z/nL3yt3
 zov9fX+/Y0Tdlgj9SB/lh1sNZ3s+mJZzRO2R2OFZ01bdEr2UmXvvoRrHo15btYApqnFBpRrX
 ZtaXpUkanYzUVFnKt1z3t0yi8+s/6xx60pyqCjVeLClxWaG5KsbhscBiDuNgH8/Q1t3qv0oi
 m0uUmf/PaMpLfXmmL1eJpTgj0VCLuag4EQAnXwwhRQMAAA==
X-CMS-MailID: 20181204095327eucas1p2d50b5ff6000b959fbd6929ed26369292
X-Msg-Generator: CA
X-RootMTR: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
 <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
 <5C06124B.5030409@samsung.com> <5C06140E.7010603@samsung.com>
 <5C061A57.7040002@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_045519_187560_FAEA5402 
X-CRM114-Status: GOOD (  30.35  )
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

SGkgQ2hhbndvbywKCk9uIDEyLzQvMTggNzoxMCBBTSwgQ2hhbndvbyBDaG9pIHdyb3RlOgo+IEhp
IEx1a2FzeiwKPiAKPiBJIGFkZCB0aGUgY29tbWVudCBhYm91dCAnc3VzcGVuZF9jb3VudCcuCj4g
Cj4gT24gMjAxOOuFhCAxMuyblCAwNOydvCAxNDo0MywgQ2hhbndvbyBDaG9pIHdyb3RlOgo+PiBI
aSwKPj4KPj4gT24gMjAxOOuFhCAxMuyblCAwNOydvCAxNDozNiwgQ2hhbndvbyBDaG9pIHdyb3Rl
Ogo+Pj4gSGkgTHVrYXN6LAo+Pj4KPj4+IExvb2tzIGdvb2QgdG8gbWUuIEJ1dCwgSSBhZGQgdGhl
IHNvbWUgY29tbWVudHMuCj4+PiBJZiB5b3Ugd2lsbCBmaXggaXQsIGZlZWwgZnJlZSB0byBhZGQg
bXkgdGFnOgo+Pj4gUmV2aWV3ZWQtYnk6IENoYW53b28gY2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcu
Y29tPgo+Pgo+PiBTb3JyeS4gRml4IHR5cG8gJ2Nob2knIHRvICdDaG9pJyBhcyBmb2xsb3dpbmcu
Cj4+IFJldmlld2VkLWJ5OiBDaGFud29vIENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPj4K
Pj4+Cj4+PiBPbiAyMDE464WEIDEy7JuUIDAz7J28IDIzOjMxLCBMdWthc3ogTHViYSB3cm90ZToK
Pj4+PiBUaGUgcGF0Y2ggcHJlcGFyZXMgZGV2ZnJlcSBkZXZpY2UgZm9yIGhhbmRsaW5nIHN1c3Bl
bmQvcmVzdW1lCj4+Pj4gZnVuY3Rpb25hbGl0eS4gIFRoZSBuZXcgZmllbGRzIHdpbGwgc3RvcmUg
bmVlZGVkIGluZm9ybWF0aW9uIGR1cmluZyB0aGlzCj4+Pgo+Pj4gbml0cGljay4gUmVtb3ZlIHVu
bmVlZGVkIHNwYWNlLiBUaGVyZSBhcmUgdHdvIHNwYWNlcyBiZXR3ZWVuICcuJyBhbmQgJ1RoZSBu
ZXcnLgo+Pj4KPj4+PiBwcm9jZXNzLiAgRGV2ZnJlcSBmcmFtZXdvcmsgaGFuZGxlcyBvcHAtc3Vz
cGVuZCBEVCBlbnRyeSBhbmQgdGhlcmUgaXMgbm8KPj4+Cj4+PiBkaXR0by4KPj4+Cj4+Pj4gbmVl
ZCBvZiBtb2R5ZmljYXRpb25zIGluIHRoZSBkcml2ZXJzIGNvZGUuICBJdCB1c2VzIGF0b21pYyB2
YXJpYWJsZXMgdG8KPj4+Cj4+PiBkaXR0by4KPj4+Cj4+Pj4gbWFrZSBzdXJlIG5vIHJhY2UgY29u
ZGl0aW9uIGFmZmVjdHMgdGhlIHByb2Nlc3MuCj4+Pj4KPj4+PiBUaGUgcGF0Y2ggaXMgYmFzZWQg
b24gZWFybGllciB3b3JrIGJ5IFRvYmlhcyBKYWtvYmkuCj4+Pgo+Pj4gUGxlYXNlIHJlbW92ZSBp
dCBmcm9tIGVhY2ggcGF0Y2ggZGVzY3JpcHRpb24uCj4+Pgo+Pj4+Cj4+Pj4gU3VnZ2VzdGVkLWJ5
OiBUb2JpYXMgSmFrb2JpIDx0amFrb2JpQG1hdGgudW5pLWJpZWxlZmVsZC5kZT4KPj4+PiBTdWdn
ZXN0ZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEx1a2FzeiBMdWJhIDxsLmx1YmFAcGFydG5lci5zYW1zdW5nLmNvbT4KPj4+PiAt
LS0KPj4+PiAgIGRyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCA1MSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQo+Pj4+ICAgaW5jbHVkZS9saW51eC9kZXZm
cmVxLmggICB8ICA3ICsrKysrKysKPj4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZy
ZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+Pj4+IGluZGV4IGE5ZmQ2
MWIuLjM2YmVkMjQgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYwo+
Pj4+ICsrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMKPj4+PiBAQCAtMzE2LDYgKzMxNiwx
MCBAQCBzdGF0aWMgaW50IGRldmZyZXFfc2V0X3RhcmdldChzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJl
cSwgdW5zaWduZWQgbG9uZyBuZXdfZnJlcSwKPj4+PiAgIAkJCSJDb3VsZG4ndCB1cGRhdGUgZnJl
cXVlbmN5IHRyYW5zaXRpb24gaW5mb3JtYXRpb24uXG4iKTsKPj4+PiAgIAo+Pj4+ICAgCWRldmZy
ZXEtPnByZXZpb3VzX2ZyZXEgPSBuZXdfZnJlcTsKPj4+PiArCj4+Pj4gKwlpZiAoZGV2ZnJlcS0+
c3VzcGVuZF9mcmVxKQo+Pj4+ICsJCWRldmZyZXEtPnJlc3VtZV9mcmVxID0gY3VyX2ZyZXE7Cj4+
Pj4gKwo+Pj4+ICAgCXJldHVybiBlcnI7Cj4+Pj4gICB9Cj4+Pj4gICAKPj4+PiBAQCAtNjY3LDYg
KzY3MSw5IEBAIHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxX2FkZF9kZXZpY2Uoc3RydWN0IGRldmlj
ZSAqZGV2LAo+Pj4+ICAgCX0KPj4+PiAgIAlkZXZmcmVxLT5tYXhfZnJlcSA9IGRldmZyZXEtPnNj
YWxpbmdfbWF4X2ZyZXE7Cj4+Pj4gICAKPj4+PiArCWRldmZyZXEtPnN1c3BlbmRfZnJlcSA9IGRl
dl9wbV9vcHBfZ2V0X3N1c3BlbmRfb3BwX2ZyZXEoZGV2KTsKPj4+PiArCWF0b21pY19zZXQoJmRl
dmZyZXEtPnN1c3BlbmRfY291bnQsIDApOwo+Pj4+ICsKPj4+PiAgIAlkZXZfc2V0X25hbWUoJmRl
dmZyZXEtPmRldiwgImRldmZyZXElZCIsCj4+Pj4gICAJCQkJYXRvbWljX2luY19yZXR1cm4oJmRl
dmZyZXFfbm8pKTsKPj4+PiAgIAllcnIgPSBkZXZpY2VfcmVnaXN0ZXIoJmRldmZyZXEtPmRldik7
Cj4+Pj4gQEAgLTg2NywxNCArODc0LDI4IEBAIEVYUE9SVF9TWU1CT0woZGV2bV9kZXZmcmVxX3Jl
bW92ZV9kZXZpY2UpOwo+Pj4+ICAgICovCj4+Pj4gICBpbnQgZGV2ZnJlcV9zdXNwZW5kX2Rldmlj
ZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPj4+PiAgIHsKPj4+PiArCWludCByZXQ7Cj4+Pj4g
Kwo+Pj4+ICAgCWlmICghZGV2ZnJlcSkKPj4+PiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4+Pj4gICAK
Pj4+PiAtCWlmICghZGV2ZnJlcS0+Z292ZXJub3IpCj4+Pj4gLQkJcmV0dXJuIDA7Cj4+Pj4gKwlp
ZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPj4+PiArCQlyZXQgPSBkZXZmcmVxLT5nb3Zlcm5vci0+
ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+Pj4+ICsJCQkJCURFVkZSRVFfR09WX1NVU1BFTkQsIE5V
TEwpOwo+Pj4+ICsJCWlmIChyZXQpCj4+Pj4gKwkJCXJldHVybiByZXQ7Cj4+Pj4gKwl9Cj4+Pj4g
Kwo+Pj4+ICsJaWYgKGRldmZyZXEtPnN1c3BlbmRfZnJlcSkgewo+Pj4+ICsJCWlmIChhdG9taWNf
aW5jX3JldHVybigmZGV2ZnJlcS0+c3VzcGVuZF9jb3VudCkgPiAxKQo+Pj4+ICsJCQlyZXR1cm4g
MDsKPj4+PiArCj4+Pj4gKwkJcmV0ID0gZGV2ZnJlcV9zZXRfdGFyZ2V0KGRldmZyZXEsIGRldmZy
ZXEtPnN1c3BlbmRfZnJlcSwgMCk7Cj4+Pj4gKwkJaWYgKHJldCkKPj4+PiArCQkJcmV0dXJuIHJl
dDsKPj4+PiArCX0KPiAKPiBJbiB0aGlzIHBhdGNoLCBpZiBzb21lIHVzZXJzIGNhbGwgJ2RldmZy
ZXFfc3VzcGVuZF9kZXZpY2UnIHR3aWNlLAo+ICdkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRfaGFu
ZGxlcihkZXZmcmVxLCBERVZGUkVRX0dPVl9TVVNQRU5ELCBOVUxMKScKPiBpcyBjYWxsZWQgdHdp
Y2UgYnV0IGRldmZyZXFfc2V0X3RhcmdldCgpIGlzIGNhbGxlZCBvbmx5IG9uZS4KPiBJIGtuZXcg
dGhhdCBpdCBpcyBubyBwcm9ibGVtIGZvciBvcGVyYXRpb24uCj4gCj4gQnV0LAo+IEkgdGhpbmsg
dGhhdCB5b3UgYmV0dGVyIHRvIHVzZSAnc3VzcGVuZF9jb3VudCcgYXMgdGhlIHJlZmVyZW5jZSBj
b3VudAo+IG9mIGRldmZyZXFfc3VzcGVuZC9yZXN1bWVfZGV2aWNlKCkuIEJ1dCwgaWYgeW91IHVz
ZSAnc3VzcGVuZF9jb3VudCcKPiBpbiBvcmRlciB0byBjaGVjayB3aGV0aGVyIHRoaXMgZGV2ZnJl
cSBpcyBzdXNwZW5kZWQgb3Igbm90LAo+IHdlIGNhbiByZWR1Y2UgdGhlIHVubmVlZGVkIHJlZHVu
ZGFudCBjYWxsIHdoZW4gY2FsbGluZyBpdCB0d2ljZS4KPiAKPiBjbG9jayBhbmQgcmVndWxhdG9y
IHVzZWQgdGhlICdyZWZlcmVuY2UgY291bnQnIG1ldGhvZCBpbiBvcmRlciB0bwo+IHJlbW92ZSB0
aGUgcmVkdW5kYW50IGNhbGwuCgpJIHRoaW5rIEkndmUgZ290IHRoZSBwb2ludC4gSSB3aWxsIG1v
dmUgdGhlIGF0b21pYyBjaGVjayBqdXN0CmFmdGVyIHRoZSAhZGV2ZnJlcSBjaGVjay4gU29tZXRo
aW5nIGxpa2UgdGhlIGNvZGUgYmVsbG93IGlzIHdoYXQgeW91CndvdWxkIGxpa2UgdG8gc2VlPwot
LS04PC0tLS0tCmlmICghZGV2ZnJlcSkKCXJldHVybiAtRUlOVkFMOwppZiAoYXRvbWljX2luY19y
ZXR1cm4oJmRldmZyZXEtPnN1c3BlbmRfY291bnQpID4gMSkKCXJldHVybjA7CgotLS0tPjgtLS0t
LS0tCj4gCj4gCj4+Pj4gICAKPj4+PiAtCXJldHVybiBkZXZmcmVxLT5nb3Zlcm5vci0+ZXZlbnRf
aGFuZGxlcihkZXZmcmVxLAo+Pj4+IC0JCQkJREVWRlJFUV9HT1ZfU1VTUEVORCwgTlVMTCk7Cj4+
Pj4gKwlyZXR1cm4gMDsKPj4+PiAgIH0KPj4+PiAgIEVYUE9SVF9TWU1CT0woZGV2ZnJlcV9zdXNw
ZW5kX2RldmljZSk7Cj4+Pj4gICAKPj4+PiBAQCAtODg4LDE0ICs5MDksMjggQEAgRVhQT1JUX1NZ
TUJPTChkZXZmcmVxX3N1c3BlbmRfZGV2aWNlKTsKPj4+PiAgICAqLwo+Pj4+ICAgaW50IGRldmZy
ZXFfcmVzdW1lX2RldmljZShzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSkKPj4+PiAgIHsKPj4+PiAr
CWludCByZXQ7Cj4+Pj4gKwo+Pj4+ICAgCWlmICghZGV2ZnJlcSkKPj4+PiAgIAkJcmV0dXJuIC1F
SU5WQUw7Cj4+Pj4gICAKPj4+PiAtCWlmICghZGV2ZnJlcS0+Z292ZXJub3IpCj4+Pj4gLQkJcmV0
dXJuIDA7Cj4+Pj4gKwlpZiAoZGV2ZnJlcS0+cmVzdW1lX2ZyZXEpIHsKPj4+PiArCQlpZiAoYXRv
bWljX2RlY19yZXR1cm4oJmRldmZyZXEtPnN1c3BlbmRfY291bnQpID49IDEpCj4+Pj4gKwkJCXJl
dHVybiAwOwo+IAo+IGRpdHRvLgpTYW1lIGFwcHJvYWNoIGhlcmU6Ci0tLTg8LS0tLS0KaWYgKCFk
ZXZmcmVxKQoJcmV0dXJuIC1FSU5WQUw7CmlmIChhdG9taWNfZGVjX3JldHVybigmZGV2ZnJlcS0+
c3VzcGVuZF9jb3VudCkgPj0gMSkKCXJldHVybiAwOwotLS0tPjgtLS0tLS0tCgpSZWdhcmRzLApM
dWthc3oKPiAKPj4+PiAgIAo+Pj4+IC0JcmV0dXJuIGRldmZyZXEtPmdvdmVybm9yLT5ldmVudF9o
YW5kbGVyKGRldmZyZXEsCj4+Pj4gLQkJCQlERVZGUkVRX0dPVl9SRVNVTUUsIE5VTEwpOwo+Pj4+
ICsJCXJldCA9IGRldmZyZXFfc2V0X3RhcmdldChkZXZmcmVxLCBkZXZmcmVxLT5yZXN1bWVfZnJl
cSwgMCk7Cj4+Pj4gKwkJaWYgKHJldCkKPj4+PiArCQkJcmV0dXJuIHJldDsKPj4+PiArCX0KPj4+
PiArCj4+Pj4gKwlpZiAoZGV2ZnJlcS0+Z292ZXJub3IpIHsKPj4+PiArCQlyZXQgPSBkZXZmcmVx
LT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZXZmcmVxLAo+Pj4+ICsJCQkJCURFVkZSRVFfR09W
X1JFU1VNRSwgTlVMTCk7Cj4+Pj4gKwkJaWYgKHJldCkKPj4+PiArCQkJcmV0dXJuIHJldDsKPj4+
PiArCX0KPj4+PiArCj4+Pj4gKwlyZXR1cm4gMDsKPj4+PiAgIH0KPj4+PiAgIEVYUE9SVF9TWU1C
T0woZGV2ZnJlcV9yZXN1bWVfZGV2aWNlKTsKPj4+PiAgIAo+Pj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2RldmZyZXEuaCBiL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+Pj4gaW5kZXgg
ZTQ5NjNiMC4uZDk4NTE5OSAxMDA2NDQKPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RldmZyZXEu
aAo+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oCj4+Pj4gQEAgLTEzMSw2ICsxMzEs
OSBAQCBzdHJ1Y3QgZGV2ZnJlcV9kZXZfcHJvZmlsZSB7Cj4+Pj4gICAgKiBAc2NhbGluZ19taW5f
ZnJlcToJTGltaXQgbWluaW11bSBmcmVxdWVuY3kgcmVxdWVzdGVkIGJ5IE9QUCBpbnRlcmZhY2UK
Pj4+PiAgICAqIEBzY2FsaW5nX21heF9mcmVxOglMaW1pdCBtYXhpbXVtIGZyZXF1ZW5jeSByZXF1
ZXN0ZWQgYnkgT1BQIGludGVyZmFjZQo+Pj4+ICAgICogQHN0b3BfcG9sbGluZzoJIGRldmZyZXEg
cG9sbGluZyBzdGF0dXMgb2YgYSBkZXZpY2UuCj4+Pj4gKyAqIEBzdXNwZW5kX2ZyZXE6CSBmcmVx
dWVuY3kgb2YgYSBkZXZpY2Ugc2V0IGR1cmluZyBzdXNwZW5kIHBoYXNlLgo+Pj4+ICsgKiBAcmVz
dW1lX2ZyZXE6CSBmcmVxdWVuY3kgb2YgYSBkZXZpY2Ugc2V0IGluIHJlc3VtZSBwaGFzZS4KPj4+
PiArICogQHN1c3BlbmRfY291bnQ6CSBzdXNwZW5kIHJlcXVlc3RzIGNvdW50ZXIgZm9yIGEgZGV2
aWNlLgo+Pj4+ICAgICogQHRvdGFsX3RyYW5zOglOdW1iZXIgb2YgZGV2ZnJlcSB0cmFuc2l0aW9u
cwo+Pj4+ICAgICogQHRyYW5zX3RhYmxlOglTdGF0aXN0aWNzIG9mIGRldmZyZXEgdHJhbnNpdGlv
bnMKPj4+PiAgICAqIEB0aW1lX2luX3N0YXRlOglTdGF0aXN0aWNzIG9mIGRldmZyZXEgc3RhdGVz
Cj4+Pj4gQEAgLTE2Nyw2ICsxNzAsMTAgQEAgc3RydWN0IGRldmZyZXEgewo+Pj4+ICAgCXVuc2ln
bmVkIGxvbmcgc2NhbGluZ19tYXhfZnJlcTsKPj4+PiAgIAlib29sIHN0b3BfcG9sbGluZzsKPj4+
PiAgIAo+Pj4+ICsJdW5zaWduZWQgbG9uZyBzdXNwZW5kX2ZyZXE7Cj4+Pj4gKwl1bnNpZ25lZCBs
b25nIHJlc3VtZV9mcmVxOwo+Pj4+ICsJYXRvbWljX3Qgc3VzcGVuZF9jb3VudDsKPj4+PiArCj4+
Pj4gICAJLyogaW5mb3JtYXRpb24gZm9yIGRldmljZSBmcmVxdWVuY3kgdHJhbnNpdGlvbiAqLwo+
Pj4+ICAgCXVuc2lnbmVkIGludCB0b3RhbF90cmFuczsKPj4+PiAgIAl1bnNpZ25lZCBpbnQgKnRy
YW5zX3RhYmxlOwo+Pj4+Cj4+Pgo+Pj4KPj4KPj4KPiAKPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
