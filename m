Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:04:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C232086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e/Nv3HiT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKY7Njzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C232086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MScWFmkEL6J2aINW3PrYNhBGgIfslvIbv7VoImOU4YI=; b=e/Nv3HiT7pynCw
	vXmdWkDBZlo4iLvUMR2Jfi+eq2Mhx+r0LPb6VR/AtWi+NK3dUmN63/U+qJIScl7B71uVwxfVHlhKR
	2Mha/BC2xM5kX2x9s5GpONEBhD14qu0yoR5fP4Gokc7BL8pvEk2pfBT6keIoU9Mas8pt6TKpHKSfH
	Bf9T0/IhjZ+KEoT8OypVJGv5ZWp4eImN43OSkfyl1OErLAdKEZBsn4VygGL7qzEhBogYgbmsyv3fv
	VaApcvXr+GjyHe+8F4pawxNPtojdJkAzRZlQT+p8og0xC3MzRBWY248cf9EujU8hRy0UwM3ReryV5
	nQk7DhV4YdvHCIe3oNsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwGJK-0003GL-Tf; Wed, 20 Feb 2019 01:04:30 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwGJH-0003Fr-N3
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 01:04:29 +0000
Received: by mail-pg1-x543.google.com with SMTP id u9so7437173pgo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 17:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=3ZatgbslWh4ZRWSPeM65DfU1uUxzDxa2WM38Pde0f8M=;
 b=JKY7NjzxmmmwjXBtAbEG1wVIxgX3uyHt8sa9KP9xhWTK2cDqGOBdk63V1pTs1gqg99
 N/17cAhnnjL+ebvmanfrQI9xgk0QXwsVGpnY8GtlxFmw8hDONMiz62HuxPDTDmPJHqG4
 Hl6sMjb0zdl9EOVeCBKrd40qorUR31Fs3D7g/N4JeObvhl8Q7BfscvtrKOPyfdOKsMY+
 54HiGSVH2bSzb6tKKZKpYGuPHWV28wjCJAFCZNGrXb1s+kMdq2dP29YmW/aBrN57YCQp
 Cypy1bK3SkEHIxrsgawrq047MoCrFJqwHW3nOGzBK+ylKh7kMLivYGVw4XmG0xdCS3mO
 7mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=3ZatgbslWh4ZRWSPeM65DfU1uUxzDxa2WM38Pde0f8M=;
 b=NIYRrFRCM0uvTLxP+CTlfEUVrB69sR0NWUsRPonxX2xMtBwr4Z5J2r42OpnOf2uUmR
 5+aTKvZhMIePD4BCV4ncjWUt1/Cex5qu7M2QGgZaGFr8kNP+ai6mksYcxUusOH44nEz/
 DMR1c6S+uchYaGGY719gp9V4LaESti+r6IHvNZedrSsu1IgWqeylMkxrkMerbC+gdtuD
 v1USGtYFE1/HMwkU8I7ahA1PqTrYxAKiysRBraQvUq/b21P4dGI9KJhfRGGS29BdgJWg
 LQQzxjsgt5Kjo+92C2PCi0eMwQNVfwBqdmsSdjlUClrbbTTeCjiIVHHDF0550FM6iy5x
 v40w==
X-Gm-Message-State: AHQUAubB9Y2mAdmifqG5dG7NckLglKWeO2zLwHt8gpgNOBESxUXdXC34
 aUq2I7435Cduf0YAq7kuYu8=
X-Google-Smtp-Source: AHgI3Ia3h477b1FPZi1FCXxPPpanfwhs6S16Cw8o1G6os5t8YZ6w9ay8hF+ZT9MIYnjqm1Arf5jbVQ==
X-Received: by 2002:a62:4bd5:: with SMTP id d82mr31546603pfj.85.1550624666269; 
 Tue, 19 Feb 2019 17:04:26 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id p6sm35095810pgd.69.2019.02.19.17.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 17:04:24 -0800 (PST)
Date: Tue, 19 Feb 2019 17:04:22 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190220010420.GA2811@localhost.localdomain>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB39165EFE027405873E8AB4ECF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C9B1A6F0E4C6352BA43CF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916C9B1A6F0E4C6352BA43CF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_170427_754376_DDB59121 
X-CRM114-Status: GOOD (  23.43  )
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
 "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBGZWIgMTksIDIwMTkgYXQgMDc6MjA6NThBTSArMDAwMCwgQW5zb24gSHVhbmcgd3Jv
