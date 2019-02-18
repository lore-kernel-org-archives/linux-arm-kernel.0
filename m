Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB8DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A3421479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gu/QQwUy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfmONUNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ClfhTd65v5Wmqy/ygZeeOWsseZ7/Bo4bfvdK3/LoBMw=; b=Gu/QQwUyl+fXJP
	ued6GQe32yNX0pR2tXE6MsM561oLkTzCWEOpYXAcLtcgfSA0OSmAS1cisoawv3WUAcnIr0YUDjVna
	rzgaXh21tYO9IR1KcztaJY60txvioOjwAww9GWAGhgOQ5iqCFqmCT3hVW6pM3VLOXAJSEOXgYMDB3
	q8JeNyI57n5Nw75rAkKOw45oDrd8uoEVGYr3t/iSTHc54jEtxqf90jv3ZZLYOm27Ivvh76C3ln/K9
	R2dnt8+58YScdvlddrDgj9Q2eUzQClN/9W9OYFp5j/mrusHmPXwNuYoMGHVGElhQZnheiOnc+AsOe
	kXcH61drxGQvDpN1HhPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvi3H-0007hC-6p; Mon, 18 Feb 2019 12:29:39 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvi39-0007cd-8r
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:29:33 +0000
Received: by mail-wm1-x341.google.com with SMTP id j125so16941641wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 04:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MRzmTEn9G8kwM20BMcAVcDRHrXJ3gBe2p0nBD+YMJro=;
 b=xfmONUNSh0hOZbxqpkLcUrMqFonwDGkiq7gydIXoj42z/Gb5HT1YcUJLifIQzWTLRh
 GJgrv9gs5/p39PWaUPyVLGO4IpPHPxExIHO3RNX2MtHkVzk5Q+VYC00tQbb6LUMCaDK0
 /C4P5p5mrYvVulsNYXenT3ywd7lByEAC1S5WfrYHgzdXhy3WGHFKpKpko4f8vB80YroU
 OrepEqlRm0CG4sc549aFHTaZ4Bo1Dc37aRbmgiR8n0pQkxVA8MeMBwgO2geLNA41aUrH
 o+ueQgCTi254uj0tB/6ygVPeFf8Kxb1jGFni4aVjLETBBp58gVhsBdFI/nlruuJpNP3R
 N5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MRzmTEn9G8kwM20BMcAVcDRHrXJ3gBe2p0nBD+YMJro=;
 b=l2xl0a8CPat2epkcJ7DRcpLluz5wX60eiNcPynNkuSKCpwzYQcx7QYaoDQgYe+dQAV
 9dUSDZq66/6epGJyyk4EO21W/V8FmmOLOsffqsPhyO91//fGXucuT3UI2CBII+Omyxqk
 EyqyOPhVEhr8NLEgci4rLymkM9Q7cThU5tyCvcKEppaAT/QpvBTZG04Rsj0dLLmsna1U
 bPvZhKN5zHAp7LP4cXfi1YIlJ4aat+GBMUzxgP1l3wOAfK/+khfsRJEXwoazvDHYrveo
 qEWxxKH0jhnO/uCo2kWTI1F/2cbXLB7HligPq5rFbO+/7fI3oL/DzI/webyYsARlfSKa
 KDkA==
X-Gm-Message-State: AHQUAua/WGy/tIhHZ4b/2tl/EnBrcbtCnL4Itz936UQkjam5e0C31ZII
 nDJlcX1duUvz8dLLmQrGOvX50g==
X-Google-Smtp-Source: AHgI3IaWwB7F0Gq3PtNhGGuTd0bA3jVnrHb0zcpRv2/sVP8qXGbPFPDEaQ4O+kOCPSRcyB3zrni5TA==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr16453075wmj.0.1550492969297; 
 Mon, 18 Feb 2019 04:29:29 -0800 (PST)
Received: from [192.168.0.41] (148.125.92.92.rev.sfr.net. [92.92.125.148])
 by smtp.googlemail.com with ESMTPSA id v4sm5034268wmg.1.2019.02.18.04.29.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 04:29:28 -0800 (PST)
