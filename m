Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72466C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:12:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB432190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S0L3NlVp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPbJyUZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB432190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TZrFQwQ1INysv9js18bHaUhGubhfz7xuosYZsqKVI+w=; b=S0L3NlVpMpodIG
	6lUL0mWDSGYPeWEqaQQMoz39Z1JRmd+/23r5l03jt8bAFWq1aJJ+D2Dn/PylzMKG9PymYchaCXqUy
	wgwImkW0k4dM5yBIyK+CIJfSJthlPkD6XwiunAi8C0qSk2pZF4zEtpUGA1scYh8hVrwsEvYmTFfKc
	3QQKTgIqgZyyvTAl4xg3NYjQiPzQbO7RJpY56UGnSLli81HdUQefBHCRBnI6yBrWxP0dqI+4OyEVt
	yk+sVs83Zuhs6MetN/YhV/gYDNqNWZZMHgczsxNUSmFvsooBdBcitUpqHqs3g/rSaH5t5iXZOreLi
	JAzaSbK6s9tHdui2RGGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrWb-0000Wt-60; Wed, 13 Feb 2019 10:12:17 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrWX-0000W7-UV
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 10:12:15 +0000
Received: by mail-pl1-x642.google.com with SMTP id o6so928832pls.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 02:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=4PkyRM9LdRS3VccLHP+LNCCOIPvUX0cNYbYPhXWFY7M=;
 b=bPbJyUZ4Y/la1Ew8iVoCMd2F9jAa5gtu9gs6bFMN6NP0+y+n5zAPu7M3kCiT7exsMD
 2pHEnQhP/Li8sE671vCYA6prsfZulzO63qC9t84U4j12PbOcD/5RdqvvDGCUl1L1jyOw
 zFQ0cJPiP+BQg3ZNalayPYdNgEO7xFagnJWxTKu8UJCx7jdyabhYHtBn/PbSaxut1YnD
 ep72hrXYMUDFfygByXibWLRi2Kg4QjLnvTu06QmqDrEpsrECQlTNSJxlSC6riNe7s0dQ
 3PxH/S5rRq1g8BIg7+Do/GMDnReqjrF+l3mfgnPc3IZUdMmmqCwqg2DP8jeeVkCrRts4
 jccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=4PkyRM9LdRS3VccLHP+LNCCOIPvUX0cNYbYPhXWFY7M=;
 b=R4o1Eh3okIOudx4T7p56Mts/Jcdmke9bIXaPoTm7OGH66k4dAdW9Jcr6CX9K6JYTBV
 L+deSTxJfSjXqqEkd4kyUov4/PG6gdorF5V9WNK36VBnesWZwMrCBivkqt68buT6mRZY
 hqNHBIwNVA63URhJicYF45sSqHx0CLDOFO1lsVAmPojkMD4Wq6ejN+X7wMXCDOEr6qs8
 0oCzv3Hbr8PkQNDKnRcJv3vboSKnhuBIki1oi9xZ//8UQxKbMWu3Mbx13sBLhR8YfVdY
 pSdARnNukIbiqW4gC+5QPaG6RskO1GTduCkoQRFhcZXdgLM1GcjSzTDUIGeToIBodnSH
 2MyA==
X-Gm-Message-State: AHQUAuYpyesuvTB7GRcxmS1MPedU+N7UUsFANGLUdl9xhm3y8Xp5UHpq
 MXeN2DVd6YDD/ugeSOn+RI63IA==
X-Google-Smtp-Source: AHgI3IYWwA6lcbc/EsGpZrBVdFTKqR4fupbOcssyJqdXM7th1frwx8mkX0qAnPgaFJw4eRuxBgDX+g==
X-Received: by 2002:a17:902:264:: with SMTP id
 91mr9122566plc.108.1550052733308; 
 Wed, 13 Feb 2019 02:12:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id 22sm7897323pfk.53.2019.02.13.02.12.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 02:12:10 -0800 (PST)
Date: Wed, 13 Feb 2019 15:42:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH 3/3] cpufreq: imx-sc: add i.mx system controller cpufreq
 support
Message-ID: <20190213101207.ggunz5lhlv46r5o6@vireshk-i7>
References: <1550027011-7884-1-git-send-email-Anson.Huang@nxp.com>
 <1550027011-7884-3-git-send-email-Anson.Huang@nxp.com>
 <20190213070904.3oswrjafy6cqedsr@vireshk-i7>
 <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916203C35D82A7667DA3A16F5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_021214_109792_5321F0A6 
