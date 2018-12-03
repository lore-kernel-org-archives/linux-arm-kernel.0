Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8E2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2D720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i22xFLBG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X+kj6KL1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aoumYSBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2D720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M+08Q7IRy18JHPyfgaMIN9hRz5+8hDf0qw80RSZL5r8=; b=i22xFLBG00AqqMzW+wfWIxA8D
	qkrOwks9BvRNuvTsYSDXZ90a7lXJP30MToEnWE1T2YH5OO/r4AIzyTUhT9esyTPkpiAw+M5S+oAhF
	l1GlIU+q4hrMNDLsC80QJl3XvWYzBz0zO65vGfhMtn5bnPCRZ+FXhN/VDJ7vjrDZ5J0guky9RHFzG
	UKEK2DH3yRxji1UTcPjzbgcPDqV4s07VJaOXIKSkouJt9Tpxh5WoGEKu6TybPkoTEpRuSm1gv2iba
	acPNO19ZAguQCmoe0svNqxXMYTF0s/oRwfz6e47jRSTilYXiHW9KLCDhIO6uqmgU5AL5RjISOHCRQ
	YW1M3klQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqvO-0008SI-15; Mon, 03 Dec 2018 16:18:22 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqvK-0008Rj-F2
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:18:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 084E260792; Mon,  3 Dec 2018 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543853888;
 bh=6UFT2TG8zHLoGKePSCqyLZM7D8OM6TltHRynFRM06fg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=X+kj6KL1soPxD306+07S8Cj/k77gm0JNxqX1+SJ4Jj5f7GRoVbaqtckPtpRIR9fyl
 EJlb7oqcvbpHxtgarUMtcyu0CfQeyybsunvro9AAB7eMGQvUv4Vn8YCURhayiVvG7v
 /JACjlPPum2ZO8mwYyW+dvjLXihssyWQep+kr8y4=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jhugo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id CCD1460540;
 Mon,  3 Dec 2018 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543853887;
 bh=6UFT2TG8zHLoGKePSCqyLZM7D8OM6TltHRynFRM06fg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=aoumYSBSovPKXAPLf0bYphvkrAn60KpKgeqvTAMYSGv0JnLA+SF+9e3pNJV0qJMtN
 fzeozjAYHjUSZhVs23h2VroxC9X2Engj0YU4gwBbLO0Qe/ZLuYxn3oS9W8VsoQgOZB
 9v30q1uLgTiuPgMVeGf+MQOsgGXaIfGsLsaEyCm4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCD1460540
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: WIP: UFS on apq8098
To: Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Andy Gross
 <andy.gross@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <de223e7a-3b60-0566-997f-b607bbc15007@codeaurora.org>
 <7d588806-5699-2d87-e95e-f1388de01a74@codeaurora.org>
 <8b697e3b-6cb5-41ea-cd56-94c54082c58b@free.fr>
 <e1b8ed92-c310-97ed-c1bd-5b90af76b3a0@codeaurora.org>
 <0dd4dfa9-5c54-702a-c830-a9f4eba2bcc9@free.fr>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <7ca7d95d-87a3-1704-c14d-6d6c78bd4f73@codeaurora.org>
