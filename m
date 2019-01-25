Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1FEC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:08:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA00218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b8yU4A3U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXND35wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA00218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mcbLwGvQQUOoi4oVB2g1blHADfPE7nJFO95RbgLN5rk=; b=b8yU4A3UHUETDn
	xi15eLyjvqJqfhwN2fyt5zgMbrVYMcI8XrLUO8Rd8H0qTroOvr7p/dX9phCAR6AUOK4P14d8PMT2v
	IT8TS/RSc2KClpAjPSFWUzwl0jKKzG6R4C3lKYwUiCQGCPkP3nqSkh390iAR6CLCTgwMw1nBSH7ST
	fqTECi0/qQbX4Hm6zxjbavV0pTdi7BREXCN3gXlfqhTWEBNjL3Mq+C67VLIM+HDhcVCUO3P6VCCIY
	t6QnfucX9/1vxtUf3LbAE67ev2ZIAd8FcW63Vukk0n45Mfay+PklaOhG7Ec3PVm6ipRgyiRdq/kIA
	tjAHGKT1wr6d7MtLWzWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn6po-0006O9-OC; Fri, 25 Jan 2019 19:08:12 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn6pk-00068S-Qm
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 19:08:11 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so7624397wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 11:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lnSGyzvw4RsY4eJFCCYo2d9evybrfYMCU/uQO4l0uDs=;
 b=bXND35wpM/qo+hfoCh2rR4Ka6GqBnOjRXWf4EAfawy2rmyobZaws7SrNUDNGVdgw6J
 xvCFSRtSB6k05MXwWVxZ6zQHaWmxcjBsIvW+HWp1R6z+kqAn/cmuRWvZCKWoXM/lUQYH
 kV+3SdQqDSvYcN+B1N0Xg+ijqxhHhd/hnax2WstXHufhNT/1pR2v+XsBmJiCKEzMp+j3
 FpWoWaA92fUzHI1TEu3Y0q2SoBBlrqAw+SNz7NiIo355P4ALO1z4YQVDNEdQQD6WFVSG
 T8W9VM+e6D3T/zBhEIORGi5gTJCwGhAXggmeGmWcQbUcggfDnurj5rI49QWcDYIshD4V
 BQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lnSGyzvw4RsY4eJFCCYo2d9evybrfYMCU/uQO4l0uDs=;
 b=lJB8gUub+9fOLfdWmgNvMcllT7zjoxl9hnNmFB7QhE1G1MXP8RDJAuOkEjgS1tUgKz
 pL8hGLK/rMjjO4kJX9U0iNXIuTCj6jfZDE60Ds14fhjQMUpNX/3tuboyBWTCc71xO2Hh
 RmiQ09sbGyAFF+FbpP0IzJgcfaOf+PhVlVQbv/2agVJQeb3x/lvijgB9YNNMJacG0/u3
 3r5IYnZKGZ45x2tgOQP6qguSauMbvRqJpw1Ppptc28pGf7ntiGUAldKzQ7AZe3YTnx3O
 9JKbmSoZ/tEj/F6d3/x0fA5uqIw+Th+WoKvJwU1i5KZq5thNLK9wUb1V9yuafwHdtTdL
 TjTA==
X-Gm-Message-State: AJcUuke2dN9hogM0R6Jn1X51915X8PbK5LYh8+lY32WFPQzZ4Ci4+PLp
 vO5/t5SBLduueHhCOuNvnd8kgK2X
X-Google-Smtp-Source: ALg8bN74AkXkOdMPcy0A1VHdulOPtn0ZNtXdXrSFk5KgArmB6ReV7KP+bjbNa+AAe7dh++r+jP3NrQ==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr8167077wmj.90.1548443285665; 
 Fri, 25 Jan 2019 11:08:05 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:fc07:c732:1a36:65ad?
 (p200300EA8BF1E200FC07C7321A3665AD.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:fc07:c732:1a36:65ad])
 by smtp.googlemail.com with ESMTPSA id y13sm76583166wme.2.2019.01.25.11.08.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 11:08:04 -0800 (PST)
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
To: Carlo Caione <ccaione@baylibre.com>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
 <20190125184330.dm3kaoewvbwddacy@xps>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
