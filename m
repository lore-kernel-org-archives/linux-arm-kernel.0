Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D312C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:02:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672FC21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dZ2ApFs9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5B8F++n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672FC21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wj7NcdV/GrEiNJN54F2DmbYZ0On4DL89q8l4GLu+iF8=; b=dZ2ApFs9LX005n
	NJeul/lKRkYBYcUu2gmzw76GBBVE9E3loQNctH1G8fgkWfomjKAOBOjizdyCtvyjErNT7n2wvBdOq
	m3Gx3DoR/mlWc+FAHp5A1foDJfwcPPgJcFvU4/8MsxJ2YX9Fw8tKBSTJFmujS7ty/7omWgn8vVeta
	/LT/cjTYhdM+UkfwYpNeHAAsGUgT3xAV2hP+h9rrU+7gQcjuR52RVKPKcGR6KPpHmemq7iia9Uv3+
	Jf8608Dthcb+rHiqhirCUlk2DWwLt+UUCHiaEtIu/6l5Brf/Jx/4os0/CjJrMDCzhb+5JCUhG30PU
	wmKNdlR+y0kJxToA2lsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwVG1-0001Zy-CK; Wed, 20 Feb 2019 17:02:05 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwVFv-0001Z9-Rp
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 17:02:02 +0000
Received: by mail-lj1-x243.google.com with SMTP id l5so18030342lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lYAS/tJV+XlVv40JuDpW9eWz8mulCBkbrP397zDqNso=;
 b=C5B8F++nvta5oFaLo9qXS/QpTUWvhDr+VdaqgZStAYJgwfuBZpL3cT3MW+Ze8nCtyu
 tDz/FKKTq4GFHHUrCiOmVnCDrsltV5VQXCy7Por+RYfb1TGngQ1HfcjFSm6XYDlKoMUG
 1Nnn1JwafXqUgUXtsd8fIoP2Weu7XbofFbYBuatXJHJjtoc4yZRsa/q6i//lBlQMtFwa
 /jm2hPwAQXgIPX9ZbJA1PZB2VhNfuOpMSqpQPjNxf6jH7CpTqXSdoDkb9DiCxpX8/VoN
 rNRjgKSGBXHSABo6NVy16TBWZMEi3Suau0/LL5lPiOSoKlbrAdVzsvPSsh/z/u++JLPa
 CG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lYAS/tJV+XlVv40JuDpW9eWz8mulCBkbrP397zDqNso=;
 b=dawzi3FroKx+wfY/xUvePfWhnv2GkgXt9ge24392HPhSNhbGAy/uLWRDAZPPB5FuEU
 Ehu2ew/iu24W1GmLLsmDEQ3sut4LDAmuBHydJBhzBeNlQkUQ7x6aBO1WF6PSzSqyD9uw
 vaUG9X7PMpBI/6B1LSGt6hiiqtFtkg3vEftey7Bj4rl9GMO+eFV7/XaKkioHg1jErqH1
 dhMmCGyEjeQHBJrN/pPiiYGiGEu0GkD/gj8BUrpsNRP8dvNgrwLJbeo60idtzScp4Shc
 1HZUxvWS89vLjWsX6OXAXi/7CLDKqqzV5y6XL1zCwCDSq9zCrooEVnsDA1mhcF95Prcp
 O0/A==
X-Gm-Message-State: AHQUAuYyE7hgFa36EoTz+6NCe+os8vobBuAwoUq5o5Cbupc4HSPqf5/0
 S7wGznqnBVPPI7Zu8It2ZVs=
X-Google-Smtp-Source: AHgI3Ib8eCvEIBx7U37Xvtz1rzN+RoX6fp/NtmBf6AqQkHkNrMat20XWQVo1wehQYJV9ivG0bmPGvw==
X-Received: by 2002:a2e:9595:: with SMTP id
 w21-v6mr20843352ljh.194.1550682117887; 
 Wed, 20 Feb 2019 09:01:57 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id 8sm5345390ljs.42.2019.02.20.09.01.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 09:01:57 -0800 (PST)
Subject: Re: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20190218001726.16785-1-digetx@gmail.com>
 <c6d761cf-370c-c4f7-931b-d2333e02f2dc@gmail.com>
 <20190220163614.GA11116@qmqm.qmqm.pl>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ba276a8f-57fb-4565-817a-6f7ee4175d41@gmail.com>
