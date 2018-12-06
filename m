Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:11:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DF321479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mAubuT1X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XParHtd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DF321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ye4fudKpS17bjVt80K4zRWh1KclmE16Zr3LjdXqKj4c=; b=mAubuT1XBSlTpq
	p4sxIajpZ1HiJRPwk+ldlThefo6daPlDj9lP4wQ6w3nhnyU1FQVqL4thhYyt6P3MkIni5d0u8dUzn
	b27Si89rcVAoSgBpqYHj3wNw5BBOZlltRCPSka9pjCL1otuvII3TwSdaMnYdnApxQvLE/oZvcwHVL
	xqbVN9xwL28qNBtBOgQB9d2DrFCsIuxf0yTFH00ot7x+dOWMx4ZhpmnugWY3DkzWAcHGFei8I57S3
	4ukKAZUeuGYXh+aW6JzGchlKLO/eNyy+XS8+QNIntM6qsVEKiPlXxGuYW03bLO2tNhokG1shkJRYz
	jdDdo9iAOGdwYkQEQHXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUpgh-00026D-Cz; Thu, 06 Dec 2018 09:11:15 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUpgd-00025M-AY
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:11:12 +0000
Received: by mail-oi1-x241.google.com with SMTP id c206so20125585oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 01:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OkFya+LvZuwwjtMnxth+NO6mwN8h2pWDKcOwBP9BysA=;
 b=XParHtd52lOLNOnbWk0D0nST1hHeRzxG1xpdHdNkE9Yb3gtPneWOwZooOdvUaYW86X
 lmx4sLPyoMrt8tk2ey585WPF/bqHLUOJn8KbH+Y4v7+aTOv9OX5Y/kSaIrtLR9A8vWJl
 4ELtC6bKrmxi2PFqmVw/8oCbUMMIqLCaq5vCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OkFya+LvZuwwjtMnxth+NO6mwN8h2pWDKcOwBP9BysA=;
 b=PUwe3iwrjhtSBRK/Vyx9khyJiXHBnZFdjzU8enPGvUm9tU+2WGLL9TLwWSEkvG6dsc
 v+pFDHXD+wlOEOR5Wh28Kfm3PwzxIALL+SEM8d7AIYuAJiTwbtS6jSeUHfuaOusgpv1q
 ui67TJpncYP9mRR49Dck5Xrotz7/xnL3FEAeEKMfZCeCMiMtJ5g6BqqoUd/AMAJqYHPP
 vrK+3qEwqOq+MpLMLr0Vuru10TkJo/e9yecL/9BOqaIITXtf/HEFLBkQkfGaZhDV4J4f
 wiaGBBacKmaft8AS39HAHJAUDLUySRNBK27XliYE9Kz6w4lNDN86cWeAjxAnO2PlaepX
 ZyCw==
X-Gm-Message-State: AA+aEWYDBZR68M2BlYDV2+TWwVJcy/cwH9Sj3A1tGaz9zy8n7Zzk/I+L
 7cdJt15lT/5NV6CIWeP6ZErQ45P3nKLw1HeIYHdlSQ==
X-Google-Smtp-Source: AFSGD/V5kI/9KgVWzMk0CoBDzREHKEV8VtER11k0UdWhY4RcgQZ7SiJBBvBNi7bu7+Em8ZfX4gIFbWZsMB2h6R3Z1ww=
X-Received: by 2002:aca:4282:: with SMTP id
 p124mr16295974oia.327.1544087459581; 
 Thu, 06 Dec 2018 01:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
 <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
 <20181206011045.GA23336@builder>
In-Reply-To: <20181206011045.GA23336@builder>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 6 Dec 2018 10:10:48 +0100
Message-ID: <CA+M3ks5-5OWPz7Dan5fO6vTp74NpgCNxRhj1CL14hHSaTwrouQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support of STM32 hwspinlock
To: Bjorn Andersson <bjorn.andersson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_011111_365670_F1F60A99 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: Ohad Ben Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgamV1LiA2IGTDqWMuIDIwMTggw6AgMDI6MTIsIEJqb3JuIEFuZGVyc3Nvbgo8Ympvcm4uYW5k
ZXJzc29uQGxpbmFyby5vcmc+IGEgw6ljcml0IDoKPgo+IE9uIEZyaSAzMCBOb3YgMDY6NDUgUFNU
IDIwMTgsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOgo+Cj4gPiBMZSBtZXIuIDE0IG5vdi4gMjAx
OCDEhSAxMDowMCwgQmVuamFtaW4gR2FpZ25hcmQKPiA+IDxiZW5qYW1pbi5nYWlnbmFyZEBsaW5h
cm8ub3JnPiBhIMOpY3JpdCA6Cj4gPiA+Cj4gPiA+IFRoaXMgc2VyaWUgYWRkcyB0aGUgc3VwcG9y
dCBvZiB0aGUgaGFyZHdhcmUgc2VtYXBob3JlIGJsb2NrIGZvciBzdG0zMm1wMSBTb0MuCj4gPiA+
Cj4gPiA+IHZlcnNpb24gNDoKPiA+ID4gLSBhZGQgTGluYXJvIFNvQgo+ID4KPiA+IEdlbnRsZSBw
aW5nIG9uIHRoaXMgc2VyaWVzCj4gPgo+Cj4gU29ycnkgYWJvdXQgdGhhdCBCZW5qYW1pbiwgSSB3
YXMgY29udmluY2VkIHRoYXQgSSBwaWNrZWQgeW91ciBwYXRjaGVzCj4gYWxyZWFkeS4gQXBwbGll
ZCBmaXJzdCB0d28gcGF0Y2hlcyB0byBod3NwaW5sb2NrIHRyZWUuCgpUaGFua3MuCgo+Cj4gSSBl
eHBlY3QgdGhlIGR0cyB1cGRhdGUgdG8gZ28gdGhyb3VnaCB0aGUgU1QgdHJlZSwgYW5kIEkgZ3Vl
c3MgdGhlCj4gY29tcGxhaW50IGZyb20gMGRheSB0ZWxscyB1cyB0aGV5IGFscmVhZHkgYXJlPwoK
WWVzIEkgd2lsbCBzZW5kIGZpeGVkIGR0cyBwYXRjaGVzIGZvciBzdG0zMiB0cmVlCgo+Cj4gUmVn
YXJkcywKPiBCam9ybgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
