Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B88C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:03:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752E42075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HF77SHbX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guKzi/8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752E42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mHiQywNdn3A8Q1aL6slKiuoopUBgKRPcKBxSIt2GhYc=; b=HF77SHbXSyuOgN
	QQg1ThPn+Woz9RagJxGp3ebRU9rhdk9LQKQJkYiBdnnbYauX1dhPmSZq8pJz2gM+1g0Hsr7SLqjEf
	b+XKbPmZbzlNia6V9aCIO+Lpt0oi/MYuScDZOeP+vM5nqjfLxAouEErg6GIqp6u4mFh1Oa26l7fxn
	VgVJ/RfNeQIH5JFKqii35IYbEStd22xB3fbFPwngyGIdwtUDh0xNhM0x+dXPjWENY5HWKQsUU6c0l
	skn2UczYbq+oPVAi1wPKDm2aTV3V30obl4kDL7ikR60u9WhNq8TJvYAUu70pPxAFrm2QkSYgbBbsv
	rHxKuAb3FF4YNxr0l5eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3wS-0003ds-10; Fri, 08 Feb 2019 11:03:32 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3wP-0003dC-EG
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:03:30 +0000
Received: by mail-wm1-x342.google.com with SMTP id t200so2963946wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 03:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=knW0z7TbZkk4k9GAX5c/GhUDvRtIDL/zkxnCrXGg7wc=;
 b=guKzi/8r5BTCFCD7qPgsIdinPklLl5lQl9SqYuAN8HOHuCAVgsPQUoVS55Tz/57xZd
 LhdHT41XQmQk+XRmT1DgFLE6g4XBPdcq3M3Z1FABBXtIh8F67G+cu5nK8rn7NvluORuM
 dIgEdH8kmGYnvYuM83Lkgb1ZMKcZSuPeCcRnS2qmoUQVAUHLT+aFpN34ONRL7aFntyUb
 yFBrlOYR+csN3MQM/T3aUFFnMwvpfaHhS4LLgc8x7mcxIjsCXW4cTsuO1Z1JV2U7mdvS
 I9Mm9/UAW7ztCdc/EXxfET0FcFPAXZ46zTpGZLqY0yRQBtVxsUbNInS2R9+8ozzh5hYa
 nAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=knW0z7TbZkk4k9GAX5c/GhUDvRtIDL/zkxnCrXGg7wc=;
 b=L/5EhQg/wIA11BOibZ0Bga5L6N6AON63fMPtnWkXjoU3bQW4DqW5l/F53IjRwjupdp
 86HPLF+RJyE+C4yNgJWuy5oSc1Ms+IC7SKR7jlWDDKeqpwWOhetLhRSqW1h2+ndC6Uoi
 dpjlInV31GwRq6ujAEvkYC7xIbrchgkTx4KHTjlgSqwU5AdtW3V6B4kiMPQJ911H8TW8
 3/K1/k4pJRhuUzZTEwMUwYbXeUpDpfCVvYG0S0wmDu2czWktQ5cgsyT54DQ8HNhq1CwP
 rH1yF6Kk//gkY/OTyVKnJbzmZH9gYUh3Lo3qLGaj8x6LfGoQP6Z6Iw4/1phj8Fb6pE6I
 2Rxw==
X-Gm-Message-State: AHQUAuakkTiS6+xptIthdTiA6wGXVdt6DuiaonvvA7A/eHVRia6yD2HK
 nynGfjQ5dtlzz9cmVCzHjGRVRA==
X-Google-Smtp-Source: AHgI3IaWUmARQbjqZ4kU6hLTUyLy2A5wPMuDrximngCGWcJncatY80GHwlySBSiYnZ+++zUyl6zgpQ==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr2143879wmg.21.1549623806030; 
 Fri, 08 Feb 2019 03:03:26 -0800 (PST)
Received: from dell ([2.27.35.171])
 by smtp.gmail.com with ESMTPSA id h62sm2152740wmf.11.2019.02.08.03.03.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 03:03:25 -0800 (PST)
Date: Fri, 8 Feb 2019 11:03:23 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RFT PATCH 7/9] mfd: axp20x: add USB power supply mfd cell to
 AXP813
