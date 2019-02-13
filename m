Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E6FC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:11:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E07021904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JcgKKvyk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tie8DOsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E07021904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7LsY5r5c4cJLhv1pAxSV0786XMa+kGtjaBkYteTeYgo=; b=JcgKKvykHFKsBK
	ep7priFw74Ae5sHS9t0L5aV0fy93Fgsehtl3QEcU7PJS2VHCxPwAq3onU+UEHYxj/bfB5je2WkB9p
	RrOtmmslRXX0kQl1PvdVxuSOAELZn7E0KHXe4+8CzX3RfG7jadQIhiKLvAwGe3oEDsJ/SI3yLmZpg
	tJALDATdfph9IRJKlUk6ZHjZGCeF7EdVDJBPafjPe05Mt2uEwSDZAoRCSroKOyH7wKKbvCHXI8BdL
	52ecIxDw93RdGsk7gHwiS7Ub7VPC31SZyPmt6+IxvXpS7yvrVvVckaIOMVhwWLELOwTr8r8UZOHWd
	J21jS/RRiUbcYYJvmuFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtohx-0006n2-PD; Wed, 13 Feb 2019 07:11:49 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoht-0006mb-ID
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 07:11:47 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20190213071142epoutp0331a4f1f9b1b18195f16afbc33bf86a97~C2uXLPUrp0608906089epoutp03A
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 07:11:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20190213071142epoutp0331a4f1f9b1b18195f16afbc33bf86a97~C2uXLPUrp0608906089epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550041902;
 bh=UYX5CL3ikrIiJpVBODpawcG6tfyGJF61Sn7qomYc8yI=;
 h=Subject:To:From:Date:In-Reply-To:References:From;
 b=tie8DOsIG69L0+mJ9UU9WO8C8XdkckAiTUVGhuLJO5pyn4ofJP4kGCW+TUXnJe/w5
 1zY6ADh4ND/q0gRaDrqUv5H5XdPauiUX7/B0+puBrDr1ibWkrsd4R9T7aXNAeFnMzB
 quy5jPu7Ey3lR1AG3iVVwCk/+5RPZQslxAvdkqrQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20190213071139epcas1p479d800ad1f9042a035c2c693df22ec57~C2uUUA34P1382713827epcas1p4g;
 Wed, 13 Feb 2019 07:11:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 1E.69.04069.B23C36C5; Wed, 13 Feb 2019 16:11:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190213071138epcas1p1682f47f1d1be2992b9f4926cbce48f36~C2uT_8s522944429444epcas1p1r;
 Wed, 13 Feb 2019 07:11:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190213071138epsmtrp1888692f949566593bb38251ea2894ac5~C2uT9FfhT2844428444epsmtrp1M;
 Wed, 13 Feb 2019 07:11:38 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-74-5c63c32b5304
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 AC.C4.03971.A23C36C5; Wed, 13 Feb 2019 16:11:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190213071138epsmtip2b65ad37527c3f1ea5dddf99a326b9b01~C2uTnueLB0685606856epsmtip2n;
 Wed, 13 Feb 2019 07:11:38 +0000 (GMT)
Subject: Re: [PATCH 3/4] clk: samsung: exynos5410: Add gate clock for ADC
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa
 <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c75f4582-18e4-f123-382d-e50626b650c8@samsung.com>
