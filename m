Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F366C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:44:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE6220879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pVG73qFY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pGrQuUf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE6220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZY7TOdqP+SzjwbERiya2cHLVwX6mt7HMpqSSSDTtyBg=; b=pVG73qFYElvVbj
	lEcDfWZaKJ3ywzLC++8qAEwZYfQtzbmtXg6VaAkOKXPME5TAoCfnQCBN+/sBE4jBYkdDiIhUarC6q
	gHA8jjRW41/4y0PP2mLBkzFQo8oRDzcStboseM/Oc7QRKIw34k9gKMaW62++eu80lUWbXhNILbM1a
	RgXqdkP7P39w6TQlJvnILmlONAxZW/g7w8RhwIl5OoX6L5S2W9LibefVbsUAc6+UXgnlHVE3CvIdS
	WnybNMBKpTA+X6b+tI7f0IgZlmPXugMBbLWvx6EasWnPlOwZzcL9L4DuFXd31fA77ClyFRKvaX4k1
	koVTVgcEiZeVwjc2SFdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXRI8-00024q-3O; Thu, 13 Dec 2018 13:44:40 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXRI3-00023J-7J
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:44:36 +0000
Received: by mail-qt1-x843.google.com with SMTP id y20so2088313qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 05:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XcHOTrwef+d/3NpOnG6UkJ2OjWRwDQnbxAR+dweCJqY=;
 b=pGrQuUf70QYOWnWOFy9glld1HmxOl/YGxEUye4D3XR+1FNeKiWP0QcqC4QMo57cvwn
 1Mo2b3blWZUzwONJpWyoE0ujYnqqNaywUdEMk0rhzNA2AUm9AxAokVNsT+V1f6R0pZjy
 i6yOUlC8tdbsmimlL3BZ/FsD4hDei1Z1rT6VkCbGQs9g7JESooDfLxxP/9iTjREckNUS
 60e+NPUTpcydL6Md+CuxX1l4b79nSDMJtSWwHhEJKKLQL2PaaE0mrNOc+dLrcXmj1X0C
 NjsxNAZdnO8YMMUb/OWt2sN4bOcdZlyeENxDmD82ywPoRGIPRFDyiHzI+w+CwzxDja14
 biYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XcHOTrwef+d/3NpOnG6UkJ2OjWRwDQnbxAR+dweCJqY=;
 b=uFummyZsxjA56tEPYeuKnB/bEyALJz27WLPhxJWq8b7VPsALqn+RSsM1tce1J7bi5W
 hMsQla8gwfNimPHhwp9fEGb6+US+NbdFCer+3JZNhzmKUEp9sLpyffPu5AmxHOizg52q
 XzDpTzuHc4dNF62bFBuSif77TnfYwWuARykO8VV/W9G43fEOjljVF+cStCd1Z/Wprt7A
 b4Rp9KCwq4SMi7PHLI1JsYq+/SvQA3vYifXk/FQXhaqtW+kXTHrP3GYzVeoSBbUCJlAJ
 rrmYua4vqLsHE5P9lb7AFN77423VCSJH9C/xs5jfp9pJYg5lRoZ4r+oXiJgwNcpCJbmf
 r3Yg==
X-Gm-Message-State: AA+aEWbaQ8Rhot2AXLm6arr8gPPqioXq8/ruRNEBZdMqaat7ffvoJsMG
 DBm+OlYWp/vOQ5YOqJlkUbIZmw==
X-Google-Smtp-Source: AFSGD/XoYJwUHe6CpH+VfdlXpO3DqTs34O79NBy+a+LVOi2KsrmPz4ZVLzDCa9JhZJupr9LOseuBjw==
X-Received: by 2002:a0c:d033:: with SMTP id u48mr22856833qvg.146.1544708662064; 
 Thu, 13 Dec 2018 05:44:22 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id b20sm1513077qkb.17.2018.12.13.05.44.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 05:44:21 -0800 (PST)
Message-ID: <1544708660.18411.15.camel@lca.pw>
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
From: Qian Cai <cai@lca.pw>
To: James Morse <james.morse@arm.com>
Date: Thu, 13 Dec 2018 08:44:20 -0500
In-Reply-To: <1b150a95-2b80-2be3-0b77-599404f882dc@arm.com>
References: <1544654224.18411.11.camel@lca.pw>
 <20181213052259.56352-1-cai@lca.pw>
 <1b150a95-2b80-2be3-0b77-599404f882dc@arm.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_054435_263878_C24665BC 