dGU6Cj4gUGluZy4uLgoKSSB3aWxsIHRha2UgYSBsb29rIG9uIHRoaXMuCgo+IAo+IEJlc3QgUmVn
YXJkcyEKPiBBbnNvbiBIdWFuZwo+IAo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+
IEZyb206IEFuc29uIEh1YW5nCj4gPiBTZW50OiAyMDE55bm0MuaciDEz5pelIDEzOjM2Cj4gPiBU
bzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2Vy
bmVsLm9yZzsKPiA+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgZmVzdGV2YW1AZ21haWwuY29tOwo+ID4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwu
ZGVhY29uQGFybS5jb207IHJ1aS56aGFuZ0BpbnRlbC5jb207Cj4gPiBlZHViZXp2YWxAZ21haWwu
Y29tOyBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBBaXNoZW5nIERvbmcKPiA+IDxhaXNoZW5n
LmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IERhbmllbCBCYWx1dGEKPiA+
IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgQW5k
eSBHcm9zcwo+ID4gPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47IGhlaWtvQHNudGVjaC5kZTsgYXJu
ZEBhcm5kYi5kZTsKPiA+IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207IGphZ2FuQGFtYXJ1bGFz
b2x1dGlvbnMuY29tOwo+ID4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGVucmljLmJhbGxl
dGJvQGNvbGxhYm9yYS5jb207Cj4gPiBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsgb2xvZkBsaXhv
bS5uZXQ7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOwo+ID4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0K
PiA+IHBtQHZnZXIua2VybmVsLm9yZwo+ID4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+Cj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIFY2IDEvNF0gZHQtYmluZGluZ3M6IGZzbDog
c2N1OiBhZGQgdGhlcm1hbCBiaW5kaW5nCj4gPiAKPiA+IEdlbnRhbCBwaW5nLi4uCj4gPiAKPiA+
IEJlc3QgUmVnYXJkcyEKPiA+IEFuc29uIEh1YW5nCj4gPiAKPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0KPiA+ID4gRnJvbTogQW5zb24gSHVhbmcKPiA+ID4gU2VudDogMjAxOeW5tDLm
nIg35pelIDE3OjUzCj4gPiA+IFRvOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBh
cm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOwo+ID4gPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsKPiA+ID4gY2F0YWxp
bi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IHJ1aS56aGFuZ0BpbnRlbC5j
b207Cj4gPiA+IGVkdWJlenZhbEBnbWFpbC5jb207IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7
IEFpc2hlbmcgRG9uZwo+ID4gPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyB1bGYuaGFuc3NvbkBs
aW5hcm8ub3JnOyBEYW5pZWwgQmFsdXRhCj4gPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBo
b3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgQW5keSBHcm9zcwo+ID4gPiA8YW5keS5ncm9zc0Bs
aW5hcm8ub3JnPjsgaGVpa29Ac250ZWNoLmRlOyBhcm5kQGFybmRiLmRlOwo+ID4gPiBtYXhpbWUu
cmlwYXJkQGJvb3RsaW4uY29tOyBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsKPiA+ID4gYmpv
cm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207Cj4g
PiA+IG1hcmMudy5nb256YWxlekBmcmVlLmZyOyBvbG9mQGxpeG9tLm5ldDsgZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7Cj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsKPiA+ID4gbGludXgtIHBtQHZnZXIua2Vy
bmVsLm9yZwo+ID4gPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4KPiA+ID4g
U3ViamVjdDogW1BBVENIIFY2IDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQgdGhlcm1h
bCBiaW5kaW5nCj4gPiA+Cj4gPiA+IE5YUCBpLk1YOFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBh
IENvcnRleC1NNCBjb3JlIGluc2lkZSBhcyBzeXN0ZW0KPiA+ID4gY29udHJvbGxlciwgdGhlIHN5
c3RlbSBjb250cm9sbGVyIGlzIGluIGNoYXJnZSBvZiBzeXN0ZW0gcG93ZXIsIGNsb2NrCj4gPiA+
IGFuZCB0aGVybWFsIHNlbnNvcnMgZXRjLiBtYW5hZ2VtZW50LCBMaW51eCBrZXJuZWwgaGFzIHRv
IGNvbW11bmljYXRlCj4gPiA+IHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdl
IHVuaXQpIElQQyB0byBnZXQgdGVtcGVyYXR1cmUKPiA+ID4gZnJvbSB0aGVybWFsIHNlbnNvcnMs
IHRoaXMgcGF0Y2ggYWRkcyBiaW5kaW5nIGRvYyBmb3IgaS5NWCBzeXN0ZW0KPiA+ID4gY29udHJv
bGxlciB0aGVybWFsIGRyaXZlci4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+Cj4gPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPgo+ID4gPiAtLS0KPiA+ID4gQ2hhbmdlTG9nIHNpbmNlIFY1Ogo+ID4g
PiAJLSBhZGQgImlteCxzZW5zb3ItcmVzb3VyY2UtaWQiIGluIGVhY2ggdGhlcm1hbCB6b25lIHRv
IHBhc3MgcmVzb3VyY2UKPiA+ID4gSUQgZm9yIHRoZXJtYWwgZHJpdmVyLgo+ID4gPiAtLS0KPiA+
ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgICAg
fCAyMAo+ID4gPiArKysrKysrKysrKysrKysrKysrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdAo+ID4gPiBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0Cj4gPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50
eHQKPiA+ID4gaW5kZXggNzJkNDgxYy4uNGI3OTc1MSAxMDA2NDQKPiA+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQKPiA+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUv
ZnNsLHNjdS50eHQKPiA+ID4gQEAgLTEyMiw2ICsxMjIsMjAgQEAgUlRDIGJpbmRpbmdzIGJhc2Vk
IG9uIFNDVSBNZXNzYWdlIFByb3RvY29sCj4gPiA+IFJlcXVpcmVkIHByb3BlcnRpZXM6Cj4gPiA+
ICAtIGNvbXBhdGlibGU6IHNob3VsZCBiZSAiZnNsLGlteDhxeHAtc2MtcnRjIjsKPiA+ID4KPiA+
ID4gK1RoZXJtYWwgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wKPiA+ID4g
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+ID4gPiArCj4gPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ID4gPiArLSBjb21wYXRp
YmxlIDogTXVzdCBiZSAiZnNsLGlteDhxeHAtc2MtdGhlcm1hbCI7Cj4gPiA+ICstIHRzZW5zLW51
bSA6IFRvdGFsIG51bWJlciBvZiB0aGVybWFsIHNlbnNvcnMgc3VwcG9ydGVkOwo+ID4gPiArLSAj
dGhlcm1hbC1zZW5zb3ItY2VsbHMgOiBTaG91bGQgYmUgMS4gU2VlCj4gPiA+ICsKPiA+ID4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhlcm1hbC50eHQKPiA+ID4g
KwkJCSAgZm9yIGEgZGVzY3JpcHRpb24uCj4gPiA+ICstIGlteCxzZW5zb3ItcmVzb3VyY2UtaWQg
OiBUaGlzIHByb3BlcnR5IHNob3VsZCBiZSBkZWZpbmVkIGluIGVhY2gKPiA+ID4gK3RoZXJtYWwK
PiA+ID4gem9uZQo+ID4gPiArCQkJICAgb2YgdGhlcm1hbC16b25lcyBub2RlLCBpdCBwYXNzZXMg
ZWFjaCB0aGVybWFsCj4gPiA+IHpvbmUncwo+ID4gPiArCQkJICAgcmVzb3VyY2UgaWQgZm9yIHRo
ZXJtYWwgZHJpdmVyIHRvIGdldCB0ZW1wZXJhdHVyZQo+ID4gPiB2aWEKPiA+ID4gKwkJCSAgIFND
VSBJUEMuCj4gPiA+ICsKPiA+ID4gIEV4YW1wbGUgKGlteDhxeHApOgo+ID4gPiAgLS0tLS0tLS0t
LS0tLQo+ID4gPiAgbHNpb19tdTE6IG1haWxib3hANWQxYzAwMDAgewo+ID4gPiBAQCAtMTY4LDYg
KzE4MiwxMiBAQCBmaXJtd2FyZSB7Cj4gPiA+ICAJCXJ0YzogcnRjIHsKPiA+ID4gIAkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDhxeHAtc2MtcnRjIjsKPiA+ID4gIAkJfTsKPiA+ID4gKwo+ID4gPiAr
CQl0c2VuczogdGhlcm1hbC1zZW5zb3Igewo+ID4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14
OHF4cC1zYy10aGVybWFsIjsKPiA+ID4gKwkJCXRzZW5zLW51bSA9IDwxPjsKPiA+ID4gKwkJCSN0
aGVybWFsLXNlbnNvci1jZWxscyA9IDwxPjsKPiA+ID4gKwkJfTsKPiA+ID4gIAl9Owo+ID4gPiAg
fTsKPiA+ID4KPiA+ID4gLS0KPiA+ID4gMi43LjQKPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