Date: Wed, 13 Feb 2019 16:11:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212175052.6310-4-krzk@kernel.org>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmvq724eQYg747nBbzj5xjteh//JrZ
 4vz5DewWmx5fY7X42HOP1eLyrjlsFjPO72OyWHr9IpPFxVOuFq17j7BbHH7Tzmrx79pGFotV
 u/4wOvB6rJm3htHj/Y1Wdo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwR2XbZKQmpqQWKaTm
 JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdq6RQlphTChQKSCwuVtK3
 synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzmh5upit4B1Hxfrd
 bg2Mm9i7GDk5JARMJLrPLmbuYuTiEBLYwSjRuX0yWEJI4BOjxKV/lhCJb4wSHyd3w3VcWPCK
 ESKxl1Hi+aVLbBDOe0aJrsVHWEGqhAU8JdrvnQCbKyJwk1niwOR+NpAEm4CWxP4XN8BsfgFF
 ias/HjOC2LwCdhKbLv5k6mLk4GARUJU43mkAEhYViJA43PsOqkRQ4uTMJywgNifQFV3TLjOB
 2MwC4hK3nsyHsuUlmrfOBtsrITCPXeLSoSYmiLNdJJr73rBA2MISr45vgXpHSuJlfxuUXS2x
 8uQRNojmDkaJLfsvsEIkjCX2L50MdhyzgKbE+l36EMv4JN597WEFCUsI8Ep0tAlBVCtLXH5w
 F2qtpMTi9k42CNtDonf5V0ZI8G5klOj/4jqBUWEWktdmIXlnFpJ3ZiEsXsDIsopRLLWgODc9
 tdiwwBg5sjcxgtOxlvkOxg3nfA4xCnAwKvHwrjiaFCPEmlhWXJl7iFGCg1lJhDd+Y3KMEG9K
 YmVValF+fFFpTmrxIUZTYMBPZJYSTc4H5oq8knhDUyNjY2MLE0MzU0NDJXHe9Q7OMUIC6Ykl
 qdmpqQWpRTB9TBycUg2ME65LdvauF/S2f54av3drualaq+Irbb8NnN5Nrofvnj16JsX+2uVU
 xo+KUQyM8XOaz2f2+wmrfHE8GtJ1U23+h4yPCZsrbG5cd389kz/l14HznHsV9+iuyGcUjFro
 8tkv+dqve3N2/LkmXHK1tmd+vEfJLN/7+Q4LNueW7a5csYHddHe818NwJZbijERDLeai4kQA
 x97/It0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK7W4eQYgxfPNS3mHznHatH/+DWz
 xfnzG9gtNj2+xmrxseceq8XlXXPYLGac38dksfT6RSaLi6dcLVr3HmG3OPymndXi37WNLBar
 dv1hdOD1WDNvDaPH+xut7B47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgj+KySUnNySxLLdK3
 S+DKaHm6mK3gHUfF+t1uDYyb2LsYOTkkBEwkLix4xQhiCwnsZpRY06YDEZeUmHbxKHMXIweQ
 LSxx+HBxFyMXUMlbRokl12+xgtQIC3hKtN87wQySEBG4zSyx9FUbO0TVRkaJbV9usYFUsQlo
 Sex/cQPM5hdQlLj64zHYNl4BO4lNF38ygWxgEVCVON5pABIWFYiQ+Ph0HxNEiaDEyZlPWEBs
 TqBDu6ZdBoszC6hL/Jl3iRnCFpe49WQ+VFxeonnrbOYJjEKzkLTPQtIyC0nLLCQtCxhZVjFK
 phYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMefluYOxstL4g8xCnAwKvHwrjiaFCPEmlhW
 XJl7iFGCg1lJhDd+Y3KMEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KL
 YLJMHJxSDYwt/1PO319zweyV1tbpyyaohZ532usgMeWk7GS9isJb29ZMVJq9XOPWSsb8fzaB
 715GHZ03/6z+o464WzPuxt36v71ur7Ks1YG5C8vsPcPPPm1ZUv2md91ckQXzfLL5/z4+6LvH
 4PSy1kK+m188/7/jSdX9fGVnsBLvUQtTkd6vYUaroqQ2WJ7PV2Ipzkg01GIuKk4EABcR2Hy7
 AgAA
X-CMS-MailID: 20190213071138epcas1p1682f47f1d1be2992b9f4926cbce48f36
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212175212epcas5p4ff5ed8b2264956844e14d5e6ca03eac6
References: <20190212175052.6310-1-krzk@kernel.org>
 <CGME20190212175212epcas5p4ff5ed8b2264956844e14d5e6ca03eac6@epcas5p4.samsung.com>
 <20190212175052.6310-4-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_231146_125495_B25E129E 
X-CRM114-Status: GOOD (  20.38  )
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
Ogo+IEFkZCB0aGUgZ2F0ZSBjbG9jayBmb3IgQURDIGJsb2NrIG9uIEV4eW5vczU0MTAuCj4gCj4g
U2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPgo+IC0t
LQo+ICBkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1leHlub3M1NDEwLmMgfCAxICsKPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3Nh
bXN1bmcvY2xrLWV4eW5vczU0MTAuYyBiL2RyaXZlcnMvY2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0
MTAuYwo+IGluZGV4IDBhMGIwOTU5MWU2Zi4uYjJkYTJjOGZhMGM3IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvY2xrL3NhbXN1bmcvY2xrLWV4eW5vczU0MTAuYwo+ICsrKyBiL2RyaXZlcnMvY2xrL3Nh
bXN1bmcvY2xrLWV4eW5vczU0MTAuYwo+IEBAIC0yMDksNiArMjA5LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBzYW1zdW5nX2dhdGVfY2xvY2sgZXh5bm9zNTQxMF9nYXRlX2Nsa3NbXSBfX2luaXRj
b25zdCA9IHsKPiAgCUdBVEUoQ0xLX1VTSTEsICJ1c2kxIiwgImFjbGs2NiIsIEdBVEVfSVBfUEVS
SUMsIDExLCAwLCAwKSwKPiAgCUdBVEUoQ0xLX1VTSTIsICJ1c2kyIiwgImFjbGs2NiIsIEdBVEVf
SVBfUEVSSUMsIDEyLCAwLCAwKSwKPiAgCUdBVEUoQ0xLX1VTSTMsICJ1c2kzIiwgImFjbGs2NiIs
IEdBVEVfSVBfUEVSSUMsIDEzLCAwLCAwKSwKPiArCUdBVEUoQ0xLX1RTQURDLCAidHNhZGMiLCAi
YWNsazY2IiwgR0FURV9JUF9QRVJJQywgMTUsIDAsIDApLAo+ICAJR0FURShDTEtfUFdNLCAicHdt
IiwgImFjbGs2NiIsIEdBVEVfSVBfUEVSSUMsIDI0LCAwLCAwKSwKPiAgCj4gIAlHQVRFKENMS19T
Q0xLX1VBUlQwLCAic2Nsa191YXJ0MCIsICJkaXZfdWFydDAiLAo+IAoKSSBjaGVja2VkIGl0IG9u
IEV4eW5vczU0MTAgVFJNLiBMb29rcyBnb29kIHRvIG1lLgpBY2tlZC1ieTogQ2hhbndvbyBDaG9p
IDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+CgotLSAKQmVzdCBSZWdhcmRzLApDaGFud29vIENob2kK
U2Ftc3VuZyBFbGVjdHJvbmljcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