Message-ID: <20190208110323.GK20638@dell>
References: <20190207064535.9226-1-wens@csie.org>
 <20190207064535.9226-8-wens@csie.org> <20190207110247.GE20638@dell>
 <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGb2v66uC=ZUj3S3ceVHABg68WMuyfHPcG77CV1DjCNn9ff71A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_030329_502816_7E145B40 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Quentin Schulz <quentin.schulz@bootlin.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAwNyBGZWIgMjAxOSwgQ2hlbi1ZdSBUc2FpIHdyb3RlOgoKPiBPbiBUaHUsIEZlYiA3
LCAyMDE5IGF0IDc6MDIgUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6
Cj4gPgo+ID4gT24gVGh1LCAwNyBGZWIgMjAxOSwgQ2hlbi1ZdSBUc2FpIHdyb3RlOgo+ID4KPiA+
ID4gRnJvbTogUXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QGJvb3RsaW4uY29tPgo+ID4g
Pgo+ID4gPiBUaGUgQVhQODEzIGhhcyBhIFZCVVMgcG93ZXIgaW5wdXQuIE5vdyB0aGF0IHRoZSBh
eHAyMHhfdXNiX3Bvd2VyIGRyaXZlcgo+ID4gPiBzdXBwb3J0cyB0aGlzIHZhcmlhbnQsIHdlIGNh
biBhZGQgYW4gbWZkIGNlbGwgZm9yIGl0IHRvIHVzZSBpdC4KPiA+ID4KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogUXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QGJvb3RsaW4uY29tPgo+ID4gPiBb
d2Vuc0Bjc2llLm9yZzogYWRkIGNvbW1pdCBtZXNzYWdlXQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBD
aGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy9tZmQv
YXhwMjB4LmMgfCAxMSArKysrKysrKysrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2F4cDIweC5jIGIv
ZHJpdmVycy9tZmQvYXhwMjB4LmMKPiA+ID4gaW5kZXggM2M5N2YyYzBmZGZlLi4xN2IxMTU4NDU5
OTMgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbWZkL2F4cDIweC5jCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvbWZkL2F4cDIweC5jCj4gPiA+IEBAIC0xOTgsNiArMTk4LDEyIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcmVzb3VyY2UgYXhwMjJ4X3VzYl9wb3dlcl9zdXBwbHlfcmVzb3VyY2VzW10gPSB7
Cj4gPiA+ICAgICAgIERFRklORV9SRVNfSVJRX05BTUVEKEFYUDIyWF9JUlFfVkJVU19SRU1PVkFM
LCAiVkJVU19SRU1PVkFMIiksCj4gPiA+ICB9Owo+ID4gPgo+ID4gPiArLyogQVhQODAzIGFuZCBB
WFA4MTMvQVhQODE4IHNoYXJlIHRoZSBzYW1lIGludGVycnVwdHMgKi8KPiA+ID4gK3N0YXRpYyBz
dHJ1Y3QgcmVzb3VyY2UgYXhwODAzX3VzYl9wb3dlcl9zdXBwbHlfcmVzb3VyY2VzW10gPSB7Cj4g
PiA+ICsgICAgIERFRklORV9SRVNfSVJRX05BTUVEKEFYUDgwM19JUlFfVkJVU19QTFVHSU4sICJW
QlVTX1BMVUdJTiIpLAo+ID4gPiArICAgICBERUZJTkVfUkVTX0lSUV9OQU1FRChBWFA4MDNfSVJR
X1ZCVVNfUkVNT1ZBTCwgIlZCVVNfUkVNT1ZBTCIpLAo+ID4KPiA+IE5pdDogV2h5IDIgc3BhY2Vz
IGhlcmU/ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+IAo+IDIgc3BhY2VzPyBJJ20g
b25seSBzZWVpbmcgb25lLgoKRWgsIHRoYXQncyBvZGQuICBNeSBleWVzIG11c3QgYmUgZmFpbGlu
ZyBtZS4KCkp1c3QgYWRkIG15IEFjayB0aGVuLiA6KQoKLS0gCkxlZSBKb25lcyBb5p2O55C85pav
XQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3Vy
Y2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRl
ciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
