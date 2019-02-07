Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACEFC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:03:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F89B218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sWL5+xcJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWHfYk5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F89B218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BiJjfhY3qNrZ0x5dEG83C6YOTXO9CJbEIEvlDL5uXCw=; b=sWL5+xcJI0QybI
	jip14ZQgDX7LPEicIT149d9Ujw1e9lLhDdDBwbYNULsq2YCxWB48f0imEZh8tHF48rZK5irtl+n3E
	yWX0wnR1s8Q6+PgDOgUQjgp5BPY3Vmzm4y2j5LEoeejJ69xsGCpsqtV0eHyW0lSvOZ4GOFvwnQIw4
	/GaeFCH6MjdskMkn+wUjwNV+f3JsCmry6W69sRV5q8vrlvV3WzF6iiLLUCmBD7V9uoNfpv6ckh4JU
	lIxkJmvmNZHZPPyEdv242+LngkpDgRbd6ujWE8zVpGvny+/hDBRZma7KyMFnCtrZTwpEC7SyjXL/E
	+GzkF9H1i8vz8MHObOBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhSM-0002ee-2x; Thu, 07 Feb 2019 11:02:58 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhSH-0002do-Lh
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:02:55 +0000
Received: by mail-wm1-x343.google.com with SMTP id a62so5624196wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=J/pM0jxyaOEUTLPWuvo5olApQH7SNEpeuvTbqTu51bA=;
 b=kWHfYk5sNUc7DK611zxEgHqlydUZiOX0B/p0pD6Ybn8zad/aeMwI+vPeco1NJK6/mv
 n1jdKN9bGGsZW3OkXs9IPVPBmLLKWX1MxUf4t+xc0waVEYGL5AezAIcP8GjKvWz6lQbK
 fcDUgTD1KJlKKBHLRMC0howf+kuh5QJulVwe0LY1PRI7Y/ERC0c37CRv2rJBJkQQNcHf
 pAwgNC/uURfEU7lSsEkEtKScLnWExVp743hL68qNRpYgqTPHq3Lq8ZZf+mJLrfEVuko7
 z9Var2N0Jt11dds4j2I0ApwRpfha4fG5pouCM9K1Tymy/BB1rwrrkgJQy7tP+wgiOXf6
 doig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=J/pM0jxyaOEUTLPWuvo5olApQH7SNEpeuvTbqTu51bA=;
 b=mWTGF6JVc+ZJ6VdjNYvniefZjFRP1AF/VHnomZ6ZZ5GBJZw11wbVOK8T/l5gpUThnI
 wgVbbkoapsYF8XnjaCFBRwXYQjNE9Qop7WoAlc7m4YIo71H9swlNSOHs+3AKcF0g5eVu
 xLaO8c15qgJEIp00v8awAM4H8b1RVXPIShBg8p2xiZXyJWMpyv5++ulJNHkN87tPEv8b
 odqq7G8HulrIg47thEe5c++x9XFaahTTKEMELaM7webOYGCC019n5+H2crBchJB8t19e
 AP3cdJ8qOgr9ojCupoI5V81UmI6EBkxnpZpoN1REgeNhQddwnnrI5sFT27zRsBBdH22v
 3UYg==
X-Gm-Message-State: AHQUAuYcpto/ZSvXXJsh5SVeGmztyJsn5aKWG06OYjehl16h9LscGtyI
 9OXMqxAcG5BgfRrs53Oi+G96mw==
X-Google-Smtp-Source: AHgI3IY+ZRaQ1ZHmwrTN0Hx/PWGH9S3/GQrjaoecCVZeXtNwlzby8OUxZxKGUq7K7foY0S3YD2tOdA==
X-Received: by 2002:a1c:7a03:: with SMTP id v3mr1428214wmc.57.1549537369322;
 Thu, 07 Feb 2019 03:02:49 -0800 (PST)
