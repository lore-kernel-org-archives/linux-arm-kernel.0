Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3FFC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:24:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FBC20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="je4w18uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FBC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ml+JgjL7FeeqQ5erxu34P+IwD7eJZacLt9IsFyGMBvE=; b=je4w18uKt9R9hQ
	AtugqXnLEX3Nn8vmqoYpOZ2cYn1C4DLSwy+1QZBE0rTO1tPkuVDPhtg+7GYqr5QZAxAdbASyMt0Hq
	5RvX/4DVLlBon3iY+WzFdow+60mWXL2NppLlcs6WgacaPe8/0tgyEw8Ya8nvotIKdUwA/JqT1TEGD
	ZRJ/3hZausujpwS+p5h5j3Ev9WNKCN5HTxhZAG9MFocwZR37YMjf63zkN3CUJZjwbvtIeWoupq2G0
	NT65rsOVoYLLcCRI0GqRAOJa8oD5nRBvXL2JaJqju+/ZJ5X2xzJDtzdbSIoCOv+7Mx3717jA/84TZ
	5uAesg4av+R8m03bvphA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu20b-0006AM-E5; Wed, 13 Feb 2019 21:23:57 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu20X-00069v-Rd
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:23:55 +0000
Received: by mail-ot1-f68.google.com with SMTP id 98so6942487oty.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=OZi5qeKyemTwFrkRIe6rM2nfjxLljMfmiFgKI5v1Pmk=;
 b=nViJ6Q0+ypHhHcz7DlC7ngvn7TA7dPaVCcy774mPcYGfRkLip410dUKFzQevLyYuhX
 nc/QU4mLVCMVKpchUcbxdeqLSP8EhHTbvLcIkxjool81ZRCB7NW5+ObzmNTzJbpZs55j
 6dEu1byh9BFW6xspTH841JK7qg/z3KebsI3vs36Ut+PgC7MaCXj6HSHKAmgzaQ7G2dSd
 jEy3tmfcqJiA0ZnaP7HLgLRCDE6OLITbqiflId/lztKiZ1o4XfWuJyWaPr8Usx/v6YqN
 MFM+/p270MHUo1OG/54iU7A/7uZbwbpcZRrr9fIf+baQBDbtjC99VtZnIcLWj1wzSQyK
 ErBQ==
X-Gm-Message-State: AHQUAubrDqXK1aicrBmcUdX6wSNSi3EB2jst3effNfQrhR95LfzDMWDO
 hiBalD8uqas5xXlGvOvFww==
X-Google-Smtp-Source: AHgI3IbFiYWp1blgcT1bjroj4h2TCTpGw8ddd9reFzOyK6+B6zlbt5lRuTNVoz1Z7HbREJBQA5pJ/A==
X-Received: by 2002:aca:3155:: with SMTP id x82mr140568oix.55.1550093033106;
 Wed, 13 Feb 2019 13:23:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r203sm187427oih.11.2019.02.13.13.23.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 13:23:52 -0800 (PST)
Date: Wed, 13 Feb 2019 15:23:47 -0600
From: Rob Herring <robh@kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Message-ID: <20190213212347.GA26140@bogus>
References: <20190205153924.7204-1-pankaj.bansal@nxp.com>
 <20190205153924.7204-2-pankaj.bansal@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190205153924.7204-2-pankaj.bansal@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_132353_887328_879EA5DE 
