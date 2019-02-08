Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B115C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:50:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B97921907
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z1PqBRvX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMcscsj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B97921907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h+gADkfDWavrmuitB46rwhYPMzmG7xd8i1nh2wufz7E=; b=Z1PqBRvXlmIJUb
	e2jGbiCOK2U89M5qi98DQrmvrFYjngYfzYy/K8W+17bjW57j5oZmKgvjXgnQovPe0s4BIdoukfdfo
	BcktGsjcPjD7PPPyGvXdalQSRDJ3vlHq4WDUnUKtl4sUSPCM+jZ1H5giYAG8qMSiy4BMVhM8ohsPr
	Nw9arpUr5QVAIvUZLMzKyg4Nan+I+zUsNjNyr5u8ESOX0RxLyD542bv204+b0z49WHR/MEU3fkyL0
	7e+GOFDsrbzNQ7zmOvU9yWVRvbFpujMCYOkbYxQ27NK/z9q+KxIZziUv/4z04wFXfOchO6dSOn2ua
	azNSdutMiNLIOuZaHD0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gruNS-0000Uw-Ug; Fri, 08 Feb 2019 00:50:46 +0000
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gruNP-0000U5-GP
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:50:44 +0000
Received: by mail-ot1-x332.google.com with SMTP id e24so3143363otp.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HVX8rr1eEmYNnSCBWoFDkJxWT8KNaY8PcA/mXMC8Mow=;
 b=QMcscsj5XAIQYzV0LeNxRBsmYQQP4tN7MoHmLzjFIIrvM6SP1oc/+gAu/VOetWxCLb
 cwjk34nEeHq0Se+51Pt4r5GJZGWEze3EoAe/Jco9WslUctu7Eeg50WqMeIdEUypxIZsV
 bIVFuA9wbyYW0Cfw0D3iwlMS+1UmR2QNsYJBMS0sEqes/oEfbY1K2DI9sLfRS0NdnxSg
 ZbioWYx2LzrnKaZSs6R6GMUTmR7odxhojBEMthVhD1fZ5CCZUZvWho/c+/2OZFkN/HgH
 ws72H4qecgSU6XK2Mynw7e504OKm4ETr6kocdSR5ec0eALAJz7oYlnOYJbjIcsE9dRIE
 BnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HVX8rr1eEmYNnSCBWoFDkJxWT8KNaY8PcA/mXMC8Mow=;
 b=ksDw4dRy15KaXSYoEvIrEc4uf4SdAQCiTgxSo4ogMl/gOVe89D2wkmj04tvT7pGs1t
 0Cemz4NHjE9y1/jb9xzdmAgVFPBSk4Ff9E0nQTO1vtQhP2Gr9sT84SCzytssGvg1vFP0
 RocjFfIXRvOI0Sa6q5v8XP1/i6KXUUU4IXPievP9qw4YdJevNcsw2sU1CywHUaRM7CDT
 5CccpCHoublPGnr/CRObj7HIVmBUP7ooWmqGb34yI7uNS//pXadTB4MeGtxTSAmGqq/b
 xM/uPMOqSmnAD2K+SBEr9c5z1lhjGkGrERVtGIfRQEO7G86k/lqF+qdUK7Le2qnQ/d+q
 QLhA==
X-Gm-Message-State: AHQUAuYV28URQm7cHzOsNDWay0/g4HKymw3OmQTNZI1xCMkUS9eWDTH9
 cjopKwmuXuco6dUvPvSPP4/NkdWh4bwjvmEmQas=
X-Google-Smtp-Source: AHgI3Ia18v7BZWfEroKirwRuuwATIf7BhF7uBIMxN/YqS1Y2ohYTCIza0NTPqB6WaUeWNHhlx24HPaRhmra1edWEoXs=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr11120598otp.225.1549587042164; 
 Thu, 07 Feb 2019 16:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20190207225211.GA17552@latitude>
