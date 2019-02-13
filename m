Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:08:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7513221904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SMF22hnF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F/mcB5Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7513221904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fRVhSTcS8eOwGU6r892mLm4HSoF7TyCALMEmimMmeUk=; b=SMF22hnFVDmNkg
	vna3ijvHnQ4kGSgeygEC9ouECGddYVa1pztK2A+ty12jpd2gFSN0/uXm4ktZs694/Tt1TkEoNIv/5
	6UA44YtcwoSoX4eRDEE1dxbBGaTEQPtKnV9o/Hm4PG+Ookr73WeiO1p4iUfI7mLoVFBLuWfd6DF5l
	NsA4tcdoA/geuEFmPj4Az8YShnt6QsUo/Tkpqc+TbETT3QBax757DIEHqnA2FAA/3HXh9udmLhwKP
	SWybZzb+STd+/pG1xbSCIy66WMTIARff2CVyZ2dpMkKi+KX3mCI3IBoUjGi2vwuBGdrBCoVDpBRyX
	8in78/HBqIWRPGkUJxMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtoeQ-00049j-Mb; Wed, 13 Feb 2019 07:08:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoeM-00049A-L2
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 07:08:08 +0000
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20190213070803epoutp01474ea831e3e59f0f2ffa6d5225b6f98e~C2rLU1xtC1348613486epoutp01U
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20190213070803epoutp01474ea831e3e59f0f2ffa6d5225b6f98e~C2rLU1xtC1348613486epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550041683;
 bh=sfd9FyskU6oEvPk9aYFOdOu50Wv0Yqv7GjJCefgvCFs=;
 h=Subject:To:From:Date:In-Reply-To:References:From;
 b=F/mcB5LvAcZ6WdYAtZtkCddLEbreLRKeRoEESZoi86PzgAmgDeHCfAZKjdbR6jYOJ
 etGVxr7rzaJFCzHTdG2Ff7z5Aky3I9YgjQBPDqFyo7VktQtxQoJCvtu/IVQT8EGBKq
 O+ERxpNxaMMKnHWniQeQz5wkAraChHPhxeFPWZBs=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20190213070759epcas1p444fc197c39151a16a85fec526e20a40d~C2rH4nGFy0089000890epcas1p4B;
 Wed, 13 Feb 2019 07:07:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 C7.1D.04173.F42C36C5; Wed, 13 Feb 2019 16:07:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190213070759epcas1p2997074c9670dee7a0663c13ee72788e7~C2rHeQUYn1439514395epcas1p2C;
 Wed, 13 Feb 2019 07:07:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190213070759epsmtrp2f90cdf1c1dc543222c0cd4e1654909f8~C2rHaPEON1804018040epsmtrp2D;
 Wed, 13 Feb 2019 07:07:59 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-7c-5c63c24f4b38
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 26.94.03971.F42C36C5; Wed, 13 Feb 2019 16:07:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190213070758epsmtip2c1c80108e9741080a733055bb76ef319~C2rHL6lrO0614906149epsmtip2x;
 Wed, 13 Feb 2019 07:07:58 +0000 (GMT)
Subject: Re: [PATCH 2/4] dt-bindings: clock: exynos: Add ADC clock ID to
 Exynos5410
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa
 <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a8e1ab3f-83f7-0d35-a943-df6600d6c3cd@samsung.com>
