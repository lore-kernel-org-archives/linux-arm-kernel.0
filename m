Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:54:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDB42176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N7gN/8re";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYa1E4TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDB42176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iec2/Vl89j8SgmYa6n95kmpjoTS3TDvIUhMKxewhL3I=; b=N7gN/8rewcsOiM
	scp29B3d6pbplYmFc8//3zZb66bMJ1k4cr4Pqwwi1ntYooxRzu1U6x7CAUnalp+MSxerjbseaAETP
	7LloNaBcYF72DMA8W6QUDCOWDOeeXgtoLbW7j1pQzKlmk+7e7qfLA/oxKsFwhp0+tJAU7Pb34z6Sm
	ZR8oVs1gtQtW77tGBSAHbUWDQKJFvM8NJkCdb4PYA1lXuqRlQ7l3StD4gQJql9xPSW2aonmO1OU/8
	pdVfAlXHTaQa5N3mhtlYBewHdpn5A3xS1+osozCTfQTLkbDGhnyAQQDsMWlajc1Hh3YgZGSGTIouN
	o3hp3CmQWDOy/t2ckGWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gssMm-0006AH-87; Sun, 10 Feb 2019 16:54:04 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gssMi-00069m-Kp
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 16:54:02 +0000
Received: by mail-lj1-x242.google.com with SMTP id a16so2746240ljb.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=arU6AScsirO3xNqhZACBezb+W7JFcBIniwVJ01DbbBM=;
 b=JYa1E4TMNOuyC0erdqLnJ0X5M5CTj/4st5MDdmb5Kkogb0k1GKBm4iR20ZwFToNocD
 wPPEMAzuFxFgwzZz1B0kV2yrBIxSTC/9FsvYpWhApIsFp9Uh5AYYkcnt1SHrREHvXWSV
 POd2RD5v5+kOAKv7HmtkRNxNbGgZ5XB4xJOlhLvxNH95Z5CEJs4PnO/W6oKOvGAslCQ4
 yL0srw1VkJyO/AvbkMT3HbVqZAP7bT39dwXtrysJ9IPN1+nQec4Dm+CFdOAIFk22TruP
 gRQyDyrAQvLkHfQt1qq+B/N15H6Ln2jUT78RCkkDZtaiFc4qbXVXOdH9oqfmpa7bAhOv
 YJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=arU6AScsirO3xNqhZACBezb+W7JFcBIniwVJ01DbbBM=;
 b=eKr5h+qG4YdyyviEYRV2oTX+z2d4iHzGAFOj2rn7EPhxyRTL+smWn6hYfRu/Nke79G
 Hg8+VXsjnXCerpk1rDoKft3bs0feuw5rV0SWz/Cfwo9jT4J0u0LW/oCRCLAItyGljJjY
 Z/1gGtBjpICZUbNQngV86FPYnmCMxbjlAlyI27Cq3aedpJqg3K7aopEuH7mgfJV5Kj8B
 yEP7msrjfgZ1clZQg9L99ltk4M0Q3sB9lcQ5LbtvcnGzbu7S+DA+GnG3fkoXBulwy35X
 DgqIN8gV9O6EHivmDsUTbpswvkqoit6QuMiFZYyW9v+iXdTlhVMBdkdm7oNZlyj3DTcN
 JELA==
X-Gm-Message-State: AHQUAuaSKe20mcB1HBCrlTaOhjKwsgn89L6imlNa8/8yIfl/QZk7EVaR
 9Hs5rZSycLOf2YeiD+ipfqQ=
X-Google-Smtp-Source: AHgI3Ib0p6WY/tBRW6R43TXcmMBcOWXuM2zUSX607UVPHwk1RSMGclrssRkyXKG2GrgS5w596kdQuw==
X-Received: by 2002:a2e:86ca:: with SMTP id
 n10-v6mr17264840ljj.49.1549817638171; 
 Sun, 10 Feb 2019 08:53:58 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id g6sm355432lfh.35.2019.02.10.08.53.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 10 Feb 2019 08:53:57 -0800 (PST)
Subject: Re: [REGRESSION] drm/tegra: hdmi: tegra_hdmi_setup_audio: division by
 zero in kernel
