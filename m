Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067C7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:20:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C793D20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MnuI9EDP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN2yG6j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C793D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kwLo3sn7dPhKUV5OUN3p6hOP69Humzmc8/+hbzntF3w=; b=MnuI9EDPvliCqB/a61Eujynar
	RYj69If0JufZq6jF0R0YcKjAPLrL7hQ8kFYsZIiRwC45OV+HVUTEzIPZnODdhrwDHcGvnBrRKn9q0
	l5G+gqY/E+Nu5CBJgK9TDKOnZoBxzXmwtNJftPwLtfde6M14Mq9nz8TkrjxP/QZ8QTsPiBDw/+gVC
	iqNuRv8+ThvGrufVrbaesmvSLrhmti5O1hvSA2ae3LQMsHsWrlhHNNRVhfg/vqbyOKJobrB8k9zxp
	4trtWgy/Hnd/SmUuemzn2ardlkTxIpBzg/6e0IOm6P8zeEhJVyrZtmnZ2XMk3NUZ3w2PFY54AIYqD
	YZQRHFM9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxkL8-0004eg-LV; Sun, 24 Feb 2019 03:20:30 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxkL4-0004eL-Ex
 for linux-arm-kernel@lists.infradead.org; Sun, 24 Feb 2019 03:20:28 +0000
Received: by mail-pf1-x441.google.com with SMTP id i20so2889972pfo.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 19:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yiEhL0DGWWum/tuGZwjPTbXUSmgMoh8TiLPmsv85WSw=;
 b=bN2yG6j4ZAgHA0RKnJA1/KiYbgp2tIcvSiJAh/tRE2byCafAFshloQTv5u74uwO2vF
 +2PzIn2wCXbo2hx6UynbB8bMMhQfMyHES+4uol2MtrQRxtGtOEWklumSik7YYjuKXZtc
 EeKou036QEjedNaOH8k4p26kBDMA/nwVRBrFTQN2Ft13Bm5X9A/aZAnM5gkh146VZkW7
 Ori9ea/+BWiYRgt7M7QXAHW2NrtUSOvDRBZIFwikw7Sbxr9COy0orYAZ+1lB2Y3PBTQ1
 /j34DjE+4uJtRf/1LJmhmE8C3FZQ/S0UMbGPhLkqY8uDJ9OVYiUUQZnPwo+zJfeASGWG
 Scbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yiEhL0DGWWum/tuGZwjPTbXUSmgMoh8TiLPmsv85WSw=;
 b=N33HvTvWPaIu97XnzgFbRd3bXqyrtteRMIzHx7gxj6kwyDIp9CtRW4rDYux6npv93v
 IP3IwcBD2PdyDNxvhCMhP8Uu0PXEkAJXsZWof1gYsTN3UDnkbDPVDXwm7PSNkpzFt9GT
 JOUrrHdVze1t93ZyY+IqH9LXFdMFHvAq7MZU5GNV7dQVwQoKIeWNWssVMB6lOpGMI/uX
 OzckY6jTnIWPcL+idJogvasQehB6k9siacRZMSpJfSolEpT90WmHDuF+m1CWAsW+hBJd
 b5a3XRwqWyC9gZcaRx6h1ub84kKXUmHDvG9iXHo5CcB+UxsKVGOHgfOMi0PhJfaJPLRk
 Ma4g==
X-Gm-Message-State: AHQUAuaUMtw50iqhB9Y6U+ubCErwCCLU2LOEy08Bh7o30efzt4DKa8y8
 I2pZIoupIYLs++NMft46B9Y=
