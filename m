Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE484C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:11:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FDC20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FDr9O++I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FDC20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=isPow1ylVIuW7wkG0EIMbLIP93Q5w0ZWgh9JQ5lL8/s=; b=FDr9O++In2GG2F
	vInWXRnx+UqfCwBAnav6/tPAW2hM7tHIfVjP0TpxBXniP7oy/LJz+ky6HdSwVQS6RtRRRh/7ioT6d
	tK/H0+fD3wM9yo6fMv/VqxbECAICJipPgpcQpGexmBJ4q1xf/8nEyxLF/U3P0xA5Z7JSwx1iIaH5h
	sbbN4qeqA5e1ArrD4R1XGwOFIBkx2f1ZcIem8pnka8DinxFHzjkt2A+0CaYFZZJEx0YMW6ienZTHp
	+lTk07q0e9o6kuU50TCejW+rsOSoWvH+kprfq6JeXvY80QLtSLcFXpiwDE5V7sHmL0bbO5uUuEPj7
	1gSwdOF3eqEqNF9R9YcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVBEP-00018i-Od; Fri, 07 Dec 2018 08:11:29 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVBEL-000189-0e; Fri, 07 Dec 2018 08:11:26 +0000
Received: from [192.168.178.52] ([109.104.37.200]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKbc2-1glkAn38oe-00Kwum; Fri, 07 Dec 2018 09:10:57 +0100
Subject: Re: [PATCH 1/5] dt-bindings: nvmem: add binding for Raspberry Pi OTP
To: Rob Herring <robh@kernel.org>
References: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
 <1542805904-6446-2-git-send-email-stefan.wahren@i2se.com>
 <20181206234941.GA6340@bogus>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <894cfae3-43f4-f201-9b54-41114ce8107e@i2se.com>
Date: Fri, 7 Dec 2018 09:10:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206234941.GA6340@bogus>
Content-Language: en-US
X-Provags-ID: V03:K1:sKUm/bjNhYq7Fu35af4AwYm3vcdy9GZVQ/WEjKXbbqS1XOtBkvF
 1JQuaph4J2Mf7ff7qAwbzvoK6T35E+SeVmkMcbHI8ATdnc8+j0T3FwIKjeWL0VHL6Hq6f8a
 RWma0UlTGtASLnwC3RpDKRYm9jtO/hjsf12xFwQtfSJfMrmznsl8MAt0w/a5Jb/IvoNVTca
 S1pWzuG+r5OoRxExbqC0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DAIEqJ0gw+g=:a4L1QfGkQv/+Z8WWO8YbMx
 JDLP6pvWE6buelGOEqbUZa9EDPZs8BTfFxPGOCxjZdAL7+x3SHGPm4DPaFHxbzHzxBYPY6+nG
 hkqBjN6l3/3fB83DtpQhYJ1HCO/tkVKPOF0INbI3eUa3mBfV7W2dOWmyUdWbR3TE2Qa2PO80w
 TDNPMg96GK0v8sGuWfghigiokNWbczf4yjJODpsqLYdHd0hhHGa7yu024wvlTWuTJZ2JEqrx5
 9FfAyaFbuvLTP/CwGqQtigjo0hNTBRi8RCFZ5SDaQ6PDojrTq9/8CqQefGlQVqjhD1/619BPR
 G+yXWjmRCVARnD7DfDdPXWWCBlURB9X8w90a2OpX57quacOTMnbrYOk1dy9tBQ4fho9GC+eet
 m0TEwOwRpm0XLVbV3s6mz4a7h+7BKh03lhlVWENTewwJEDjqmpNdLItlpQVy/9ueHJLl68ko0
 IoVVBOJYBHA1myxbPk971x1iDZjpmCr+q7agx1k4aIUdDjjkcmXKkMsx9YoxN4dc+NBllvyH1
 m0oNCZ+8iamXndmfniXw058KKKnpSzgmUYr5HyAPex1Rjr9Vt2Xd+150Lri1sPgnjxabWopJg
 wm9Kefi7e1rZK3En+zn2ZYe1w5/W2V+7hBQivbjTmWiBYO/yiAT8NHF7ZDnMJICXfjbWADypT
 LSn8dYrEgEG2KL374/yqGGCqbboewIaI6SsX7BWZfyXPgkoa4q1zzLigQUygVO6jRdyQoZ4gr
 HsNIWN4C/Zg5epp62U5Q3tOD/xhvDJY90QZPYHX4/2As541wn1yEjCF0fn0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_001125_362117_B21DE1EA 
X-CRM114-Status: GOOD (  18.19  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Eric Anholt <eric@anholt.net>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgUm9iLAoKQW0gMDcuMTIuMTggdW0gMDA6NDkgc2NocmllYiBSb2IgSGVycmluZzoKPiBPbiBX
ZWQsIE5vdiAyMSwgMjAxOCBhdCAwMjoxMTo0MFBNICswMTAwLCBTdGVmYW4gV2FocmVuIHdyb3Rl
Ogo+PiBUaGlzIHBhdGNoIGFkZHMgdGhlIGRldmljZXRyZWUgYmluZGluZyBmb3IgUmFzcGJlcnJ5
IFBpIGN1c3RvbWVyIE9UUAo+PiBkcml2ZXIuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBX
YWhyZW4gPHN0ZWZhbi53YWhyZW5AaTJzZS5jb20+Cj4+IC0tLQo+PiAgLi4uL252bWVtL3Jhc3Bi
ZXJyeXBpLGJjbTI4MzUtY3VzdG9tZXItb3RwLnR4dCAgICAgfCAyMiArKysrKysrKysrKysrKysr
KysrKysrCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQo+PiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9yYXNwYmVy
cnlwaSxiY20yODM1LWN1c3RvbWVyLW90cC50eHQKPj4KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9yYXNwYmVycnlwaSxiY20yODM1LWN1c3Rv
bWVyLW90cC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vcmFz
cGJlcnJ5cGksYmNtMjgzNS1jdXN0b21lci1vdHAudHh0Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
Cj4+IGluZGV4IDAwMDAwMDAuLjA0MWZmMTcKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vcmFzcGJlcnJ5cGksYmNtMjgzNS1j
dXN0b21lci1vdHAudHh0Cj4+IEBAIC0wLDAgKzEsMjIgQEAKPj4gK0N1c3RvbWVyIE9UUCBNZW1v
cnkgZm9yIFJhc3BiZXJyeSBQaQo+PiArCj4+ICtUaGUgVkM0IGZpcm13YXJlIGV4cG9zZXMgYSBt
YWlsYm94IGludGVyZmFjZSB0aGF0IGFsbG93cyB0aGUgQVJNIGNvcmUKPj4gK3RvIGFjY2VzcyB0
aGUgY3VzdG9tZXIgcGFydCBvZiB0aGUgT1RQIG1lbW9yeS4KPj4gKwo+PiArVGhlIE9UUCBub2Rl
IG11c3QgYmUgYSBjaGlsZCBub2RlIG9mIHRoZSBSYXNwYmVycnkgUGkgZmlybXdhcmUgbm9kZS4K
Pj4gKwo+PiArUmVxdWlyZWQgcHJvcGVydGllcyA6Cj4+ICstIGNvbXBhdGlibGUgICAgIDogU2hv
dWxkIGJlICJyYXNwYmVycnlwaSxiY20yODM1LWN1c3RvbWVyLW90cCIKPiBXaHkgZG8gd2UgbmVl
ZCB0aGlzIGNoaWxkIG5vZGU/IENhbid0IHRoZSBwYXJlbnQgaW5zdGFudGlhdGUgdGhpcz8KPgo+
IEFyZSB0aGVyZSBPVFAgZmllbGRzIHlvdSB3YW50IHRvIGV4cG9zZSBpbiBEVD8KCnRoZSBjdXN0
b21lciBwYXJ0IG9mIHRoZSBPVFAgaXMgcmVzZXJ2ZWQgKGluaXRpYWxpemVkIHdpdGggemVybykg
Zm9yCnVzZXIgd2hvIHdhbnRzIHRvIHVzZSB0aGUgUmFzcGJlcnJ5IFBpIChtb3N0bHkgdGhlIENv
bXB1dGUgTW9kdWxlKSBpbgp0aGVpciBjdXN0b20gZGVzaWducy4gU28gaSBjYW5ub3QgcHJvdmlk
ZSBhbnkgbnZtZW0gY2VsbHMgeWV0IGJlY2F1c2UgaXQKaXMgdXAgdG8gdGhlIHVzZXIgdG8gZGVm
aW5lIHRoZW0gKGUuZy4gaGFyZHdhcmUgcmVsYXRlZCB2YWx1ZXMgbGlrZQpzZXJpYWwgbnVtYmVy
cywgTUFDIGFkZHJlc3NlcyBmb3IgYWRkaXRpb25hbCBuZXR3b3JrIGludGVyZmFjZXMgb3IKY2Fs
aWJyYXRpb24gdmFsdWVzKS4gQnV0IHllcyBpIGNvbnNpZGVyIHRoZSBiaW5kaW5nIGFuZCB0aGUg
YWJpbGl0eSB0bwpkZWZpbmUgbnZtZW0gY2VsbHMgdmlhIGRldmljZXRyZWUgYXMgYSBncmVhdCBm
ZWF0dXJlLgoKQ3VycmVudGx5IHRoZSBGb3VuZGF0aW9uIHN1Z2dlc3RzIHRvIHVzZSB0aGUgbWFp
bGJveCBpbnRlcmZhY2UgZnJvbQp1c2Vyc3BhY2UgWzFdLCBidXQgaSBwcmVmZXIgYSBtb3JlIGNv
bW1vbiB3YXkgbGlrZSBudm1lbS4KClsxXSAtwqAKaHR0cHM6Ly93d3cucmFzcGJlcnJ5cGkub3Jn
L2RvY3VtZW50YXRpb24vaGFyZHdhcmUvaW5kdXN0cmlhbC9SRUFETUUubWQKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