From: Dmitry Osipenko <digetx@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <87f8fd40b25e2842b547059a8d28295533e8c09c.camel@toradex.com>
 <139085a2-014a-b666-2d3f-d1833b6017c5@gmail.com>
Message-ID: <36fe3952-c1d8-da39-7996-55240fe15552@gmail.com>
Date: Sun, 10 Feb 2019 19:53:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <139085a2-014a-b666-2d3f-d1833b6017c5@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_085400_683293_E65DE7C6 
X-CRM114-Status: GOOD (  11.99  )
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

MTAuMDIuMjAxOSAxOTo1MSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMDguMDIuMjAx
OSAyMzowMSwgTWFyY2VsIFppc3dpbGVyINC/0LjRiNC10YI6Cj4+IEhpIHRoZXJlCj4+Cj4+IEkg
anVzdCBzdHVtYmxlZCBvdmVyIHRoaXMgb25lOgo+Pgo+PiBbICAgMzEuMDI2MjIwXSBEaXZpc2lv
biBieSB6ZXJvIGluIGtlcm5lbC4KPj4gWyAgIDMxLjAyNjIzOF0gQ1BVOiAxIFBJRDogNTI5IENv
bW06IFggTm90IHRhaW50ZWQgNS4wLjAtcmM1LW5leHQtCj4+IDIwMTkwMjA4LWRpcnR5ICMxNTMK
Pj4gWyAgIDMxLjAyNjI0NF0gSGFyZHdhcmUgbmFtZTogTlZJRElBIFRlZ3JhIFNvQyAoRmxhdHRl
bmVkIERldmljZSBUcmVlKQo+PiBbICAgMzEuMDI2MjgxXSBbPGMwMTEyMGNjPl0gKHVud2luZF9i
YWNrdHJhY2UpIGZyb20gWzxjMDEwYzkyYz5dCj4+IChzaG93X3N0YWNrKzB4MTAvMHgxNCkKPj4g
WyAgIDMxLjAyNjMwMV0gWzxjMDEwYzkyYz5dIChzaG93X3N0YWNrKSBmcm9tIFs8YzBhN2M1YWM+
XQo+PiAoZHVtcF9zdGFjaysweGI0LzB4YzgpCj4+IFsgICAzMS4wMjYzMTddIFs8YzBhN2M1YWM+
XSAoZHVtcF9zdGFjaykgZnJvbSBbPGMwYTdhN2U0Pl0KPj4gKExkaXYwKzB4OC8weDEwKQo+PiBb
ICAgMzEuMDI2MzM3XSBbPGMwYTdhN2U0Pl0gKExkaXYwKSBmcm9tIFs8YzA1ODg3NTg+XQo+PiAo
dGVncmFfaGRtaV9zZXR1cF9hdWRpbysweDFhYy8weGVkMCkKPj4gWyAgIDMxLjAyNjM1M10gWzxj
MDU4ODc1OD5dICh0ZWdyYV9oZG1pX3NldHVwX2F1ZGlvKSBmcm9tIFs8YzA1ODlhNjg+XQo+PiAo
dGVncmFfaGRtaV9lbmNvZGVyX2VuYWJsZSsweDVlYy8weDJhMjApCj4+IFsgICAzMS4wMjYzNzld
IFs8YzA1ODlhNjg+XSAodGVncmFfaGRtaV9lbmNvZGVyX2VuYWJsZSkgZnJvbQo+PiBbPGMwNTQ0
MTVjPl0gKGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF9tb2Rlc2V0X2VuYWJsZXMrMHgxMGMvMHgy
MjApCj4+IFsgICAzMS4wMjYzOTddIFs8YzA1NDQxNWM+XSAoZHJtX2F0b21pY19oZWxwZXJfY29t
bWl0X21vZGVzZXRfZW5hYmxlcykKPj4gZnJvbSBbPGMwNTQ0NDljPl0gKGRybV9hdG9taWNfaGVs
cGVyX2NvbW1pdF90YWlsX3JwbSsweDI0LzB4NmMpCj4+IFsgICAzMS4wMjY0MTJdIFs8YzA1NDQ0
OWM+XSAoZHJtX2F0b21pY19oZWxwZXJfY29tbWl0X3RhaWxfcnBtKSBmcm9tCj4+IFs8YzA1NDQz
MWM+XSAoY29tbWl0X3RhaWwrMHg0MC8weDZjKQo+PiBbICAgMzEuMDI2NDI3XSBbPGMwNTQ0MzFj
Pl0gKGNvbW1pdF90YWlsKSBmcm9tIFs8YzA1NDQ0MGM+XQo+PiAoZHJtX2F0b21pY19oZWxwZXJf
Y29tbWl0KzB4YmMvMHgxMjgpCj4+IFsgICAzMS4wMjY0NDNdIFs8YzA1NDQ0MGM+XSAoZHJtX2F0
b21pY19oZWxwZXJfY29tbWl0KSBmcm9tCj4+IFs8YzA1NDcyNjA+XSAocmVzdG9yZV9mYmRldl9t
b2RlX2F0b21pYysweDE2MC8weDFjYykKPj4gWyAgIDMxLjAyNjQ1N10gWzxjMDU0NzI2MD5dIChy
ZXN0b3JlX2ZiZGV2X21vZGVfYXRvbWljKSBmcm9tCj4+IFs8YzA1NDc0MjA+XSAoZHJtX2ZiX2hl
bHBlcl9wYW5fZGlzcGxheSsweGM0LzB4MWQwKQo+PiBbICAgMzEuMDI2NDgxXSBbPGMwNTQ3NDIw
Pl0gKGRybV9mYl9oZWxwZXJfcGFuX2Rpc3BsYXkpIGZyb20KPj4gWzxjMDRiMDI1MD5dIChmYl9w
YW5fZGlzcGxheSsweDljLzB4MTE4KQo+PiBbICAgMzEuMDI2NDk4XSBbPGMwNGIwMjUwPl0gKGZi
X3Bhbl9kaXNwbGF5KSBmcm9tIFs8YzA0YjBmZGM+XQo+PiAoZG9fZmJfaW9jdGwrMHg0YjAvMHg3
Y2MpCj4+IFsgICAzMS4wMjY1MTRdIFs8YzA0YjBmZGM+XSAoZG9fZmJfaW9jdGwpIGZyb20gWzxj
MDI3ZTY4OD5dCj4+IChkb192ZnNfaW9jdGwrMHhhYy8weDhmOCkKPj4gWyAgIDMxLjAyNjUyN10g
WzxjMDI3ZTY4OD5dIChkb192ZnNfaW9jdGwpIGZyb20gWzxjMDI3ZWYwOD5dCj4+IChrc3lzX2lv
Y3RsKzB4MzQvMHg2MCkKPj4gWyAgIDMxLjAyNjU0MF0gWzxjMDI3ZWYwOD5dIChrc3lzX2lvY3Rs
KSBmcm9tIFs8YzAxMDEwMDA+XQo+PiAocmV0X2Zhc3Rfc3lzY2FsbCsweDAvMHg1NCkKPj4gWyAg
IDMxLjAyNjU0Nl0gRXhjZXB0aW9uIHN0YWNrKDB4Y2JhNTlmYTggdG8gMHhjYmE1OWZmMCkKPj4g
WyAgIDMxLjAyNjU1OV0gOWZhMDogICAgICAgICAgICAgICAgICAgMDAxNTI3YTggMDAxNTIyNzgg
MDAwMDAwMGEKPj4gMDAwMDQ2MDYgMDAxNTI4MDggMDAwMDAwMDAKPj4gWyAgIDMxLjAyNjU3Ml0g
OWZjMDogMDAxNTI3YTggMDAxNTIyNzggMDAxNWIzNjggMDAwMDAwMzYgYjZmMjA5NjEKPj4gMDAw
MDAwMGEgYmVkYjVkZDQgMDAwMDAwMDAKPj4gWyAgIDMxLjAyNjU4MV0gOWZlMDogYjZhZjcwOTgg
YmVkYjViMWMgYjZhZjQ2MDMgYjZjZGI2N2MKPj4gWyAgIDMxLjAyNjU4Nl0gRGl2aXNpb24gYnkg
emVybyBpbiBrZXJuZWwuCj4+IFsgICAzMS4wMjY1OTVdIENQVTogMSBQSUQ6IDUyOSBDb21tOiBY
IE5vdCB0YWludGVkIDUuMC4wLXJjNS1uZXh0LQo+PiAyMDE5MDIwOC1kaXJ0eSAjMTUzCj4+IFsg
ICAzMS4wMjY2MDBdIEhhcmR3YXJlIG5hbWU6IE5WSURJQSBUZWdyYSBTb0MgKEZsYXR0ZW5lZCBE
ZXZpY2UgVHJlZSkKPj4gWyAgIDMxLjAyNjYxNV0gWzxjMDExMjBjYz5dICh1bndpbmRfYmFja3Ry
YWNlKSBmcm9tIFs8YzAxMGM5MmM+XQo+PiAoc2hvd19zdGFjaysweDEwLzB4MTQpCj4+IFsgICAz
MS4wMjY2MjldIFs8YzAxMGM5MmM+XSAoc2hvd19zdGFjaykgZnJvbSBbPGMwYTdjNWFjPl0KPj4g
KGR1bXBfc3RhY2srMHhiNC8weGM4KQo+PiBbICAgMzEuMDI2NjQwXSBbPGMwYTdjNWFjPl0gKGR1
bXBfc3RhY2spIGZyb20gWzxjMGE3YTdlND5dCj4+IChMZGl2MCsweDgvMHgxMCkKPj4gWyAgIDMx
LjAyNjY1NF0gWzxjMGE3YTdlND5dIChMZGl2MCkgZnJvbSBbPGMwNTg4N2FjPl0KPj4gKHRlZ3Jh
X2hkbWlfc2V0dXBfYXVkaW8rMHgyMDAvMHhlZDApCj4+IFsgICAzMS4wMjY2NjddIFs8YzA1ODg3
YWM+XSAodGVncmFfaGRtaV9zZXR1cF9hdWRpbykgZnJvbSBbPGMwNTg5YTY4Pl0KPj4gKHRlZ3Jh
X2hkbWlfZW5jb2Rlcl9lbmFibGUrMHg1ZWMvMHgyYTIwKQo+PiBbICAgMzEuMDI2Njg0XSBbPGMw
NTg5YTY4Pl0gKHRlZ3JhX2hkbWlfZW5jb2Rlcl9lbmFibGUpIGZyb20KPj4gWzxjMDU0NDE1Yz5d
IChkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfbW9kZXNldF9lbmFibGVzKzB4MTBjLzB4MjIwKQo+
PiBbICAgMzEuMDI2NzAwXSBbPGMwNTQ0MTVjPl0gKGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF9t
b2Rlc2V0X2VuYWJsZXMpCj4+IGZyb20gWzxjMDU0NDQ5Yz5dIChkcm1fYXRvbWljX2hlbHBlcl9j
b21taXRfdGFpbF9ycG0rMHgyNC8weDZjKQo+PiBbICAgMzEuMDI2NzE1XSBbPGMwNTQ0NDljPl0g
KGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF90YWlsX3JwbSkgZnJvbQo+PiBbPGMwNTQ0MzFjPl0g
KGNvbW1pdF90YWlsKzB4NDAvMHg2YykKPj4gWyAgIDMxLjAyNjcyOV0gWzxjMDU0NDMxYz5dIChj
b21taXRfdGFpbCkgZnJvbSBbPGMwNTQ0NDBjPl0KPj4gKGRybV9hdG9taWNfaGVscGVyX2NvbW1p
dCsweGJjLzB4MTI4KQo+PiBbICAgMzEuMDI2NzQzXSBbPGMwNTQ0NDBjPl0gKGRybV9hdG9taWNf
aGVscGVyX2NvbW1pdCkgZnJvbQo+PiBbPGMwNTQ3MjYwPl0gKHJlc3RvcmVfZmJkZXZfbW9kZV9h
dG9taWMrMHgxNjAvMHgxY2MpCj4+IFsgICAzMS4wMjY3NTVdIFs8YzA1NDcyNjA+XSAocmVzdG9y
ZV9mYmRldl9tb2RlX2F0b21pYykgZnJvbQo+PiBbPGMwNTQ3NDIwPl0gKGRybV9mYl9oZWxwZXJf
cGFuX2Rpc3BsYXkrMHhjNC8weDFkMCkKPj4gWyAgIDMxLjAyNjc3MF0gWzxjMDU0NzQyMD5dIChk
cm1fZmJfaGVscGVyX3Bhbl9kaXNwbGF5KSBmcm9tCj4+IFs8YzA0YjAyNTA+XSAoZmJfcGFuX2Rp
c3BsYXkrMHg5Yy8weDExOCkKPj4gWyAgIDMxLjAyNjc4NV0gWzxjMDRiMDI1MD5dIChmYl9wYW5f
ZGlzcGxheSkgZnJvbSBbPGMwNGIwZmRjPl0KPj4gKGRvX2ZiX2lvY3RsKzB4NGIwLzB4N2NjKQo+
PiBbICAgMzEuMDI2Nzk3XSBbPGMwNGIwZmRjPl0gKGRvX2ZiX2lvY3RsKSBmcm9tIFs8YzAyN2U2
ODg+XQo+PiAoZG9fdmZzX2lvY3RsKzB4YWMvMHg4ZjgpCj4+IFsgICAzMS4wMjY4MDldIFs8YzAy
N2U2ODg+XSAoZG9fdmZzX2lvY3RsKSBmcm9tIFs8YzAyN2VmMDg+XQo+PiAoa3N5c19pb2N0bCsw
eDM0LzB4NjApCj4+IFsgICAzMS4wMjY4MjBdIFs8YzAyN2VmMDg+XSAoa3N5c19pb2N0bCkgZnJv
bSBbPGMwMTAxMDAwPl0KPj4gKHJldF9mYXN0X3N5c2NhbGwrMHgwLzB4NTQpCj4+IFsgICAzMS4w
MjY4MjZdIEV4Y2VwdGlvbiBzdGFjaygweGNiYTU5ZmE4IHRvIDB4Y2JhNTlmZjApCj4+IFsgICAz
MS4wMjY4MzddIDlmYTA6ICAgICAgICAgICAgICAgICAgIDAwMTUyN2E4IDAwMTUyMjc4IDAwMDAw
MDBhCj4+IDAwMDA0NjA2IDAwMTUyODA4IDAwMDAwMDAwCj4+IFsgICAzMS4wMjY4NTBdIDlmYzA6
IDAwMTUyN2E4IDAwMTUyMjc4IDAwMTViMzY4IDAwMDAwMDM2IGI2ZjIwOTYxCj4+IDAwMDAwMDBh
IGJlZGI1ZGQ0IDAwMDAwMDAwCj4+IFsgICAzMS4wMjY4NTldIDlmZTA6IGI2YWY3MDk4IGJlZGI1
YjFjIGI2YWY0NjAzIGI2Y2RiNjdjCj4+Cj4+IFRoaXMgaGFzIGJlZW4gb2JzZXJ2ZWQgb24gYSBB
cGFsaXMgVDMwIDJHQiBydW5uaW5nIHRvZGF5cyAtbmV4dC4KPj4KPj4gQW55Ym9keSBrbm93aW5n
IHdoYXQgaXMgZ29pbmcgb24gYmVmb3JlIEkgZGlnIGRlZXBlcj8KPiAKPiBTb3VuZHMgbGlrZSB0
aGlzIFswXSBjb3VsZCBiZSB0aGUgY2F1c2UuCj4gCj4gWzBdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0L2Ry
aXZlcnMvZ3B1L2RybS90ZWdyYT9pZD1kYjVhZGY0ZDZkY2VkNGUzMzI2Y2UzNjlmZTBjMjEzYzk2
ODA5NWY0Cj4gCgpBaCwgc2VlbXMgeW91IGFscmVhZHkgZmlndXJlZCB0aGF0IG91dC4uIHNvcnJ5
IGZvciB0aGUgbm9pc2UuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