X-Google-Smtp-Source: AHgI3IbiOQqXR+RZh8mTx3E1ae/YnWqBttKtFDpsey9lZvn/HvlENxDb/VSTHAj+2q4kNtp9c5wLcQ==
X-Received: by 2002:a63:aa46:: with SMTP id x6mr11416392pgo.452.1550978425602; 
 Sat, 23 Feb 2019 19:20:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d131sm9830977pfd.108.2019.02.23.19.20.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 19:20:24 -0800 (PST)
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
To: Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
Date: Sat, 23 Feb 2019 19:20:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_192026_534941_094D1E0B 
X-CRM114-Status: GOOD (  24.40  )
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
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8yMy8xOSA3OjA0IFBNLCBBbnNvbiBIdWFuZyB3cm90ZToKPiBIaSwgR3VlbnRlci9Sb2IK
PiAKPiBCZXN0IFJlZ2FyZHMhCj4gQW5zb24gSHVhbmcKPiAKPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0KPj4gRnJvbTogR3VlbnRlciBSb2VjayBbbWFpbHRvOmdyb2VjazdAZ21haWwuY29t
XSBPbiBCZWhhbGYgT2YgR3VlbnRlcgo+PiBSb2Vjawo+PiBTZW50OiAyMDE55bm0MuaciDI05pel
IDE6MDgKPj4gVG86IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBBbnNvbiBIdWFuZyA8
YW5zb24uaHVhbmdAbnhwLmNvbT4KPj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1
b0BrZXJuZWwub3JnOwo+PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsKPj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdp
bGwuZGVhY29uQGFybS5jb207IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7Cj4+IEFpc2hlbmcgRG9u
ZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBEYW5pZWwK
Pj4gQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3NzIDxhbmR5Lmdyb3Nz
QGxpbmFyby5vcmc+Owo+PiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgaGVpa29Ac250ZWNo
LmRlOyBhcm5kQGFybmRiLmRlOwo+PiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgamFnYW5A
YW1hcnVsYXNvbHV0aW9ucy5jb207Cj4+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IG1h
cmMudy5nb256YWxlekBmcmVlLmZyOyBvbG9mQGxpeG9tLm5ldDsKPj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0KPj4g
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVsLm9y
ZzsgZGwtbGludXgtaW14Cj4+IDxsaW51eC1pbXhAbnhwLmNvbT4KPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBSRVNFTkQgVjIgMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZCB3YXRjaGRvZwo+
PiBiaW5kaW5nCj4+Cj4+IE9uIDIvMjIvMTkgMTE6NTIgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOgo+
Pj4gT24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgMDY6NTM6NDhBTSArMDAwMCwgQW5zb24gSHVhbmcg
d3JvdGU6Cj4+Pj4gQWRkIGkuTVg4UVhQIHN5c3RlbSBjb250cm9sbGVyIHdhdGNoZG9nIGJpbmRp
bmcuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4KPj4+PiAtLS0KPj4+PiBDaGFuZ2VzIHNpbmNlIFYxOgo+Pj4+IAktIHVwZGF0ZSBkdHMg
bm9kZSBuYW1lIHRvICJ3YXRjaGRvZyI7Cj4+Pj4gLS0tCj4+Pj4gICAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgfCAxMAo+PiArKysr
KysrKysrCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPj4+Pgo+Pj4+
IGRpZmYgLS1naXQKPj4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
ZnJlZXNjYWxlL2ZzbCxzY3UudHh0Cj4+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dAo+Pj4+IGluZGV4IDRiNzk3NTEuLmYzODhl
YzYgMTAwNjQ0Cj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9mcmVlc2NhbGUvZnNsLHNjdS50eHQKPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dAo+Pj4+IEBAIC0xMzYsNiArMTM2
LDEyIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6Cj4+Pj4gICAgCQkJICAgcmVzb3VyY2UgaWQgZm9y
IHRoZXJtYWwgZHJpdmVyIHRvIGdldCB0ZW1wZXJhdHVyZQo+PiB2aWEKPj4+PiAgICAJCQkgICBT
Q1UgSVBDLgo+Pj4+Cj4+Pj4gK1dhdGNoZG9nIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdl
IFByb3RvY29sCj4+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4+ICsKPj4+PiArUmVxdWlyZWQgcHJvcGVydGllczoKPj4+
PiArLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXdkdCI7Cj4+Pj4gKwo+
Pj4+ICAgIEV4YW1wbGUgKGlteDhxeHApOgo+Pj4+ICAgIC0tLS0tLS0tLS0tLS0KPj4+PiAgICBs
c2lvX211MTogbWFpbGJveEA1ZDFjMDAwMCB7Cj4+Pj4gQEAgLTE4OCw2ICsxOTQsMTAgQEAgZmly
bXdhcmUgewo+Pj4+ICAgIAkJCXRzZW5zLW51bSA9IDwxPjsKPj4+PiAgICAJCQkjdGhlcm1hbC1z
ZW5zb3ItY2VsbHMgPSA8MT47Cj4+Pj4gICAgCQl9Owo+Pj4+ICsKPj4+PiArCQl3YXRjaGRvZzog
d2F0Y2hkb2cgewo+Pj4+ICsJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXdkdCI7Cj4+
Pgo+Pj4gQXMtaXMsIHRoZXJlJ3Mgbm8gcmVhc29uIGZvciB0aGlzIHRvIGJlIGluIERULiBUaGUg
cGFyZW50IG5vZGUncwo+Pj4gZHJpdmVyIGNhbiBpbnN0YW50aWF0ZSB0aGUgd2RvZy4KPj4+Cj4+
Cj4+IEFzIHRoZSBkcml2ZXIgaXMgY3VycmVudGx5IHdyaXR0ZW4sIHlvdSBhcmUgY29ycmVjdCwg
c2luY2UgaXQgZG9lc24ndCBhY2NlcHQKPj4gd2F0Y2hkb2cgdGltZW91dCBjb25maWd1cmF0aW9u
IHRocm91Z2ggZGV2aWNldHJlZS4KPj4KPj4gUXVlc3Rpb24gaXMgaWYgdGhhdCBpcyBpbnRlbmRl
ZC4gSXMgaXQgPwo+IAo+IEkgYW0gYSBsaXR0bGUgY29uZnVzZWQsIGRvIHlvdSBtZWFuIHdlIG5v
IG5lZWQgdG8gaGF2ZSAid2F0Y2hkb2ciIG5vZGUgaW4gc2lkZSAic2N1Igo+IG5vZGU/IE9yIHdl
IG5lZWQgdG8gbW9kaWZ5IHRoZSB3YXRjaGRvZyBub2RlJ3MgY29tcGF0aWJsZSBzdHJpbmcgdG8g
IiBmc2wsaW14LXNjLXdkdCIgdG8gbWFrZQo+IGl0IG1vcmUgZ2VuZXJpYyBmb3Igb3RoZXIgcGxh
dGZvcm1zPyBJZiB5ZXMsIEkgY2FuIHJlc2VuZCB0aGUgcGF0Y2ggc2VyaWVzIHRvIG1vZGlmeSBp
dC4KPiAgIAoKSSB0aGluayBSb2Igc3VnZ2VzdGVkIHRoYXQgdGhlIFNDVSBwYXJlbnQgZHJpdmVy
IHNob3VsZCBpbnN0YW50aWF0ZSB0aGUgd2F0Y2hkb2cKd2l0aG91dCBleHBsaWNpdCB3YXRjaGRv
ZyBub2RlLiBUaGF0IHdvdWxkIGJlIHBvc3NpYmxlLCBidXQgaXQgY3VycmVudGx5IHVzZXMKZGV2
bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIHRvIGRvIHRoZSBpbnN0YW50aWF0aW9uLCBhbmQgY2hh
bmdpbmcgdGhhdCB3b3VsZApiZSBhIG1lc3MuIEJlc2lkZXMsIGl0IGRvZXMgc2VtIHRvIG1lIHRo
YXQgeW91ciBzdWdnZXN0ZWQgbm9kZSB3b3VsZCBkZXNjcmliZQp0aGUgaGFyZHdhcmUsIHNvIEkg
YW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSByZWFzb25pbmcuCgpGb3IgbXkgcGFydCBJIHJl
ZmVycmVkIHRvCgl3YXRjaGRvZ19pbml0X3RpbWVvdXQoaW14X3NjX3dkZCwgREVGQVVMVF9USU1F
T1VULCAmcGRldi0+ZGV2KTsKaW4gdGhlIGRyaXZlciwgd2hpY2ggZ3VhcmFudGVlcyB0aGF0IHRo
ZSB0aW1lb3V0IHByb3BlcnR5IHdpbGwgbm90IGJlIHVzZWQKdG8gc2V0IHRoZSB0aW1lb3V0LiBB
IG1vcmUgY29tbW9uIGltcGxlbWVudGF0aW9uIHdvdWxkIGhhdmUgYmVlbgoKCWlteF9zY193ZGQt
PnRpbWVvdXQgPSBERUZBVUxUX1RJTUVPVVQ7CglyZXQgPSB3YXRjaGRvZ19pbml0X3RpbWVvdXQo
aW14X3NjX3dkZCwgdGltZW91dCwgJnBkZXYtPmRldik7Cgp3aGVyZSAndGltZW91dCcgaXMgdGhl
IG1vZHVsZSBwYXJhbWV0ZXIuIFdoaWNoIGlzIGFjdHVhbGx5IG5vdCB1c2VkIGluIHlvdXIgZHJp
dmVyLgpIbW0gLi4uIEkgd2Fzbid0IGNhcmVmdWwgZW5vdWdoIHdpdGggbXkgcmV2aWV3LiBUaGUg
dGltZW91dCBpbml0aWFsaXphdGlvbiBhcy1pcwpkb2Vzbid0IG1ha2Ugc2Vuc2UuIEknbGwgY29t
bWVudCBvbiB0aGF0IGluIHRoZSBwYXRjaC4KCkd1ZW50ZXIKCj4gQW5zb24uCj4gCj4+Cj4+IFRo
YW5rcywKPj4gR3VlbnRlcgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
