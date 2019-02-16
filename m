Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:13:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE7A222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 01:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rlLGPALC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eysGb+nV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE7A222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0JpFtQRcr6uuVYBEl2DA35pIvBDRJ9AC53wQLvePCIA=; b=rlLGPALCAtRv9x
	0/vzcS23Z5GaIW559qklz+8i5lNk0IYqMSADOyO7CvIMsJIkvCj8Pbj2LmyrW2XMiThtN4sP90Y+C
	7POSPi0uNYP6WeP9Ij3UYEgyh8IRSDaN0mnE2I4NEy208RAllY28Ij9jpzeGq0ombQbP7vqVZGosn
	b4hiecFVoZa275LqPZjIBI6bOT1zN0pJfjW3MBTvg+Sahru32WWDNcXE5FfZOF0n6t/eSTezarfcL
	2gifqQgpDROugmtDi06NTuqEgw1ZYQz5iAXtUUKn+VncZeVESyx2B228pXmT2tmATqHIY5+jmhaaC
	YoNEadISOrY4+qMFgymw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guoY3-0001yQ-Av; Sat, 16 Feb 2019 01:13:43 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guoY0-0001xJ-HH
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 01:13:42 +0000
Received: by mail-ot1-x341.google.com with SMTP id t7so3296321otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/J++2veKGNq70nHjhGrI31XfrWth14XreBo/zeUPb+U=;
 b=eysGb+nVwWZZfzv3JEXH92iljbM+6DT6EsdbB5vrOcUBdUImmp5udiu+bfmOAm9EGz
 egQhOHxiyHdbmNHALCGtaYC2IJ8PLmb1hGuuDXynejz43TPnshmbut31RAJk8VMNodRZ
 8W+ivG1aeDlSmmNAglgd3lQyUXA9IsaLtQLXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/J++2veKGNq70nHjhGrI31XfrWth14XreBo/zeUPb+U=;
 b=K+mOKV3dnKmkKglHNG8iTC4ezbLoMuLMPz2TSHO/RO+Kgy+7lxqFoEnsCRirSCYXlp
 Cvp0zoCYlvOT3vdTNEiRx54Br7Gj2efnIj9dSm43nPMSCNtnermg20l9ufQqsipujH8i
 ePswFW/GByUc1e5xHyGNP6gcHilXjei6VbVhg9ZTIeGvUL7pwTLh9iolYM4SHMNdR/x2
 DEOZrgSSdQV7xNrOKFmntUTClb2jy7d0apM8FVSlMM/OlUyhJmTQ4YUuERDykJdLFqWh
 cS8lGh1CcIUI3bBTW7jJh9Vxq6pNqNlEZPrLc7FsqHCTa+U2bnYfm+OhXxICM7k3npDe
 ZVDA==
X-Gm-Message-State: AHQUAubDNc7mxOi0W7NpXS9RnJ8ahXYBH2pksX+h5ian9oNfUIGicoLn
 T07z3PsmCCCAaLMRJ/ZdeVcYeCYeqXA=
X-Google-Smtp-Source: AHgI3IZHE8dkaQDEhDTXCFIJV1EPLCXWS1LNlSkEE/H05k/QGmYEKmJ7CyMD8iZQq88r73YwMzphUw==
X-Received: by 2002:aca:af85:: with SMTP id y127mr7601027oie.83.1550279619021; 
 Fri, 15 Feb 2019 17:13:39 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com.
 [209.85.210.43])
 by smtp.gmail.com with ESMTPSA id n76sm3900637ota.51.2019.02.15.17.13.36
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 17:13:36 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id w25so19608077otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 17:13:36 -0800 (PST)
X-Received: by 2002:aca:dac6:: with SMTP id r189mr7790584oig.52.1550279616017; 
 Fri, 15 Feb 2019 17:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20190215115150.32299-1-enric.balletbo@collabora.com>
 <22158501.cNvkU8jGDh@diego>
