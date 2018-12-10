Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EADC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:00:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E2D2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BxK3AkCB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHP1/OM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E2D2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SeGoP3QY3OpO9dp45iHKgjE3DOjO+Nu7YMd77BE4KMU=; b=BxK3AkCBuHDCC+
	Nd85lVb0aWlPvfGgPg+DYcrMatyckUgnQrYKtByphjwli+HY0TLZ0wjU9m13his891baxDaV49cbC
	j4ZYaDXf/GNBKKTtaFczE4q+zK49W6IBT2t0cTzqDI/q/IqywNdVDg1zQZKuTSX3cxB5H67WnbDCA
	B03ZDcjv6XVhCiR1eiKfU9KSXlR/KWk9jSbpj/2KNMJdiXzGdFBOH4zbCP9Qz8q2ONGVSYnlRKTzG
	c9fmBTa//OALr+PfW48x6zHBqHXyudaGrHNeeCTUizhAkIh+AWJopXXkgXzk5tp3Y95O6ZIL9TuF1
	TdEkACazs0Sb218dU68g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOv0-0006x5-CK; Mon, 10 Dec 2018 17:00:30 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOuw-0006wY-Dx
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:00:29 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so11226310wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YnOVPTnN8dX/BYzujInLN1FwrnYyPwOhbFWA6dfnqf4=;
 b=RHP1/OM4RMfntZ4kJY9BspCpSeZe8eJNB76zF9nKX8TPg2LKtvu6tJn/MU0xVq9wQQ
 dchzaMDud3qWQv+V62n16lmAF4ICf3SwnBAtaSzSA2Lb3Ag2ItO7VVj0Uu1BPW7MLf/F
 NCNG8H+fBVcr2zhLWn3d27fd+gAYX/gnKItRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YnOVPTnN8dX/BYzujInLN1FwrnYyPwOhbFWA6dfnqf4=;
 b=hw5betQWr4RF8VCTNdbDy0zL/f8OvW3F7L0cHCe/V1jEgYsLEVjt/NAjUj26jAm5+I
 7Gmm2c52E2+JzkzGgK+VerLDBcQNq5sQ4vtQVC7+Hwq9q7NC0oFriykNSyQatbh2dgFY
 GTU00nJNeKMtY91QCDCk5juF4Mn96WO5cmbDtsVf6+g2brUXLpa5mjSpHB5aMKb8WHVK
 zd54bZTEbfQdVg8srDXnLCnLP/93iziKGwCLiwo+dTX1HEeFDl/StnEnhdT0dmnkwwXM
 zgUPt4sUAHt6ZhaUk3I8RY0IKJ9874wHyw7nPkLUcefdOiv4m4735FrsmQYbq0F90j1R
 XspQ==
X-Gm-Message-State: AA+aEWYL5qMNTPD4JiyJuqwx4rCRNxwN73XfFVOZy26N1a9XlWc0IRSW
 RyCb8f/QAjoX2iPq/AE2jCu/rA==
X-Google-Smtp-Source: AFSGD/Xe/y0QaSU1vdBPhK9uO3AFsVB7CeNvn08oTccplmXC9+kqougHvb34EFSF1+NtQ5P5wumwVQ==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr10045227wrg.325.1544461214290; 
 Mon, 10 Dec 2018 09:00:14 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id w80sm14344460wme.38.2018.12.10.09.00.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:00:13 -0800 (PST)
Subject: Re: [PATCH v4] cpuidle: big.LITTLE: fix refcount leak
To: Yangtao Li <tiny.windzz@gmail.com>, lorenzo.pieralisi@arm.com,
 rjw@rjwysocki.net
References: <20181210162641.21029-1-tiny.windzz@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ee49b2fc-f855-4406-8780-0638d5fe09a0@linaro.org>
Date: Mon, 10 Dec 2018 18:00:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210162641.21029-1-tiny.windzz@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_090026_627759_60A4A327 
X-CRM114-Status: GOOD (  20.50  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTAvMTIvMjAxOCAxNzoyNiwgWWFuZ3RhbyBMaSB3cm90ZToKPiBvZl9maW5kX25vZGVfYnlf
cGF0aCgpIGFjcXVpcmVzIGEgcmVmZXJlbmNlIHRvIHRoZSBub2RlCj4gcmV0dXJuZWQgYnkgaXQg
YW5kIHRoYXQgcmVmZXJlbmNlIG5lZWRzIHRvIGJlIGRyb3BwZWQgYnkgaXRzIGNhbGxlci4KPiBi
bF9pZGxlX2luaXQoKSBkb2Vzbid0IGRvIHRoYXQsIHNvIGZpeCBpdC4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBZYW5ndGFvIExpIDx0aW55LndpbmR6ekBnbWFpbC5jb20+CgpBY2tlZC1ieTogRGFuaWVs
IExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+Cgo+IC0tLQo+IGNoYW5nZXMgaW4g
djQ6Cj4gLXVwZGF0ZSB0aWxlCj4gLXJlZmFjdG9yIGNvZGUsc3VnZ2VzdGVkIGJ5IERhbmllbAo+
IC0tLQo+ICBkcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxlLmMgfCA3ICsrKysrKy0K
PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxlLmMgYi9kcml2ZXJz
L2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxlLmMKPiBpbmRleCBkYjJlZGU1NjVmMWEuLmI0NDQ3
NmExYjdhZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxl
LmMKPiArKysgYi9kcml2ZXJzL2NwdWlkbGUvY3B1aWRsZS1iaWdfbGl0dGxlLmMKPiBAQCAtMTY3
LDYgKzE2Nyw3IEBAIHN0YXRpYyBpbnQgX19pbml0IGJsX2lkbGVfaW5pdCh2b2lkKQo+ICB7Cj4g
IAlpbnQgcmV0Owo+ICAJc3RydWN0IGRldmljZV9ub2RlICpyb290ID0gb2ZfZmluZF9ub2RlX2J5
X3BhdGgoIi8iKTsKPiArCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoX2lkOwo+ICAK
PiAgCWlmICghcm9vdCkKPiAgCQlyZXR1cm4gLUVOT0RFVjsKPiBAQCAtMTc0LDcgKzE3NSwxMSBA
QCBzdGF0aWMgaW50IF9faW5pdCBibF9pZGxlX2luaXQodm9pZCkKPiAgCS8qCj4gIAkgKiBJbml0
aWFsaXplIHRoZSBkcml2ZXIganVzdCBmb3IgYSBjb21wbGlhbnQgc2V0IG9mIG1hY2hpbmVzCj4g
IAkgKi8KPiAtCWlmICghb2ZfbWF0Y2hfbm9kZShjb21wYXRpYmxlX21hY2hpbmVfbWF0Y2gsIHJv
b3QpKQo+ICsJbWF0Y2hfaWQgPSBvZl9tYXRjaF9ub2RlKGNvbXBhdGlibGVfbWFjaGluZV9tYXRj
aCwgcm9vdCk7Cj4gKwo+ICsJb2Zfbm9kZV9wdXQocm9vdCk7Cj4gKwo+ICsJaWYgKCFtYXRjaF9p
ZCkKPiAgCQlyZXR1cm4gLUVOT0RFVjsKPiAgCj4gIAlpZiAoIW1jcG1faXNfYXZhaWxhYmxlKCkp
Cj4gCgoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBz
b3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cu
ZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29t
LyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJs
b2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
