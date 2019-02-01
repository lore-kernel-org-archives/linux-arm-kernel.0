Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF4C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:41:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3DE204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DaGUlNVe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IZr64iy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3DE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AiZflcWcPA87viM7oVNSKPmrPWKt4rmqRvbN0xaMa4c=; b=DaGUlNVeouNolM
	YGo1MNy6FvRWd/eq7mhaTv3pYNQ8mxv+5QHzS+eHyyVKQ84R6Yx3aVsDY7/Ei/KdBmFgfwzFNK04H
	1Pi+Cfwk6xOIYXlw3M7UWDsXu9bTiidSIi45A34XRdpjYPwZ5QcmsDM8Z0SPnaO8vQ3nkSn3ClzMh
	qKcTrYvwuUXhSrylidJy4VDg/D4jfxF53yvW1wrPv90yn7NbsbqLVIkp5a6wokJiNEjEWYaztaCJ1
	HL9RJCpzrI43SI5u7bL1nlS+DsSNcq02wLKXbgjJdYb+B8enFgq+lAZ+XVi7dCblT322ShdbBzKHV
	rnr5GmVSPZQiOrHimxUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpTSJ-0000um-0K; Fri, 01 Feb 2019 07:41:43 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpTRQ-0000PE-5B
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 07:41:12 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20190201074044epoutp045ac54564f636597db74317788ce3064a~-LYSlWuEb3235532355epoutp04C
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 07:40:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20190201074044epoutp045ac54564f636597db74317788ce3064a~-LYSlWuEb3235532355epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549006844;
 bh=/esMvKCboX+xZXHW8ZllwQ13wPNGv9JiWaHP3D1nnmw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=IZr64iy+bZigN9C/7JY/EGjT2/oeXzDIkIa8keWV+ue+cqiYZ8/eCGLYA75QC4EuS
 4G2S+nfl4dgyejCpBcRBGtbxJJewFcTzq20QAgLlXusEwi4jAdPuzH75mYla3aHnmh
 Ch/efHZRUZNrNp6LtzABfLUpn9b+ypZvqkjxx2ss=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190201074039epcas1p292ec2977a0502e158d1f89bc96ec9615~-LYN4dHri1136711367epcas1p2_;
 Fri,  1 Feb 2019 07:40:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 CD.2B.04069.7F7F35C5; Fri,  1 Feb 2019 16:40:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190201074038epcas1p2505be255c61fb6a678ee06d75ebbe188~-LYNXZG961135511355epcas1p2T;
 Fri,  1 Feb 2019 07:40:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190201074038epsmtrp1913ecc1fdcf7f21aba8dfefe45de43cb~-LYNTIbDC0965709657epsmtrp17;
 Fri,  1 Feb 2019 07:40:38 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-61-5c53f7f7ba88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C0.F9.03971.6F7F35C5; Fri,  1 Feb 2019 16:40:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20190201074038epsmtip2948f1c843ab356a09452244d789a5af8~-LYNCHCPw0160101601epsmtip2P;
 Fri,  1 Feb 2019 07:40:38 +0000 (GMT)
