Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D75C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F49320665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CVOLE/t9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AaZojl24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F49320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FJ1dlyTPGi6o69Z1FjpHh2h0+ZmEiop5g6aUjgtwm5Y=; b=CVOLE/t9Wwxo0d
	eD/Ln2g/j0oqlRjrNdb9Hht7SQbjAyRtHyYqb4WIpBEW3oqo0KpNlb6WhJdDgpxDJO7lcdvsXOkTv
	wKbrcaGU8FAvIcZfgpUubEjP/tB5pzI4EcBjhuQj5PWxJYatskgLjPrX/Bgu2DWLCKiT//rIZTfyQ
	FbTdglP91IqTuT1m0qfGzsHHXBYCIepPJ0CFx+J1V4IJJPSkA2I65fbmSV2XWayLMYFLg0iFMhak5
	61uBHiJYez94MWcsTW6BlgaufWeY5UBxizcpTYBJ5YfKaFJsTpgGLjNBkCTvoEz/ASYC/ANNZXhkH
	g1NueExCSy5b9P2rjFrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIaP-0007sv-PH; Wed, 09 Jan 2019 18:28:17 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIaC-0007iU-MB
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:28:06 +0000
Received: by mail-yb1-xb42.google.com with SMTP id x9so3377997ybj.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 10:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JxIjSXUMfcMOh/NKE8hkX8k17mbhEUFgFur+hJ0iY4I=;
 b=AaZojl24TyxUvoj3qk5rJ+KXI5rrkbo+R4lzjpvup5hwI4SPvsj7L5SF1ITf8RdiLS
 UCRkX7esIHh3M5xSq+3S1+YCnolVOIINbAHKv622mmFWNpB1TQS3PopOIu/LhuSBQ+QF
 EoQF9HQjnxKNyhSe6gkxb+z1dPGJx1Jml3KqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JxIjSXUMfcMOh/NKE8hkX8k17mbhEUFgFur+hJ0iY4I=;
 b=oEU9M177CeOG3e7Tu6yBHdtp1D5piOtyJdEYW1ThFTI/NAF9ug6kHbsDDxwRqsIohN
 gXab0yqXP3XWEe0x0xLWyCQwu8Q0p8RHcrYnhEetarkx6iKvJarX8RHpuD/Mo5A3dbaW
 lE5N9ocMnbqz+nyM0krOpUTBGJ+NZFvCuI/80FbhqDST54rlSOYzXqhfuvLJEFmaeQXX
 5WSpuLgdx175zZWdyCb5AQh5qFlZcPA6Uvpxb7Z7Bo8zbfami+3uQAwXFchURF61AQQU
 7/Y7ulm9geHDyDaCWZ1hfH/ZVWmGBbxEAtGndSrF+CbvUX8poAX0EBbiPGk8Up8UGIjy
 bsZA==
X-Gm-Message-State: AJcUukdWKgYSepQBjYXD02h+s4UiqbKkoREOS0kWyIuxR8jgZ3TBV/Rw
 C8XIUyb4LTrgLS9lawsN1+Bkcw==
X-Google-Smtp-Source: ALg8bN5Wwoh9/bzU9U9aFL17dEx+mrUhv1QgcFn5B5+gwe43pk9B+zFgdGKuRgvL44IFOhcu+af9Sg==
X-Received: by 2002:a25:bac2:: with SMTP id a2mr6801058ybk.519.1547058482932; 
 Wed, 09 Jan 2019 10:28:02 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id a72sm27998605ywh.42.2019.01.09.10.28.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 10:28:02 -0800 (PST)
Subject: Re: [PATCH 0/8] Add IPROC I2C slave mode and NIC I2C support
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <1546938997-13798-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <6a5380e3-1e15-31e3-bbaa-134856a0c2dc@broadcom.com>
 <CAHO=5PG3NnYqoSyZ9u9kN1m7KagtKv275tpWj6s8NXvzhj52fQ@mail.gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <44deeaef-a9b8-9ce1-d6b8-76d99a53cd4f@broadcom.com>
