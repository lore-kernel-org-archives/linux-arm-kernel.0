Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0253C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:26:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A865720659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TciiPLxO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmBVDzm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A865720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mXbs1d8k02UeWPMdrrya+9kffRYZdAZyir+LqEUzet4=; b=TciiPLxOFrkk2v
	9WeT54kF4xyRbp+lLzo+rwO9u8WxdHNQ7CTaUxhWJH13umDpO+lerxcje8ynZPExt+PCJBwRnhPN+
	fgzR4oaVP+c+NMS0HEW8xpG7EBoHWw1A893Htx+bl3Ph9JKlFiH/QwM0jPFLD0oSwEkFFq4/FJWM4
	W98D7v3jFN+ysz+KSEWNs3aniRfEuH16XAV+8Ffis60mvposdDIaFrOsaRBG07xOOKIOQxLMdBZdq
	vHWDcqgN78sddyhCkdPmWFJtNC0P1RBQm745GOmNIkPRpqd1oL93tEf2HSpMU+gvRfmaONhvLPnTO
	vs2gRDp90RKcF7Z5ArBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj6wo-0007BG-Po; Mon, 14 Jan 2019 18:26:54 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj6wm-0007Au-8T
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 18:26:53 +0000
Received: by mail-pf1-x441.google.com with SMTP id c123so10558pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qg2xpNBtDpubbIcqexbyMVs5CziNiFpypv07kt2X48I=;
 b=dmBVDzm/3fEL5ODbPR0wXOII140tDV93o47pKBrjytKlB39B7nKalNOgQmcxe3/fX6
 H/WelqvBgp6ODZVs6vEVyFnIYK7O10eIMmKd3MlZTpsvK+CtVYmcQiMiQM/RAlDItuKm
 Er7tSNWVTxQrZtye5K3D9HqA85Bkxri9S3zTKordvfouiuYSuBOoro9RXe23BaYVZPTZ
 ukXOYFJngv2qA22doY8njxQ2GVR5jCNL2E+lkAOeKW/seVNQKpX3KSqgMVQuXb2OWoDE
 +j70I9yQ+GQa6GI+ioBRq4yNdbvkSIE2V/Mauq6gU59vZRbHvpXozU/53dRwsDZ4Cvif
 6aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qg2xpNBtDpubbIcqexbyMVs5CziNiFpypv07kt2X48I=;
 b=QHJOPGquu+VsuLTIGwSNVgROQeQTOJYXaNlnyWw+0HiLXbmaQQMm6wAKSfsDwXWswS
 81bP03ZkE6ib6rvQ5QGY81iiQHfPDLD2bJbNviI0+rm+tV7YuzCDgqDywrwbtD2wM/VS
 k1Q8yVEVTdOkzJnqjAwCBTtlmubAWCWrKPElM9ltLnux2MOFht3bGib5pYH1HAGf6jxv
 jhCZMajwdPCrpy98Wyx9KC7Ds8S+AhMCfNsK9T3mIyfPc0Kh9vA5Z4xLwbD2EWy8vy2X
 c64WxHgTZhe1z7YIaOaYE+e1nUheiNIImHNt/cU9CThYN5JOnkbi4M+o4gzbZwddoDF5
 KEQA==
X-Gm-Message-State: AJcUukcHk+Q67BFhl/ktQVaTwKpoL20plBaB5l2j4ZrYfTShMxD9Wln4
 G4LC1GnOY/VrjAGloYSPo+Bb148q
X-Google-Smtp-Source: ALg8bN4ruV8HAdlIE8t/tLSbROTSSFENvZC8ko7gz05ZAYzlT9ooF3cAKw6P3UG8bJTe4eZxfyLIJQ==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr24374259pgi.301.1547490410289; 
 Mon, 14 Jan 2019 10:26:50 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id 85sm1482946pfw.17.2019.01.14.10.26.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 10:26:49 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: BCM53573: Relicense Luxul files to the GPL 2.0+
 / MIT
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Dan Haab <riproute@gmail.com>
References: <1543795215-31863-1-git-send-email-dan.haab@luxul.com>
 <1abbf738f6ac9808310e27a43f430cc9@milecki.pl>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <158e0161-0d94-54a9-3851-9a3e65e85b77@gmail.com>
Date: Mon, 14 Jan 2019 10:26:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1abbf738f6ac9808310e27a43f430cc9@milecki.pl>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_102652_328427_80FB539C 
X-CRM114-Status: GOOD (  11.79  )
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
 Dan Haab <dan.haab@luxul.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMS8xMy8xOSAxMToxNSBQTSwgUmFmYcWCIE1pxYJlY2tpIHdyb3RlOgo+IE9uIDIwMTgtMTIt
MDMgMDE6MDAsIERhbiBIYWFiIHdyb3RlOgo+PiBUaGlzIG1hdGNoZXMgbGljZW5zaW5nIHVzZWQg
Ynkgb3RoZXIgQkNNNTM1NzMgZmlsZXMgYW5kIEJDTTUzMDFYLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBEYW4gSGFhYiA8ZGFuLmhhYWJAbHV4dWwuY29tPgo+IAo+IEFja2VkLWJ5OiBSYWZhxYIgTWnF
gmVja2kgPHJhZmFsQG1pbGVja2kucGw+Cj4gCj4gRmxvcmlhbjogcGluZyA6KQoKSWYgYmNtLWtl
cm5lbC1mZWVkYmFjay1saXN0QGJyb2FkY29tLmNvbSBpcyBub3QgY29waWVkLCB0aGVuIG91cgpw
YXRjaHdvcmsgaW5zdGFuY2UgZG9lcyBub3QgcGljayB1cCB0aGF0IHBhdGNoLCBhbmQgdGhlcmUg
aXMgYSByZW1vdGUKY2hhbmNlIHRoaW5ncyBjYW4gZ2V0IGxvc3QuLi4gTm90IHRyeWluZyB0byB1
c2UgdGhhdCBhcyBhbiBleGN1c2UgZm9yCm5vdCBoYXZpbmcgc2VlbiB0aGlzLCBidXQgcGxlYXNl
IG1ha2Ugc3VyZSB5b3UgY29weSB0aGF0IGxpc3QgdG8KbWF4aW1pemUgdGhlIGxpa2VsaWhvb2Qg
b2YgZ2V0dGluZyBwYXRjaGVzIGFjY2VwdGVkLgoKTm93IGFwcGxpZWQsIHRoYW5rcyEKLS0gCkZs
b3JpYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