Received: from dell ([2.27.35.171])
 by smtp.gmail.com with ESMTPSA id q12sm21622838wrx.31.2019.02.07.03.02.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 03:02:48 -0800 (PST)
Date: Thu, 7 Feb 2019 11:02:47 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RFT PATCH 7/9] mfd: axp20x: add USB power supply mfd cell to
 AXP813
Message-ID: <20190207110247.GE20638@dell>
References: <20190207064535.9226-1-wens@csie.org>
 <20190207064535.9226-8-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207064535.9226-8-wens@csie.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_030253_715061_DA19DC9D 
X-CRM114-Status: GOOD (  16.10  )
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
 Quentin Schulz <quentin.schulz@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAwNyBGZWIgMjAxOSwgQ2hlbi1ZdSBUc2FpIHdyb3RlOgoKPiBGcm9tOiBRdWVudGlu
IFNjaHVseiA8cXVlbnRpbi5zY2h1bHpAYm9vdGxpbi5jb20+Cj4gCj4gVGhlIEFYUDgxMyBoYXMg
YSBWQlVTIHBvd2VyIGlucHV0LiBOb3cgdGhhdCB0aGUgYXhwMjB4X3VzYl9wb3dlciBkcml2ZXIK
PiBzdXBwb3J0cyB0aGlzIHZhcmlhbnQsIHdlIGNhbiBhZGQgYW4gbWZkIGNlbGwgZm9yIGl0IHRv
IHVzZSBpdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBRdWVudGluIFNjaHVseiA8cXVlbnRpbi5zY2h1
bHpAYm9vdGxpbi5jb20+Cj4gW3dlbnNAY3NpZS5vcmc6IGFkZCBjb21taXQgbWVzc2FnZV0KPiBT
aWduZWQtb2ZmLWJ5OiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+Cj4gLS0tCj4gIGRyaXZl
cnMvbWZkL2F4cDIweC5jIHwgMTEgKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvYXhwMjB4LmMgYi9kcml2
ZXJzL21mZC9heHAyMHguYwo+IGluZGV4IDNjOTdmMmMwZmRmZS4uMTdiMTE1ODQ1OTkzIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbWZkL2F4cDIweC5jCj4gKysrIGIvZHJpdmVycy9tZmQvYXhwMjB4
LmMKPiBAQCAtMTk4LDYgKzE5OCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlc291cmNlIGF4
cDIyeF91c2JfcG93ZXJfc3VwcGx5X3Jlc291cmNlc1tdID0gewo+ICAJREVGSU5FX1JFU19JUlFf
TkFNRUQoQVhQMjJYX0lSUV9WQlVTX1JFTU9WQUwsICJWQlVTX1JFTU9WQUwiKSwKPiAgfTsKPiAg
Cj4gKy8qIEFYUDgwMyBhbmQgQVhQODEzL0FYUDgxOCBzaGFyZSB0aGUgc2FtZSBpbnRlcnJ1cHRz
ICovCj4gK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgYXhwODAzX3VzYl9wb3dlcl9zdXBwbHlfcmVz
b3VyY2VzW10gPSB7Cj4gKwlERUZJTkVfUkVTX0lSUV9OQU1FRChBWFA4MDNfSVJRX1ZCVVNfUExV
R0lOLCAiVkJVU19QTFVHSU4iKSwKPiArCURFRklORV9SRVNfSVJRX05BTUVEKEFYUDgwM19JUlFf
VkJVU19SRU1PVkFMLCAiVkJVU19SRU1PVkFMIiksCgpOaXQ6IFdoeSAyIHNwYWNlcyBoZXJlPyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCldpdGggdGhhdCBmaXhlZCwgeW91IGNhbiBh
ZGQgbXk6CgpGb3IgbXkgb3duIHJlZmVyZW5jZToKICBBY2tlZC1mb3ItTUZELWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5h
cm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29m
dHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJs
b2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