X-CRM114-Status: GOOD (  21.17  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list : OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Leo Li <leoyang.li@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBGZWIgMDUsIDIwMTkgYXQgMTA6MTQ6NDBBTSArMDAwMCwgUGFua2FqIEJhbnNhbCB3
cm90ZToKPiBhbiBGUEdBLWJhc2VkIHN5c3RlbSBjb250cm9sbGVyLCBjYWxsZWQg4oCcUWl4aXPi
gJ0sIHdoaWNoCj4gbWFuYWdlcyBzZXZlcmFsIGNyaXRpY2FsIHN5c3RlbSBmZWF0dXJlcywgaW5j
bHVkaW5nOgo+IOKAoiBSZXNldCBzZXF1ZW5jaW5nCj4g4oCiIFBvd2VyIHN1cHBseSBjb25maWd1
cmF0aW9uCj4g4oCiIEJvYXJkIGNvbmZpZ3VyYXRpb24KPiDigKIgaGFyZHdhcmUgY29uZmlndXJh
dGlvbgo+IAo+IFRoZSBxaXhpcyByZWdpc3RlcnMgYXJlIGFjY2Vzc2libGUgb3ZlciBvbmUgb3Ig
bW9yZSBzeXN0ZW0tc3BlY2lmaWMKPiBpbnRlcmZhY2VzLCB0eXBpY2FsbHkgSTJDLCBKVEFHIG9y
IGFuIGVtYmVkZGVkIHByb2Nlc3Nvci4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2Fs
IDxwYW5rYWouYmFuc2FsQG54cC5jb20+Cj4gLS0tCj4gCj4gTm90ZXM6Cj4gICAgIFY0Ogo+ICAg
ICAtIE5vIENoYW5nZQo+ICAgICBWMzoKPiAgICAgLSBBZGRlZCBib2FyZG5hbWUgYmFzZWQgY29t
cGF0aWJsZSBmaWVsZCBpbiBiaW5kaW5ncwo+ICAgICAtIEFkZGVkIGJpbmRpbmdzIGZvciBNTUlP
IGJhc2VkIEZQR0EKPiAgICAgVjI6Cj4gICAgIC0gTm8gY2hhbmdlCj4gCj4gIC4uLi9iaW5kaW5n
cy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0ICAgICAgICAgIHwgNTMgKysrKysrKysrKysrKysrKysr
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9mc2wvcWl4aXNfY3RybC50eHQK
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNWQ1MTBkZjE0YmU4
Cj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb2MvZnNsL3FpeGlzX2N0cmwudHh0Cj4gQEAgLTAsMCArMSw1MyBAQAo+ICsqIFFJWElTIEZQ
R0EgYmxvY2sKPiArCj4gK2FuIEZQR0EtYmFzZWQgc3lzdGVtIGNvbnRyb2xsZXIsIGNhbGxlZCDi
gJxRaXhpc+KAnSwgd2hpY2gKPiArbWFuYWdlcyBzZXZlcmFsIGNyaXRpY2FsIHN5c3RlbSBmZWF0
dXJlcywgaW5jbHVkaW5nOgo+ICvigKIgQ29uZmlndXJhdGlvbiBzd2l0Y2ggbW9uaXRvcmluZwo+
ICvigKIgUG93ZXIgb24vb2ZmIHNlcXVlbmNpbmcKPiAr4oCiIFJlc2V0IHNlcXVlbmNpbmcKPiAr
4oCiIFBvd2VyIHN1cHBseSBjb25maWd1cmF0aW9uCj4gK+KAoiBCb2FyZCBjb25maWd1cmF0aW9u
Cj4gK+KAoiBoYXJkd2FyZSBjb25maWd1cmF0aW9uCj4gK+KAoiBCYWNrZ3JvdW5kIHBvd2VyIGRh
dGEgY29sbGVjdGlvbiAoRENNKQo+ICvigKIgRmF1bHQgbW9uaXRvcmluZwo+ICvigKIgUkNXIGJ5
cGFzcyBTUkFNIChyZXBsYWNlIGZsYXNoIFJDVyB3aXRoIGludGVybmFsIFJDVykgKE5PUiBvbmx5
KQo+ICvigKIgRGVkaWNhdGVkIGZ1bmN0aW9uYWwgdmFsaWRhdGlvbiBibG9ja3MgKFBPU3QvSVJT
LCB0cmlnZ2VyZWQgZXZlbnQsIGFuZCBzbyBvbikKPiAr4oCiIEkyQyBtYXN0ZXIgZm9yIHJlbW90
ZSBib2FyZCBjb250cm9sIGV2ZW4gd2l0aCBubyBEVVQgYXZhaWxhYmxlCj4gKwo+ICtUaGUgcWl4
aXMgcmVnaXN0ZXJzIGFyZSBhY2Nlc3NpYmxlIG92ZXIgb25lIG9yIG1vcmUgc3lzdGVtLXNwZWNp
ZmljIGludGVyZmFjZXMsCj4gK3R5cGljYWxseSBJMkMsIEpUQUcgb3IgYW4gZW1iZWRkZWQgcHJv
Y2Vzc29yLgo+ICsKPiArRlBHQSBjb25uZWN0ZWQgdG8gSTJDOgo+ICtSZXF1aXJlZCBwcm9wZXJ0
aWVzOgo+ICsKPiArIC0gY29tcGF0aWJsZTogc2hvdWxkIGJlIGEgYm9hcmQtc3BlY2lmaWMgc3Ry
aW5nIGZvbGxvd2VkIGJ5IGEgc3RyaW5nCj4gKyAgIGluZGljYXRpbmcgdGhlIHR5cGUgb2YgRlBH
QS4gIEV4YW1wbGU6Cj4gKwkiZnNsLDxib2FyZD4tZnBnYSIsICJmc2wsZnBnYS1xaXhpcy1pMmMi
CgpZb3UgZG9uJ3QgcmVhbGx5IG5lZWQgdGhlICctaTJjJyBwYXJ0IGJlY2F1c2UgaXQgd2lsbCBv
bmx5IGdldCBib3VuZCB0byAKYW4gaTJjIGJhc2VkIGRyaXZlciB3aGVuIGEgY2hpbGQgb2YgYW4g
aTJjIGNvbnRyb2xsZXIuCgo+ICsgLSByZWcgOiBpMmMgYWRkcmVzcyBvZiB0aGUgcWl4aXMgZGV2
aWNlLgo+ICsKPiArRXhhbXBsZSAoTFgyMTYwQS1RRFMpOgo+ICsJLyogVGhlIEZQR0Egbm9kZSAq
Lwo+ICsgICAgICAgIGZwZ2FANjYgewo+ICsJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGFxZHMt
ZnBnYSIsICJmc2wsZnBnYS1xaXhpcy1pMmMiOwo+ICsJCXJlZyA9IDwweDY2PjsKCj4gKwkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47Cj4gKwkJI3NpemUtY2VsbHMgPSA8MD47CgpZb3UgZG9uJ3QgbmVl
ZCB0aGlzIHVubGVzcyB5b3UgaGF2ZSBjaGlsZCBub2RlcyB3aXRoICdyZWcnLgoKPiArCX0KPiAr
Cj4gKyogRnJlZXNjYWxlIG9uLWJvYXJkIEZQR0EKPiArCj4gK1RoaXMgaXMgdGhlIG1lbW9yeS1t
YXBwZWQgcmVnaXN0ZXJzIGZvciBvbiBib2FyZCBGUEdBLgo+ICsKPiArUmVxdWlyZWQgcHJvcGVy
dGllczoKPiArLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgYSBib2FyZC1zcGVjaWZpYyBzdHJpbmcg
Zm9sbG93ZWQgYnkgYSBzdHJpbmcKPiArICBpbmRpY2F0aW5nIHRoZSB0eXBlIG9mIEZQR0EuICBF
eGFtcGxlOgo+ICsJImZzbCw8Ym9hcmQ+LWZwZ2EiLCAiZnNsLGZwZ2EtcWl4aXMiCj4gKy0gcmVn
OiBzaG91bGQgY29udGFpbiB0aGUgYWRkcmVzcyBhbmQgdGhlIGxlbmd0aCBvZiB0aGUgRlBHQSBy
ZWdpc3RlciBzZXQuCj4gKwo+ICtFeGFtcGxlIChMUzIwODBBLVJEQik6Cj4gKwo+ICsgICAgICAg
IGNwbGRAMywwIHsKPiArICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGxzMjA4MGFy
ZGItZnBnYSIsICJmc2wsZnBnYS1xaXhpcyI7Cj4gKyAgICAgICAgICAgICAgICByZWcgPSA8MHgz
IDAgMHgxMDAwMD47Cj4gKyAgICAgICAgfTsKPiArCj4gLS0gCj4gMi4xNy4xCj4gCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
