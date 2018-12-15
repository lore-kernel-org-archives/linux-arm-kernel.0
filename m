Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E54C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:58:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A2520656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OfGCB9i0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/iZ9PGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A2520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T2hOIfCnXDBC8zpgJjsy5/kmyxoikkDvA4AhYRxZifU=; b=OfGCB9i0+5toKL
	JlSyd/xkcJE0nh/10PVCh7w2BSWJiQ5trN0hjOI24ioe81831mKgTRdet5iUdK4UoHHjNRYH859QW
	EJFKhx6zuLAFShHZhGCWxaQS9dQehFxnLdraljqlxg62+J2ZkM1WlaBN93WoFrtp4laVuRRXfOT8S
	I9WK2Y7cGgQLmdfe/PvKlblJlxZve2HRbtqAgt2mf1vih3GXVonGmrwmvoQHsuLvPLv/JUG2gARI7
	B/GMZxKpVCZVp+3AQoaA6a707QAe/yXSeFbKsqO53eIpJZFMVf23JkcgpvUr3J92oApdj+/xH5z0A
	Bb+97AFLiXf1G5TMBJLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY2y8-0008Gt-2m; Sat, 15 Dec 2018 05:58:32 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY2y3-0008Fe-Vs
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 05:58:29 +0000
Received: by mail-pl1-x642.google.com with SMTP id w4so3700981plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 21:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=vLvcbvZr/qgk6hR402kBjOmWf7cUgxjiM4+Zjy39Ja0=;
 b=C/iZ9PGgG1JPeTxFBLyF/Pn7753HKANn2zKy4b5uxksOkOzrSA7x8SKh9pXgQd4Qp9
 ypDRAoRh2IMyHHz77Qa6w/ddONv8y3SfGlQNaJR3QCy+ASV0ajvtLmpTAHBL4+NUzEvi
 Vp9qsSMwVOWWpyvOWjAwuaTRMirmJ3zR91zwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=vLvcbvZr/qgk6hR402kBjOmWf7cUgxjiM4+Zjy39Ja0=;
 b=Gb0bXB+0ThK6q0LcppTRKh+AuaEhT9Ulzpcyml1gM/xKrZV/eL/QhL1IafVbDAnTTb
 YZg378cdLadzplA3kn6c/5VCnvcEhXtaV2tK15WLQ1nL7kZFsbNIxvG6OVx1/azQuNA0
 TREbvQDAjkHe6pM9k4+aIDdWxmU3LtrjeH1g80LFgV0eZZQ03ESs3qRgdQbyBxXUazP3
 dedW+LFD+yEsHbIthPgRxQoBQhOnlU98CazctVAvYpXhQihX9Q9fh10SLY3+g54q4rWK
 7LINebnYbG/RYRUeHe/XB1m9BLSN2E7PRXUky3ISbK1HnryMj6W7Lae2nK67t/9lQoMF
 TGjQ==
X-Gm-Message-State: AA+aEWadlhlE1K+XmqYcpziNKT974b6K4qgaEL1OFPfRfEaNh+tU8QeT
 XDUh9j5G34kTwrHpXDvw38No
X-Google-Smtp-Source: AFSGD/XjOwFQvvJpbbwa9ZG70TPP0rhXWRf9mIFrrLepc0iW4REtUm2ysDIhnG/3JYY8NluIkk4FAA==
X-Received: by 2002:a17:902:784d:: with SMTP id
 e13mr5561534pln.188.1544853495673; 
 Fri, 14 Dec 2018 21:58:15 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cd:dae9:f1e8:77a0:59f7:2cb5])
 by smtp.gmail.com with ESMTPSA id c7sm12667860pfa.24.2018.12.14.21.58.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Dec 2018 21:58:15 -0800 (PST)
Date: Sat, 15 Dec 2018 11:28:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 11/15] clocksource: Add clock driver for RDA8810PL SoC
Message-ID: <20181215055804.GA9723@Mani-XPS-13-9360>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-12-manivannan.sadhasivam@linaro.org>
 <0b90a179-aa4b-57f7-0874-996d5c535ea9@linaro.org>
 <20181212154748.GA28130@Mani-XPS-13-9360>
 <affe5ffd-66de-526a-f568-52ad5f0c0083@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <affe5ffd-66de-526a-f568-52ad5f0c0083@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_215828_023843_B9387C60 