Date: Wed, 13 Feb 2019 16:07:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212175052.6310-3-krzk@kernel.org>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmnq7/oeQYg9OrlCzmHznHatH/+DWz
 xfnzG9gtNj2+xmrxseceq8XlXXPYLGac38dksfT6RSaLi6dcLVr3HmG3OPymndXi37WNLBar
 dv1hdOD1WDNvDaPH+xut7B47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgj8q2yUhNTEktUkjN
 S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
 Z1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnfF49X62gg3sFZte
 zWNtYPzD2sXIySEhYCJxv201cxcjF4eQwA5GiZM3m9ggnE+MEkfefIDKfGOUePziDzNMy47e
 h1BVexklfhxvhap6zyhx+N1FNpAqYYFQia47F1lBEiICN5klDkzuB0uwCWhJ7H9xA8zmF1CU
 uPrjMSOIzStgJ/F10UYmEJtFQFXi9dZbYBeKCkRIHO59B1UjKHFy5hMWEJsT6Ixdp9+DxZkF
 xCVuPZnPBGHLSzRvnQ12kYTAInaJvpcPgRo4gBwXiTXnHSBeEJZ4dXwLO4QtJfH53V42CLta
 YuXJI2wQvR2MElv2X4AGk7HE/qWTmUDmMAtoSqzfpQ+xi0/i3dceVojxvBIdbUIQ1coSlx/c
 ZYKwJSUWt3dCjfeQuLfqDgsksDYySmx88p15AqPCLCSvzULyziwk78xC2LyAkWUVo1hqQXFu
 emqxYYERcnxvYgQnZS2zHYyLzvkcYhTgYFTi4V1xNClGiDWxrLgy9xCjBAezkghv/MbkGCHe
 lMTKqtSi/Pii0pzU4kOMpsCQn8gsJZqcD8wYeSXxhqZGxsbGFiaGZqaGhkrivOsdnGOEBNIT
 S1KzU1MLUotg+pg4OKUaGNmnHnTY8Tn8u+K6j+bsfCyCNh69AXsWvorXz03LbuG5zPzc8K90
 BQML5w6h2W+1zpa+mV9v8Wn1Z9VTD6bIs9WeMTSp3v7tKuPSxeds5GbMNsyUMuqu9pjwr3TZ
 DM6H8a2PPjZa/19S1jCLPfLYu4xfuhve1k8LOSFk12/u0SFwtPh5+HvxZiWW4oxEQy3mouJE
 AImrpBXgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvK7/oeQYg/Wr2CzmHznHatH/+DWz
 xfnzG9gtNj2+xmrxseceq8XlXXPYLGac38dksfT6RSaLi6dcLVr3HmG3OPymndXi37WNLBar
 dv1hdOD1WDNvDaPH+xut7B47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgj+KySUnNySxLLdK3
 S+DKeLx6P1vBBvaKTa/msTYw/mHtYuTkkBAwkdjR+5Cti5GLQ0hgN6PE9Z9TGCESkhLTLh5l
 7mLkALKFJQ4fLoaoecso0fl9BRtIjbBAqETXnYusIAkRgdvMEktftbFDVG1klFj0diEzSBWb
 gJbE/hc3wDr4BRQlrv54DLaBV8BO4uuijUwgNouAqsTrrbfAThIViJD4+HQfE0SNoMTJmU9Y
 QGxOoFN3nX4P1sssoC7xZ94lZghbXOLWk/lMELa8RPPW2cwTGIVmIWmfhaRlFpKWWUhaFjCy
 rGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI5CLc0djJeXxB9iFOBgVOLhXXE0KUaI
 NbGsuDL3EKMEB7OSCG/8xuQYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqem
 FqQWwWSZODilGhhrq91nJyd4elsYfH93wv+Mnbv1OVf+dRU/UwKDF70KLXv6V/zalry4PQm6
 k6r4/uw0SV7hEfSdxXmRyW7lKa1LKwKVz2ytu8tXnJZn9nBFwJcf908k5L3obkqL/Tn3v8Wb
 ue6/nrVnHHM0OyQTeVK8/brEtg+zVzB+tZvQdoXpV1nqEse5iw4rsRRnJBpqMRcVJwIADcsW
 Kb4CAAA=
X-CMS-MailID: 20190213070759epcas1p2997074c9670dee7a0663c13ee72788e7
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212175204epcas1p1bf2eb348293554593eabb561c5dcf6c1
References: <20190212175052.6310-1-krzk@kernel.org>
 <CGME20190212175204epcas1p1bf2eb348293554593eabb561c5dcf6c1@epcas1p1.samsung.com>
 <20190212175052.6310-3-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_230807_047769_44728FBE 
X-CRM114-Status: GOOD (  23.31  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAxOS4gMi4gMTMuIOyYpOyghCAyOjUwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3Rl
Ogo+IEFkZCBJRCBmb3IgVFNBREMgY2xvY2sgdG8gRXh5bm9zNTQxMC4gIENob29zZSB0aGUgc2Ft
ZSB2YWx1ZSBvZiBJRCBhcyBpbgo+IEV4eW5vczU0MjAgdG8gbWFrZSBpdCBzaW1wbGVyL2NvbXBh
dGlibGUgaW4gZnV0dXJlIChhbHRob3VnaCBjbG9jawo+IGRyaXZlciBjb2RlIGlzIG5vdCBzaGFy
ZWQpLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz4KPiAtLS0KPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9leHlub3M1NDEwLmggfCAx
ICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5bm9zNTQxMC5oIGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9leHlub3M1NDEwLmgKPiBpbmRleCA1YjkxMWVkZTA1MzQuLjg2YzJhZDU2YzVlZiAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2V4eW5vczU0MTAuaAo+ICsr
KyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svZXh5bm9zNTQxMC5oCj4gQEAgLTQ1LDYgKzQ1
LDcgQEAKPiAgI2RlZmluZSBDTEtfVVNJMQkJMjY2Cj4gICNkZWZpbmUgQ0xLX1VTSTIJCTI2Nwo+
ICAjZGVmaW5lIENMS19VU0kzCQkyNjgKPiArI2RlZmluZSBDTEtfVFNBREMJCTI3MAo+ICAjZGVm
aW5lIENMS19QV00JCQkyNzkKPiAgI2RlZmluZSBDTEtfTUNUCQkJMzE1Cj4gICNkZWZpbmUgQ0xL
X1dEVAkJCTMxNgo+IAoKQWNrZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcu
Y29tPgoKLS0gCkJlc3QgUmVnYXJkcywKQ2hhbndvbyBDaG9pClNhbXN1bmcgRWxlY3Ryb25pY3MK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
