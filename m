Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9130C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:41:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A632146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KA4BT8mF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcCgZl30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A632146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TTgvZ528BulnHq6hXoCpQdk2xMuCLye0eVEQdRVPqB0=; b=KA4BT8mFh2zrgX
	ZpCucPRrW0Fxz3NJ0WK9EXWu5grzqUOJ5T7u8a0DFLbyFyjN2NgqIw62GFlHMpYTBhAq+UYEYsBV1
	a8sTk5G/g98E5ReEW9gHyobarHQ96LEHWhjrBgSq1MBTwD0lkemgIOKoqMRA2lws3rf2Ncmzr26rL
	m1M36aeEwIeeEzKglMBJd2XaimJbVJmAor4MNkVM3RYEDlYEE5QjAn7cjjkuF5lGrzXDMpV8R6WlQ
	d/oSV1Ud8dHpimkzJEhYXOujzT+4OrvUec5siyrAc5ZGDGnOXqgbejouQOyoiE7BB1Tbx1O9uaRhN
	///prfXkVtwP3PmlARNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtJh-0003Y6-6s; Fri, 11 Jan 2019 09:41:29 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtJd-0003Xd-N7
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:41:27 +0000
Received: by mail-pl1-x644.google.com with SMTP id b5so6549167plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=tbiaA4fJYcgLb1K4vUdUrbau2fblch5OFHfxAA3Jx6Y=;
 b=GcCgZl30ekMXf9dQ34DPGjltcR8nc2we04mXPbjyfOoyXc2Zl1q1KcEV7bT/GppfwU
 oCc4ZV+BHU4YBhAy0zRvvT/VxYJL/AL+L96pfD6qrNlhjdXs0JY645s2SMiSobmpUo9W
 cilKLeB4DmMGU41ItqVFx1uh4Q5NHvHoxKkaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=tbiaA4fJYcgLb1K4vUdUrbau2fblch5OFHfxAA3Jx6Y=;
 b=VTehBMuaIO52YMpFbXBEYM8RwTn0sCqqc6qGQxFEPwWBA7SC7kK/LDLuUiWc08xBFL
 JGXmkfvnSn8IpPIaniXAv+5uxix0o4G85VRubv717eqO/q0JW/rcBR+CdjgG0dRjcg7b
 pIoMMH+Yv2t6Lf1mH0MmRXyZs14PZi8XynpVqTzp3Z3DTb7eQJOjDI+Nrbr/RDrwM2s/
 iC1KbUYDlw4wc4wZicv0S1MLmHx30kMgG4zBIe/9HCx4gBxDucqAckAzQP2Mmo/LOTLB
 EPRSrboLwDRI8WozJrCEZWtgdcI369M6TKZEw5Xh3lJowypm4qn5Z6Gz/wXPdAkkLSXf
 tUKQ==
X-Gm-Message-State: AJcUukew6FpYTIX+rxMrXweBs9ErKQ/0p9r6S7vfboyxiEBP1L/ah2YB
 HxNWLXx0YQgGcqLaV4Exs6vjlw3W07k=
X-Google-Smtp-Source: ALg8bN4IjpnAOTmlVspkQtv7ADosTvS3hRuvvcSpujqPY0ZxmJpnVeiMCadtsOt0Fk91YxcVy7jl0g==
X-Received: by 2002:a17:902:bd0a:: with SMTP id
 p10mr13524931pls.322.1547199684113; 
 Fri, 11 Jan 2019 01:41:24 -0800 (PST)
Received: from localhost ([122.172.34.203])
 by smtp.gmail.com with ESMTPSA id 125sm139472770pfx.159.2019.01.11.01.41.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 01:41:22 -0800 (PST)
Date: Fri, 11 Jan 2019 15:11:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
Message-ID: <20190111094120.6dcnspccp6ufxd4y@vireshk-i7>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_014125_771349_A6622002 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTEtMDEtMTksIDA5OjMyLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOgo+IE9uIFRodSwg
MTAgSmFuIDIwMTkgYXQgMjE6NTMsIFBhd2XFgiBDaG1pZWwKPiA8cGF3ZWwubWlrb2xhai5jaG1p
ZWxAZ21haWwuY29tPiB3cm90ZToKPiA+Cj4gPiBUaGlzIGNvbW1pdCBhZGRzIGRtYyBub2Rlcywg
d2hpY2ggYXJlIG5lZWRlZCBieSBzNXB2MjEwIGNwdWZyZXEgZHJpdmVyCj4gPiB0byB3b3JrLgo+
ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVs
QGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaSB8
IDEyICsrKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCj4g
Pgo+IAo+IFRoYW5rcywgYXBwbGllZCAoYWN0dWFsbHkgSSBhcHBsaWVkIHYxIC0gSSBob3BlIHRo
ZXJlIHdlcmUgbm8gY2hhbmdlcykuCgpXb3VsZCB5b3UgbGlrZSB0byBBY2sgdGhlIG90aGVyIHBh
dGNoZXMgc28gdGhhdCBJIGNhbiBhcHBseSB0aGVtID8KCi0tIAp2aXJlc2gKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
