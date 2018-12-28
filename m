Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:15:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244FE20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1jpOL31";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYEdK5zJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244FE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yrNXjanqBq2OJM59TUTMt7ehOtQsMPov9QLjjRrVgbc=; b=F1jpOL31lyNQ/nuMfoj+PdlM5a
	px45bAYOU3U1Er7aV4OTjrcBK2akOZPREmaf5+MZkMDtTgAj9hIY9nDU90wVCUvCYszokrgZTyo+T
	E6FkqrqlL+SMjdpSk+u1+QTHstnBuQex+pqFgmlLXqnC8wGQYxaWGbTgdWzmNTW4fQCpgAtL3L2+p
	+H+iZmVthH66XB7YKUWxUchm1BFjsvvxAdOMY1LaxlSbu0Mrfve31YQZ7k9UC81DUmsHIBIF7apMp
	R7dgarQDv62ke4sqMD+XmfZXTAkfU9mSiagZxD6kSNhmODjDag/eJHavwAvUIJrMdX+z84tXPVyP4
	iNJBBsjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcq6x-0001CE-OG; Fri, 28 Dec 2018 11:15:27 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcq6f-0008JE-QB
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 11:15:12 +0000
Received: by mail-ed1-x543.google.com with SMTP id o10so17258171edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=/+ZefrT6mPMsbOv0JVrKOYuJlv4IAFghLMge1EfhaH0=;
 b=sYEdK5zJGzFOd2AZBXszK76zWrG/W1737r1iwI1AOQYxQ4AwSWaas1vxoKEPZKHjrI
 fJn6qUV9TXfrgAexmci8SlwouTPICq/54FnwQigrWJTAPmRh1wNEPKMy7ybnilWVJX9f
 1jmN9mN4UJH2wAuk/ObbqLLFh+Zzs3MCCUzID+i9DeWv106/II8O250i2iLMAJSK3mjs
 DJn1LlLVaVZncvmkauv2C0yhkPHd7PPSsTrU1XUWSwCSRBoVddQGFd0ueCJAu2pty24p
 bZ+vad+9qUbLiSCaAqpzo3HWcoEqljcNUdhWuCD8vTWUZRU2t1Aw0jWicXmeyuGR4Ce8
 ZEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=/+ZefrT6mPMsbOv0JVrKOYuJlv4IAFghLMge1EfhaH0=;
 b=Hoq5ba/I19XXJyJH3npdNqIdHL4X2BFYzoP0vlXQggaofPjHKo5JYWPMXxLQTDhtvg
 8T8kl0NswtW1zL7hg9fEhIBblxZNznffLAfkMAwBClLZY6s7/br/pUNEJ0Bok3nIuFDk
 8PHD/kE45bZP8b4EHKZG+BtEgQm8JN1U7WSaAgInxlm3KMvt1949nFmWoDAZ3ScvemZv
 yxirCXanWnBjjrJaCYYpy5MA4Z0pDBFd0Z55iArpHIxUcS8PfCh0e9bi0DseY28itOrv
 TvgPFxD0xWrG77AYmq2u+389VDKNOF2P163sjKB3J5adImzqUuvSb4fCq+m2dI3mFYey
 7+eQ==
X-Gm-Message-State: AA+aEWZCgwJqPxN9a+a9P8TnuuVa/OezEKAI31B4IZT+koOxmlqvFW/p
 YXzl1RbKjsCMm0DVCHg9/us=
X-Google-Smtp-Source: AFSGD/VnbFz7WoY7Mej3s8g0NAuXy/2+wT4QwPPMR2Eeq/ziiL8pA/QweM2jRfZRStWLpP6Wj0AduA==
X-Received: by 2002:aa7:c55a:: with SMTP id s26mr21555886edr.132.1545995697545; 
 Fri, 28 Dec 2018 03:14:57 -0800 (PST)