Subject: Re: [PATCH v3 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d6124295-cb72-0d5f-f887-438698cf48e1@samsung.com>
Date: Fri, 1 Feb 2019 16:40:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548924594-19084-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmvu7378ExBhdeSVpsnLGe1WL+kXOs
 Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
 N65gs2jde4Td4vCbdlYHfo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtKtsmIzUx
 JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
 YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xsezv5gK
 tgtUXNx4ibmB8QpvFyMnh4SAicTSh2fZuhi5OIQEdjBKPPu+Dcr5xChxc8sdJgjnG6PEycdX
 mGFaJjyfBlW1l1Hi9Jw9zBDOe0aJHa1zWUGqhAXCJY59mM8IkhARWM4osW/qXUaQBLPATCaJ
 zjdlIDabgJbE/hc32EBsfgFFias/HoPV8ArYSaz48BVsHYuAikTP3WnsILaoQITE4d53UDWC
 EidnPmEBsTkFvCUmrj/CAjFfXOLWk/lMELa8RPPW2WDXSQjsYpf40bSWHeIHF4l7my4wQtjC
 Eq+Ob4GKS0m87G+DsqslVp48wgbR3MEosWX/BVaIhLHE/qWTgTZwAG3QlFi/Sx9iGZ/Eu689
 rCBhCQFeiY42IYhqZYnLD+4yQdiSEovbO9kgbA+JV9tbWCYwKs5C8s4sJC/MQvLCLIRlCxhZ
 VjGKpRYU56anFhsWGCPH9yZGcHrWMt/BuOGczyFGAQ5GJR7eDb+CYoRYE8uKK3MPMUpwMCuJ
 8B65GxwjxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBuSOvJN7Q1MjY2NjCxNDM1NBQSZx3
 vYNzjJBAemJJanZqakFqEUwfEwenVAOjWNBEc31X6V1VF9zyyneoMv2IvHXoZUi72tsvb8/5
 TAndlVoaWquQmfE6/vlllvMX95gY7n5QpfVrwrYn7/Y4aV1xFN3gaXPj9Smjymz7lfevMs95
 0tz4QUl58f7qI2o7HjI1nb7zPPCccNdZ7rZmM+lJp2Xe9E8Wm3HlrVxButTU9HetO/peKLEU
 ZyQaajEXFScCAJjBjiLlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvO6378ExBudX6ltsnLGe1WL+kXOs
 Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
 N65gs2jde4Td4vCbdlYHfo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtissmJTUn
 syy1SN8ugSvj49lfTAXbBSoubrzE3MB4hbeLkZNDQsBEYsLzaWxdjFwcQgK7GSXO3J/GBJGQ
 lJh28ShzFyMHkC0scfhwMUTNW0aJC4uusoHUCAuESxz7MJ8RJCEisJxRYu7fpSwgDrPATCaJ
 X6tWM0O03GeUuP/8KwtIC5uAlsT+FzfA2vkFFCWu/njMCGLzCthJrPjwlRnEZhFQkei5O40d
 xBYViJD4+HQfE0SNoMTJmU/A5nAKeEtMXH8EzGYWUJf4M+8SM4QtLnHryXwmCFteonnrbOYJ
 jMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeqluYO
 xstL4g8xCnAwKvHwbvgVFCPEmlhWXJl7iFGCg1lJhPfI3eAYId6UxMqq1KL8+KLSnNTiQ4zS
 HCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhhbbpUvWbzCffLdtBMKZ6x8BY9P7J6T9uRV
 p3PEkUbN26+t2pckq+bHT8/V2t6gemarWNek5fY6D+99EJjrlPdXaEN4mUySp4P/8ZYI4Yqo
 e+J/up/ZyJ5Y8pnPQlvqdv6sH7vc3X/ZLpqfJttbNX/9t2M/uF+uu5Kg+LxDV17979Lne3ae
 6EtWYinOSDTUYi4qTgQA73nxVNACAAA=
X-CMS-MailID: 20190201074038epcas1p2505be255c61fb6a678ee06d75ebbe188
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7@eucas1p2.samsung.com>
 <1548924594-19084-2-git-send-email-l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_234049_500678_BD0B105D 
X-CRM114-Status: GOOD (  18.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, b.zolnierkie@samsung.com,
 krzk@kernel.org, Rob Herring <robh+dt@kernel.org>, kyungmin.park@samsung.com,
 kgene@kernel.org, myungjoo.ham@samsung.com, s.nawrocki@samsung.com,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAxOS4gMS4gMzEuIOyYpO2bhCA1OjQ5LCBMdWthc3ogTHViYSB3cm90ZToKPiBEZWZp
bmUgbmV3IElEcyBmb3IgY2xvY2tzIHVzZWQgYnkgRHluYW1pYyBNZW1vcnkgQ29udHJvbGxlciBp
bgo+IEV4eW5vczU0MjIgU29DLgo+IAo+IENDOiBTeWx3ZXN0ZXIgTmF3cm9ja2kgPHMubmF3cm9j
a2lAc2Ftc3VuZy5jb20+Cj4gQ0M6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29t
Pgo+IENDOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPgo+IENDOiBNYXJrIFJ1dGxh
bmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgo+IENDOiBLdWtqaW4gS2ltIDxrZ2VuZUBrZXJuZWwu
b3JnPgo+IENDOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+Cj4gQ0M6IGxp
bnV4LXNhbXN1bmctc29jQHZnZXIua2VybmVsLm9yZwo+IENDOiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZwo+IENDOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDQzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IFNpZ25lZC1vZmYtYnk6IEx1a2FzeiBMdWJh
IDxsLmx1YmFAcGFydG5lci5zYW1zdW5nLmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9leHlub3M1NDIwLmggfCAxOCArKysrKysrKysrKysrKysrKy0KPiAgMSBmaWxlIGNo
YW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9leHlub3M1NDIwLmggYi9pbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL2V4eW5vczU0MjAuaAo+IGluZGV4IDM1NWY0NjkuLjE4MjdhNjQgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9leHlub3M1NDIwLmgKPiArKysgYi9pbmNs
dWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2V4eW5vczU0MjAuaAo+IEBAIC02MCw2ICs2MCw3IEBACj4g
ICNkZWZpbmUgQ0xLX01BVV9FUExMCQkxNTkKPiAgI2RlZmluZSBDTEtfU0NMS19IU0lDXzEyTQkx
NjAKPiAgI2RlZmluZSBDTEtfU0NMS19NUEhZX0lYVEFMMjQJMTYxCj4gKyNkZWZpbmUgQ0xLX1ND
TEtfQlBMTAkJMTYyCj4gIAo+ICAvKiBnYXRlIGNsb2NrcyAqLwo+ICAjZGVmaW5lIENMS19VQVJU
MAkJMjU3Cj4gQEAgLTE5NSw2ICsxOTYsMTYgQEAKPiAgI2RlZmluZSBDTEtfQUNMSzQzMl9DQU0J
CTUxOAo+ICAjZGVmaW5lIENMS19BQ0xLX0ZMMTU1MF9DQU0JNTE5Cj4gICNkZWZpbmUgQ0xLX0FD
TEs1NTBfQ0FNCQk1MjAKPiArI2RlZmluZSBDTEtfQ0xLTV9QSFkwCQk1MjEKPiArI2RlZmluZSBD
TEtfQ0xLTV9QSFkxCQk1MjIKPiArI2RlZmluZSBDTEtfQUNMS19QUE1VX0RSRVgwXzAJNTIzCj4g
KyNkZWZpbmUgQ0xLX0FDTEtfUFBNVV9EUkVYMF8xCTUyNAo+ICsjZGVmaW5lIENMS19BQ0xLX1BQ
TVVfRFJFWDFfMAk1MjUKPiArI2RlZmluZSBDTEtfQUNMS19QUE1VX0RSRVgxXzEJNTI2Cj4gKyNk
ZWZpbmUgQ0xLX1BDTEtfUFBNVV9EUkVYMF8wCTUyNwo+ICsjZGVmaW5lIENMS19QQ0xLX1BQTVVf
RFJFWDBfMQk1MjgKPiArI2RlZmluZSBDTEtfUENMS19QUE1VX0RSRVgxXzAJNTI5Cj4gKyNkZWZp
bmUgQ0xLX1BDTEtfUFBNVV9EUkVYMV8xCTUzMAo+ICAKPiAgLyogbXV4IGNsb2NrcyAqLwo+ICAj
ZGVmaW5lIENMS19NT1VUX0hETUkJCTY0MAo+IEBAIC0yMTcsNiArMjI4LDEwIEBACj4gICNkZWZp
bmUgQ0xLX01PVVRfRVBMTAkJNjU3Cj4gICNkZWZpbmUgQ0xLX01PVVRfTUFVX0VQTEwJNjU4Cj4g
ICNkZWZpbmUgQ0xLX01PVVRfVVNFUl9NQVVfRVBMTAk2NTkKPiArI2RlZmluZSBDTEtfTU9VVF9E
UExMCQk2NjAKPiArI2RlZmluZSBDTEtfTU9VVF9BQ0xLX0czRAk2NjEKClRoZSBzZWNvbmQgcGF0
Y2ggZG9uJ3QgaW1wbGVtZW50IHNvbWUgY2xvY2tzCmZvciBDTEtfTU9VVF9EUExMLCBDTEtfTU9V
VF9BQ0xLX0czRC4KCldoeSBkbyB5b3UgZGVmaW5lIHRoZW0/Cgooc25pcCkKCi0tIApCZXN0IFJl
Z2FyZHMsCkNoYW53b28gQ2hvaQpTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
