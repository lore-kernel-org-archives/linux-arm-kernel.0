Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92591C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:43:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4BB20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i6EGVFxL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+a9OcOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4BB20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Brqb9UgMiOCPdRVNgEWmN7C0grV3SgMiPwFJQSn8II=; b=i6EGVFxLi9NvSy
	OPPeyFpKp2ySpDA67rfLpee9+aoyhfSgLm9I3HcFsdXLOD1zuQnL3FR2YTTJ381jp+I7AOJBppHjB
	Jrswwf4zFJzky5l8QStLCB5y4bTbmE0Gt5BPdFt0Tgq/MgZwzSZZYyxmAwInJmqu4oKcgUTCgObrG
	ew6J+ue1E9xiUk3cnYNQ8u1CXinlsQ8ZIUxg8jDgkqC7SVOk9ohAry/sJT/jIlWGmJPJjCKw+yxMR
	c5pkspMN6QbQ5BPG23cXs0wg0D83H3ylCyKFtxUuFHpa9Xlyw2y1WjBnr8S6P8SAH6Ofwn1J32Tat
	FwZ2yhmPA211gIZNUN+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjFv-00032v-P2; Tue, 11 Dec 2018 14:43:27 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjDX-0001pM-N6
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 14:41:21 +0000
Received: by mail-ot1-x342.google.com with SMTP id n8so14214699otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 06:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=8h97DuT0MBx9loXjcSrMN+imn6MuDC6J319x0ZsFJZM=;
 b=e+a9OcOuoCEd6qXQ60fjfA6PEzhOfAfXDFkpbkKFXKwKru559EmE9xeCYKgunGwXLz
 O3+B9MGke1IZgeuyB5v18nbtmRoYoV4a4fQNlobbkJMcR20hPg2dgqCJjrfDA9lnA4Bh
 NlaEBuPn2R1sUtg4NTOMJPCfP00kT+XuarJHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=8h97DuT0MBx9loXjcSrMN+imn6MuDC6J319x0ZsFJZM=;
 b=JaJJOUnyNdp1hM5/7N/wOB2p+SRXBS9Y+Xgpoj6afIljbwelw7fOm8xyP/x+0JCgKd
 bnkMdzIaGyZc5PZOCzc99LXhW4SC7QEnOIx6KTnlNTPOV2beuVWhGQdgDuFBYRxfusfL
 sWKMtZDPSadjXkTZ+HvY6nN5hJ56DWimo7iWKpy9YDVklxBjApNVQ8tA8fdc4SAZk+vn
 1o3fV+m+4D5TbSemuiSrqCxVFlx7LGLILLUJIhZxYCQrRuFiOUELmNH77gC4NhuHHQ14
 r8LnB9MxVlyenGpbmUBNq0OVvBX5PdxmgO9ttXK1a18gD1tWYLucnPwUjQ6CpeFVzmuW
 Ojaw==
X-Gm-Message-State: AA+aEWYir+Pnblm8yNuBhgo6j76WHE7v/i7ZUPvN6rZc8782KAA+06ms
 unahTG2sSvJL4eYk0ygH4G/fkA==
X-Google-Smtp-Source: AFSGD/X2OFEpy7kbyAYWioTAFUf62S4T1lV+m1tWWtEMbr/PlhBhm7L/2UIxQxSrOjHv1P0nbdhrOA==
X-Received: by 2002:a9d:17ca:: with SMTP id j68mr10821150otj.268.1544539248361; 
 Tue, 11 Dec 2018 06:40:48 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:79bb:a266:cd71:3186])
 by smtp.gmail.com with ESMTPSA id u109sm6354021otb.8.2018.12.11.06.40.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 06:40:47 -0800 (PST)
Date: Tue, 11 Dec 2018 08:40:46 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
Message-ID: <20181211144046.GB25288@hector.attlocal.net>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
 <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
 <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
 <20181210190513.GA25288@hector.attlocal.net>
 <84d1b299-2898-2df3-8b78-f9510f7bc229@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84d1b299-2898-2df3-8b78-f9510f7bc229@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_064100_520939_BD9F4359 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 arm@kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMTAsIDIwMTggYXQgMTE6MzY6NDhQTSArMDIwMCwgU3RhbmltaXIgVmFyYmFu
