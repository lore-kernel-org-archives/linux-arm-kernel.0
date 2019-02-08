Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49362C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1512321841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UYdBppvI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaIGnWKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1512321841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NhQAkxdVHeXdLATFvuXsxeRiedLbOXECCIT7RIL53yA=; b=UYdBppvI4dNC4O
	sMnJ8kvDAn5EdjtjqoSkfgaVq/OYblusSHVZy0FcqP07t2wq2JtQpXAFrrG014+QDdRuBkMF1SZYw
	Y3cpYkgZjMCiNaxurCI/J4OUveVa3SYAKY9va18wJ48Opvyr3MZinQdnES3JuVXwHkKy0Z76fFx85
	8tvRO1bfn93zjl5llz4+BhSKEMXGw1AkoWMA2VMTIpgPdOWP/ZyVWqRI38f1BvuiwKnmcFO/F942F
	hU8TvpllypRfleErAgbs+Ii6LS83mZMcIEUpAAFBcXBWam82sh2zv5FZpwUKjw4+IZGb9m364gnXg
	MzckhAE2QifjgEupbm0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsCE9-0006LP-0w; Fri, 08 Feb 2019 19:54:21 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsCE5-0006Kz-Mw
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 19:54:19 +0000
Received: by mail-pf1-x443.google.com with SMTP id y126so2173723pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 11:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZW/JrFWuX55nLZipr01Egyz6wooJxiWCzUtC/iAGv+s=;
 b=ZaIGnWKw45nXiBEfG2vBbFDP4ZIpFxQ5HemNl0EK1R9FxACcgh7zLc9Ue8O1meg6d4
 gtx6O5iZsPZVamfPgUL3RTD22tw4UUdMG/XcOzUumsrE0RkebQansSEBd60eakVzngi/
 SLQvvV+yJWEJw1ubUG7MpUUYDQE4fQboArrsoWdZ/WV1HTXDwfFOHlCc5vmhTx8mAcPH
 VtYsAGd8GVRm93bXACf8J5WmDfO6gmauJR1bnSV4gu3hL/XTaDA/2HVIaQCw1eW09Zf5
 72ICxoX8Ls59f1V3spt2zH0111Rb+bP/ROGKOzM+xTpCgsgWmyto37v7NgvuJhttgEbL
 4BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZW/JrFWuX55nLZipr01Egyz6wooJxiWCzUtC/iAGv+s=;
 b=a0U8LVXlmBJYGG0KQrphT0O3v7C64nY0mrgpZHUfiOSdf6Mpbeh488l0aDnoZGOWu9
 qlo5LLnINfkUgm/oDusa3XREw/5bs1wy3oh9VaQ4Mw5JRJ5FeuJNV/6oxGu406k7Zzf2
 EnjCQoCQSlrUvYVkScU0SqWLIEl3biNKsC7PJs4YlBq+6Z3eScYvXPSHpvor4W06ATts
 RWHYyAfGhJjJ2x2tGr2Wn9OBAFKPxYBg8sT29V4nO9Aq+WCM7pNxCrZavvciTQGBxZRy
 gyF6QahLjY9tHdjtmgi6G0YgK2GSXue3v15FXysgysFz96zIYmiEMnFMdDTXJ39/6GhJ
 VdKg==
X-Gm-Message-State: AHQUAuZpIIvDzckPxlDMnTSn4xUmYSDT9jc4J5t9IUK0mp5SRwM9Dc3f
 vNwX5iVOqxalj3jXKIEi34A=
X-Google-Smtp-Source: AHgI3IZRi5kRXNdq819Ty846yarEgn7Ju96oX1bfuqTkknGqcqYfL7+NsybiNNacVMEfTjJZXBDDzg==
X-Received: by 2002:a63:184a:: with SMTP id 10mr21478044pgy.81.1549655656806; 
 Fri, 08 Feb 2019 11:54:16 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id u6sm3194106pgr.79.2019.02.08.11.54.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 11:54:16 -0800 (PST)
Subject: Re: [PATCH 5/5] clk: tegra: add tegra20 automotive init
To: Kejia Hu <kejia.hu@codethink.co.uk>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20190207125408.8776-1-kejia.hu@codethink.co.uk>
 <20190207125408.8776-6-kejia.hu@codethink.co.uk>
 <7f300cd5-2b97-17fb-da06-b212a8fae647@gmail.com>
 <1549620609.19850.1.camel@codethink.co.uk>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <13a80190-bf33-ebf4-3076-843ca1e8ecdb@gmail.com>
Date: Fri, 8 Feb 2019 22:54:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549620609.19850.1.camel@codethink.co.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_115417_745326_AD1ADA4B 
X-CRM114-Status: GOOD (  18.75  )
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
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
 Thomas Preston <thomas.preston@codethink.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MDguMDIuMjAxOSAxMzoxMCwgS2VqaWEgSHUg0L/QuNGI0LXRgjoKPiBPbiBUaHUsIDIwMTktMDIt
