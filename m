Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC59C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:51:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E57F2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mPgUNXJ0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipa+kTP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E57F2176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EsxOYjzEYiXOSYneDWSV1yjysDkk7M9s+9z2ok2GZ4A=; b=mPgUNXJ0a02l67
	Ki4u1vCeI2QwW7xWdgPRMmaS5A9tc2oc52KdGqjUjOoQKfHGMmDlLa664B8OuyzjoTVq+/EOvzStR
	p9610Id0MNDsrhRIDSVXzbwv6rzvtnwv/xTKm08kz9bacthFKf7MrmyNbnYmjGFS8eQsXGYjegrsn
	8YWCB3MhOtzqqiRdwgfxx7WQxH5BJK/1qsfalS+A1BsepMkofEOeMya70ZSqKiIFeFVpbv6sIzKCa
	sWm2uXBzCY8Dmr6Tc692ZdZuknfoLRXKoWZBvrAfDGxKDrc4xBSWd3v6iNLS86i27wFReRwF8cmrQ
	0S8EhE5o0LXcSjB3V/hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gssKP-0005rC-Q8; Sun, 10 Feb 2019 16:51:37 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gssKH-0005qe-S3
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 16:51:31 +0000
Received: by mail-lf1-x141.google.com with SMTP id m11so5947526lfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 08:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HSKl9PE626k4XvspQ7FlvluO5/onCPjgpbaqlXdRgI8=;
 b=ipa+kTP9jmc4S2MnU/k02r6+iZDEo1dmErShbuJzEcV2eX7OQP+hED7LqUNyOukvPv
 QIGG1ZcaXRw54Pc6E3WnjHE1HnFywCz3jEJn7em7S7yXUxNBcd+U77RlkyJQYcClwec4
 9PflO1oj2io8bZqm0wMsvAk9gmeFK6xAdxHwvLFct3RnyTu4sq31m6WTfayx70TcKb/1
 LKazXql7ubZtYmaXZNsYuf5KONAnrV2FBNsttOn4YNcvIGQdpa8fS9sjtj3RFXHuQ15u
 E6guCspQUMkSQAYCYB313m94z2SnkZIR/xR2fdstXChNDFfU7e7Sb1Ow+KCc3n3lquVs
 mXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HSKl9PE626k4XvspQ7FlvluO5/onCPjgpbaqlXdRgI8=;
 b=OUj996zG8pA13rZY8Vc7tm2Ns2fBbnVvZAtYzxlc8pJSShg1mMhXpQGQiwjlxsWVpr
 Vp3TTxCfzHo5QdMUUzRE/aDLV6w28xNZ7OIOz5tRMNdsPSFBfPBxuSrkc0Y0Yew0S3LI
 TCT+DKGxBE+xaeaOsIb7Fc+fBprvNCSa8HQ9pzcdjW9WnRH3AsrLrSIS4r/4jWUvPvfX
 EtjU+Pe6wVFMctjFg0lOpPxqV660ggXLHqeFldgTb559vfWxa/WzdQ8c/0xdX67hKX6o
 4SI9cd7DHluEe0N1l9ZMHP/IZpUxTLbTDT7c4YixEk5E9iDZ6vXEkjuIbjEaHHX5CyCb
 fzzA==
X-Gm-Message-State: AHQUAuanZjDGI6UhZhHPQBR3DNXPspt91NZArzzaWyiJnDTCDeqofHi5
 GvOVuJLCOFK68m/e+5mqaAI=
X-Google-Smtp-Source: AHgI3IaHVXsQFfE37ajPkixP7HrAAqOaRTeXbGb0e1I8sG+y37G2KAXOKBTzWH4AsynotlfvYEiR8Q==
X-Received: by 2002:a19:6a1a:: with SMTP id u26mr949569lfu.81.1549817485424;
 Sun, 10 Feb 2019 08:51:25 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49]) by smtp.googlemail.com with ESMTPSA id
 p77-v6sm1771677lja.0.2019.02.10.08.51.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 10 Feb 2019 08:51:24 -0800 (PST)