X-CRM114-Status: GOOD (  19.77  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTMtMDItMTksIDA4OjQ2LCBBbnNvbiBIdWFuZyB3cm90ZToKPiBIaSwgVmlyZXNoCj4gCj4g
QmVzdCBSZWdhcmRzIQo+IEFuc29uIEh1YW5nCj4gCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+ID4gRnJvbTogVmlyZXNoIEt1bWFyIFttYWlsdG86dmlyZXNoLmt1bWFyQGxpbmFyby5v
cmddCj4gPiBTZW50OiAyMDE55bm0MuaciDEz5pelIDE1OjA5Cj4gPiBUbzogQW5zb24gSHVhbmcg
PGFuc29uLmh1YW5nQG54cC5jb20+Cj4gPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsKPiA+IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOwo+ID4gY2F0
YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IHJqd0Byand5c29ja2ku
bmV0Owo+ID4gQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IERhbmllbCBCYWx1
dGEKPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3NzIDxhbmR5Lmdyb3NzQGxp
bmFyby5vcmc+Owo+ID4gaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IGhlaWtvQHNudGVjaC5k
ZTsgYXJuZEBhcm5kYi5kZTsKPiA+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBqYWdhbkBh
bWFydWxhc29sdXRpb25zLmNvbTsKPiA+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IG1h
cmMudy5nb256YWxlekBmcmVlLmZyOyBvbG9mQGxpeG9tLm5ldDsKPiA+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LQo+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBk
bC1saW51eC1pbXggPGxpbnV4LQo+ID4gaW14QG54cC5jb20+Cj4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIDMvM10gY3B1ZnJlcTogaW14LXNjOiBhZGQgaS5teCBzeXN0ZW0gY29udHJvbGxlciBjcHVm
cmVxCj4gPiBzdXBwb3J0Cj4gPiAKPiA+IE9uIDEzLTAyLTE5LCAwMzowOSwgQW5zb24gSHVhbmcg
d3JvdGU6Cj4gPiA+IE9uIE5YUCdzIGkuTVggU29DcyB3aXRoIHN5c3RlbSBjb250cm9sbGVyIGlu
c2lkZSwgQ1BVIGZyZXF1ZW5jeQo+ID4gPiBzY2FsaW5nIGNhbiBPTkxZIGJlIGRvbmUgYnkgc3lz
dGVtIGNvbnRyb2xsZXIgZmlybXdhcmUsIGFuZCBpdCBjYW4KPiA+ID4gT05MWSBiZSByZXF1ZXN0
ZWQgZnJvbSBzZWN1cmUgbW9kZSwgc28gTGludXggY3B1ZnJlcSBkcml2ZXIgaGFzIHRvCj4gPiA+
IGNhbGwgQVJNIFNNQyB0byB0cmFwIHRvIEFSTS1UcnVzdGVkLUZpcm13YXJlIHRvIHJlcXVlc3Qg
c3lzdGVtCj4gPiA+IGNvbnRyb2xsZXIgZmlybXdhcmUgdG8gZG8gQ1BVIGZyZXF1ZW5jeSBzY2Fs
aW5nLgo+ID4gPgo+ID4gPiBUaGlzIHBhdGNoIGFkZHMgaS5NWCBzeXN0ZW0gY29udHJvbGxlciBj
cHVmcmVxIGRyaXZlciBzdXBwb3J0LCB3aGVuCj4gPiA+IGRvaW5nIENQVSBmcmVxdWVuY3kgc2Nh
bGluZywgY3B1ZnJlcSBkcml2ZXIgd2lsbCBkbyBBUk0gU01DIGNhbGwgYW5kCj4gPiA+IHRyYXAg
dG8gQVJNLVRydXN0ZWQtRmlybXdhcmUsIHRoZW4gU0lQKHNpbGljb24gcHJvdmlkZXIpIHNlcnZp
Y2Ugd2lsbAo+ID4gPiBjb21tdW5pY2F0ZSB3aXRoIHN5c3RlbSBjb250cm9sbGVyIGZvciBDUFUg
ZnJlcXVlbmN0IHNjYWxpbmcuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPgo+ID4gPiAtLS0KPiA+ID4gIGRyaXZlcnMvY3B1ZnJlcS9L
Y29uZmlnLmFybSAgICAgIHwgICA5ICsrCj4gPiA+ICBkcml2ZXJzL2NwdWZyZXEvTWFrZWZpbGUg
ICAgICAgICB8ICAgMSArCj4gPiA+ICBkcml2ZXJzL2NwdWZyZXEvaW14LXNjLWNwdWZyZXEuYyB8
IDE4Mwo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgMTkzIGluc2VydGlvbnMoKykKPiA+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL2NwdWZyZXEvaW14LXNjLWNwdWZyZXEuYwo+ID4gCj4gPiBXaHkgY2FuJ3Qg
eW91IHVzZSBjcHVmcmVxLWR0IGRyaXZlciBsaWtlIGV2ZXJ5b25lIGVsc2UgPwo+IAo+IEp1c3Qg
bm90aWNlIHRoYXQgd2UgY2FuIG92ZXJ3cml0ZSB0aGUgc2V0X3RhcmdldCBpZiB1c2luZyBjcHVm
cmVxLWR0LCB0aGVuIHdlIHN0aWxsCj4gbmVlZCBhIHBsYXRmb3JtIGNwdWZyZXEgZmlsZSB0byBp
bXBsZW1lbnQgYXJjaF9zZXRfZnJlcV9zY2FsZSgpLCBJIGNhbiB1c2UgaXQgdG8gc2F2ZQoKV2h5
IGRvIHlvdSBuZWVkIHRvIGltcGxlbWVudCBhcmNoX3NldF9mcmVxX3NjYWxlKCkgPyBJdCBpcyBh
bHJlYWR5CmRlZmluZWQgZm9yIGFybTY0IEkgYmVsaWV2ZS4KCj4gdGhlIGNvZGUgb2YgaW14IHN5
c3RlbSBjb250cm9sbGVyIGNwdWZyZXEgZHJpdmVyLCBhbmQgQlRXLCBjYW4gY3B1ZnJlcS1kdCBz
dXBwb3J0Cj4gbXVsdGkgY2x1c3RlcnMgY3B1ZnJlcT8gQXMgaS5NWDhRTSBoYXMgMiBjbHVzdGVy
cyBydW5uaW5nIHdpdGggZGlmZmVyZW50IE9QUHMuCgpZZXMsIGl0IHN1cHBvcnRzIG11bHRpLWNs
dXN0ZXIuCgotLSAKdmlyZXNoCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