Subject: Re: [PATCH v2 00/15] Add basic support for Socionext Milbeaut M10V SoC
To: Arnd Bergmann <arnd@arndb.de>, Sugaya Taichi <sugaya.taichi@socionext.com>
References: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <10a0375b-0814-6b7d-97d5-ed2c2838c4b4@linaro.org>
Date: Mon, 18 Feb 2019 13:29:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_042931_359200_2905C9C6 
X-CRM114-Status: GOOD (  26.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Takao Orito <orito.takao@socionext.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Jassi Brar <jaswinder.singh@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTgvMDIvMjAxOSAxMzoyMCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBGcmksIEZlYiA4
LCAyMDE5IGF0IDE6MjQgUE0gU3VnYXlhIFRhaWNoaQo+IDxzdWdheWEudGFpY2hpQHNvY2lvbmV4
dC5jb20+IHdyb3RlOgo+Pgo+PiBIaSwKPj4KPj4gSGVyZSBpcyB0aGUgc2VyaWVzIG9mIHBhdGNo
ZXMgdGhlIGluaXRpYWwgc3VwcG9ydCBmb3IgU0MyMDAwKE0xMFYpIG9mCj4+IE1pbGJlYXV0IFNv
Q3MuICJNMTBWIiBpcyB0aGUgaW50ZXJuYWwgbmFtZSBvZiBTQzIwMDAsIHNvIGNvbW1vbmx5IHVz
ZWQgaW4KPj4gc291cmNlIGNvZGUuCj4+Cj4+IFNDMjAwMCBpcyBhIFNvQyBvZiB0aGUgTWlsYmVh
dXQgc2VyaWVzLiBlcXVpcHBlZCB3aXRoIGEgRFNQIG9wdGltaXplZCBmb3IKPj4gY29tcHV0ZXIg
dmlzaW9uLiBJdCBhbHNvIGZlYXR1cmVzIGFkdmFuY2VkIGZ1bmN0aW9uYWxpdGllcyBzdWNoIGFz
IDM2MC1kZWdyZWUsCj4+IHJlYWwtdGltZSBzcGhlcmljYWwgc3RpdGNoaW5nIHdpdGggbXVsdGkg
Y2FtZXJhcywgaW1hZ2Ugc3RhYmlsaXphdGlvbiBmb3IKPj4gd2l0aG91dCBtZWNoYW5pY2FsIGdp
bWJhbHMsIGFuZCByb2xsaW5nIHNodXR0ZXIgY29ycmVjdGlvbi4gTW9yZSBkZXRhaWwgaXMKPj4g
YmVsb3c6Cj4+IGh0dHBzOi8vd3d3LnNvY2lvbmV4dC5jb20vZW4vcHJvZHVjdHMvYXNzcC9taWxi
ZWF1dC9TQzIwMDAuaHRtbAo+Pgo+PiBTcGVjaWZpY2F0aW9ucyBmb3IgZGV2ZWxvcGVycyBhcmUg
YmVsb3c6Cj4+ICAtIFF1YWQtY29yZSAzMmJpdCBDb3J0ZXgtQTcgb24gQVJNdjctQSBhcmNoaXRl
Y3R1cmUKPj4gIC0gTkVPTiBzdXBwb3J0Cj4+ICAtIERTUAo+PiAgLSBHUFUKPj4gIC0gTUFYIDNH
QiBERFIzCj4+ICAtIENvcnRleC1NMCBmb3IgcG93ZXIgY29udHJvbAo+PiAgLSBOQU5EIEZsYXNo
IEludGVyZmFjZQo+PiAgLSBTRCBVSFMtSQo+PiAgLSBTRCBVSFMtSUkKPj4gIC0gU0RJTwo+PiAg
LSBVU0IyLjAgSE9TVCAvIERldmljZQo+PiAgLSBVU0IzLjAgSE9TVCAvIERldmljZQo+PiAgLSBQ
Q0kgZXhwcmVzcyBHZW4yCj4+ICAtIEV0aGVybmV0IEVuZ2luZQo+PiAgLSBJMkMKPj4gIC0gVUFS
VAo+PiAgLSBTUEkKPj4gIC0gUFdNCj4+Cj4+IFN1cHBvcnQgaXMgcXVpdGUgbWluaW1hbCBmb3Ig
bm93LCBzaW5jZSBpdCBvbmx5IGluY2x1ZGVzIHRpbWVyLCBjbG9jaywKPj4gcGljdHJsIGFuZCBz
ZXJpYWwgY29udHJvbGxlciBkcml2ZXJzLCBzbyB3ZSBjYW4gb25seSBib290IHRvIHVzZXJzcGFj
ZQo+PiB0aHJvdWdoIGluaXRyYW1mcy4gU3VwcG9ydCBmb3IgdGhlIG90aGVyIHBlcmlwaGVyYWxz
ICB3aWxsIGNvbWUgZXZlbnR1YWxseS4KPiAKPiBJJ3ZlIGxvb2tlZCBvdmVyIHRoZSBwbGF0Zm9y
bSBvbmNlIG1vcmUuIE92ZXJhbGwsIGl0IGxvb2tzIHZlcnkgZ29vZCwgYW5kCj4gSSdkIHN0aWxs
IGxpa2UgdG8gbWVyZ2UgdGhpcyBmb3IgbGludXgtNS4xLCBidXQgd2UgYXJlIHJ1bm5pbmcgb3V0
IG9mIHRpbWUKPiB0aGVyZS4gSWYgeW91IHNlbmQgdGhlIHBhdGNoZXMgdG8gc29jQGtlcm5lbC5v
cmcgcXVpY2tseSwgd2UgY2FuIHRyeSB0bwo+IHN0aWxsIG1lcmdlIHRoZW0gaW4sIGJ1dCBpZiBh
bnl0aGluZyBnb2VzIHdyb25nLCBpdCB3aWxsIGhhdmUgdG8gd2FpdCB1bnRpbAo+IHdlIHN0YXJ0
IG1lcmdpbmcgcGF0Y2hlcyBmb3IgNS4yLCBkaXJlY3RseSBhZnRlciA1LjEgaXMgb3V0Lgo+IAo+
IEkgZGlkIG5vdCBsb29rIGF0IHRoZSBkZXZpY2UgZHJpdmVyIHBhdGNoZXMgKGNsaywgY2xvY2tz
b3VyY2UsIHBpbmN0cmwsIHNlcmlhbCkKPiBpbiBtdWNoIGRldGFpbC4gSWYgeW91IGhhdmUgYW4g
QWNrIGZyb20gdGhlIG1haW50YWluZXJzLCBmZWVsIGZyZWUgdG8KPiBpbmNsdWRlIHRoZW0gaW4g
dGhlIHNlcmllcywgb3RoZXJ3aXNlIGxldCdzIG1lcmdlIHRoZSByZXN0IG5vdyBhbmQgdGhlbgo+
IHlvdSBjYW4gc2VuZCB0aGUgdXBkYXRlZCBwYXRjaGVzIGZvciBpbmNsdXNpb24gdGhyb3VnaCB0
aGUgc3Vic3lzdGVtCj4gdHJlZXMgaW4gNS4yLgoKSSdtIG5vdCBpbiBjb3B5IG9mIHRoZSBjbG9j
a3NvdXJjZSBwYXRjaCBidXQgSSBhY2tlZCBpdCBmb3IgdGhlIGluaXRpYWwKcG9zdC4KCj4gSSBo
YXZlIHNlbnQgYSBmZXcgY29tbWVudHMuIFRoZSBvbmx5IG9uZSB0aGF0IGlzIHJlYWxseSBpbXBv
cnRhbnQKPiBoZXJlIGlzIHRoZSBtaXNzaW5nIHBsYXRmb3JtIGNoZWNrIGluIHRoZSBzdXNwZW5k
IG9wdGlvbnMuIFBsZWFzZQo+IHRyeSB0byBhZGRyZXNzIG1vc3Qgb2YgdGhlIG90aGVyIGNvbW1l
bnRzbSwgZWl0aGVyIGJ5IGNoYW5naW5nIHRoZQo+IGNvZGUsIG9yIGJ5IGV4cGxhaW5pbmcgd2h5
IHlvdXIgdmVyc2lvbiBpcyBjb3JyZWN0Lgo+IAo+IAo+IAo+ICAgICAgQXJuZAo+IAoKCi0tIAog
PGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3
YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNv
bS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9v
cmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
