Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27795C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:46:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E278A21927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nW4lIBoh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnM0HfTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E278A21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O3+sHA+9/q8Tat8PEasANNwpL88mhNG4HciBFe3WFXo=; b=nW4lIBohWCnCHxwkJ3Vq/G6IK
	byRbrnWVJOQkHhBuOF1ulUY1s8JxB/E3NvTc1Io+K9EaDh9YMvZKz6+0DrvAHvlwWxxecZ6yPj0Yb
	jRg7BOL52cHA+7f7RqNUPP8QKIalX31tXUQ9W89Caynq70zFGnKF4QDtP0tjzhDIaUjWLxnifXtAn
	3hqsjOltzXCBn4d9IX/XDOdTvTxAnOe2pF3TlFXj2erJ3ArbZb0YyS6JiVMIk7n169aT37vXrNzDR
	k6zPMLIILD4C+lB6isRgakf00pHzxqc26RdVBBJ49N3C38FPXroAtM6pcrgWLPemeM9yZHALop4vq
	U00S5H1UQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaScI-0003Sd-Uk; Fri, 21 Dec 2018 21:45:58 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaScG-0003Rn-CX
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 21:45:57 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so6665546wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=IPvxWyDGn40AW/ybwE+RF5uPIUCl8L1WOlqQ8THFUlQ=;
 b=MnM0HfTd74e7qQ66LwmA+S82wJWAJ4yv+6y73Wio2bLQ5CVdwGt32PgqJcjH+7S2XB
 Y3VFlfe4U74b8aqAlqiK1lKHniWk+xHHdrVjRTSC8D62h0yQTvGpA7a5QfRjeNaSW6ua
 nxhIJioRS/33gNC70NRq3mJvjghJTRUF4nFiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IPvxWyDGn40AW/ybwE+RF5uPIUCl8L1WOlqQ8THFUlQ=;
 b=oMfYEcGP5y7VV1Oi/JENlgzAL5Qc+ibqVMH+SDaAI4iL4gHWxA4GpGaiYNmg4lycTa
 hOA+BU8PdmkzAMHrXqXvFCeqDgo31aroiXhFb71JY+ofLrbdXaxuCv46OaN8BXyfUJtt
 Rxbwi83xNGTa66Kohmc0PranPD7H5zi5rgKvuWaibsCc1DsL5z2OpkPn4nBy1UlU2gt2
 kXnMnBvtO5CokUBb+Mpb5jx/2vLRJDT+zsvaCpbAiMDb7srwfNBp7vWG4dBJ5p9vRAmp
 HTDmMvMe1GEiPYfQaPWDcsSOiFfAxAE7jbZjjQSut+zkunVUb04O/1sO8cjkUSyczQhm
 H/Jw==
X-Gm-Message-State: AJcUukcWlb160cE2jepcFYVeVGMxWu66eXdCtjtLJPXbryIB72lJBUMK
 R+KDEkWFgr0W/KfQSGqgK2uHgA==
X-Google-Smtp-Source: ALg8bN7d3xmC390m8qd9j4u6JLMgH+J+Oc8P81C/AeBE0yty8l06+1uwYNDNQmEWk6JFlkpLwkLtQg==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr4338977wra.81.1545428744225;
 Fri, 21 Dec 2018 13:45:44 -0800 (PST)
Received: from [192.168.1.2] (119.red-79-146-81.dynamicip.rima-tde.net.
 [79.146.81.119])
 by smtp.gmail.com with ESMTPSA id o5sm20036921wmg.25.2018.12.21.13.45.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 13:45:43 -0800 (PST)
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To: Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Taniya Das <tdas@codeaurora.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
 <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
 <20181221192823.GA9704@minitux>
 <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
 <154542841268.13075.13095552962351570142@swboyd.mtv.corp.google.com>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <914bd56c-4470-4f78-75ac-f7bedd83d7c0@linaro.org>
Date: Fri, 21 Dec 2018 22:45:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154542841268.13075.13095552962351570142@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_134556_435205_0DCCCBC7 
X-CRM114-Status: GOOD (  13.01  )
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
Cc: mark.rutland@arm.com, jassisinghbrar@gmail.com, heiko@sntech.de,
 mturquette@baylibre.com, will.deacon@arm.com, david.brown@linaro.org,
 linux-clk@vger.kernel.org, olof@lixom.net, jagan@amarulasolutions.com,
 andy.gross@linaro.org, sibis@codeaurora.org, devicetree@vger.kernel.org,
 arnd@arndb.de, niklas.cassel@linaro.org, robh+dt@kernel.org,
 horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMjEvMTggMjI6NDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToKPiBRdW90aW5nIEpvcmdlIFJh
bWlyZXogKDIwMTgtMTItMjEgMTE6NDU6MjgpCj4+IE9uIDEyLzIxLzE4IDIwOjI4LCBCam9ybiBB
bmRlcnNzb24gd3JvdGU6Cj4+PiBQZXJoYXBzIHRoZXJlJ3MgYSBiZXR0ZXIgd2F5IHRvIGRlZmlu
ZSB0aGF0IHRoaXMgcGFydGljdWxhciBjbG9jawo+Pj4gaGFyZHdhcmUgY2FuIGNoYW5nZSByYXRl
LCBidXQgaW4gdGhpcyBpbXBsZW1lbnRhdGlvbiBpdCBtdXN0IG5vdD8KPj4gdGhlIGluaXRpYWxp
emF0aW9uIGZvciB0aGlzIHBhcnRpY3VsYXIgUExMIG9uIHRoaXMgcGFydGljdWxhciBwbGF0Zm9y
bQo+PiBpcyB3cm9uZwo+PiBhcyB0aGUgaW50ZXJmYWNlIGRvZXMgbm90IGFwcGx5IHRvIHRoZSBw
bGF0Zm9ybSBuZWVkcyBldmVuIHRob3VnaCBpdCBpcyBhbgo+PiBhbHBoYV9wbGwKPj4KPj4gaWYg
dGhlIFZDTyBpcyBub3QgYW4gb3B0aW9uIC1ldmVuIHRob3VnaCBpdCByZWZsZWN0cyB0aGUgcGxh
dGZvcm0KPj4gY29uc3RyYWlucy0KPj4gSSB3b3VsZCBzdWdnZXN0IG51bGxpZnlpbmcgdGhlIGFs
cGhhX3BsbF9vcHMgdGhhdCBkbyBub3QgYXBwbHkgdG8gdGhpcwo+PiBwbGF0Zm9ybToKPj4gaWU6
IHNldF9yYXRlLCByb3VuZF9yYXRlIHNldCB0byBudWxsIGluIHRoZSBwcm9iZS4KPj4KPj4gYWxs
b3dpbmcgdGhlIGludGVyZmFjZSBjYWxscyAob3BzKSB0byBnbyB0aHJvdWdoIHRvIGxhdGVyIG9u
IG1ha2UgdGhlbSBmYWlsCj4+IGJhc2VkIG9uIHNvbWUgc2V0dGluZyB3b3VsZCBiZSBmdW5kYW1l
bnRhbGx5IHdyb25nIElNTwo+Pgo+IFdlIGhhdmUgY2xrX2FscGhhX3BsbF9wb3N0ZGl2X3JvX29w
cyBzbyBtYXliZSBqdXN0IGFkZCBhbm90aGVyIHNldCBvZgo+IHRob3NlIGZvciB0aGUgYWxwaGFf
cGxsIGl0c2VsZj8KPgo+Cgpzb21ldGhpbmcgbGlrZSDigKhjbGtfYWxwaGFfcGxsX2ZpeGVkX29w
cz8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