X-CRM114-Status: GOOD (  21.22  )
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
Cc: ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyMDE4LTEyLTEzIGF0IDEwOjQ0ICswMDAwLCBKYW1lcyBNb3JzZSB3cm90ZToKPiBU
aGUga2VybmVsIHNob3VsZCBhbHJlYWR5IGhhbmRsZSB0aGlzLCBhcyB3ZSBkb24ndCB0cnVzdCB0
aGUgYm9vdGxvYWRlciB0bwo+IGNsZWFuCj4gdXAgZWl0aGVyLgo+IAo+IEluIGFyY2gvYXJtNjQv
bW0vcHJvYy5TOjpfX2NwdV9zZXR1cCgpCj4gPiAvKgo+ID4gKglfX2NwdV9zZXR1cAo+ID4gKgo+
ID4gKglJbml0aWFsaXNlIHRoZSBwcm9jZXNzb3IgZm9yIHR1cm5pbmcgdGhlIE1NVSBvbi7CoMKg
UmV0dXJuIGluIHgwIHRoZQo+ID4gKgl2YWx1ZSBvZiB0aGUgU0NUTFJfRUwxIHJlZ2lzdGVyLgo+
ID4gKi8KPiA+IAkucHVzaHNlY3Rpb24gIi5pZG1hcC50ZXh0IiwgImF3eCIKPiA+IEVOVFJZKF9f
Y3B1X3NldHVwKQo+ID4gCXRsYmkJdm1hbGxlMQkJCQkvLyBJbnZhbGlkYXRlIGxvY2FsCj4gPiBU
TEIKPiA+IAlkc2IJbnNoCj4gCj4gVGhpcyBpcyBjYWxsZWQgZnJvbSBzdGV4dCwgd2hpY2ggdGhl
biBicmFuY2hlcyB0byBfX3ByaW1hcnlfc3dpdGNoKCksIHdoaWNoCj4gY2FsbHMgX19lbmFibGVf
bW11KCkgd2hlcmUgeW91IHNlZSB0aGlzIHByb2JsZW0uIEl0IHNob3VsZG4ndCBub3QgYmUgcG9z
c2libGUKPiB0bwo+IGFsbG9jYXRlIG5ldyB0bGIgZW50cmllcyBiZXR3ZWVuIHRoZXNlIHBvaW50
cy4uLgo+IAo+IERvIHlvdSBoYXZlIENPTkZJR19SQU5ET01JWkVfQkFTRSBkaXNhYmxlZD8gVGhp
cyBjYXVzZXMgZW5hYmxlX21tdSgpIHRvIGJlCj4gY2FsbGVkIHR3aWNlLCB0aGUgZXh0cmEgdGxi
IG1haW50ZW5hbmNlIGlzIGluIF9fcHJpbWFyeV9zd2l0Y2guCj4gKGlmIGl0IHdvcmtzIHdpdGgg
dGhpcyB0dXJuZWQgb2ZmLCBpdCBwb2ludHMgdG8gdGhlIGV4dHJhIG9mZi90bGJpL29uCj4gc2Vx
dWVuY2UpLgoKWWVzLCBDT05GSUdfUkFORE9NSVpFX0JBU0UgaXMgTk9UIHNldC4KCj4gCj4gCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvaGVhZC5TIGIvYXJjaC9hcm02NC9rZXJu
ZWwvaGVhZC5TCj4gPiBpbmRleCA0NDcxZjU3MGEyOTUuLjUxOTZmM2Q3MjlkZSAxMDA2NDQKPiA+
IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL2hlYWQuUwo+ID4gKysrIGIvYXJjaC9hcm02NC9rZXJu
ZWwvaGVhZC5TCj4gPiBAQCAtNzcxLDYgKzc3MSwxMCBAQCBFTlRSWShfX2VuYWJsZV9tbXUpCj4g
PiDCoAltc3IJdHRicjBfZWwxLCB4MgkJCS8vIGxvYWQgVFRCUjAKPiA+IMKgCW1zcgl0dGJyMV9l
bDEsIHgxCQkJLy8gbG9hZCBUVEJSMQo+ID4gwqAJaXNiCj4gPiArCWRzYgluc2hzdAo+ID4gKwl0
bGJpCXZtYWxsZTEJCQkJLy8gaW52YWxpZGF0ZQo+ID4gVExCCj4gPiArCWRzYgluc2gKPiA+ICsJ
aXNiCj4gPiDCoAltc3IJc2N0bHJfZWwxLCB4MAo+ID4gwqAJaXNiCj4gCj4gVGhlIG92ZXJhbGwg
Y2hhbmdlIGhlcmUgaXMgdGhhdCB3ZSBkbyBleHRyYSBtYWludGVuYW5jZSBsYXRlci4KPiAKPiBD
YW4gbW92ZSB0aGlzIGFyb3VuZCB0byBiaXNlY3Qgd2hlcmUgdGhlIFRMQiBlbnRyaWVzIGFyZSBl
aXRoZXIgY29taW5nIGZyb20sCj4gb3IKPiBmYWlsaW5nLXRvLWJlIGludmFsaWRhdGVkPwo+IERv
IHlvdXIgZmlyc3QgYW5kIGtkdW1wIGtlcm5lbHMgaGF2ZSB0aGUgc2FtZSBWQV9CSVRTL1BBR0Vf
U0laRT8KClllcywKCkNPTkZJR19BUk02NF9WQV9CSVRTPTQ4CkNPTkZJR19BUk02NF9QQUdFX1NI
SUZUPTE2CiMgQ09ORklHX0FSTTY0XzRLX1BBR0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJNNjRf
MTZLX1BBR0VTIGlzIG5vdCBzZXQKQ09ORklHX0FSTTY0XzY0S19QQUdFUz15Cgo+IEFzIGEgc3Rh
YiBpbiB0aGUgZGFyaywgKHRvdGFsbHkgdW50ZXN0ZWQpOgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSU8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvbW0vcHJvYy5TIGIvYXJjaC9hcm02NC9tbS9wcm9jLlMKPiBpbmRleCAyYzc1
YjBiOTAzYWUuLmE1ZjNiNzMxNGJkYSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L21tL3Byb2Mu
Uwo+ICsrKyBiL2FyY2gvYXJtNjQvbW0vcHJvYy5TCj4gQEAgLTQwNiw5ICs0MDYsNiBAQCBFTkRQ
Uk9DKGlkbWFwX2twdGlfaW5zdGFsbF9uZ19tYXBwaW5ncykKPiDCoCAqLwo+IMKgwqDCoMKgwqDC
oMKgwqAucHVzaHNlY3Rpb24gIi5pZG1hcC50ZXh0IiwgImF3eCIKPiDCoEVOVFJZKF9fY3B1X3Nl
dHVwKQo+IC3CoMKgwqDCoMKgwqDCoHRsYmnCoMKgwqDCoHZtYWxsZTHCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8vIEludmFsaWRhdGUgbG9jYWwgVExC
Cj4gLcKgwqDCoMKgwqDCoMKgZHNiwqDCoMKgwqDCoG5zaAo+IC0KPiDCoMKgwqDCoMKgwqDCoMKg
bW92wqDCoMKgwqDCoHgwLCAjMyA8PCAyMAo+IMKgwqDCoMKgwqDCoMKgwqBtc3LCoMKgwqDCoMKg
Y3BhY3JfZWwxLCB4MMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLy8gRW5h
YmxlIEZQL0FTSU1ECj4gwqDCoMKgwqDCoMKgwqDCoG1vdsKgwqDCoMKgwqB4MCwgIzEgPDwgMTLC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLy8gUmVzZXQgbWRzY3JfZWwx
IGFuZCBkaXNhYmxlCj4gQEAgLTQ2NSw1ICs0NjIsMTAgQEAgRU5UUlkoX19jcHVfc2V0dXApCj4g
wqAxOgo+IMKgI2VuZGlmIC8qIENPTkZJR19BUk02NF9IV19BRkRCTSAqLwo+IMKgwqDCoMKgwqDC
oMKgwqBtc3LCoMKgwqDCoMKgdGNyX2VsMSwgeDEwCj4gK8KgwqDCoMKgwqDCoMKgaXNiCj4gKwo+
ICvCoMKgwqDCoMKgwqDCoHRsYmnCoMKgwqDCoHZtYWxsZTHCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8vIEludmFsaWRhdGUgbG9jYWwgVExCCj4gK8Kg
wqDCoMKgwqDCoMKgZHNiwqDCoMKgwqDCoG5zaAo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAvLyByZXR1cm4gdG8gaGVhZC5TCj4gwqBFTkRQUk9DKF9fY3B1X3NldHVw
KQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSU8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gCgpUaGlzIHBhdGNoIHdvcmtzIHdlbGwgdG9vLgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
