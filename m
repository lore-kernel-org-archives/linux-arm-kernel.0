Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:58:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049A720868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i7HT5yNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049A720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LakI3Sm4W50BzfQE/LyqiHFkVn3/lbar/21EKyen698=; b=i7HT5yNNEo+siK
	J5jQMnECFeaxctIXZbGc8HrsbZCwe56RVJQxGyMkpFH2oBMAvT6VtXePdr+lqJSMoKsTxe98ZMVPM
	1yFWO2k3aqs9EwBNREeAUCAswqevaHmPHaLkk60CRe3jE1FpVMRj0DNzCMHmkUum6UXol27+kEHFH
	Z9AtrVdA3fajnUloO5MKrwJwpKDpZOdWvAhfRRPRuSEmchQp78S/eLrrBHjrMjpgeXmGSWHIU8YPZ
	PaPzY5DrGiOpmDb1FdzLsvc2uo9xeCNptP4mz42tTaMG4GtoRqXdKrs/3d/u1EjdbrIgL6nEhRzb4
	wdRExUvJ2KmSFSl1UbkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gg9sz-0002Ce-UQ; Sun, 06 Jan 2019 14:58:45 +0000
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gg9sv-0002CI-OX
 for linux-arm-kernel@lists.infradead.org; Sun, 06 Jan 2019 14:58:44 +0000