Date: Wed, 20 Feb 2019 20:01:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190220163614.GA11116@qmqm.qmqm.pl>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_090200_879798_085F0569 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Robert Yang <decatf@gmail.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MjAuMDIuMjAxOSAxOTozNiwgTWljaGHFgiBNaXJvc8WCYXcg0L/QuNGI0LXRgjoKPiBPbiBXZWQs
IEZlYiAyMCwgMjAxOSBhdCAwNDozMDoyMFBNICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
Cj4+IDE4LjAyLjIwMTkgMzoxNywgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4+PiBIZWxs
bywKPj4+Cj4+PiBUaGlzIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFRydXN0ZWQgRm91
bmRhdGlvbnMgZmlybXdhcmUgb24KPj4+IE5WSURJQSBUZWdyYTMwLiBQcmV0dHkgbXVjaCBhbGwg
b2YgVGVncmEzMCBjb25zdW1lciBkZXZpY2VzIGhhdmUgdGhhdAo+Pj4gZmlybXdhcmUgYW5kIHVw
c3RyZWFtIGtlcm5lbCBjYW4ndCBib290IG9uIHRob3NlIGRldmljZXMgd2l0aG91dCB0aGUKPj4+
IGZpcm13YXJlIHN1cHBvcnQuCj4+Cj4+IEhlbGxvIE1pY2hhxYIsCj4+Cj4+IFdpbGwgYmUgYXdl
c29tZSBpZiB5b3UgY291bGQgdGVzdCB0aGUgc2VyaWVzIG9uIHlvdXJzIFRGMzAwVCBhbmQgcmVw
b3J0IGJhY2ssIHRoYW5rcyBpbiBhZHZhbmNlIQo+IAo+IEkgdGhpbmsgSSB3aWxsIGJlIGFibGUg
dG8gbG9vayBpbnRvIHRoaXMgZHVyaW5nIHRoZSB3ZWVrZW5kLiBXaGljaAo+IGtlcm5lbCB0cmVl
IGRvIHlvdSBzdWdnZXN0IGFzIGJhc2U/CgpFaXRoZXIgbGludXgtbmV4dCAocHJlZmVyYWJseSkg
b3IgdGhlIG1haW5saW5lIHY1LjAgd2lsbCBiZSBmaW5lLCB0aGVyZSB3ZXJlIG5vIG11Y2ggY2hh
bmdlcyBmb3IgdGhlIGxhc3QgeWVhciBpbiB0aGUgY29kZSB0aGF0IHRoaXMgcGF0Y2hzZXQgdG91
Y2hlcy4gWW91IGNvdWxkIGFsc28gdHJ5IHRoZSBncmF0ZS1rZXJuZWwgWzBdIHdoaWNoIGhhcyBz
b21lIGV4dHJhIHBhdGNoZXMgdGhhdCB3ZXJlIG5vdCBzdWJtaXR0ZWQgdG8gdXBzdHJlYW0geWV0
LCBwbGVhc2UgdHJ5IGl0IGlmIHlvdSdsbCBleHBlcmllbmNlIHNvbWUgcHJvYmxlbXMuCgpbMF0g
aHR0cHM6Ly9naXRodWIuY29tL2dyYXRlLWRyaXZlci9saW51eC9jb21taXRzL21hc3RlcgoKUGxl
YXNlIHRlc3QgdGhlIGZvbGxvd2luZzoKCjEpIEtlcm5lbCBib290cyBmaW5lIHdpdGggYWxsIDQg
Q1BVIGNvcmVzIHVwIGFuZCBydW5uaW5nLgoKMikgTFAyIENQVSBpZGxpbmcgd29ya3MuIFRlc3Qg
aXQgYnkgZGlzYWJsaW5nIHRoZSBzZWNvbmRhcnkgY29yZXM6CgojIGVjaG8gMCB8IHRlZSAvc3lz
L2RldmljZXMvc3lzdGVtL2NwdS9jcHVbMS0zXS9vbmxpbmUKCjMpIExQMSBzdXNwZW5kLXJlc3Vt
ZSB3b3Jrcy4gTWFrZSBzdXJlIHRoYXQgIm52aWRpYSxzdXNwZW5kLW1vZGUiIGlzIHNldCB0byAi
MSIgaW4gdGhlIFBNQyBkZXZpY2UtdHJlZSBub2RlIGFuZCB0aGF0IHRoZSBvdGhlciByZWxldmFu
dCBwcm9wZXJ0aWVzIGFyZSBzZXQgdXAgY29ycmVjdGx5IChjb3B5IHRoZSB2YWx1ZXMgZnJvbSBU
RjMwMFQgZG93bnN0cmVhbSBrZXJuZWwpLiBUZXN0IGl0IGJ5IHJ1bm5pbmcgdGhpcyBjb21tYW5k
IChtdWx0aXBsZSB0aW1lcyk6CgojIHJ0Y3dha2UgLW0gbWVtIC1zIDEKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
