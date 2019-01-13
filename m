Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A36BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:34:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9802084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cWqvVgr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9802084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m/ivGfyW/2O8VMP2CcTsjFa1Al6RJ2VZUPpM+lm17OM=; b=cWqvVgr2x516TM
	QNzziAqvTDVGlt/m6+BxhUL/C+U79eSDzZ0StiOGiTXnraML4vkrkzXL1M7b4yXWbg/BwlkYSw1W5
	Xg2Zc8VWTIO5cmmH8k3XwrS6Bd90VSSqEj+DMoRauTcjHUrr5Lo+0pkeggLM71i7TjmL9NnS+zQ8s
	A++NpkJPIeGJn/0hMxL0jpJ90LoMR2+fGP9iHfUk31k3SInqVFB1/I8L+iibqmVC8rr2W1X+hdPVB
	leKHMn6HYOQCT++jr85iSgbxijwMLDONI1OQ7J2asha0GA/ImAHbK1/p9ou2fKSdEcr50Z+fuPCls
	7JaP6pLZZSOI0V21+CSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gic9y-00060H-MF; Sun, 13 Jan 2019 09:34:26 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gic9v-0005zw-F4
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 09:34:24 +0000
Received: by mail-ed1-f68.google.com with SMTP id o10so16332484edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 01:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=bqtD+IZ9XT8e+fGQkEeRwvV8GURM2V1wPqLQ2hCv1EU=;
 b=VPPQXpCjmW/x/Kj8nT40R2OZS9ia2LejalExyrtxhXToVxVg8nEtpWRzw9ld3aCPfL
 btw8s41cog1Yy6UwOATKE7LGd+txEEQ4O59phaxxrhg/o+l5aAgCW3Gt11vSAT1XGYYS
 d0E+CSl0svqOGf2zh5gIlGMoqngk01GRXv/YklBm4/OaNZQdn+lzoddU7jQ+KFmppy7Q
 FVvLxGYN2gJ78qbLvCvuDiFXesZ1nUkFfbdQDvkoeelOOZX6wOo16x/FNPINk/yGKm2Z
 e43hgam+YqNclf9d4LgOAahPSHrbrdfaMVEXKN9WCudkfIHAHjTWhkxJnNGlrB40N7Ys
 UZgw==
X-Gm-Message-State: AJcUukcHRpXi87RC/EQw+Bl/4Isi3yDiJvP7C2kwngewDORK3YFOOGbd
 B7ihLUIiG68UYey2p417ufM=
X-Google-Smtp-Source: ALg8bN5AE0So5HzFbet1Co/Lm594Nx/S201oca+dq0qIQG9W2aj62PRAxT06LnMYNrIrq1qd0zXwkw==
X-Received: by 2002:a17:906:948d:: with SMTP id
 t13-v6mr16591106ejx.119.1547372060972; 
 Sun, 13 Jan 2019 01:34:20 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
 by smtp.googlemail.com with ESMTPSA id c29sm3490630eda.75.2019.01.13.01.34.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Jan 2019 01:34:19 -0800 (PST)
Date: Sun, 13 Jan 2019 10:34:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Message-ID: <20190113093416.GA27934@kozik-lap>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-5-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110205215.22030-5-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_013423_501367_CDF5EA3B 
X-CRM114-Status: UNSURE (   9.04  )
X-CRM114-Notice: Please train this message.
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
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBKYW4gMTAsIDIwMTkgYXQgMDk6NTI6MTVQTSArMDEwMCwgUGF3ZcWCIENobWllbCB3
cm90ZToKPiBUaGlzIGNvbW1pdCBlbmFibGVzIGNwdWZyZXEgc3VwcG9ydCBmb3IgYWxsIHM1cHYy
MTAgZGV2aWNlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtv
bGFqLmNobWllbEBnbWFpbC5jb20+Cj4gLS0tCj4gIGFyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9k
ZWZjb25maWcgfCA2ICsrKysrKwoKVGhhbmtzLCBhcHBsaWVkLgoKQmVzdCByZWdhcmRzLApLcnp5
c3p0b2YKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
