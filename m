Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0FDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D842C222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qXKcVKTF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDtFvFc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D842C222D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TZD5Q/Jso87iav+L7wnZs2qHND+Fj2qnTcyYmCKqQ5E=; b=qXKcVKTFS8hITf
	/tLGpIdl/hMzlmkADTq3XtDBqDK3FLdL74tniNJ+F7EpIyCDC+MbSKTlUBHzLu5N5o8LKVztQqQfm
	Mw6nI8x8BXwSEpUA3X+3CctuYP8DY3TRwdsupQxK56Kq2riQVA9uLaYiiCgyjDsstu0vxeft/BF6Z
	KokprsOWyeT34rvvNHKV65XUyQwjUV6Q2DFNYQX4ChEfiE+5IdiEuVGNvJ17T7KULMuxvo4D+h6hG
	HG5yyO+zezeJ4BopWSUh+eRIoC4ekK2zo3tX6DQuLeD2bCa24B9a/RnHmPCwHVdj002pFUoNzcD1X
	7JgGRZzlzwuekUn4ypRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guHw6-0000j4-VY; Thu, 14 Feb 2019 14:24:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guHw3-0000ih-MM
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:24:21 +0000
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 46BC4222D7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550154259;
 bh=ZviCB4UK+yPmuMDh7PuGrRRgjNrg+f4+Z5wYwmTpiVU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=vDtFvFc83qDStPyHEZLUlwUrpwWXv74xEIrNY/2b3RNdd2MhFRWIdFWRFtahgoUFc
 i3L0Ezh0zr18lZflRFlepGVeddLxITeJVwKNL0IHH+XswCSQG8vNQnJhxTnxbyUzX9
 pH0HivZPJZ4QmNa/jhgJP2KbHnD14XeC5nOXKn0c=
Received: by mail-qt1-f171.google.com with SMTP id v10so6982653qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:24:19 -0800 (PST)
X-Gm-Message-State: AHQUAua16lkAVxAZs4VpTrvk99riGxJl9LwJGLwdTkILYHNKL8CIA+LR
 rDR0UvzLbdWjxPkHEJF7P3s23lPHXL/shZp1pA==
X-Google-Smtp-Source: AHgI3IaAqyV0Bi9f8MwikDZm6bMdc94+avjRW4HSg1PgsYazr6lpxXVkrHs76nh+5S5uNjuJQGCucf7rkxY5jC/iQnc=
X-Received: by 2002:ac8:4548:: with SMTP id z8mr3116552qtn.257.1550154258491; 
 Thu, 14 Feb 2019 06:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-6-robh@kernel.org>
 <CGME20190213161024epcas3p3acc5c074714ad1d44fb90ab3f21cfcff@epcas3p3.samsung.com>
 <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com>
 <5cc4b5a3-c4ad-46a9-2856-3ed67c6755d3@samsung.com>
In-Reply-To: <5cc4b5a3-c4ad-46a9-2856-3ed67c6755d3@samsung.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 Feb 2019 08:24:07 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+hoRE5UG3+Z9OKDc3xmkJbGgQpUF+M4pzXJ_BSjj0kfg@mail.gmail.com>
Message-ID: <CAL_Jsq+hoRE5UG3+Z9OKDc3xmkJbGgQpUF+M4pzXJ_BSjj0kfg@mail.gmail.com>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
To: Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_062419_749638_9B40AB73 
X-CRM114-Status: GOOD (  17.42  )
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
Cc: devicetree@vger.kernel.org,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBGZWIgMTMsIDIwMTkgYXQgOTo0OSBQTSBDaGFud29vIENob2kgPGN3MDAuY2hvaUBz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4KPiBIaSBSb2IsCj4KPiBPbiAxOS4gMi4gMTQuIOyYpOyghCAx
OjA5LCBSb2IgSGVycmluZyB3cm90ZToKPiA+IE9uIFdlZCwgRGVjIDUsIDIwMTggYXQgMTo1MCBQ
TSBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiB3cm90ZToKPiA+Pgo+ID4+IENvbnZlcnQg
c3RyaW5nIGNvbXBhcmVzIG9mIERUIG5vZGUgbmFtZXMgdG8gdXNlIG9mX25vZGVfbmFtZV9lcSBo
ZWxwZXIKPiA+PiBpbnN0ZWFkLiBUaGlzIHJlbW92ZXMgZGlyZWN0IGFjY2VzcyB0byB0aGUgbm9k
ZSBuYW1lIHBvaW50ZXIuCj4gPj4KPiA+PiBGb3IgaW5zdGFuY2VzIHVzaW5nIG9mX25vZGVfY21w
LCB0aGlzIGhhcyB0aGUgc2lkZSBlZmZlY3Qgb2Ygbm93IHVzaW5nCj4gPj4gY2FzZSBzZW5zaXRp
dmUgY29tcGFyaXNvbnMuIFRoaXMgc2hvdWxkIG5vdCBtYXR0ZXIgZm9yIGFueSBGRFQgYmFzZWQK
PiA+PiBzeXN0ZW0gd2hpY2ggYWxsIG9mIHRoZXNlIGFyZS4KPiA+Pgo+ID4+IENjOiBDaGFud29v
IENob2kgPGN3MDAuY2hvaUBzYW1zdW5nLmNvbT4KPiA+PiBDYzogTXl1bmdKb28gSGFtIDxteXVu
Z2pvby5oYW1Ac2Ftc3VuZy5jb20+Cj4gPj4gQ2M6IEt5dW5nbWluIFBhcmsgPGt5dW5nbWluLnBh
cmtAc2Ftc3VuZy5jb20+Cj4gPj4gQ2M6IEt1a2ppbiBLaW0gPGtnZW5lQGtlcm5lbC5vcmc+Cj4g
Pj4gQ2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4KPiA+PiBDYzogbGlu
dXgtcG1Admdlci5rZXJuZWwub3JnCj4gPj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwo+ID4+IENjOiBsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5vcmcKPiA+
PiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgo+ID4+IC0tLQo+
ID4+ICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS1ldmVudC5jICAgICB8IDIgKy0KPiA+PiAgZHJp
dmVycy9kZXZmcmVxL2V2ZW50L2V4eW5vcy1wcG11LmMgfCAyICstCj4gPj4gIDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+IENhbiBzb21lb25l
IGFwcGx5IHRoaXMgcGxlYXNlLgo+Cj4gTXl1bmdqb28gcGlja2VkIHVwIHRoaXMgcGF0Y2hbMV0g
b24gZGV2ZnJlcS5naXQKPiBidXQgaGFzIG5vdCB5ZXQgc2VudCB0aGUgcHVsbCByZXF1ZXN0LgoK
T2theSwgdGhhbmtzLgoKUGxlYXNlIGFkZCB0aGF0IHRyZWUgdG8gbGludXgtbmV4dCBvciByZXBs
eSB0byBwYXRjaGVzIHdoZW4gdGhleSd2ZQpiZWVuIGFwcGxpZWQsIHNvIHN1Ym1pdHRlcnMgaGF2
ZSBzb21lIHdheSB0byBrbm93IHdoZW4gdGhlaXIgcGF0Y2ggaXMKYWNjZXB0ZWQuCgpSb2IKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