b3Ygd3JvdGU6Cj4gCj4gCj4gT24gMTAuMTIuMTgg0LMuIDIxOjA1INGHLiwgQW5keSBHcm9zcyB3
cm90ZToKPiA+T24gTW9uLCBEZWMgMTAsIDIwMTggYXQgMDI6MjA6NDdQTSArMDIwMCwgU3Rhbmlt
aXIgVmFyYmFub3Ygd3JvdGU6Cj4gPj5IaSBBbmR5LAo+ID4+Cj4gPj5PbiAxMi84LzE4IDc6MTMg
QU0sIEFuZHkgR3Jvc3Mgd3JvdGU6Cj4gPj4+VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNv
bW1pdCBiNjAxZjczMTMwYTM3NWM5MTJkOWYyZWM5M2M1ZjNjZWE1ZDZhM2RhOgo+ID4+Pgo+ID4+
PiAgIGRybTogbXNtOiBDaGVjayBjbWRfZGJfcmVhZF9hdXhfZGF0YSgpIGZvciBmYWlsdXJlICgy
MDE4LTExLTI5IDE3OjQxOjUzIC0wNjAwKQo+ID4+Pgo+ID4+PmFyZSBhdmFpbGFibGUgaW4gdGhl
IGdpdCByZXBvc2l0b3J5IGF0Ogo+ID4+Pgo+ID4+PiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9hZ3Jvc3MvbGludXguZ2l0IHRhZ3MvcWNvbS1kcml2ZXJz
LWZvci00LjIxLTIKPiA+Pj4KPiA+Pj5mb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gOTJk
ZWYwNGJkN2I0NmY1YjE4NmY5ODVkNWM5ZDM4MDQ4NThjM2MyZjoKPiA+Pj4KPiA+Pj4gICBNQUlO
VEFJTkVSUzogQ2hhbmdlIFRvZG9yIFRvbW92J3MgZW1haWwgYWRkcmVzcyAoMjAxOC0xMi0wNSAx
Njo0NTozNCAtMDYwMCkKPiA+Pj4KPiA+Pj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPj4+UXVhbGNvbW0gQVJNIEJhc2Vk
IERyaXZlciBVcGRhdGVzIGZvciB2NC4yMSBQYXJ0IDIKPiA+Pj4KPiA+Pj4qIEZpeCBNQUlOVEFJ
TkVSUyBlbWFpbCBhZGRyZXNzIGZvciBUb2Rvcgo+ID4+PiogRml4IFNDTSBjb21waWxhdGlvbiBl
cnJvcgo+ID4+Pgo+ID4+Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+Pj5Kb25hdGhhbiBNYXJlayAoMSk6Cj4gPj4+ICAg
ICAgIGZpcm13YXJlOiBxY29tOiBzY206IGZpeCBjb21waWxhdGlvbiBlcnJvciB3aGVuIGRpc2Fi
bGVkCj4gPj4+Cj4gPj4+VG9kb3IgVG9tb3YgKDEpOgo+ID4+PiAgICAgICBNQUlOVEFJTkVSUzog
Q2hhbmdlIFRvZG9yIFRvbW92J3MgZW1haWwgYWRkcmVzcwo+ID4+Cj4gPj5JIHNhdyB0aGlzIHBh
dGNoIGlzIGFwcGxpZWQgYWxzbyBpbiBtZWRpYV90cmVlLmdpdCwgbm90IHN1cmUgdGhhdCBpcwo+
ID4+cHJvYmxlbSB0aG91Z2guCj4gPgo+ID5XaGljaCBvbmU/ICBUaGUgbWFpbnRhaW5lciBvciB0
aGUgc2NtPwo+IAo+IHRoZSBtYWludGFpbmVyIG9uZS4KCkFoIG9rLiAgSSBjYW4gZHJvcCB0aGF0
IGFuZCByZXNlbmQgdGhlIFBSLiAgTm90IGEgYmlnIGRlYWwuCgpPbG9mLEFybmQsIEtldmluLAoK
SG9sZCBvZmYgb24gdGhpcyBvbmUgdW50aWwgSSBzZW5kIGEgcmV2aXNlZCBwdWxsIHJlcXVlc3Qu
CgoKVGhhbmtzIQpBbmR5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
