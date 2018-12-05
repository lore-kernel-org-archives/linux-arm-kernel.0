Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEE1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:21:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB672064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IaS9mf94";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq+iUBmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB672064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2PDGfzthptJRn3Edq1P1kD3Qj7bOH1X7ZdLuXUEVD1Y=; b=IaS9mf94h7RqiF
	E496mVYJQ3WtoXie1jdhU1w9FWa6/qnbD5BYpY4ociP1CafmNlR0VXbWEsE+CGHgOZklZK5e8VLPV
	MpvI0gIpDVB8TIZ3uXEAOGBLgBiV0W0FScXBP+XwfPj6Yf+8CIfHewiEl+M7kw8/PXlBa28xika/x
	8SiaMgfzzer4Hs4rcaehkYSrmFzhUNIQZjMiu8y0YDdwBuC99eCDNOjb41JDBdu+M2NqvPJqu/9wZ
	YvLr1U2KqLGDFg8CFAScNTY8ukJ8VDrD1go796/HDs1a0Z67UI+VFsoMfsNvONWG6p+l6ATcQ3rLg
	gbHX7c7f1cbOfQgykzDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZvo-0007dE-F1; Wed, 05 Dec 2018 16:21:48 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZvg-0007R0-EB
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:21:46 +0000
Received: by mail-it1-x143.google.com with SMTP id b5so21080173iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nduLlnBo/Uywkt7yTjD99E0aRSNQV7XfrKlh9WL4JGs=;
 b=nq+iUBmCfUSArwFPeRVf30/zz/zZCCroLWlbaYxDyHgEJP3Q0BczOvHd91r13Ogjh7
 rRFmgg0xhqepDV4e/4DAiZkdvYDBH/69dxH1EiyoW+AQcT5xZvxPpJD2NjnXZlJB3Byi
 cipzIZRClcjJmJam3e2BYJRvNEh1ifuHu2aY4zdyBZ8aw/E+g2f+Kj457BeA7a8Hubf0
 24kVpTy/qbWA1w+PCVSxLKs4O/z/MMBOZVbc8H3aA7+FPDjxcn0Ov9/FqsR5jtOPTQbP
 vWl4Vahr9Lcpd7o2EXT8xL/DlSw25TcrX0XC2hj/i5JaeYXIORutPuirvTtXGckEqUNt
 Hh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nduLlnBo/Uywkt7yTjD99E0aRSNQV7XfrKlh9WL4JGs=;
 b=Phu7KzAcAhlMPX/RypRNozR9nvK8g1ep4ejyYHO/0ATTG3KZzm8kPXNzFhHWX/b2Fh
 adnW0Ihxm/vsZu2UX33tiwCJyg+obtiVNoeJ16trF463hx9PODqYRS8M1yGkWaDifzvv
 VGYJ15bPl5+kpjCHgPaMZJ0RXRzXsqYjvr+cclOT8jzcd+4LUtuIg5nLJS+FUOwwi6QU
 jkav1NU6QPUUzUad8Cf9SWDFjTtswiVGEczV3xoFhQTvWVOVt0zTKMo5jsJiWV/R+sF0
 0gT23eizOeZSAkZsG+hmKb997f3cybhDgYqzFSzU1VOVCcTyZaL03ET+aZkNN0qLRkv+
 Wgyw==
X-Gm-Message-State: AA+aEWZcRabDADSfa5A+qjh3TaZKcrS5sFtZeZ6/soJyuInNSPtvKSYD
 fqDuNn8s+/fBQ1EVWHkhyU7JmffTZSs3jTm1p24=
X-Google-Smtp-Source: AFSGD/WjC2Ge3pbLrupBxazf8RTz355OinquUWHktsr9na4GGCKhAyL6bwvlST/f2BJKxAHU9+wpy6bDPFppE93sw4w=
X-Received: by 2002:a02:6c90:: with SMTP id w138mr22442031jab.60.1544026889461; 
 Wed, 05 Dec 2018 08:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
 <20181205082719.GF2847@vkoul-mobl>
 <CAEExFWu1ahDPqKbYWKPY_bQuw=1Kp1gUki+CpQ7Mq5sNNiy_tg@mail.gmail.com>
 <20181205155912.GP2847@vkoul-mobl>