Subject: Re: [REGRESSION] drm/tegra: hdmi: tegra_hdmi_setup_audio: division by
 zero in kernel
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <87f8fd40b25e2842b547059a8d28295533e8c09c.camel@toradex.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <139085a2-014a-b666-2d3f-d1833b6017c5@gmail.com>
Date: Sun, 10 Feb 2019 19:51:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87f8fd40b25e2842b547059a8d28295533e8c09c.camel@toradex.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_085129_933724_356341D0 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: "treding@nvidia.com" <treding@nvidia.com>,
 "alban.bedel@avionic-design.de" <alban.bedel@avionic-design.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MDguMDIuMjAxOSAyMzowMSwgTWFyY2VsIFppc3dpbGVyINC/0LjRiNC10YI6Cj4gSGkgdGhlcmUK
PiAKPiBJIGp1c3Qgc3R1bWJsZWQgb3ZlciB0aGlzIG9uZToKPiAKPiBbICAgMzEuMDI2MjIwXSBE
aXZpc2lvbiBieSB6ZXJvIGluIGtlcm5lbC4KPiBbICAgMzEuMDI2MjM4XSBDUFU6IDEgUElEOiA1
MjkgQ29tbTogWCBOb3QgdGFpbnRlZCA1LjAuMC1yYzUtbmV4dC0KPiAyMDE5MDIwOC1kaXJ0eSAj
MTUzCj4gWyAgIDMxLjAyNjI0NF0gSGFyZHdhcmUgbmFtZTogTlZJRElBIFRlZ3JhIFNvQyAoRmxh
dHRlbmVkIERldmljZSBUcmVlKQo+IFsgICAzMS4wMjYyODFdIFs8YzAxMTIwY2M+XSAodW53aW5k
X2JhY2t0cmFjZSkgZnJvbSBbPGMwMTBjOTJjPl0KPiAoc2hvd19zdGFjaysweDEwLzB4MTQpCj4g
WyAgIDMxLjAyNjMwMV0gWzxjMDEwYzkyYz5dIChzaG93X3N0YWNrKSBmcm9tIFs8YzBhN2M1YWM+
XQo+IChkdW1wX3N0YWNrKzB4YjQvMHhjOCkKPiBbICAgMzEuMDI2MzE3XSBbPGMwYTdjNWFjPl0g
KGR1bXBfc3RhY2spIGZyb20gWzxjMGE3YTdlND5dCj4gKExkaXYwKzB4OC8weDEwKQo+IFsgICAz
MS4wMjYzMzddIFs8YzBhN2E3ZTQ+XSAoTGRpdjApIGZyb20gWzxjMDU4ODc1OD5dCj4gKHRlZ3Jh
X2hkbWlfc2V0dXBfYXVkaW8rMHgxYWMvMHhlZDApCj4gWyAgIDMxLjAyNjM1M10gWzxjMDU4ODc1
OD5dICh0ZWdyYV9oZG1pX3NldHVwX2F1ZGlvKSBmcm9tIFs8YzA1ODlhNjg+XQo+ICh0ZWdyYV9o
ZG1pX2VuY29kZXJfZW5hYmxlKzB4NWVjLzB4MmEyMCkKPiBbICAgMzEuMDI2Mzc5XSBbPGMwNTg5
YTY4Pl0gKHRlZ3JhX2hkbWlfZW5jb2Rlcl9lbmFibGUpIGZyb20KPiBbPGMwNTQ0MTVjPl0gKGRy
bV9hdG9taWNfaGVscGVyX2NvbW1pdF9tb2Rlc2V0X2VuYWJsZXMrMHgxMGMvMHgyMjApCj4gWyAg
IDMxLjAyNjM5N10gWzxjMDU0NDE1Yz5dIChkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfbW9kZXNl
dF9lbmFibGVzKQo+IGZyb20gWzxjMDU0NDQ5Yz5dIChkcm1fYXRvbWljX2hlbHBlcl9jb21taXRf
dGFpbF9ycG0rMHgyNC8weDZjKQo+IFsgICAzMS4wMjY0MTJdIFs8YzA1NDQ0OWM+XSAoZHJtX2F0
b21pY19oZWxwZXJfY29tbWl0X3RhaWxfcnBtKSBmcm9tCj4gWzxjMDU0NDMxYz5dIChjb21taXRf
dGFpbCsweDQwLzB4NmMpCj4gWyAgIDMxLjAyNjQyN10gWzxjMDU0NDMxYz5dIChjb21taXRfdGFp
bCkgZnJvbSBbPGMwNTQ0NDBjPl0KPiAoZHJtX2F0b21pY19oZWxwZXJfY29tbWl0KzB4YmMvMHgx
MjgpCj4gWyAgIDMxLjAyNjQ0M10gWzxjMDU0NDQwYz5dIChkcm1fYXRvbWljX2hlbHBlcl9jb21t
aXQpIGZyb20KPiBbPGMwNTQ3MjYwPl0gKHJlc3RvcmVfZmJkZXZfbW9kZV9hdG9taWMrMHgxNjAv
MHgxY2MpCj4gWyAgIDMxLjAyNjQ1N10gWzxjMDU0NzI2MD5dIChyZXN0b3JlX2ZiZGV2X21vZGVf
YXRvbWljKSBmcm9tCj4gWzxjMDU0NzQyMD5dIChkcm1fZmJfaGVscGVyX3Bhbl9kaXNwbGF5KzB4
YzQvMHgxZDApCj4gWyAgIDMxLjAyNjQ4MV0gWzxjMDU0NzQyMD5dIChkcm1fZmJfaGVscGVyX3Bh
bl9kaXNwbGF5KSBmcm9tCj4gWzxjMDRiMDI1MD5dIChmYl9wYW5fZGlzcGxheSsweDljLzB4MTE4
KQo+IFsgICAzMS4wMjY0OThdIFs8YzA0YjAyNTA+XSAoZmJfcGFuX2Rpc3BsYXkpIGZyb20gWzxj
MDRiMGZkYz5dCj4gKGRvX2ZiX2lvY3RsKzB4NGIwLzB4N2NjKQo+IFsgICAzMS4wMjY1MTRdIFs8
YzA0YjBmZGM+XSAoZG9fZmJfaW9jdGwpIGZyb20gWzxjMDI3ZTY4OD5dCj4gKGRvX3Zmc19pb2N0
bCsweGFjLzB4OGY4KQo+IFsgICAzMS4wMjY1MjddIFs8YzAyN2U2ODg+XSAoZG9fdmZzX2lvY3Rs
KSBmcm9tIFs8YzAyN2VmMDg+XQo+IChrc3lzX2lvY3RsKzB4MzQvMHg2MCkKPiBbICAgMzEuMDI2
NTQwXSBbPGMwMjdlZjA4Pl0gKGtzeXNfaW9jdGwpIGZyb20gWzxjMDEwMTAwMD5dCj4gKHJldF9m
YXN0X3N5c2NhbGwrMHgwLzB4NTQpCj4gWyAgIDMxLjAyNjU0Nl0gRXhjZXB0aW9uIHN0YWNrKDB4
Y2JhNTlmYTggdG8gMHhjYmE1OWZmMCkKPiBbICAgMzEuMDI2NTU5XSA5ZmEwOiAgICAgICAgICAg
ICAgICAgICAwMDE1MjdhOCAwMDE1MjI3OCAwMDAwMDAwYQo+IDAwMDA0NjA2IDAwMTUyODA4IDAw
MDAwMDAwCj4gWyAgIDMxLjAyNjU3Ml0gOWZjMDogMDAxNTI3YTggMDAxNTIyNzggMDAxNWIzNjgg
MDAwMDAwMzYgYjZmMjA5NjEKPiAwMDAwMDAwYSBiZWRiNWRkNCAwMDAwMDAwMAo+IFsgICAzMS4w
MjY1ODFdIDlmZTA6IGI2YWY3MDk4IGJlZGI1YjFjIGI2YWY0NjAzIGI2Y2RiNjdjCj4gWyAgIDMx
LjAyNjU4Nl0gRGl2aXNpb24gYnkgemVybyBpbiBrZXJuZWwuCj4gWyAgIDMxLjAyNjU5NV0gQ1BV
OiAxIFBJRDogNTI5IENvbW06IFggTm90IHRhaW50ZWQgNS4wLjAtcmM1LW5leHQtCj4gMjAxOTAy
MDgtZGlydHkgIzE1Mwo+IFsgICAzMS4wMjY2MDBdIEhhcmR3YXJlIG5hbWU6IE5WSURJQSBUZWdy
YSBTb0MgKEZsYXR0ZW5lZCBEZXZpY2UgVHJlZSkKPiBbICAgMzEuMDI2NjE1XSBbPGMwMTEyMGNj
Pl0gKHVud2luZF9iYWNrdHJhY2UpIGZyb20gWzxjMDEwYzkyYz5dCj4gKHNob3dfc3RhY2srMHgx
MC8weDE0KQo+IFsgICAzMS4wMjY2MjldIFs8YzAxMGM5MmM+XSAoc2hvd19zdGFjaykgZnJvbSBb
PGMwYTdjNWFjPl0KPiAoZHVtcF9zdGFjaysweGI0LzB4YzgpCj4gWyAgIDMxLjAyNjY0MF0gWzxj
MGE3YzVhYz5dIChkdW1wX3N0YWNrKSBmcm9tIFs8YzBhN2E3ZTQ+XQo+IChMZGl2MCsweDgvMHgx
MCkKPiBbICAgMzEuMDI2NjU0XSBbPGMwYTdhN2U0Pl0gKExkaXYwKSBmcm9tIFs8YzA1ODg3YWM+
XQo+ICh0ZWdyYV9oZG1pX3NldHVwX2F1ZGlvKzB4MjAwLzB4ZWQwKQo+IFsgICAzMS4wMjY2Njdd
IFs8YzA1ODg3YWM+XSAodGVncmFfaGRtaV9zZXR1cF9hdWRpbykgZnJvbSBbPGMwNTg5YTY4Pl0K
PiAodGVncmFfaGRtaV9lbmNvZGVyX2VuYWJsZSsweDVlYy8weDJhMjApCj4gWyAgIDMxLjAyNjY4
NF0gWzxjMDU4OWE2OD5dICh0ZWdyYV9oZG1pX2VuY29kZXJfZW5hYmxlKSBmcm9tCj4gWzxjMDU0
NDE1Yz5dIChkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfbW9kZXNldF9lbmFibGVzKzB4MTBjLzB4
MjIwKQo+IFsgICAzMS4wMjY3MDBdIFs8YzA1NDQxNWM+XSAoZHJtX2F0b21pY19oZWxwZXJfY29t
bWl0X21vZGVzZXRfZW5hYmxlcykKPiBmcm9tIFs8YzA1NDQ0OWM+XSAoZHJtX2F0b21pY19oZWxw
ZXJfY29tbWl0X3RhaWxfcnBtKzB4MjQvMHg2YykKPiBbICAgMzEuMDI2NzE1XSBbPGMwNTQ0NDlj
Pl0gKGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF90YWlsX3JwbSkgZnJvbQo+IFs8YzA1NDQzMWM+
XSAoY29tbWl0X3RhaWwrMHg0MC8weDZjKQo+IFsgICAzMS4wMjY3MjldIFs8YzA1NDQzMWM+XSAo
Y29tbWl0X3RhaWwpIGZyb20gWzxjMDU0NDQwYz5dCj4gKGRybV9hdG9taWNfaGVscGVyX2NvbW1p
dCsweGJjLzB4MTI4KQo+IFsgICAzMS4wMjY3NDNdIFs8YzA1NDQ0MGM+XSAoZHJtX2F0b21pY19o
ZWxwZXJfY29tbWl0KSBmcm9tCj4gWzxjMDU0NzI2MD5dIChyZXN0b3JlX2ZiZGV2X21vZGVfYXRv
bWljKzB4MTYwLzB4MWNjKQo+IFsgICAzMS4wMjY3NTVdIFs8YzA1NDcyNjA+XSAocmVzdG9yZV9m
YmRldl9tb2RlX2F0b21pYykgZnJvbQo+IFs8YzA1NDc0MjA+XSAoZHJtX2ZiX2hlbHBlcl9wYW5f
ZGlzcGxheSsweGM0LzB4MWQwKQo+IFsgICAzMS4wMjY3NzBdIFs8YzA1NDc0MjA+XSAoZHJtX2Zi
X2hlbHBlcl9wYW5fZGlzcGxheSkgZnJvbQo+IFs8YzA0YjAyNTA+XSAoZmJfcGFuX2Rpc3BsYXkr
MHg5Yy8weDExOCkKPiBbICAgMzEuMDI2Nzg1XSBbPGMwNGIwMjUwPl0gKGZiX3Bhbl9kaXNwbGF5
KSBmcm9tIFs8YzA0YjBmZGM+XQo+IChkb19mYl9pb2N0bCsweDRiMC8weDdjYykKPiBbICAgMzEu
MDI2Nzk3XSBbPGMwNGIwZmRjPl0gKGRvX2ZiX2lvY3RsKSBmcm9tIFs8YzAyN2U2ODg+XQo+IChk
b192ZnNfaW9jdGwrMHhhYy8weDhmOCkKPiBbICAgMzEuMDI2ODA5XSBbPGMwMjdlNjg4Pl0gKGRv
X3Zmc19pb2N0bCkgZnJvbSBbPGMwMjdlZjA4Pl0KPiAoa3N5c19pb2N0bCsweDM0LzB4NjApCj4g
WyAgIDMxLjAyNjgyMF0gWzxjMDI3ZWYwOD5dIChrc3lzX2lvY3RsKSBmcm9tIFs8YzAxMDEwMDA+
XQo+IChyZXRfZmFzdF9zeXNjYWxsKzB4MC8weDU0KQo+IFsgICAzMS4wMjY4MjZdIEV4Y2VwdGlv
biBzdGFjaygweGNiYTU5ZmE4IHRvIDB4Y2JhNTlmZjApCj4gWyAgIDMxLjAyNjgzN10gOWZhMDog
ICAgICAgICAgICAgICAgICAgMDAxNTI3YTggMDAxNTIyNzggMDAwMDAwMGEKPiAwMDAwNDYwNiAw
MDE1MjgwOCAwMDAwMDAwMAo+IFsgICAzMS4wMjY4NTBdIDlmYzA6IDAwMTUyN2E4IDAwMTUyMjc4
IDAwMTViMzY4IDAwMDAwMDM2IGI2ZjIwOTYxCj4gMDAwMDAwMGEgYmVkYjVkZDQgMDAwMDAwMDAK
PiBbICAgMzEuMDI2ODU5XSA5ZmUwOiBiNmFmNzA5OCBiZWRiNWIxYyBiNmFmNDYwMyBiNmNkYjY3
Ywo+IAo+IFRoaXMgaGFzIGJlZW4gb2JzZXJ2ZWQgb24gYSBBcGFsaXMgVDMwIDJHQiBydW5uaW5n
IHRvZGF5cyAtbmV4dC4KPiAKPiBBbnlib2R5IGtub3dpbmcgd2hhdCBpcyBnb2luZyBvbiBiZWZv
cmUgSSBkaWcgZGVlcGVyPwoKU291bmRzIGxpa2UgdGhpcyBbMF0gY291bGQgYmUgdGhlIGNhdXNl
LgoKWzBdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25l
eHQvbGludXgtbmV4dC5naXQvY29tbWl0L2RyaXZlcnMvZ3B1L2RybS90ZWdyYT9pZD1kYjVhZGY0
ZDZkY2VkNGUzMzI2Y2UzNjlmZTBjMjEzYzk2ODA5NWY0CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
