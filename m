Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:55:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15ABA20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YenIoude";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7MkJFAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15ABA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n9TnCI7uaE9lCaSXovtjMkOxqZ50pnIigGZAPSNdBKA=; b=YenIoudelUrkn0
	DAIbxY+hdloRYzK/JxSbj6w+mfJUr3pzJHaYvupHfF7WUcK62SuwIAZQILrDujnHXFcankfos4843
	Pdjtyj5Z3phfKHouTM8hqduFOMeVYpadfuVD7EvfoI44s4T0BDOIck45IsfjpxIXmuzgF9frV2rzM
	SGOurepwQOeXy9/qMnTWpfosU+ykODEEMtzUh1TtkgjzLyqP/R5KvcG6GVdbXttGbIVOkGysxVMrj
	zo+1mLhOOelzIhjJTdk3LoQk9xbbkPlEJ5HVymT49y03Icc5g71meDGpRJjn54zGUJoCnvN7KUy+n
	RZ14s2aQ6QCy72dP5PHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwk8r-0003Cq-5F; Thu, 21 Feb 2019 08:55:41 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwk8n-0003CV-Pc
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 08:55:39 +0000
Received: by mail-qt1-x841.google.com with SMTP id z25so8886591qti.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 00:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0YDfOgyjbgd8RDB/ZLVqE90tU6o8kZmnDzMINTJVMN0=;
 b=L7MkJFANTQLzfJiQYU0xOWbNWDpuF9AQvONbCeKjb9OtF87Zg/+sS91UqdnNf2X1IN
 mwvbsqu+ui2HyoR7AgLbohgjRCuhHur57VhoekoC+ClkcLjiHWijlhUq/m0AHrjB/chv
 Jl5KUMP8LYVZ2pTgju3PbyGBAbSx+7aj1x8fersKhpsOtcgwHAvP7PIOLmWbfdoC7NkC
 E5Bpl7fQ46QDeflB5mC//5SkE5+mNpi2B8JWejcMftwWa7wJZbqXjCmAcmLGkonUZFZO
 9YrFKOjlmqvUOJp8Iyy9U77drmNT3xlf+kTsirK+HTP+2A4Yd2JKd9JagcBK/o3/p72d
 H/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0YDfOgyjbgd8RDB/ZLVqE90tU6o8kZmnDzMINTJVMN0=;
 b=XLJlZ8QOmUXYOMj44c1iNO9EDFjEACQq4KhWp6EfMpLxq1Z8DT4ikTjMgszafRACje
 KNQ4PM2y0+nn9WuSglvjx45deacKJbAEmUog2r99wodjMdsMrwyl+DcHrzQJzx4Rlr5S
 Buo9ewrrGHAks+D/dL0XkAtEeEFtPgHohAuGekCM3ZLJBrutLdF2PzrfsQ0PIU2GqSY8
 c7RbpofNCRRwOxM3w4mlU4ilgc1Bt49ZAhBUC5eXUV+5XfEitt0NT8b3Qw2YZei5MQL2
 seWiaie7rSo5yvs72vCREMQ+RO9MvszNgmK3k5e7OUwVkjSSCWvLEqRmqhZbys11zLPF
 G0Hg==
X-Gm-Message-State: AHQUAuaq3jpQV2GESshf/CopBvwruHe6bD1wxRu7P18Wxbm059KtYiV2
 SEb1s+EmcKgS6v2CdlWSDLfYW8qMwCgZySseCi/Fgw==
X-Google-Smtp-Source: AHgI3IbDsY2SK4Kf7YRnlsiNbYD5X+HKuxyMu5ko5kGc3/Sqfqw+ohmnVp1pApC5GBaCHXwgFOsOm1ZSUzHfDQ24YMo=
X-Received: by 2002:ac8:2de4:: with SMTP id q33mr29906813qta.358.1550739336331; 
 Thu, 21 Feb 2019 00:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-15-linus.walleij@linaro.org>
 <CAMpxmJU+fmum=AP1_n0W4SaD0HuLPP67qTPO_n9WU-vWeNuSSw@mail.gmail.com>