Received: from ?IPv6:2a02:168:6806:0:8dcd:a40e:9df5:dbc0?
 ([2a02:168:6806:0:8dcd:a40e:9df5:dbc0])
 by smtp.gmail.com with ESMTPSA id d7-v6sm6761816ejx.68.2018.12.28.03.14.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 03:14:56 -0800 (PST)
To: linux-arm-kernel@lists.infradead.org
From: Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: [RFC] phylink: support for devices with MAC sharing SFP cage & PHY
 (e.g. Turris Omnia)?
Message-ID: <252d7259-057d-d312-f440-612360703708@gmail.com>
Date: Fri, 28 Dec 2018 12:14:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_031510_115935_D971D66F 
X-CRM114-Status: GOOD (  19.27  )
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
Cc: Tomas Hlavacek <tmshlvck@gmail.com>, uwe@kleine-koenig.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpJIG93biBhIFR1cnJpcyBPbW5pYSwgd2hpY2ggaGFzIGJhc2ljIHN1cHBvcnQgaW5j
bHVkZWQgaW4gdGhlCkxpbnV4IGtlcm5lbCAoYXJtYWRhLTM4NS10dXJyaXMtb21uaWEuZHRzKS4K
CkFwYXJ0IGZyb20gdGhlIDg4RTE1MTQgUEhZIHNwZWNpZmllZCBmb3IgZXRoMiwgdGhlIGRldmlj
ZSBhbHNvCmZlYXR1cmVzIGFuIFNGUCBjYWdlLCB3aGljaCB1c2VzIHRoZSBzYW1lIFNHTUlJIG9m
IHRoZSBBcm1hZGEKMzg1IFNvQywgdXNpbmcgYSAyOjEgbXVsdGlwbGV4ZXIgZHJpdmVuIGJ5IHRo
ZSBNT0RfREVGMCBzaWduYWwuCkRldGFpbHMgY2FuIGJlIGZvdW5kIG9uIHBhZ2UgNSBvZgpodHRw
czovL2RvYy50dXJyaXMuY3ovZG9jL19tZWRpYS9ydHJvbTAxLXNjaGVtYS5wZGYuCgpBcyBmYXIg
YXMgSSB1bmRlcnN0YW5kIHRoZSBzaXR1YXRpb24sIHBoeWxpbmsgZG9lcyBub3Qgc3VwcG9ydApz
dWNoIGFuIGFyY2hpdGVjdHVyZSBhdCB0aGUgbW9tZW50LCB3aGljaCBpcyB0aGUgcmVhc29uIHdo
eSB0aGUKU0ZQIGNhZ2Ugd2FzIG5ldmVyIHNwZWNpZmllZCBpbiB0aGUgVHVycmlzIE9tbmlhJ3Mg
RFRTLgoKUXVlc3Rpb25zOgotIElzIGFueWJvZHkgYWxyZWFkeSB3b3JraW5nIG9uIGEgc29sdXRp
b24/Ci0gSWYgbm90LCB3b3VsZCBzb21ldGhpbmcgbGlrZSB0aGUgcGF0Y2ggYmVsb3cgYmUgYWNj
ZXB0YWJsZT8KLSBBbnkgb3RoZXIgc3VnZ2VzdGlvbnMsIGhvdyB0byBnZXQgdGhpcyBzdXBwb3J0
ZWQ/CgpTdW1tYXJ5IG9mIHRoZSBwYXRjaCBiZWxvdywgd2hpcyBpcyBiYXNlZCBvbiBkZXZpY2Ug
dHJlZQpwdWJsaXNoZWQgYnkgVG9tYXMgKGFuZCBteSBpbnRlcnByZXRhdGlvbiBvZiBwaHlsaW5r
LmMpOgoKSSdtIHNwZWNpZnlpbmcgKmJvdGgqIHRoZSBTRlAgY2FnZSBhbmQgdGhlIFBIWSBpbiB0
aGUgbm9kZSBvZgp0aGUgZXRoMiBNQUMuIEluIHBoeWxpbmtfb2ZfY29ubmVjdCwgaWYgU0ZQIG1v
ZHVsZSBpcyBhbHJlYWR5CnByZXNlbnQ6IElnbm9yZSBhbnkgUEhZIHNwZWNpZmllZCBieSB0aGUg
ZGV2aWNldHJlZS4gQWZ0ZXIKU0ZQIHJlbW92YWwsIHJlc3RvcmUgdGhlIG9yaWdpbmFsIChkZXZp
Y2UgdHJlZSBiYXNlZCkKY29uZmlndXJhdGlvbiwgd2hpY2ggd2FzIGRldGVybWluZWQgYnkgcGh5
bGlua19jcmVhdGUgZXQgYWwuCihJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyB3b3VsZCBoYXJtIHRo
ZSBnZW5lcmljIHVzZSBjYXNlKQoKV2l0aCB0aGlzLCAiaG90IiBpbnNlcnRpb24gYW5kIHJlbW92
YWwgd29yaywgYXMgbG9uZyBhcyB0aGUKbmV0d29yayBpbnRlcmZhY2UgaXMgZG93bi4gSSB0ZXN0
ZWQgdGhpcyBzdWNjZXNzZnVsbHkgb24gbXkKVHVycmlzIE9tbmlhLCBvbiBhIHJlbGF0aXZlbHkg
cmVjZW50IG9wZW53cnQtbWFzdGVyCig0LjE0IGtlcm5lbCkuIFNGUCBtb2R1bGUgaXMgYSBUUC1M
SU5LIFRMLVNNMzIxQi4KCiJIb3QiIGluc2VydGlvbi9yZW1vdmFsIGluIHRoZSAidXAiIHN0YXRl
IHdvdWxkIHJlcXVpcmUgbW9yZQp3b3JrLgoKSSBhbSBzb3JyeSwgdGhlIHBhdGNoIGJlbG93IGlz
IGFnYWluc3QgdGhlIDQuMTQgKG9wZW53cnQpCmtlcm5lbCwgYnV0IHlvdSBnZXQgdGhlIGJhc2lj
IGlkZWEuCgotLS0gYS9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzg1LXR1cnJpcy1vbW5pYS5k
dHMKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4NS10dXJyaXMtb21uaWEuZHRzCkBA
IC0xMTUsNiArMTE1LDE2IEBACiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIH07CiDCoMKgwqDCoCDC
oMKgwqAgfTsKIMKgwqDCoMKgIH07CisKK8KgwqDCoCBzZnA6IHNmcCB7CivCoMKgwqAgwqDCoMKg
IGNvbXBhdGlibGUgPSAic2ZmLHNmcCI7CivCoMKgwqAgwqDCoMKgIGkyYy1idXMgPSA8JmkyY3Nm
cD47CivCoMKgwqAgwqDCoMKgIHR4LWZhdWx0LWdwaW9zID0gPCZwY2F3YW4gMCBHUElPX0FDVElW
RV9ISUdIPjsKK8KgwqDCoCDCoMKgwqAgdHgtZGlzYWJsZS1ncGlvcyA9IDwmcGNhd2FuIDEgR1BJ
T19BQ1RJVkVfSElHSD47CivCoMKgwqAgwqDCoMKgIHJhdGUtc2VsZWN0MC1ncGlvcyA9IDwmcGNh
d2FuIDIgR1BJT19BQ1RJVkVfSElHSD47CivCoMKgwqAgwqDCoMKgIGxvcy1ncGlvcyA9IDwmcGNh
d2FuIDMgR1BJT19BQ1RJVkVfSElHSD47CivCoMKgwqAgwqDCoMKgIG1vZC1kZWYwLWdwaW9zID0g
PCZwY2F3YW4gNCBHUElPX0FDVElWRV9MT1c+OworwqDCoMKgIH07CiDCoH07CgogwqAvKiBDb25u
ZWN0ZWQgdG8gODhFNjE3NiBzd2l0Y2gsIHBvcnQgNiAqLwpAQCAtMTQ4LDYgKzE1OCw3IEBACiDC
oMKgwqDCoCBzdGF0dXMgPSAib2theSI7CiDCoMKgwqDCoCBwaHktbW9kZSA9ICJzZ21paSI7CiDC
oMKgwqDCoCBwaHkgPSA8JnBoeTE+OworwqDCoMKgIHNmcCA9IDwmc2ZwPjsKIMKgfTsKCiDCoCZp
MmMwIHsKQEAgLTIxMCw3ICsyMjEsNyBAQAogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCAvKiByb3V0
ZWQgdG8gUENJZTIgY29ubmVjdG9yIChDTjYyQSkgKi8KIMKgwqDCoMKgIMKgwqDCoCB9OwoKLcKg
wqDCoCDCoMKgwqAgaTJjQDQgeworwqDCoMKgIMKgwqDCoCBpMmNzZnA6IGkyY0A0IHsKIMKgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47CiDCoMKgwqDCoCDCoMKgwqAg
wqDCoMKgICNzaXplLWNlbGxzID0gPDA+OwogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCByZWcgPSA8
ND47Ci0tLSBhL2RyaXZlcnMvbmV0L3BoeS9waHlsaW5rLmMKKysrIGIvZHJpdmVycy9uZXQvcGh5
L3BoeWxpbmsuYwpAQCAtNTgsNiArNTgsMTIgQEAgc3RydWN0IHBoeWxpbmsgewogwqDCoMKgwqAg
Ym9vbCBtYWNfbGlua19kcm9wcGVkOwoKIMKgwqDCoMKgIHN0cnVjdCBzZnBfYnVzICpzZnBfYnVz
OworCivCoMKgwqAgLyogVGhpbmdzIHRvIHJlbWVtYmVyIGFjcm9zcyBhIG1vZHVsZSBpbnNlcnRp
b24vcmVtb3ZhbCBjeWNsZSAqLworwqDCoMKgIHU4IGRlZmF1bHRfYW5fbW9kZTsKK8KgwqDCoCB1
OCBkZWZhdWx0X3BvcnQ7CivCoMKgwqAgc3RydWN0IHBoeWxpbmtfbGlua19zdGF0ZSBkZWZhdWx0
X2NvbmZpZzsKK8KgwqDCoCBib29sIHNmcF9tb2R1bGVfcHJlc2VudDsKIMKgfTsKCiDCoHN0YXRp
YyBpbmxpbmUgdm9pZCBsaW5rbW9kZV96ZXJvKHVuc2lnbmVkIGxvbmcgKmRzdCkKQEAgLTY4MCw2
ICs2ODYsMTAgQEAgaW50IHBoeWxpbmtfb2ZfcGh5X2Nvbm5lY3Qoc3RydWN0IHBoeWxpbgogwqDC
oMKgwqAgaWYgKHBsLT5saW5rX2FuX21vZGUgPT0gTUxPX0FOX0ZJWEVEKQogwqDCoMKgwqAgwqDC
oMKgIHJldHVybiAwOwoKK8KgwqDCoCAvKiBJZiBTRlAgbW9kdWxlIHByZXNlbnQsIHdlIGRvIG5v
dCBuZWVkIGEgc2VwYXJhdGUgUEhZICovCivCoMKgwqAgaWYgKHBsLT5zZnBfbW9kdWxlX3ByZXNl
bnQpCivCoMKgwqAgwqDCoMKgIHJldHVybiAwOworCiDCoMKgwqDCoCBwaHlfbm9kZSA9IG9mX3Bh
cnNlX3BoYW5kbGUoZG4sICJwaHktaGFuZGxlIiwgMCk7CiDCoMKgwqDCoCBpZiAoIXBoeV9ub2Rl
KQogwqDCoMKgwqAgwqDCoMKgIHBoeV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkbiwgInBoeSIs
IDApOwpAQCAtMTM3MSw2ICsxMzgxLDExIEBAIHN0YXRpYyBpbnQgcGh5bGlua19zZnBfbW9kdWxl
X2luc2VydCh2b2kKIMKgwqDCoMKgIGlmIChtb2RlID09IE1MT19BTl84MDIzWiAmJiBwbC0+cGh5
ZGV2KQogwqDCoMKgwqAgwqDCoMKgIHJldHVybiAtRUlOVkFMOwoKK8KgwqDCoCBwbC0+ZGVmYXVs
dF9hbl9tb2RlID0gcGwtPmxpbmtfYW5fbW9kZTsKK8KgwqDCoCBwbC0+ZGVmYXVsdF9wb3J0ID0g
cGwtPmxpbmtfcG9ydDsKK8KgwqDCoCBwbC0+ZGVmYXVsdF9jb25maWcgPSBwbC0+bGlua19jb25m
aWc7CivCoMKgwqAgcGwtPnNmcF9tb2R1bGVfcHJlc2VudCA9IHRydWU7CisKIMKgwqDCoMKgIGNo
YW5nZWQgPSAhYml0bWFwX2VxdWFsKHBsLT5zdXBwb3J0ZWQsIHN1cHBvcnQsCiDCoMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCBfX0VUSFRPT0xfTElOS19NT0RFX01BU0tfTkJJVFMpOwogwqDC
oMKgwqAgaWYgKGNoYW5nZWQpIHsKQEAgLTEzOTksNiArMTQxNCwxNiBAQCBzdGF0aWMgaW50IHBo
eWxpbmtfc2ZwX21vZHVsZV9pbnNlcnQodm9pCiDCoMKgwqDCoCByZXR1cm4gcmV0OwogwqB9Cgor
c3RhdGljIHZvaWQgcGh5bGlua19zZnBfbW9kdWxlX3JlbW92ZSh2b2lkICp1cHN0cmVhbSkKK3sK
K8KgwqDCoCBzdHJ1Y3QgcGh5bGluayAqcGwgPSB1cHN0cmVhbTsKKworwqDCoMKgIHBsLT5saW5r
X2FuX21vZGUgPSBwbC0+ZGVmYXVsdF9hbl9tb2RlOworwqDCoMKgIHBsLT5saW5rX3BvcnQgPSBw
bC0+ZGVmYXVsdF9wb3J0OworwqDCoMKgIHBsLT5saW5rX2NvbmZpZyA9IHBsLT5kZWZhdWx0X2Nv
bmZpZzsKK8KgwqDCoCBwbC0+c2ZwX21vZHVsZV9wcmVzZW50ID0gZmFsc2U7Cit9CisKIMKgc3Rh
dGljIHZvaWQgcGh5bGlua19zZnBfbGlua19kb3duKHZvaWQgKnVwc3RyZWFtKQogwqB7CiDCoMKg
wqDCoCBzdHJ1Y3QgcGh5bGluayAqcGwgPSB1cHN0cmVhbTsKQEAgLTE0MzIsNiArMTQ1Nyw3IEBA
IHN0YXRpYyB2b2lkIHBoeWxpbmtfc2ZwX2Rpc2Nvbm5lY3RfcGh5KHYKCiDCoHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgc2ZwX3Vwc3RyZWFtX29wcyBzZnBfcGh5bGlua19vcHMgPSB7CiDCoMKgwqDCoCAu
bW9kdWxlX2luc2VydCA9IHBoeWxpbmtfc2ZwX21vZHVsZV9pbnNlcnQsCivCoMKgwqAgLm1vZHVs
ZV9yZW1vdmUgPSBwaHlsaW5rX3NmcF9tb2R1bGVfcmVtb3ZlLAogwqDCoMKgwqAgLmxpbmtfdXAg
PSBwaHlsaW5rX3NmcF9saW5rX3VwLAogwqDCoMKgwqAgLmxpbmtfZG93biA9IHBoeWxpbmtfc2Zw
X2xpbmtfZG93biwKIMKgwqDCoMKgIC5jb25uZWN0X3BoeSA9IHBoeWxpbmtfc2ZwX2Nvbm5lY3Rf
cGh5LAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