MDcgYXQgMTY6MjMgKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4gdGhpcyBhbGwgbG9v
a3MgdmVyeSBnZW5lcmljIGFuZCBtdWNoIG1vcmUgYm9hcmQtc3BlY2lmaWMgdGhhbiBhdXRvbW90
aXZlCj4gCj4gSGksCj4gCj4gVGhhbmtzIGZvciB5b3VyIHJlcGx5Lgo+IAo+IFdlIGdvdCB0aGUg
Y2xvY2sgZGF0YSBmcm9tIG52aWRpYSBwZGsgZm9yIHRoZSBhdXRvbW90aXZlIHdoaWNoIGRpZG4n
dAo+IHNldCB0aGUgY2xvY2tzIHVwIGluIHRoZSBzYW1lIHdheSBhcyBjb21tZXJjaWFsIHBhcnRz
LCBhbmQgd2Ugd2VyZSB0b2xkCj4gdGhhdCB0aGVyZSBhcmUgY2VydGFpbiBjbG9jayByZXN0cmlj
dGlvbnMgZm9yIHRoZSBhdXRvbW90aXZlIHBhcnRzIHRoYXQKPiB0aGUgY29tbWVyY2lhbCBvbmVz
IGRvIG5vdCBoYXZlLgo+IAo+IEFwcGx5aW5nIGRpZmZlcmVudCBjbG9jayBjb25maWdzIGZvciBl
YWNoIG5vZGVzIGRvZXNuJ3Qgc2VlbXMgdG8gYmUgYQo+IGdvb2Qgd2F5LCBhcyB0aGV5IHdpbGwg
YmUgdG9vIHNjYXR0ZXJlZCBpbiB0aGUgZGV2aWNlIHRyZWUuIFdlIHByb3Bvc2VkCj4gdG8gYWRk
IGEgbmV3IHJvb3Qgbm9kZSBmb3IgdGhlIGNsb2NrIG9yaWdpbmFsbHlbMV0sIGFuZCBmdXJ0aGVy
Cj4gZGlzY3Vzc2lvbiBzdWdnZXN0ZWQgdXMgdG8gZGlzdGluZ3Vpc2ggdGhlIHZhcmlhdGlvbiBi
eSByZWFkaW5nIHRoZSBTS1UKPiBpbmZvLCB0aHVzIGNhbWUgdGhpcyBwYXRjaC4gV2UgY2FuIGRp
c2N1c3MgZnVydGhlciB0aG91Z2guCj4gCj4gUmVnYXJkcwo+IAo+IFsxXSBodHRwczovL3d3dy5z
cGluaWNzLm5ldC9saXN0cy9hcm0ta2VybmVsL21zZzY2NTM0NC5odG1sCj4gCgpJIGRvbid0IHNl
ZSBhbnkgcHJvYmxlbXMgd2l0aCBzcGVjaWZ5aW5nIGNsb2NrIGNvbmZpZ3MgZm9yIGVhY2ggbm9k
ZSBpbiB0aGUgZGV2aWNlIHRyZWUuIEl0IGFsc28gbG9va3MgdG8gbWUgdGhhdCB0aGUgY2xvY2sg
Y29uZmlncyB5b3UncmUgc3VnZ2VzdGluZyBpbiB0aGlzIHNlcmllcyBhcmUgb25seSByZWxldmFu
dCBmb3IgYSBvbmUgc3BlY2lmaWMgYm9hcmQgKG9yIG1heWJlIGZhbWlseSkuIFlvdSBjb3VsZCBt
b3ZlIG91dCB0aGUgYXNzaWduZWQtY2xvY2sgY29uZmlncyBpbnRvIGEgc2VwYXJhdGUgRFRTSSBm
aWxlIHRoYXQgd2lsbCBiZSBzaGFyZWQgYnkgYWxsIG9mICJhdXRvbW90aXZlIiBib2FyZHMuCgpN
YXliZSBpdCB3aWxsIG1ha2Ugc2Vuc2UgdG8gaGF2ZSBhIGN1c3RvbSBpbml0LXRhYmxlIHRvIGF2
b2lkIHNvbWUgb2YgdGhlIGZhdGFsIGNsb2NrIGNvbmZpZ3VyYXRpb25zIGR1cmluZyBvZiBlYXJs
eSBib290IG9mIHRoZSBrZXJuZWwuIEJ1dCBtYXliZSBpbiB0aGlzIGNhc2Ugd2UgY291bGQganVz
dCBsaW1pdCB0aG9zZSB2aXRhbCBjbG9ja3MgdG8gYSBzYW5lci1jb21tb24gdmFsdWU/ICAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
