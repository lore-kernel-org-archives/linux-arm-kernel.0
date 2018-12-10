Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1539DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:07:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D935D20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P4FHs9Ag";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4JAAWS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D935D20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lNWnorlk2yC83LmOwVLLswSMzvDN5ww+jE8jNEtDjWA=; b=P4FHs9Ag9d1tXZ
	OBcadglr6RtZS4dHKKyUBCeaurxVd7GMomsywGuUNQcj+2YM4KKsIIiXO0xFxYxlx9NRlICPqkO0e
	0L5sbBIFDpe1fSHgm10ScUmWfo8J9ifrkBKKtVUfme1T44QCU4G9wb/6jt7BsydQ7FqlsORPSJWcN
	JS61dwtO8hhHH5Y14SCxIXG22b+yw76eJ2rXca3RWcGLrsSItWuc4+oLrBlZATGfNoB9FW3j+EFV8
	4k08XlneUpA2KyKOb3XUTjB5MiJPJbnorN72Z2OvizDvyMTLW8s6g4Yx5kz5NG45rlly7qZl65kU1
	cWBfZVSHuOHaRqZz9zNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWITd-0002ZY-3B; Mon, 10 Dec 2018 10:07:49 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWITY-0002XY-NU
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:07:47 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so9787617wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 02:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=NM3kHVQqUzDYGFECnYFQlEVh1nDZzAwDhS9Ur9x25V8=;
 b=D4JAAWS5iHodNIPOboxukpafl76vItSa0P6ABaYiy0gtNk4SqKoBrlBpTi1xr0l8dr
 CdU5GXuvdVlIR1IoVo1DoVqOIPzo0hw+d9MXd/5TZ8IU5hEjtkLNtGud4rofGmLItnZA
 ndf0h6ty1OcaOL2R6wzFR97zASneVqUFaZgD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=NM3kHVQqUzDYGFECnYFQlEVh1nDZzAwDhS9Ur9x25V8=;
 b=ebyAdA0lLzgJp1S21N5tqa2EFAGCofUQA2s14+ZaQ4v3YhRImWxOCUOCgyWPGth+V2
 SXEMhwDpAVfods1p/5ZFkufncfCcyFlDAoEc+RQSHrwzcZnFEI/0Luv8ilAmlUSI2vUe
 Y5aCq2C7nx+Eg3XRIv2B1zvwVvg585oIxEwrRgYojA3dlQVcj8HdLLkYRlBsrib9l6ju
 IUKKil02xofitYSF/WcCe6oxLSSAd7Mxf6+ZDet41yuDpvIob3b3SspT30fC3d1mvAAj
 yW1dz7K6SHnqYZRKFbIvufNP6pNomUCupqvX9iXB5H6ocnXNP8Peqog8B7ACwNkL6UD/
 XD2A==
X-Gm-Message-State: AA+aEWYcAwhJdKDK96yXEmxGlybhQCtF6fw7Idn4/cdwnku+TXVWVebI
 Ek3dRc6b1u4BoRoabe9wlQiwQw==
X-Google-Smtp-Source: AFSGD/XqLbFWgS6JEChHkstzJAj8jIlKIu3pJnGWZvCL/MuhZJrE1KDHCehTsEPHA5s9/o4OpOCY+w==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr10064713wrr.285.1544436452090; 
 Mon, 10 Dec 2018 02:07:32 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id e142sm30375177wmf.46.2018.12.10.02.07.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 02:07:30 -0800 (PST)
Date: Mon, 10 Dec 2018 10:07:29 +0000
From: Lee Jones <lee.jones@linaro.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Message-ID: <20181210100729.GX26661@dell>
References: <20181209063440.27820-1-yuehaibing@huawei.com>
 <20181210061557.GL26661@dell>
 <4f1a67e5-b735-f8bd-88b8-3a1ca590eba2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4f1a67e5-b735-f8bd-88b8-3a1ca590eba2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_020744_764021_79D3BEB6 
X-CRM114-Status: GOOD (  15.71  )
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
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org,
 matthias.bgg@gmail.com, chen.zhong@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAxMCBEZWMgMjAxOCwgWXVlSGFpYmluZyB3cm90ZToKCj4gT24gMjAxOC8xMi8xMCAx
NDoxNSwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gT24gU3VuLCAwOSBEZWMgMjAxOCwgWXVlSGFpYmlu
ZyB3cm90ZToKPiA+IAo+ID4+IFJlbW92ZSBkdXBsaWNhdGVkIGluY2x1ZGUuCj4gPj4KPiA+PiBT
aWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+Cj4gPj4gLS0t
Cj4gPj4gIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXRrLXBtaWMta2V5cy5jIHwgMSAtCj4gPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbnB1dC9rZXlib2FyZC9tdGstcG1pYy1rZXlzLmMgYi9kcml2ZXJzL2lucHV0L2tleWJv
YXJkL210ay1wbWljLWtleXMuYwo+ID4+IGluZGV4IDAyYzY3YTEuLjUwMjdlYmIgMTAwNjQ0Cj4g
Pj4gLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9tdGstcG1pYy1rZXlzLmMKPiA+PiArKysg
Yi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL210ay1wbWljLWtleXMuYwo+ID4+IEBAIC0xOSw3ICsx
OSw2IEBACj4gPj4gICNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgo+ID4+ICAjaW5jbHVkZSA8bGlu
dXgvaW50ZXJydXB0Lmg+Cj4gPj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4K
PiA+PiAtI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgo+ID4+ICAjaW5jbHVkZSA8bGludXgvb2Yu
aD4KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPgo+ID4+ICAjaW5jbHVkZSA8bGlu
dXgvcmVnbWFwLmg+Cj4gPiAKPiA+IFlvdSBhcmUgcmVtb3ZpbmcgdGhlIHdyb25nIG9uZS4KPiAK
PiBObywgbGludXgva2VybmVsLmggaXMgYSBkdXBsaWNhdGVkIGluY2x1ZGUgaW5kZWVkLgoKQWN0
dWFsbHkgYm90aCBhcmUgbm90IGNvcnJlY3QsIGJ1dCB0aGUgZmlyc3QgaW5zdGFuY2UgKGF0IHRo
ZSB0b3ApIGlzCmV2ZW4gbW9yZSBpbmNvcnJlY3QuCgo+ID4gUGxlYXNlIGNvbnZlcnQgdGhpcyBw
YXRjaCdzIG1haW4gaW50ZW50IHRvIGFscGhhYmV0aXNlIHRoZSBoZWFkZXIKPiA+IGZpbGVzLiAg
VGhlbiB5b3UgY2FuIHJlbW92ZSBhbnkgb2J2aW91cyBkdXBsaWNhdGVzLgo+IAo+IEkgY2FuIGFs
cGhhYmV0aXplIGl0IGluIHYyIGlmIG5lZWQgYmUuCgpZZXMgcGxlYXNlLgoKLS0gCkxlZSBKb25l
cyBb5p2O55C85pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDi
lIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vi
b29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
