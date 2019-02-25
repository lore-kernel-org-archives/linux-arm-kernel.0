Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2192C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:13:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F1820842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HbxXwM1e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWvoI4cx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F1820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MiSS44XmK1EowA8U/55J1acrgTa0iosHPeOiSdqnomY=; b=HbxXwM1eCqnvo5
	81N1CWQ2/50b/kiAmNZ20brTBROk9txqC/ahR0lAGB+Nigzzo7aIbJ0OaVxpkslak5HNjnM6C5/q9
	d9Hvx3JXmsx7UJHL/9DjB8aNJs77q9KQ0pWCwLcpHx7gzVsk8Zg1CmN0/t6WVCg6Vbcw+thQOro3P
	9B3Q4oCFz+XBIE0ant58QjP82SBdiK5iUy6OoQ/1yLczrHhmP5i8SpIkC7XZCwcl4FNPXN2r3dFwI
	yC1aPA7dSO3uCWYegR/hJ9wnonidmY9Uz6tCN4p5SaJJIPTQG0qrAYjQL565rbNnc/NHajmSwSY32
	mmX7A7D5UdHvHAlS9Glg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHwl-0004u1-J0; Mon, 25 Feb 2019 15:13:35 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHwi-0004ti-Vg
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 15:13:34 +0000
Received: by mail-pg1-x544.google.com with SMTP id y4so4600630pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mrfO67nbav+CIhQN9ZK3QikqwKUUWTdGL5TK8vZgYAU=;
 b=dWvoI4cxZtHhe50aEbO0BedwzVYX6gO3n1dyBbhdlWl6VOzK62LkaVj7tyyCIlaSW+
 J5JeJi7o5QRYcxzcWSQeQXE7wOrMG7OhRVAIN3GqITGYn526eHPTktlCJ/zD/sPmAvtL
 bkeL45M5iQEVuXI1ASPevhJDN5rmah+elb1v9fvOqH/FqItKB1XY6xNk3E2NkFWmBfpd
 0X8fryS2RflDyszJHGYH+J8Qcues03x+FFKv4g7Zdecdmk7fA5hWZSCZhBJjxo756fPZ
 ijXZ1jT3KBpJKlOm37oz36duCr/F4EUvSG3QlTJOTvO1BpWJKnKZF6u3LJ/CbSNsYJcs
 RaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mrfO67nbav+CIhQN9ZK3QikqwKUUWTdGL5TK8vZgYAU=;
 b=TPULeipEQ2c98naPRYnwKevfrWUk3KxnvUT3hcvBsxYYbg0OUTlFIKFvpFYdUr9M5J
 z0DsVQse6f2dN0Ftuk2w7IdXr+9BNISQED840vckAMoLpbZWKty+awZEFHlT1jHxm+Y9
 wZkq5KF/D4ENUzkH19cR45VaNQnjhz4y0ButumzTfJuxLLioWMNmIcPN8j2wG3SGK5FX
 tIQtYIfAMWqjoeUalbC2MgtTClgfFEmZqgo26YaHp5hIauTVDTw/7nGtoQETZoRvpuU5
 U2zbY7QSsWjxfSwF42OK3RrdHCCiiER7BvurgbLEFfTf4XQMceuYQCIqYX24q8jLnpun
 m9qg==
X-Gm-Message-State: AHQUAubOxDnZYRQC0Ojh4UsLOK93KuIaf7CI1S9cNkov2CMgmJzc22TM
 oEDZ3AjaFImfCsLfxRVdDXM=
X-Google-Smtp-Source: AHgI3IZptuZzOsUP8/83IDgrSV6Xj0jd9wgQy6xyVSA/FuDTSvKi2nioUcqGTkGY/FOPya1i377lSg==
X-Received: by 2002:a63:8441:: with SMTP id k62mr18568698pgd.219.1551107612272; 
 Mon, 25 Feb 2019 07:13:32 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id t23sm7349910pfa.111.2019.02.25.07.13.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 07:13:31 -0800 (PST)
Subject: Re: [PATCH] ARM: tegra: enforce PM requirement
To: Sameer Pujar <spujar@nvidia.com>, linux@armlinux.org.uk, jhogan@kernel.org
References: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ac4bd28e-6ba9-2da7-7bdf-8f11bee83bd2@gmail.com>
Date: Mon, 25 Feb 2019 18:13:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_071333_043260_767C6407 
X-CRM114-Status: GOOD (  13.47  )
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
Cc: linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jonathanh@nvidia.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MDUuMDIuMjAxOSAxNDoxNiwgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6Cj4gRHJpdmVycyBuZWVk
IHRvIGhhbmRsZSAhUE0gY2FzZSB3aXRoIHdvcmsgYXJvdW5kcyBmb3IgbWFuYWdpbmcgY2xvY2tz
Cj4gYW5kIHBvd2VyIGV4cGxpY2l0bHksIHdoaWNoIGlzIG5vdCByZWFsbHkgbmVjZXNzYXJ5IHdo
ZW4gUE0gc3VwcG9ydCBvbgo+IHRlZ3JhIGlzIGluIGdvb2Qgc2hhcGUuIEluIGZhY3QgQVJNIDY0
LWJpdCB0ZWdyYSBwbGF0Zm9ybXMgZW5mb3JjZSBQTQoKVGVncmEKCj4gc3VwcG9ydCBhbmQgdGhl
cmUgaXMgbm8gcmVhc29uIHdoeSB0aGlzIGNhbm5vdCBiZSBkb25lIGZvciAzMi1iaXQuCj4gCj4g
VGhpcyBwYXRjaCBzZWxlY3RzIFBNIHVuY29uZGl0aW9uYWxseSBhbmQgZHJpdmVycyBjYW4gcmVs
eSBvbiBydW50aW1lCj4gUE0gZnJhbWV3b3JrIGZvciBjbG9jayBhbmQgcG93ZXIgbWFuYWdlbWVu
dC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBTYW1lZXIgUHVqYXIgPHNwdWphckBudmlkaWEuY29tPgo+
IFJldmlld2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+IFJldmll
d2VkLWJ5OiBKb25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPgo+IC0tLQoKWW91
IHByb2JhYmx5IHNob3VsZCBleHBsYWluIGluIHRoZSBjb21taXQgbWVzc2FnZSB3aGF0IGRyaXZl
ciBuZWVkIHRoaXMgcmlnaHQgbm93IGFuZCB3aHkuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