Received: from [192.168.123.38] ([84.118.159.3]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lo3IS-1hDHlL2Jp2-00fxiV; Sun, 06
 Jan 2019 15:58:03 +0100
Subject: Re: [RFC net-next 11/15] net: lora: Add IMST WiMOD
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, netdev@vger.kernel.org
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-12-afaerber@suse.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <53180657-d3f7-21ea-cbb5-cf591ee4755e@gmx.de>
Date: Sun, 6 Jan 2019 15:57:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20180701110804.32415-12-afaerber@suse.de>
Content-Language: en-US
X-Provags-ID: V03:K1:TBPLn1Mj0jJMH8Zv8YLZ9EvN/EecJLQ/+NuoLN5G2ZdAQgu1uia
 dcSoZdOXLPehQ9Ff9GL3RcV8l+Ffqf2dKWUORY6a8nCocNJQ3i1jvnex1Nrgy6QoPDqYGWw
 yot2Pjl7UkP27Nut4nnxv9nBgmg3+jpmP0ZwYSRXsos/tmCDgUrf5cbGeSGJlLOsb5+6Xwz
 Nbf4Uleyrobrk0PvhGASw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J2hbhKnO8RI=:3o9Ncem7hDOa4tKOa1myJ6
 vdty9C0q1eLs2I4oIzrFZZ6bBV2fYsoZPdZF390gyxbhrtv/PQ3oErqn5rNNcPJT9webwg/7z
 DbJfF7xmcwadcvJOutoaA9B4AEP1eMVYatuMA3r4F6bmQ37rKE1uDuc50xNjdoxwGfwNFJRgU
 TZIsSg4/Lk36Td+2+T4aRym5MZ00glVc4HJ945oZx+8vX3JO0zz3cXr3/TCXC082Wu2XtsX3I
 ysaXFHswCG9zlHp7+OwAq/2/mIgp8mTTaf2MP1xB7y28nejBUzbrmROt9fYorsuKCEZEiwlkJ
 Z7Zu4TCj72MGC22KLguHORuOl4S1kXfqRWlkRyJ/exNnH3SYQdXe5bMTDX90VH2vMzKuhFu9e
 W94TSYc/xZkmYNkeXHWe0XvcDV2+5XJdCyWv3SFnhroAWU9hZPW1HmxqCXiOfMi9NuN3R7DQo
 nyUcs1USuYlRSW4hn/Olo1A00mbPz23FDCp7Oky2+FVv6q4gev8JxWOD242FdjvQZBeL7JfJ4
 hC93VkCJcJ7fG5anOWMDsqEX92ppXGVOWRGD+19gsNVO7sWlTBxuIKBeJ9MKXkZNb7pJYFalL
 7Tf/Kwsqx+yNIYJfetRLR3fu2BE0ZQLJBNmOmBfHlLYgvR9ADU3yPSgKbnO8ebsnUexOAp2Mm
 TXsVZVFDV3E2fTrvOYTQmxFT99KoNyrVOjkr/oaUtPnzIDT28I2iX9ChzgZI3EuVZDqRy+mFx
 KlmRb1gIhXohHLIjTdQXIdkUqt0TtgSGXR/Ku+eHPxFhBpF9q6plxRbs2IJqd4Ysw7hN2JkxH
 nEBI4a9PpL/RpmSMK0BAUr9u8z98Nlw1oi+dTd0fUT0Q59lrMz4o8ZkfWx19H1j/Z2XqY02dK
 kt9VjXzvBz4V1ijFTy+DgwL/vkJEpfcUGWCS7WF4Q8XCtamlW8P7mSQUWeNgJX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_065842_106851_8FA2F634 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: Matthias Brugger <mbrugger@suse.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Janus Piwek <jpiwek@arroweurope.com>,
 Jon Ortego <Jon.Ortego@imst.de>, Dollar Chen <dollar.chen@wtmec.com>,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Ken Yu <ken.yu@rakwireless.com>,
 =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gNy8xLzE4IDE6MDggUE0sIEFuZHJlYXMgRsOkcmJlciB3cm90ZToKPiBUaGUgSU1TVCBXaU1P
RCB1c2VzIGEgU0xJUCBiYXNlZCBiaW5hcnkgVUFSVCBwcm90b2NvbC4gVHdvIHNlcGFyYXRlCj4g
ZmlybXdhcmVzIGFyZSBhdmFpbGFibGUuIEJ5IGRlZmF1bHQgaXQgc2hpcHMgd2l0aCBhIExvUmFX
QU4gZmlybXdhcmUuCj4gVGhlIGFsdGVybmF0aXZlIGZpcm13YXJlIGlzIGEgY3VzdG9tIFAyUCBh
ZGRyZXNzaW5nIG1vZGUgYmFzZWQgb24gTG9SYS4KPiAKPiBDYzogSm9uIE9ydGVnbyA8Sm9uLk9y
dGVnb0BpbXN0LmRlPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJA
c3VzZS5kZT4KPiAtLS0KPiAgZHJpdmVycy9uZXQvbG9yYS9LY29uZmlnICB8ICAgOCArCj4gIGRy
aXZlcnMvbmV0L2xvcmEvTWFrZWZpbGUgfCAgIDMgKwo+ICBkcml2ZXJzL25ldC9sb3JhL3dpbW9k
LmMgIHwgNTk3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiAgMyBmaWxlcyBjaGFuZ2VkLCA2MDggaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9uZXQvbG9yYS93aW1vZC5jCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2xvcmEvS2NvbmZpZyBiL2RyaXZlcnMvbmV0L2xvcmEvS2NvbmZpZwo+IGluZGV4IDk0MGJkMmNi
ZTEwNi4uMmUwNWNhZWY4NjQ1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L2xvcmEvS2NvbmZp
Zwo+ICsrKyBiL2RyaXZlcnMvbmV0L2xvcmEvS2NvbmZpZwo+IEBAIC0zMSw2ICszMSwxNCBAQCBj
b25maWcgTE9SQV9TWDEyNzYKPiAgCWhlbHAKPiAgCSAgU2VtdGVjaCBTWDEyNzIvMTI3Ni8xMjc4
Cj4gIAo+ICtjb25maWcgTE9SQV9XSU1PRAo+ICsJdHJpc3RhdGUgIklNU1QgV2lNT0QgZHJpdmVy
IgoKc2NyaXB0cy9jaGVja3BhdGNoLnBsIHRocm93cyB0aGlzIHdhcm5pbmc6CldBUk5JTkc6IHBs
ZWFzZSB3cml0ZSBhIHBhcmFncmFwaCB0aGF0IGRlc2NyaWJlcyB0aGUgY29uZmlnIHN5bWJvbCBm
dWxseQoKSU1TVCBoYXMgbXVsdGlwbGUgcHJvZHVjdHMgcmVsYXRlZCB0byAiV2lNT0QiOgoqIFdp
TU9EIGlDODgwQQoqIFdpTU9EIG1vZHVsZSBpTTg3MUEKKiBXU0EwMS1pTTg4MEIgLSBXaU1PRCBT
aGllbGQgZm9yIEFyZHVpbm8KKiBpTTg4MEItTCAtIExvbmcgUmFuZ2UgUmFkaW8gTW9kdWxlCgpB
bmQgSU1TVCBpcyBub3QgdmVyeSBjb25zaXN0ZW50IGFib3V0IHdoYXQgaXMgY2FsbGVkICJXaU1P
RCIuIFNvIHRoaXMKbGVhdmVzIG1lIGNsdWVsZXNzIGNvbmNlcm5pbmcgd2hhdCB0aGlzIEtjb25m
aWcgb3B0aW9uIGlzIGFib3V0LiBQbGVhc2UsCnByb3ZpZGUgYSBkZXNjcmlwdGlvbi4KClRoZXJl
IGFyZSBkb3plbnMgb2Ygd2FybmluZ3MgZ2l2ZW4gYnkgc2NyaXB0cy9jaGVja3BhdGNoLiBQbGVh
c2UsIGhhdmUgYQpsb29rIGF0IHRoZW0uCgpCZXN0IHJlZ2FyZHMKCkhlaW5yaWNoCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