Date: Mon, 3 Dec 2018 09:18:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <0dd4dfa9-5c54-702a-c830-a9f4eba2bcc9@free.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_081818_539101_1B59EA5E 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMy8yMDE4IDk6MTMgQU0sIE1hcmMgR29uemFsZXogd3JvdGU6Cj4gT24gMDMvMTIvMjAx
OCAxNzowMywgSmVmZnJleSBIdWdvIHdyb3RlOgo+IAo+PiBPbiAxMi8zLzIwMTggODo1MyBBTSwg
TWFyYyBHb256YWxleiB3cm90ZToKPj4KPj4+IE9uIDAzLzEyLzIwMTggMTY6NDcsIEplZmZyZXkg
SHVnbyB3cm90ZToKPj4+Cj4+Pj4gT24gMTIvMy8yMDE4IDg6MjcgQU0sIEplZmZyZXkgSHVnbyB3
cm90ZToKPj4+Pgo+Pj4+PiBPbiAxMi8zLzIwMTggODoxOCBBTSwgTWFyYyBHb256YWxleiB3cm90
ZToKPj4+Pj4KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB1ZnNwaHk6IHBoeUAxZGE3MDAwIHsKPj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAicWNvbSxzZG04NDUtcW1w
LXVmcy1waHkiOwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDB4MWRhNzAw
MCAweDE4Yz47Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9
IDwxPjsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDE+Owo+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmFuZ2VzOwo+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY2xvY2stbmFtZXMgPQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAicmVmX2Nsa19zcmMiLAo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAicmVmX2NsayIsCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJy
ZWZfYXV4X2NsayI7Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPQo+Pj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JnJwbWNjIDA+LAo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmdjYyBHQ0NfVUZTX0NMS1JFRl9DTEs+LAo+
Pj4+Cj4+Pj4gQWxzbywgIkdDQ19VRlNfQ0xLUkVGX0NMSyIgaXMgbm90IGRlZmluZWQgaW4KPj4+
PiBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3Fjb20sZ2NjLW1zbTg5OTguaCB3aGljaCBpcyBw
cm9iYWJseSB0aGUgY2F1c2UKPj4+PiBvZiB5b3VyIC0yIGVycm9yIGxpc3RlZCBhYm92ZS4KPj4+
Cj4+PiBJZiBpdCB3ZXJlIHVuZGVmaW5lZCwgZHRjIHdvdWxkIGhhdmUga2lja2VkIG1lIGluIHRo
ZSBuYWRzIDotKQo+Pj4KPj4+ICQgZ2l0IGdyZXAgR0NDX1VGU19DTEtSRUZfQ0xLIGluY2x1ZGUK
Pj4+IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svcWNvbSxnY2MtbXNtODk5Ni5oOiNkZWZpbmUg
R0NDX1VGU19DTEtSRUZfQ0xLICAgICAgICAyMTUKPj4+IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xv
Y2svcWNvbSxnY2MtbXNtODk5OC5oOiNkZWZpbmUgR0NDX1VGU19DTEtSRUZfQ0xLICAgICAgICAx
NjgKPj4KPj4gTm90IHByZXNlbnQgaW4gdjQuMjAtcmM1IG5vciBsaW51eC1uZXh0LiAgRGlkIHlv
dSBhZGQgdGhpcyB5b3Vyc2VsZj8gIElmCj4+IHNvLCBkaWQgeW91IGFsc28gdXBkYXRlIHRoZSBk
cml2ZXI/Cj4gCj4gWW91J3JlIHJpZ2h0LiBJIGFwcGxpZWQgQmpvcm4ncyBwYXRjaCBzZXJpZXMu
Cj4gW1BBVENIIDAvM10gY2xrOiBxY29tOiBnY2MtbXNtODk5ODogRml4ZXMgYW5kIGNsa3JlZiBj
bG9ja3MKPiAKCk9rLiAgVGhlbiBpdHMgbm9uLW9idmlvdXMgdG8gbWUgd2h5IHlvdSBhcmUgZ2V0
dGluZyB0aGUgcmVmIGNsb2NrIGVycm9yLgoKLS0gCkplZmZyZXkgSHVnbwpRdWFsY29tbSBEYXRh
Y2VudGVyIFRlY2hub2xvZ2llcyBhcyBhbiBhZmZpbGlhdGUgb2YgUXVhbGNvbW0gClRlY2hub2xv
Z2llcywgSW5jLgpRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gaXMgYSBtZW1iZXIgb2YgdGhl
CkNvZGUgQXVyb3JhIEZvcnVtLCBhIExpbnV4IEZvdW5kYXRpb24gQ29sbGFib3JhdGl2ZSBQcm9q
ZWN0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
