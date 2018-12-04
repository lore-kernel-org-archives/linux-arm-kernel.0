Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28910C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:40:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED06C20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FvWeiQ0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED06C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ffcm0iHJvmuvoPAh2KrEfn9Hp08Lj65V+QiTWbg7ns=; b=FvWeiQ0eDpoFuY
	sTc/ug4uzeUXv7C177XACRZKwxVhXkhd8i99Mt6+bdUqY/LnQPcMFhW8ww+ESv7EhJGMuFosWZK11
	zSu1teOjWV/VqFRjVjVUqJRFY3SXhUnlzpeVF9t4M/28y5427sZbjk9xWaeKOLW8UnhZu/HPapzwk
	ljCJ+st2wmPHT3Vryt6gd1bbz3LKWD1PVg6oGBgr0lMj1pjqyaJUW/L6gxwQdo6Xs6ZqeQq7/4q10
	JFpN4lZdVVGfGIPKB/xZP2fSI+N7yxCnbpTg7J6Y72oWg1rf/e2U5BPWTCEUAyAzK6u/ljRNBz34F
	W4kpeNltf5/Co3BQT9dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU6G8-0004q4-Nu; Tue, 04 Dec 2018 08:40:48 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6G5-0004pO-RV
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:40:47 +0000
Received: from [192.168.178.52] ([109.104.47.127]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfYHW-1hA0dn3JYe-00g2bi; Tue, 04 Dec 2018 09:40:27 +0100
Subject: Re: [PATCH v3 1/3] usb: chipidea: imx: support configuring for active
 low oc signal
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Peter Chen <Peter.Chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>
References: <20181204083131.12524-1-u.kleine-koenig@pengutronix.de>
 <20181204083131.12524-2-u.kleine-koenig@pengutronix.de>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <ce751026-d61f-400e-cb5d-abd9d45dc05f@i2se.com>
Date: Tue, 4 Dec 2018 09:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204083131.12524-2-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
X-Provags-ID: V03:K1:UGMVQBcxMfs1LjYCAYYMzAYNv9k4DSlxNYCrULAgjnzcmdm5mQ8
 dD3JUQ2hcPUjeLXv7lBWsPgDsZ0PVNIR3N7Vh5/clpYxXW19/A4urxLbJjPH7V9+qAlNs9Y
 5Aw/JlmDXtKE677pYzjHi6ZqJHaTYkuK2GWUR2fUW97+UjRsqnEidh4EoXunpGu6BWFxf5E
 4zznxoviYJSmBru69ObwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XpX2EW4bkmQ=:kYMM9SThEBhSegnY/y9KN5
 X3DZQjNjbWstyEnEUT03ARGo42w6SCP8ABA++V0+mllSZ8KRaQAXmlggdqRhFifeYFuGP+NSs
 wrrSOz2gfyob1LWK7AdJutVrNycF/TdV3VlqiAdiPzQLriRKHOtS8emSZoCk54ZBAcey25Itk
 75G/Dx6WvghpHdgwEbrtvE3uRKowmZitMgwaU589kOSXtUmKO5pkhejaiGaoiXIlFBeX0PpS8
 Smj/rwfiChUdPaB8Eq5+gSOAnXw5sYmyaMuYooBfrgofY3HRIed76jtaNhuOpRF6Lv411hYJf
 nxkZrjzq+K2vxPoYMIYn2SONYXjqKowXm7kADZG34u5awnYVXscT8G/2H+LzL2t29F5ksn7RH
 IXyet6ZTo0uF24e0gENmPl4xTJC8pzgCEOCMdG1VTveEPqCBdQpweb1CMEnTnSOMFlw2c8K79
 078ySAAa08izjzN/ikuTPPA5ho626Mww8A8rIT5WKS2ATrQ5H/6U1azVCiyzLFP+pGPaJlwFm
 sFoDzDDElFifle1YaEeqnuEedvwDL91r4HPjlxzB8kI2IS5NoeteFbHg2Wa3AI1vb2JiawSAF
 ZqtduoN8H+ZhHZ1PhnZSkpIdcPAVx6DJ2LyxXJBalLSS+Wz18oQN9QMfChHdWfcBPID3Zge5g
 Py576C9LxbC4wYK2J9WNVSD4V44g22o9M0eZ23199UuQd2qMz4mFRhNuWII0mak8+tsNZ/u77
 AeGazsRMNJKMErI8k/jYPJw3osiJ8k+JQI7UvVGt/QrsW7VRSF68R3l9peo=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_004046_194287_D7AAAE1B 
X-CRM114-Status: GOOD (  21.45  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-usb@vger.kernel.org,
 Matthew Starr <mstarr@hedonline.com>, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVXdlLAoKQW0gMDQuMTIuMTggdW0gMDk6MzEgc2NocmllYiBVd2UgS2xlaW5lLUvDtm5pZzoK
PiBUaGUgc3RhdHVzIHF1byBvbiBpLk1YNiBpcyB0aGF0IGlmICJvdmVyLWN1cnJlbnQtYWN0aXZl
LWhpZ2giIGlzCj4gc3BlY2lmaWVkIGluIHRoZSBkZXZpY2UgdHJlZSB0aGlzIGlzIGNvbmZpZ3Vy
ZWQgYXMgZXhwZWN0ZWQuIElmCj4gdGhlIHByb3BlcnR5IGlzIG1pc3NpbmcgcG9sYXJpdHkgaXNu
J3QgY2hhbmdlZCBhbmQgc28gdGhlCj4gcG9sYXJpdHkgaXMga2VwdCBhcyBzZXR1cCBieSB0aGUg
Ym9vdGxvYWRlci4gUmVzZXQgZGVmYXVsdCBpcwo+IGFjdGl2ZSBoaWdoLCBzbyBhY3RpdmUgbG93
IGNhbiBvbmx5IGJlIHVzZWQgd2l0aCBoZWxwIGJ5IHRoZQo+IGJvb3Rsb2FkZXIuIE9uIGkuTVg3
IGl0IGlzIHNpbWlsYXIsIGJ1dCB0aGVyZSBkaXNhYmxpbmcgb2YKPiBvdmVyIGN1cnJlbnQgZGV0
ZWN0aW9uIGhhcyBhIHNpbWlsYXIgaW5jb25zaXN0ZW5jeS4KPgo+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyBhIG5ldyBwcm9wZXJ0eSB0aGF0IGFsbG93cyB0byBleHBsaWNpdGx5Cj4gY29uZmlndXJl
IGZvciBhY3RpdmUgbG93IG92ZXIgY3VycmVudCBkZXRlY3Rpb24gYW5kIGNvbnNpc3RlbnRseQo+
IHNldHMgdGhpcyB1cC4gSW4gdGhlIGFic2VuY2Ugb2YgYW4gZXhwbGljaXQgY29uZmlndXJhdGlv
biB0aGUKPiBiaXQgaXMga2VwdCBhcyBpcy4gT24gaS5NWDcgb3ZlciBjdXJyZW50IGRldGVjdGlv
biBpcyB1c2VkIHVubGVzcwo+IGRpc2FibGVkIGluIHRoZSBkZXZpY2UgdHJlZS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXgu
ZGU+Cj4gLS0tCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9jaS1oZHJjLXVzYjIudHh0
ICB8ICA1ICsrLS0KPiAgZHJpdmVycy91c2IvY2hpcGlkZWEvY2lfaGRyY19pbXguYyAgICAgICAg
ICAgIHwgMTYgKysrKysrKystLS0KPiAgZHJpdmVycy91c2IvY2hpcGlkZWEvY2lfaGRyY19pbXgu
aCAgICAgICAgICAgIHwgIDggKysrKystCj4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL3VzYm1pc2Nf
aW14LmMgICAgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrLS0tLS0KPiAgNCBmaWxlcyBjaGFu
Z2VkLCA0MyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi50eHQKPiBp
bmRleCA1MjllNTE4NzlmYjIuLmMzMmY2ZTk4M2NmNiAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi50eHQKPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi50eHQKPiBAQCAt
ODcsOCArODcsOSBAQCBpLm14IHNwZWNpZmljIHByb3BlcnRpZXMKPiAgLSBmc2wsdXNibWlzYzog
cGhhbmRsZXIgb2Ygbm9uLWNvcmUgcmVnaXN0ZXIgZGV2aWNlLCB3aXRoIG9uZQo+ICAgIGFyZ3Vt
ZW50IHRoYXQgaW5kaWNhdGUgdXNiIGNvbnRyb2xsZXIgaW5kZXgKPiAgLSBkaXNhYmxlLW92ZXIt
Y3VycmVudDogZGlzYWJsZSBvdmVyIGN1cnJlbnQgZGV0ZWN0Cj4gLS0gb3Zlci1jdXJyZW50LWFj
dGl2ZS1oaWdoOiBvdmVyIGN1cnJlbnQgc2lnbmFsIHBvbGFyaXR5IGlzIGhpZ2ggYWN0aXZlLAo+
IC0gIHR5cGljYWxseSBvdmVyIGN1cnJlbnQgc2lnbmFsIHBvbGFyaXR5IGlzIGxvdyBhY3RpdmUu
Cj4gKy0gb3Zlci1jdXJyZW50LWFjdGl2ZS1sb3c6IG92ZXIgY3VycmVudCBzaWduYWwgcG9sYXJp
dHkgaXMgYWN0aXZlIGxvdy4KPiArLSBvdmVyLWN1cnJlbnQtYWN0aXZlLWhpZ2g6IG92ZXIgY3Vy
cmVudCBzaWduYWwgcG9sYXJpdHkgaXMgYWN0aXZlIGhpZ2guCj4gKyAgSXQncyByZWNvbW1lbmRl
ZCB0byBzcGVjaWZ5IHRoZSBvdmVyIGN1cnJlbnQgcG9sYXJpdHkuCj4gIC0gZXh0ZXJuYWwtdmJ1
cy1kaXZpZGVyOiBlbmFibGVzIG9mZi1jaGlwIHJlc2lzdG9yIGRpdmlkZXIgZm9yIFZidXMKPiAg
Cj4gIEV4YW1wbGU6Cgp0aGFua3MgZm9yIG1ha2luZyB0aGlzIGNvbmZpZ3VyYWJsZS4gQnV0IHNo
b3VsZG4ndCB0aGlzIGJlIGEgc2VwYXJhdGUKcGF0Y2ggYW5kIHJldmlld2VkIGJ5IHRoZSBkZXZp
Y2V0cmVlIGd1eXM/CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