Date: Wed, 9 Jan 2019 10:27:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHO=5PG3NnYqoSyZ9u9kN1m7KagtKv275tpWj6s8NXvzhj52fQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_102804_722167_5FE2851E 
X-CRM114-Status: GOOD (  21.61  )
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
Cc: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org,
 Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
 Michael Cheng <ccheng@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T2theS4gSnVzdCBub3RpY2VkIGFub3RoZXIgdGhpbmcuIE1heSBJIGFzayBpZiB5b3UgcmFuIHRo
ZQonZ2V0X21haW50YWltbmVyLnBsJyBzY3JpcHQgdG8gZmlndXJlIG91dCB0aGUgJ1RvOicgYW5k
ICdDYzonPwoKSSBkb24ndCBzZWUgV29sZnJhbSdzIG5hbWUgb24gb24gdGhlIFRvIG9yIENjIGZp
ZWxkIG9mIHRoZSBlbWFpbHMgeW91CnNlbmQgb3V0OgoKV29sZnJhbSBTYW5nIDx3c2FAdGhlLWRy
ZWFtcy5kZT4KCjY4NDUgSTJDIFNVQlNZU1RFTQo2ODQ2IE06ICAgICAgV29sZnJhbSBTYW5nIDx3
c2FAdGhlLWRyZWFtcy5kZT4KNjg0NyBMOiAgICAgIGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmcK
CgpUaGFua3MsCgpSYXkKCk9uIDEvOC8yMDE5IDY6MTUgUE0sIFJheWFnb25kYSBLb2thdGFudXIg
d3JvdGU6Cj4gU29ycnkgZm9yIGNvbmZ1c2lvbi4gSSBtYWRlIG1pc3Rha2UgaW4gYWRkaW5nIGJj
bS1rZXJuZWwtZmVlZGJhY2stbGlzdAo+IHdoaWxlIHNlbmRpbmcgcGF0Y2guIEhlbmNlIHNlbnQg
c2FtZSBwYXRjaCBzZXQgd2l0aCB1cGRhdGVkIGVtYWlsIGxpc3QuwqAKPiAKPiBCZXN0IHJlZ2Fy
ZHMsCj4gUmF5YWdvbmRhCj4gCj4gCj4gCj4gT24gSmFuIDgsIDIwMTkgMTA6NTUgUE0sICJSYXkg
SnVpIiA8cmF5Lmp1aUBicm9hZGNvbS5jb20KPiA8bWFpbHRvOnJheS5qdWlAYnJvYWRjb20uY29t
Pj4gd3JvdGU6Cj4gCj4gICAgIFlvdSBzZW50IG91dCB0aGUgc2FtZSBwYXRjaCBzZXJpZXMgMyB0
aW1lcyB3aXRob3V0IGFueSBleHBsYW5hdGlvbi4gVmVyeQo+ICAgICBjb25mdXNpbmcuCj4gCj4g
ICAgIElzIHRoaXMgdGhlIGxhdGVzdCBvbmUgdGhhdCBzaG91bGQgYmUgcmV2aWV3ZWQ/Cj4gCj4g
ICAgIFRoYW5rcywKPiAKPiAgICAgUmF5Cj4gCj4gCj4gICAgIE9uIDEvOC8yMDE5IDE6MTYgQU0s
IFJheWFnb25kYSBLb2thdGFudXIgd3JvdGU6Cj4gICAgID4gSGksCj4gICAgID4gVGhpcyBwYXRj
aHNldCBjb250YWlucyBzdXBwb3J0IGZvciBJUFJPQyBJMkMgc2xhdmUgYW5kIE5JQyBJMkMKPiAg
ICAgc3VwcG9ydC4KPiAgICAgPiBGb2xsb3dpbmcgYXJlIHRoZSBicmllZiBjaGFuZ2VzIGRvbmUg
aW5vcmRlciB0byBzdXBwb3J0IGJvdGggSVBST0MgSTJDCj4gICAgID4gc2xhdmUgbW9kZSBhbmQg
TklDIEkyQywKPiAgICAgPgo+ICAgICA+IGEuIEFkZCBzdXBwb3J0IHRvIGFsbG93IEkyQyByeCB0
cmFuc2ZlciB1cHRvIDI1NSBieXRlcwo+ICAgICA+IGIuIEFkZCBwb2xsaW5nIG1vZGUgc3VwcG9y
dCB0byB0aGUgaVByb2MgSTJDIGRyaXZlci4gUG9sbGluZyBtb2RlCj4gICAgIGlzIHVzZWQKPiAg
ICAgPsKgIMKgIGluIGNlcnRhaW4gU29DcyB3aGVyZSBpbnRlcnJ1cHQgaXMgbm90IGNvbm5lY3Rl
ZCBmcm9tIHRoZSBJMkMKPiAgICAgYmxvY2suCj4gICAgID4gYy4gQWRkIHdhcnBwZXIgcmVhZC93
cml0ZSBhY2Nlc3MgZm9yIHJlZ2lzdGVyIHRvIHN1cHBvcnQgaW5kaXJlY3QKPiAgICAgcmVnaXN0
ZXIKPiAgICAgPsKgIMKgIGFjY2Vzcy4gVGhpcyBpcyByZXF1aXJlZCBpbiBjZXJ0YWluIFNvQ3Mg
d2l0aCB0aGlzIGlQcm9jIEkyQwo+ICAgICA+wqAgwqAgYmxvY2sgcmVnaXN0ZXJlZC4KPiAgICAg
Pgo+ICAgICA+Cj4gICAgID4gUmF5IEp1aSAoMSk6Cj4gICAgID7CoCDCoGR0LWJpbmRpbmdzOiBp
MmM6IGlwcm9jOiBtYWtlICdpbnRlcnJ1cHRzJyBvcHRpb25hbAo+ICAgICA+Cj4gICAgID4gUmF5
YWdvbmRhIEtva2F0YW51ciAoNSk6Cj4gICAgID7CoCDCoGkyYzogaXByb2M6IGFkZCBwb2xsaW5n
IHN1cHBvcnQKPiAgICAgPsKgIMKgaTJjOiBpcHJvYzogdXNlIHdyYXBwZXIgZm9yIHJlYWQvd3Jp
dGUgYWNjZXNzCj4gICAgID7CoCDCoGR0LWJpbmRpbmdzOiBpMmM6IGlwcm9jOiBhZGQgImJyY20s
aXByb2MtbmljLWkyYyIgY29tcGF0aWJsZSBzdHJpbmcKPiAgICAgPsKgIMKgaTJjOiBpcHJvYzog
YWRkIE5JQyBJMkMgc3VwcG9ydAo+ICAgICA+wqAgwqBhcm02NDogZHRzOiBTdGluZ3JheTogQWRk
IE5JQyBpMmMgZGV2aWNlIG5vZGUKPiAgICAgPgo+ICAgICA+IFNocmVlc2hhIFJhamFzaGVrYXIg
KDIpOgo+ICAgICA+wqAgwqBpMmM6IGlwcm9jOiBJMkMgcmVhZCB1cCB0byAyNTUgYnl0ZXMgc3Vw
cG9ydAo+ICAgICA+wqAgwqBpMmM6IGlwcm9jOiBBZGQgU2xhdmUgbW9kZSBzdXBwb3J0Cj4gICAg
ID4KPiAgICAgPsKgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9icmNtLGlwcm9jLWkyYy50
eHTCoCDCoCDCoHzCoCAxNCArLQo+ICAgICA+wqAgLi4uL2FybTY0L2Jvb3QvZHRzL2Jyb2FkY29t
L3N0aW5ncmF5L3N0aW5ncmF5LmR0c2kgfMKgIDE4ICsKPiAgICAgPsKgIGRyaXZlcnMvaTJjL2J1
c3Nlcy9LY29uZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAx
ICsKPiAgICAgPsKgIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHwgNzY3Cj4gICAgICsrKysrKysrKysrKysrKysrLS0tLQo+ICAgICA+
wqAgNCBmaWxlcyBjaGFuZ2VkLCA2NjkgaW5zZXJ0aW9ucygrKSwgMTMxIGRlbGV0aW9ucygtKQo+
ICAgICA+Cj4gCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
