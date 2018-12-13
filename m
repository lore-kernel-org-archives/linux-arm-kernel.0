Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DFFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D609620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cct053nE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKUk4+P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D609620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xTklly9fBVGxgKlMY443oDq/djILvwQ+GqlxfrUmnvM=; b=cct053nEu2fu+e
	7FxI+Q1ZO6E+pD1VU/QSugkYjwl/PU4Vsi7MCuw/tD0qas0uBsVNBY7xIwwKQ/uuFGfiviElPlhEC
	qj4N7GJfl3Px0/RG9OubkZHHgHAaFOi33UJRK9f4lh70RsSd81X66AGPxlL/1g1Oy8Ie6PaNYScdL
	2SXOEhvm4ePHINBcj4u5jsHHR7mll7SQ2Kbzn+mDEax9XjMY1d6/UMfnhwJAp15F3hB1emEUCsI1/
	5pTYy8JbJib0LUpVuWpz9fI15mZtUcerNvrQINNO8/shwTWDcfLUb472YpAYKHpXduUKCAzB7BP/b
	nZv0fVqwJfTpeyvwRkoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSOi-00009H-1j; Thu, 13 Dec 2018 14:55:32 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSOe-00007L-Tc
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 14:55:30 +0000
Received: by mail-oi1-x241.google.com with SMTP id i6so1827930oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9GKZLyw8Tsi2H28DYl8UXYAAaKkAjbPWskKtZyOh9G8=;
 b=FKUk4+P0pxH6PK22ehaj73WLo4KvQcVwDMDjManW1IlYWEytNFYPQ5PaHa1vFfeif+
 0O8fuhIomwa+5Y6j7eFa+BmgAX714krm3IOMrNva3bV+CN/kkx0DCGsVAae20p4txw9O
 wIaJVTgLe6MvWSJrc0OPdjlwui8+6qMHYuTuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9GKZLyw8Tsi2H28DYl8UXYAAaKkAjbPWskKtZyOh9G8=;
 b=Pmjq4XhbR+oDIO5FMq2vYydj7DHwS+BHciJUH7aBfbzme2y8csjFB5viYimQbJnlnO
 7DR1fFAj03GSE0t3125WJsHCY6KKkH84Epjyax+yXg5brA/s+EIzIdk0EvF6lrcyvlvj
 CvyiS3/VPIuiISAgdqMHF7kyqbUlDfyBluM0XVMUrh11MOnmbb/LNFLmTXMbw4zaL02E
 C36xdh8wxe+Ll5MNFRxd8mFX42Vt0aXPcQacDo/9VXciFP6pbQw2OPKSv/8SxweKfAvM
 qmiAInMo/uXKvDJPt3R2Lwmq+SiTv6o2N9XnodCYDRB2nViq/kvJVhJ5ZhgJ3bVC/7zx
 HzFA==
X-Gm-Message-State: AA+aEWZVTPHEXCG6jSvIPiWfQqGbiZwheTx8fdcq9JKnkT4M9hb+8a4N
 SK0rwE36W619bWhWVfz5/3FyeNAcIZ02yhLWZV764w==
X-Google-Smtp-Source: AFSGD/XZINnaYrZaKDRX+XrDukik22z98xW7s0K7QilpVFTtPD7+xnxHDBQDWBpRtjmChb0WgOOVNp7QLOrUsEC1bAk=
X-Received: by 2002:aca:2ccc:: with SMTP id s195mr3114794ois.282.1544712917470; 
 Thu, 13 Dec 2018 06:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
 <20181113144805.1054-2-benjamin.gaignard@st.com>
 <20181204204733.GA14508@bogus>
 <64704359-d4ec-4a63-72cc-4d0a036bce8a@arm.com>
In-Reply-To: <64704359-d4ec-4a63-72cc-4d0a036bce8a@arm.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 13 Dec 2018 15:55:06 +0100
Message-ID: <CA+M3ks5LtxZpwvx5+p9qLTWed6yb-Vo0dZ3VHFKsGcJZROEqtQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: stm32: Document
 hwlock properties
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_065528_959729_4A08C589 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin GAIGNARD <benjamin.gaignard@st.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Alexandre Torgue <alexandre.torgue@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgamV1LiAxMyBkw6ljLiAyMDE4IMOgIDE1OjIzLCBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2ll
ckBhcm0uY29tPiBhIMOpY3JpdCA6Cj4KPiBPbiAwNC8xMi8yMDE4IDIwOjQ3LCBSb2IgSGVycmlu
ZyB3cm90ZToKPiA+IE9uIFR1ZSwgTm92IDEzLCAyMDE4IGF0IDAzOjQ4OjAzUE0gKzAxMDAsIEJl
bmphbWluIEdhaWduYXJkIHdyb3RlOgo+ID4+IEFkZCBod2xvY2tzIGFzIG9wdGlvbmFsIHByb3Bl
cnR5Cj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4u
Z2FpZ25hcmRAc3QuY29tPgo+ID4KPiA+IFNob3VsZCBiZSBsaW5hcm8ub3JnIFMtby1iPwo+Cj4g
V2hhdCBpcyB0aGUgc3RhdHVzIG9uIHRoaXM/IEknbSBub3QgZ29pbmcgdG8gcXVldWUgaXQgaWYg
dGhlcmUgaXMgYQo+IGRvdWJ0IG9uIHRoZSBTb0IuLi4KCkkgd2lsbCBmaXggdGhhdCBpbiB2ZXJz
aW9uIDIgKGV2ZW4gaWYgSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB0aGUgaXNzdWUpCgpCZW5q
YW1pbgo+Cj4gVGhhbmtzLAo+Cj4gICAgICAgICBNLgo+IC0tCj4gSmF6eiBpcyBub3QgZGVhZC4g
SXQganVzdCBzbWVsbHMgZnVubnkuLi4KCgoKLS0gCkJlbmphbWluIEdhaWduYXJkCgpHcmFwaGlj
IFN0dWR5IEdyb3VwCgpMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJN
IFNvQ3MKCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
