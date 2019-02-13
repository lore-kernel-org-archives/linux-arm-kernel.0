Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EEAC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:20:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF6F21934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X5FAvNJA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ffWS8VD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF6F21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1UOsAcR4RyysclZZthGDF/4MupHP8uH3wXPhZ6/6AK0=; b=X5FAvNJALI0qJp
	x+C3s/DYtH6IscAHCBD/hmQdR64gy3TCcnrfZ+1/vSFOticZ2GNcZb4E1ZZTB//YXQth0eXLEA+W+
	rggPk6FVyQnnHL2fldLGPngJKRhzW4Q0reOzgsXj+TX15kLFsXizRixB8uvBjIDcjEVUuGdADj5zu
	B48E2RWlof49joVbO4xdUHqw4NY2/GCmosczK78+nDCspW2AUBj0NwBGmldmmEL5DXFrXWGv0IJEv
	qypj/Dtjk6iozv15OF/cFCQ8kbZUPfxBFCnFCBE1/EusLvtSk9FS/tYspDtLi/vRt7+R52cdkauMq
	6OCCr/wuOp7o0nwCWHqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtl6B-0002LF-Eb; Wed, 13 Feb 2019 03:20:35 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtl67-0002K9-A4
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 03:20:32 +0000
Received: by mail-ed1-x544.google.com with SMTP id b20so657240edw.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 19:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oa898J5DYixPpvrXehNIzm+uZ1BeIMAqjC27Zoi9YxY=;
 b=ffWS8VD8LmmK7FtwFSnp21AiBXDQUX32HbDtodD5sxBqnX5tQsX0m671sqeB4M+H4S
 LQ2Xk4BsfGjZuFyOeDCN85TPo2wxUZXsrTa0UKMlbzCVNlBFeIOeoFlzPdxN/axq6Ypk
 Fp9S6jxuuIb3Pv4EgY6TY8H2PHF4rNLMhK8EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oa898J5DYixPpvrXehNIzm+uZ1BeIMAqjC27Zoi9YxY=;
 b=lYPLc47tygYJB0Br8ppVMoOPAzd2/HFRQHtmYIdw/cBNi6IQTVi8ZX5nGbR5a43+pP
 9I3MWt6XWuBinpmdhXMhSJNs8RYCO3XVgMPudO3tRv/xaDqZ505FDVpQVvOF2PibuwhF
 y94jXc1+qPiJ8NaltoCy1P+by2q0d88FYEqb9PpYffHZAg0F1py0riO7PF5vL30prVik
 W0M4PQQi2uqAaNoVcCK01M7JZSBaeJ0knidTxsjtnmvG5ys4sGrPxtUbK6IIOAFiKLC1
 v8duAIhfjwuYjGLKAtoMJLDNzC4Z+LoL33CNL3xeisKGMYhhhRi1m1jHeI/hzgSunQ2O
 w+ZQ==
X-Gm-Message-State: AHQUAubNHHOE+MHlg0M2D5NyvFNt6wmRkD/77/LABC5cPaTMnR7uXah1
 42gN/jPLxoLjnvC7M2d5uz/h404g/NqoqzpzTcU3ig==
X-Google-Smtp-Source: AHgI3IbIqqpIwr7rOgFbnQ5uyhJSN2OLeEbQXznz8l9cspkSuxqjvM5RlVEu0GqMwyEzqt1t1qmTWkjGGoI4xRL+sg4=
X-Received: by 2002:a50:9908:: with SMTP id k8mr5319525edb.246.1550028029818; 
 Tue, 12 Feb 2019 19:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20190131093131.245531-1-pihsun@chromium.org>
 <20190131093131.245531-3-pihsun@chromium.org>
 <20190202001749.GT81583@google.com>
In-Reply-To: <20190202001749.GT81583@google.com>
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Wed, 13 Feb 2019 11:20:18 +0800
Message-ID: <CANdKZ0ds2s46h-Rs-4aJSuVFkoaeEzXi96m2zbx5XjBhhsc3Xw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] remoteproc/mediatek: add SCP support for mt8183
To: Matthias Kaehlcke <mka@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_192031_354593_3A02DCBA 
X-CRM114-Status: GOOD (  14.40  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpUaGFua3MgZm9yIHRoZSByZXZpZXcsIHdvdWxkIGFkZHJlc3MgbW9zdCBjb21tZW50cyBp
biBuZXh0IHZlcnNpb24gb2YgcGF0Y2guCgpPbiBTYXQsIEZlYiAyLCAyMDE5IGF0IDg6MTcgQU0g
TWF0dGhpYXMgS2FlaGxja2UgPG1rYUBjaHJvbWl1bS5vcmc+IHdyb3RlOgo+Cj4gSGkgUGktSHN1
biwKPgo+IGEgZmV3IGNvbW1lbnRzIGlubGluZS4KPgo+IEl0J3MgdGhlIGZpcnN0IHRpbWUgSSBk
YWJibGUgaW50byByZW1vdGVwcm9jLCBJIGRvbid0IGNsYWltIHRvIGhhdmUgYQo+IGNvbXBsZXRl
IHVuZGVyc3RhbmRpbmcgb2YgdGhlIGRyaXZlciBhdCB0aGlzIHBvaW50IDstKQo+Cj4gT24gVGh1
LCBKYW4gMzEsIDIwMTkgYXQgMDU6MzE6MjdQTSArMDgwMCwgUGktSHN1biBTaGloIHdyb3RlOgo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMgYi9kcml2ZXJzL3Jl
bW90ZXByb2MvbXRrX3NjcC5jCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXggMDAw
MDAwMDAwMDAwMDAuLjkyMGM4MWMzNTI1YzJhCj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi9k
cml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jCj4gPiArICAgICAgICAgICAgIHJldHVybiByZXQ7
Cj4gPiArICAgICB9Cj4gPiArCj4gPiArICAgICB3cml0ZWwoMHgwLCBzY3AtPnJlZ19iYXNlICsg
TVQ4MTgzX1NDUF9TUkFNX1BETik7Cj4KPiB3aGF0IGlzIHRoZSBwdXJwb3NlIG9mIHRoaXMgd3Jp
dGU/Cj4KCkFuc3dlciBmcm9tIEVyaW46ClRoZSBjb2RlIG5lZWRzIHRvIGV4ZWN1dGUgb24gc2Nw
4oCZcyBTUkFNLgpXZSBuZWVkIHRvIHR1cm4gb24gdGhlIHBvd2VyIG9mIFNSQU0gYmVmb3JlIHVz
aW5nIGl0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