In-Reply-To: <22158501.cNvkU8jGDh@diego>
From: Alexandru M Stan <amstan@chromium.org>
Date: Fri, 15 Feb 2019 17:13:25 -0800
X-Gmail-Original-Message-ID: <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
Message-ID: <CAHNYxRzyVjLbT00ryBBkqK67JKFs7bvFR=G=rdvVa_o-q8zN9Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: add chosen node on veyron chromebooks
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_171340_571120_4190428E 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBGZWIgMTUsIDIwMTkgYXQgMzowOSBQTSBIZWlrbyBTdMO8Ym5lciA8aGVpa29Ac250
ZWNoLmRlPiB3cm90ZToKPgo+IEhpIEVucmljLAo+Cj4gQW0gRnJlaXRhZywgMTUuIEZlYnJ1YXIg
MjAxOSwgMTI6NTE6NTAgQ0VUIHNjaHJpZWIgRW5yaWMgQmFsbGV0Ym8gaSBTZXJyYToKPiA+IElu
IG9yZGVyIHRvIHVzZSBlYXJseWNvbiwgdGhlIHN0ZG91dC1wYXRoIHByb3BlcnR5IG5lZWRzIHRv
IGJlIHNldAo+ID4gaW4gdGhlIGNob3NlbiBub2RlLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEVu
cmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+Cj4KPiBX
aGF0J3MgdGhlIHJlYXNvbiBmb3IgYWRkaW5nIHRoaXMgb25seSBmb3IgdGhlIENocm9tZWJvb2sg
dmFyaWFudHM/Cj4gVWFydDIgaXMgcHJldHR5IG11Y2ggdGhlIHN0YW5kYXJkIG91dHB1dCBmb3Ig
YWxsIGRldmljZXMsIHNvIEknZCBhc3N1bWUKPiBhdCBsZWFzdCBhbGwgdmV5cm9uIGJvYXJkcyBz
aG91bGQgdXNlIHVhcnQyIGFzIHdlbGwsIG1ha2luZyB0aGlzIGlkZWFsbHkKPiBsaXZlIGluIHRo
ZSByazMyODgtdmV5cm9uLmR0c2kgaW5zdGVhZD8KClllcCwgYWxsIHZleXJpYW50cyB1c2UgdWFy
dCAyLCBldmVuIHdoZW4gdGhleSdyZSBub3QgY2hyb21lYm9va3MuCkZlZWwgZnJlZSB0byBwdXQg
aXQgaW4gdGhlIG90aGVyIGZpbGUgaW5zdGVhZC4KCk90aGVyd2lzZSBpdCdsbCBtYWtlIHRoaW5n
cyBsaWtlIHRoZSBBc3VzIENocm9tZWJpdCAobWlja2V5KSwgQU9wZW4KQ2hyb21lYm94IG1pbmkg
KGZpZXZlbCksIGFuZCBBT3BlbiBDaHJvbWViYXNlICh0aWdlcikgdW5oYXBweQp3aGlsZSBkZWJ1
Z2dpbmcuCgpUaGUgcmszMjg4LXZleXJvbi1jaHJvbWVib29rLmR0c2kgZmlsZSBpcyBtb3JlIGZv
ciB0aGluZ3MgdGhhdCBtYWtlCmEgY2hyb21lYm9vayBwb3J0YWJsZS4gRXg6IGJ1aWx0IGluIGRp
c3BsYXksIGxpZCBzd2l0Y2gsIGNyb3MtZWMuCgpOb3RlIGhvdyB3ZSBoYXZlIG5vIHVhcnQyIHJl
ZmVyZW5jZXMgZWl0aGVyIGluIG91ciB0cmVlIGluIHRoZQpjaHJvbWVib29rIHNwZWNpZmljIGR0
c2k6Cmh0dHBzOi8vY2hyb21pdW0uZ29vZ2xlc291cmNlLmNvbS9jaHJvbWl1bW9zL3RoaXJkX3Bh
cnR5L2tlcm5lbC8rL2Nocm9tZW9zLTMuMTQvYXJjaC9hcm0vYm9vdC9kdHMvcmszMjg4LXZleXJv
bi1jaHJvbWVib29rLmR0c2kKCkFsZXhhbmRydSBTdGFuIChhbXN0YW4pCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