Date: Fri, 25 Jan 2019 20:07:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125184330.dm3kaoewvbwddacy@xps>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_110809_091165_D0E86642 
X-CRM114-Status: GOOD (  14.94  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
 abailon@baylibre.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org, aisheng.dong@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjUuMDEuMjAxOSAxOTo0OCwgQ2FybG8gQ2Fpb25lIHdyb3RlOgo+IE9uIDI1LzAxLzE5IDEz
OjA2LCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggYWRtaW4gd3JvdGU6Cj4+IE9uIEZyaSwgSmFu
IDI1LCAyMDE5IGF0IDEyOjU1OjEwUE0gKzAwMDAsIENhcmxvIENhaW9uZSB3cm90ZToKPj4+IFNt
YXJ0RUVFLCBjb21wYXRpYmxlIHdpdGggSUVFRTgwMi4zYXogc3RhbmRhcmQsIGlzIGRlc2lnbmVk
IHRvIGluY2x1ZGUKPj4+IGxlZ2FjeSBNQUMgd2l0aG91dCBFRUUgY2FwYWJpbGl0eSBpbnRvIHRo
ZSBwb3dlciBzYXZpbmcgc3lzdGVtLiBTbWFydEVFRQo+Pj4gaXMgZW5hYmxlZCBieSBkZWZhdWx0
IGNvbmZpZ3VyYXRpb24gb24gQVI4MDMxIGFmdGVyIHBvd2VyLW9uIG9yIGhhcmR3YXJlCj4+PiBy
ZXNldC4KPj4+Cj4+PiBVbmZvcnR1bmF0ZWx5IHRoaXMgaXMgcHJvdmVkIGNhdXNpbmcgaXNzdWVz
IGZvciBjZXJ0YWluIGh3Cj4+PiBjb25maWd1cmF0aW9ucy7CoCBXZSBhZGQgYSBxdWlyayB0byBv
cHRpb25hbGx5IGRpc2FibGUgU21hcnRFRUUuCj4+Cj4+IEl0IG1heSBiZSBhIGdvb2QgaWRlYSB0
byBkZXRhaWwgd2hhdCAiY2VydGFpbiBodyBjb25maWd1cmF0aW9ucyIgYXJlCj4+IGFuZC9vciB3
aGF0IHRoZSAiaXNzdWVzIiBhcmUsIHNvIGl0J3MgZWFzaWVyIHRvIGZpbmQgdGhpcyBpZi93aGVu
Cj4+IG90aGVycyBlbmNvdW50ZXIgdGhlIHNhbWUgaXNzdWUuCj4gCj4gVGhpcyBmaXggd2FzIHVw
c3RyZWFtZWQgZnJvbSB0aGUgaW14IGRvd25zdHJlYW0ga2VybmVsIHNvIEkgZG8gbm90IGhhdmUg
bXVjaCBpbmZvcm1hdGlvbnMgb24gdGhhdCBidXQgc29tZXRoaW5nIGlzIHJlcG9ydGVkIGluIHRo
ZSBVLUJvb3QgZml4IGZvciB0aGUgc2FtZSBwcm9ibGVtIGF0IFswXSBzbyBJJ2xsIGFkZCBtb3Jl
IGluZm8gaW4gdGhlIG5leHQgcmV2aXNpb24uCj4gCj4gQ2hlZXJzLAo+IAo+IFswXSBodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEwMTU3ODMvCj4gClRoYW5rcyBmb3IgdGhlIGxp
bmsuIEFjY29yZGluZyB0byB0aGUgZGVzY3JpcHRpb24gU21hcnRFRUUgd29ya3Mgb25seSBpZgpi
b3RoIGxpbmsgcGFydG5lcnMgc3VwcG9ydCBpdCAoaGVuY2UgYXJlIEF0aGVyb3MgUEhZJ3MpLiBJ
IHdvdWxkIGFzc3VtZQp0aGF0IHRoaXMgdXN1YWxseSBpc24ndCB0aGUgY2FzZSwgc2hvdWxkbid0
IHRoZSBmZWF0dXJlIGJlIGFuIG9wdC1pbgp0aGVyZWZvcmU/CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