In-Reply-To: <CAMpxmJU+fmum=AP1_n0W4SaD0HuLPP67qTPO_n9WU-vWeNuSSw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Feb 2019 09:55:24 +0100
Message-ID: <CACRpkdYBm5h3Q=A2ibYH=jPc_SAA9vzz_msuTQpK_7a-gx5etA@mail.gmail.com>
Subject: Re: [PATCH 14/17 v1] gpio: ixp4xx: Add OF probing support
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_005537_838391_349076B1 
X-CRM114-Status: GOOD (  16.92  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Tim Harvey <tharvey@gateworks.com>,
 Krzysztof Halasa <khalasa@piap.pl>, Olof Johansson <olof@lixom.net>,
 Imre Kaloz <kaloz@openwrt.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBGZWIgNiwgMjAxOSBhdCA1OjEzIFBNIEJhcnRvc3ogR29sYXN6ZXdza2kKPGJnb2xh
c3pld3NraUBiYXlsaWJyZS5jb20+IHdyb3RlOgo+IG5pZWR6LiwgMyBsdXQgMjAxOSBvIDIyOjQy
IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4gbmFwaXNhxYIoYSk6Cj4g
Pgo+ID4gVGhpcyBhZGRzIGRldmljZSB0cmVlIHByb2JlIGFuZCByZWdpc3RyYXRpb24gc3VwcG9y
dCBmb3IKPiA+IHRoZSBJWFA0eHggR1BJTyBkcml2ZXIuCj4KPiBXaGF0IGlzIHRoZSByZWFzb24g
Zm9yIG5vdCBtZXJnaW5nIGl0IHdpdGggdGhlIHBhdGNoIGFkZGluZyB0aGUgZHJpdmVyPwoKU2lu
Y2UgSSBhbSBub3QgYWRkaW5nIGEgbmV3IG5ldmVyIGJlZm9yZSB1c2VkIGdwaW8gZHJpdmVyCmJ1
dCByZWZhY3RvcmluZyBhbiBleGlzdGluZyBzeXN0ZW0sIEkgbmVlZCB0byB0YWtlIG9uZSB0ZWNo
bmljYWwKc3RlcCBhdCB0aGUgdGltZSBmb3IgYmlzZWN0YWJpbGl0eSBhbmQgcmVhZGFiaWxpdHku
CgpJZiBJIHdhcyBhZGRpbmcgYSBkcml2ZXIgZm9yIGEgdG90YWxseSBuZXcgc3lzdGVtIGluZGVl
ZCBpdCB3b3VsZApiZSBpbiB0aGUgc2FtZSBwYXRjaC4KCj4gPiBAQCAtMzgxLDExICszODMsMjcg
QEAgc3RhdGljIGludCBpeHA0eHhfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQo+ID4gICAgICAgICAgKiBmcm9tIElSUUNISVBfREVDTEFSRSgpLCB0aGVuIHVzZSBvZl9u
b2RlX3RvX2Z3bm9kZSgpIHRvIGdldAo+ID4gICAgICAgICAgKiB0aGUgZndub2RlLiBGb3Igbm93
IHdlIG5lZWQgdGhpcyBib2FyZGZpbGUgc3R5bGUgY29kZS4KPiA+ICAgICAgICAgICovCj4KPiBJ
cyB0aGlzIGNvbW1lbnQgc3RpbGwgdmFsaWQgYWZ0ZXIgdGhpcyBwYXRjaD8gIE9yIGlzIHRoaXMg
bWF5YmUKPiBpbmNvbXBsZXRlIERUIHN1cHBvcnQgKHByb2Jpbmcgb25seSk/IElmIHNvIGl0IG5l
ZWQgY2xhcmlmeWluZy4KCldlIGFyZSBzdXBwb3J0aW5nIGJvYXJkIGZpbGVzIGFuZCBkZXZpY2Ug
dHJlZSBpbiBwYXJhbGxlbCBkdXJpbmcKYSB0cmFuc2l0aW9uIHBlcmlvZCwgdGhlIGRyaXZlciBo
YW5kbGVkIGJvdGggc3RhdGljIGFuZCBkeW5hbWljCmFzc2lnbm1lbnQgKGhlbmNlIHRoZSBjb21w
bGV4aXR5KS4gVGhpcyBpcyB0aGUgdHlwaWNhbCBtZXNzCndpdGggY29udmVydGluZyBvbGQgc3lz
dGVtcyBpbiB0byBuZXcgb25lcywgYSBmZXcga2VybmVscyBkb3duCnRoZSByb2FkIHdoZW4gYWxs
IGJvYXJkZmlsZXMgYXJlIGNvbnZlcnRlZCB0byBkZXZpY2UgdHJlZXMKdGhlIGNvbXBsZXhpdHkg
Y2FuIGJlIHJlbW92ZWQuCgpCdXQgaXQgc2hvdWxkIG5vdCBzYXkgImFmdGVyIGFkZGluZyBPRiBz
dXBwb3J0IiBidXQgcmF0aGVyCiJ3aGVuIHdlIGFyZSB1c2luZyBPRiBleGNsdXNpdmVseSIuCgpZ
b3VycywKTGludXMgV2FsbGVpagoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