In-Reply-To: <20181205155912.GP2847@vkoul-mobl>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Thu, 6 Dec 2018 00:21:06 +0800
Message-ID: <CAEExFWs6vFswAw6nwF8+0o8WRnin1Rk3bFHiMeJqTP1EsikVTg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
To: vkoul@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_082140_476125_BE961236 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: linux-soc@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, okaya@kernel.org, sudeep.dutt@intel.com,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 ashutosh.dixit@intel.com, David Brown <david.brown@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
 dan.j.williams@intel.com, robert.jarzmik@free.fr, daniel@zonque.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgNSwgMjAxOCBhdCAxMTo1OSBQTSBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwu
b3JnPiB3cm90ZToKPgo+IE9uIDA1LTEyLTE4LCAyMzo0OSwgRnJhbmsgTGVlIHdyb3RlOgo+ID4g
T24gV2VkLCBEZWMgNSwgMjAxOCBhdCA0OjI3IFBNIFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5v
cmc+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiAzMC0xMS0xOCwgMTA6NDIsIFlhbmd0YW8gTGkgd3Jv
dGU6Cj4gPiA+ID4gV2UgYWxyZWFkeSBoYXZlIHRoZSBERUZJTkVfU0hPV19BVFRSSUJVVEUsVGhl
cmUgaXMgbm8gbmVlZCB0byBkZWZpbmUKPiA+ID4gPiBzdWNoIGEgbWFjcm8sc28gcmVtb3ZlIERC
R0ZTX0ZVTkNfREVDTC5BbHNvIHVzZSBtYWNybyB0byBzaW1wbGlmeSBzb21lCj4gPiA+ID4gY29k
ZS4KPiA+ID4KPiA+ID4gU3BhY2VzIGFmdGVyIGZ1bGwgc3RvcCBhbmQgY29tbWEgcGxlYXNlCj4g
PiA+Cj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5ndGFvIExpIDx0aW55LndpbmR6
ekBnbWFpbC5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvZG1hL2FtYmEtcGwwOHgu
YyAgICAgfCAxNCArKy0tLS0tLS0tLS0tLQo+ID4gPiA+ICBkcml2ZXJzL2RtYS9taWNfeDEwMF9k
bWEuYyAgIHwgMjIgKysrLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiA+ICBkcml2ZXJzL2RtYS9w
eGFfZG1hLmMgICAgICAgIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gPiA+ID4gIGRy
aXZlcnMvZG1hL3Fjb20vaGlkbWFfZGJnLmMgfCAzMyArKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiA+ID4KPiA+ID4gRG8geW91IG1pbmQgc3BsaXR0aW5nIGl0IHBlciBmaWxlLgo+
ID4gSGkgVmlub2Q6Cj4gPgo+ID4gV2h5IG5vdCBhcHBseSBpdCBvbmNlIO+8n1RoZSBjaGFuZ2Ug
aXMgbm90IHRvbyBiaWcuCj4KPiBJdCBpcyBub3QgYWJvdXQgYmlnIG9yIHNtYWxsLiBBIHBhdGNo
IHNob3VsZCBkbyBvbmUgdGhpbmcgYW5kIHRvdWNoIGEKPiBzaW5nbGUgbW9kdWxlLgo+Cj4gSXQg
YWxzbyBoZWxwcyBwZW9wbGUgd2hlbiB0aGV5IGxvb2sgYXQgY2hhbmdlcyBhbmQgYmFja3BvcnRz
LgpBbHJlYWR5IGRpdmlkZWQgaW50byBzbWFsbCBmaWxlcywgYXMgeW91IG5lZWQuCgpNQlIsCllh
bmd0YW8KPgo+IC0tCj4gflZpbm9kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