X-CRM114-Status: GOOD (  16.69  )
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, olof@lixom.net,
 tglx@linutronix.de, afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgMTIsIDIwMTggYXQgMDQ6NTI6NThQTSArMDEwMCwgRGFuaWVsIExlemNhbm8g
d3JvdGU6Cj4gT24gMTIvMTIvMjAxOCAxNjo0NywgTWFuaXZhbm5hbiBTYWRoYXNpdmFtIHdyb3Rl
Ogo+ID4gSGkgRGFuaWVsLAo+ID4gCj4gPiBPbiBXZWQsIERlYyAxMiwgMjAxOCBhdCAwNDowNzo1
M1BNICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToKPiA+PiBPbiAxMC8xMi8yMDE4IDE4OjM1
LCBNYW5pdmFubmFuIFNhZGhhc2l2YW0gd3JvdGU6Cj4gPj4+IEFkZCBjbG9jayBkcml2ZXIgZm9y
IFJEQSBNaWNybyBSREE4ODEwUEwgU29DIHN1cHBvcnRpbmcgT1NUSU1FUgo+ID4+PiBhbmQgSFdU
SU1FUi4KPiA+Pj4KPiA+Pj4gUkRBODgxMFBMIGhhcyB0d28gaW5kZXBlbmRlbnQgdGltZXJzOiBP
U1RJTUVSICg1NiBiaXQpIGFuZCBIV1RJTUVSCj4gPj4+ICg2NCBiaXQpLiBFYWNoIHRpbWVyIHBy
b3ZpZGVzIG9wdGlvbmFsIGludGVycnVwdCBzdXBwb3J0LiBJbiB0aGlzCj4gPj4+IGRyaXZlciwg
T1NUSU1FUiBpcyB1c2VkIGZvciBjbG9ja2V2ZW50cyBhbmQgSFdUSU1FUiBpcyB1c2VkIGZvcgo+
ID4+PiBjbG9ja3NvdXJjZS4KPiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6Ry
YmVyIDxhZmFlcmJlckBzdXNlLmRlPgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNh
ZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgo+ID4+Cj4gPj4gVGhl
IGRyaXZlciBsb29rcyBnb29kIHRvIG1lLiBEbyB5b3Ugd2FudCBtZSB0byBwaWNrIGl0IHVwIHZp
YSBteSB0cmVlPwo+ID4+Cj4gPiAKPiA+IFllcywgcGxlYXNlIGRvLiBNYXJjIGlzIGdvaW5nIHRv
IHBpY2sgdXAgdGhlIGlycWNoaXAgZHJpdmVyIGJ1dCBJJ20gbm90Cj4gPiBzdXJlIGFib3V0IHRo
ZSBzZXJpYWwgZHJpdmVyLiBUaGUgcmVzdCBvZiB0aGUgcGF0Y2hlcyBjYW4gYmUgcGlja2VkIHVw
Cj4gPiBieSB0aGUgQVJNIG1haW50YWluZXJzIChJIG5lZWQgdG8gc2VuZCBhbm90aGVyIHZlcnNp
b24gZm9yIGRyb3BwaW5nCj4gPiBBbmRyZWFzIGZyb20gTUFJTlRBSU5FUlMpLgo+IAo+IE9rLCBh
cHBsaWVkLgo+CgpKdXN0IHRvIGJlIHN1cmUgYmVmb3JlIHNwaW5uaW5nIG5leHQgdmVyc2lvbiwg
aGF2ZSB5b3UgYWxzbyBwaWNrZWQgdXAgdGhlCmJpbmRpbmdzIHBhdGNoPyBJIGNhbid0IGZpbmQg
dGhlIGNvbW1pdChzKSBpbiB5b3VyIHRyZWUhCgpodHRwczovL2dpdC5saW5hcm8ub3JnL3Blb3Bs
ZS9kYW5pZWwubGV6Y2Fuby9saW51eC5naXQvCgpUaGFua3MsCk1hbmkKCj4gVGhhbmtzCj4gCj4g
ICAtLSBEYW5pZWwKPiAKPiAKPiAtLSAKPiAgPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcwo+IAo+IEZvbGxvdyBM
aW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8
Cj4gPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo+IDxodHRwOi8v
d3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCj4gCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