In-Reply-To: <20190207225211.GA17552@latitude>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Feb 2019 22:50:28 -0200
Message-ID: <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock is
 disabled
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_165043_553731_0A193978 
X-CRM114-Status: GOOD (  15.98  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Michael Turquette <mturquette@baylibre.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSm9uYXRoYW4sCgpPbiBUaHUsIEZlYiA3LCAyMDE5IGF0IDg6NTIgUE0gSm9uYXRoYW4gTmV1
c2Now6RmZXIKPGoubmV1c2NoYWVmZXJAZ214Lm5ldD4gd3JvdGU6Cj4KPiBIaSwKPgo+IEknbSBj
dXJyZW50bHkgcG9ydGluZyBtYWlubGluZSBMaW51eCB0byBhbiBpLk1YNTA3LWJhc2VkIGJvYXJk
Cj4gKHByZWxpbWluYXJ5IERUIGhlcmVbMV0pLiBSZWNlbnRseSBJJ3ZlIGVuYWJsZWQgZXNkaGMx
IGluIHRoZQo+IGRldmljZXRyZWUuCj4KPiBIb3dldmVyLCBhcyBzb29uIGFzIHRoZSBtbWMgZHJp
dmVyIChzZGhjaS1lc2RoYy1pbXguYykgZGlzYWJsZXMgY2xrX3Blcgo+IGluIHNkaGNpX2VzZGhj
X3J1bnRpbWVfc3VzcGVuZFsyXSwgdGhlIHdob2xlIHN5c3RlbSBsb2NrcyB1cCBpbiBzb21lIHdh
eS4KPiBCb290aW5nIHdpdGggQ09ORklHX1BNPW4gImZpeGVzIiB0aGUgcHJvYmxlbTsgY29tbWVu
dGluZyBvdXQgdGhlCj4gb2ZmZW5kaW5nIGxpbmUgaW4gc2RoY2lfZXNkaGNfcnVudGltZV9zdXNw
ZW5kIGxldHMgdGhlIHN5c3RlbSBzdXJ2aXZlLAo+IGJ1dCBsZWF2ZXMgdGhlIE1NQyBjb250cm9s
bGVyIGluIGFuIHVudXNhYmxlIHN0YXRlIChvZiBjb3Vyc2UgaXQncyBub3QgYQo+IHByb3BlciBz
b2x1dGlvbiBhbnl3YXkpLgo+Cj4gSSB0cmllZCB0byBjb21wYXJlIHRoZSBDQ00ncyBjbG9ja3Mg
YmV0d2VlbiBpLk1YNTAgYW5kIGkuTVg1MywgYnV0Cj4gdW5mb3J0dW5hdGVseSwgdGhlIGkuTVg1
MCByZWZlcmVuY2UgbWFudWFsIGRvZXNuJ3QgaGF2ZSB0aGUgdGFibGUgY2FsbGVkCj4gIk91dHB1
dCBjbG9ja3MgZnJvbSBDQ00iLgoKUGxlYXNlIGNoZWNrIFRhYmxlIDUtMTAuIENDTV9DQ0dSMyBH
YXRlZCBDbG9jayBNYXBwaW5nIHRvIFRhcmdldApNb2R1bGUgZnJvbSB0aGUgTVg1MCBSZWZlcmVu
ZSBNYW51YWwuCgo+Cj4gRG9lcyBhbnlvbmUgaGF2ZSBhbnkgaWRlYXMgb3IgcGF0Y2hlcyB0aGF0
IEkgY291bGQgdHJ5IGluIG9yZGVyIHRvCj4gbmFycm93IHRoZSBwcm9ibGVtIGZ1cnRoZXIgZG93
bj8KCkRvZXMgdGhlIGNoYW5nZSBiZWxvdyBoZWxwPwoKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NTAuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg1MC5kdHNpCkBAIC0xMDIsNyAr
MTAyLDcgQEAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
eDUwMDA0MDAwIDB4NDAwMD47CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnRlcnJ1cHRzID0gPDE+OwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY2xvY2tzID0gPCZjbGtzCklNWDVfQ0xLX0VTREhDMV9JUEdfR0FURT4sCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsa3MgSU1YNV9DTEtfRFVN
TVk+LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZj
bGtzCklNWDVfQ0xLX0VTREhDMV9JUEdfR0FURT4sCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8JmNsa3MKSU1YNV9DTEtfRVNESEMxX1BFUl9HQVRFPjsK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImlw
ZyIsICJhaGIiLCAicGVyIjsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJ1cy13aWR0aCA9IDw0PjsKQEAgLTExNCw3ICsxMTQsNyBAQAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4NTAwMDgwMDAgMHg0MDAwPjsKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8Mj47CiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmNsa3MKSU1YNV9DTEtf
RVNESEMyX0lQR19HQVRFPiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDwmY2xrcyBJTVg1X0NMS19EVU1NWT4sCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsa3MKSU1YNV9DTEtfRVNESEMyX0lQR19HQVRF
PiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xr
cwpJTVg1X0NMS19FU0RIQzJfUEVSX0dBVEU+OwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiaXBnIiwgImFoYiIsICJwZXIiOwogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVzLXdpZHRoID0gPDQ+OwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
