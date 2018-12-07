Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10716C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2572082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cdo65kpO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BqE2xAyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2572082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4oIp4jSSPLVoKhB+4OW53hRpdzUTxNW0EAaUY8mLpHY=; b=Cdo65kpO5gE+8I
	0MZ+r2+QLPu/iugdMe1E0uk33T/xKSLk8pMKCTHKY+0EJY7qB91FlbjFF2hdsCpiNKS2N53oSoonv
	90NdMkpZJROsYbc7R8aew7hnODj01MwGtfw/MWo93WwK4Pvy3MkYZMyF0YIYvT20BO2dF3FUO1+7L
	EOe64UI69UPYdwlkb17D6+XdTI6UgcpuNN6D0jymdznbzhT4J/fYjbRXe+LIrQTxj3m3p+Dx08REg
	kt3XanS62YeBH/AbeEoARFI/ECvDX7blWN6ShldkyTJtA5S4hSWWdzNrHC5Q1FIF/+uA8dXZZkFiF
	1LB5fvB3vIk/a5gnVHpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV7aZ-0002db-5W; Fri, 07 Dec 2018 04:18:07 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV7aT-0002cx-PU
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 04:18:05 +0000
Received: by mail-pg1-x542.google.com with SMTP id w7so1109633pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 20:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=pQJgfkliWdqBVgYrK8T6lXx+XA37kSfvPJD5/x/FrOI=;
 b=BqE2xAyuOCM/D7gYKELkW/w3OudRTCe28o3nzBgrVxhGKuj/+Cwxc0a4fxpXiwcsBF
 /Oq5ZV6BnAEjZ+Jnxmkqqbyssph4F75+I2HDIgTjLRQgeCSJ8UmJh+GuGQ7NrvK/AZ0d
 cp17BESrM62b659qT3SWuoWl9TYIMWKOVNas7GgV/Ak7ytxYfXSbtQGVmxDD7rZN3Pxg
 PIOu87rXQsbcBV50CT7T28JJa7jmKBjd+v6YqF/XyeU0vbo++3+XOuQbfhpj6mZlwlvg
 ih8SKTEECT+IkMzXB4CCHqoRIUilwezg7CHTOLczcr5mDgVGBmpRQcbANnYet/XIxs9H
 BmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pQJgfkliWdqBVgYrK8T6lXx+XA37kSfvPJD5/x/FrOI=;
 b=n1Z+7ABlrh7TRcTdx75Euj7m5GV7LUQImcqGnfoyA8AQk7tOzsMviLVTlTywOOUvw4
 pr+MNX+AVFo8Bg/3nejcGEKtXUaKhRHns/AR3ayXTBOFuh2nqJovSVulfALNW/wrzzlO
 8oDMFWJSPPU4RyHhzCFR/2hxZldpE75tPlkjFpPFGxAfnJpTs3ABv0UbpiYaCbTDFAyy
 tSB55ZtAvczpHfKbo8+kQSCe3JZ8teFfoGfrnVnn0Hy8AgMQF1TnykAHXbrRPaAGyrS1
 mqanKGOJkGpUYhntxsv856gK8lEdNXjCkp/72CRD0Z/UQp2tFR9B0IGQloFVbhzr3jxl
 zt0Q==
X-Gm-Message-State: AA+aEWZyioJSPVU1ARLxx8mVuiWpK+07tyopLYpOUT99EA7OoSdx+nv0
 KYfMv2VYW9tzsKH/ISSc37z/3Q==
X-Google-Smtp-Source: AFSGD/XL83txPD2nID8GuJWr33MnhGIY7owClz3sUupOALkTKsH1Wjn6UAzOdKZvnDyPaOc1aNxVMA==
X-Received: by 2002:a62:4181:: with SMTP id g1mr753967pfd.45.1544156270828;
 Thu, 06 Dec 2018 20:17:50 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id h82sm2766349pfa.105.2018.12.06.20.17.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 20:17:50 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org,
 mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
In-Reply-To: <20181204160447.27869-1-ccaione@baylibre.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
Date: Thu, 06 Dec 2018 20:17:49 -0800
Message-ID: <7hsgzax95e.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_201801_826653_FE04160E 
X-CRM114-Status: UNSURE (   8.97  )
X-CRM114-Notice: Please train this message.
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Q2FybG8gQ2Fpb25lIDxjY2Fpb25lQGJheWxpYnJlLmNvbT4gd3JpdGVzOgoKPiBUaGUgd3Jvbmcg
SVJRIHRyaWdnZXIgdHlwZSBmb3IgdGhlIG1hY2lycSB3YXMgY2F1c2luZyB0aGUgY29ubmVjdGlv
bgo+IHNwZWVkIHRvIGRyb3AgYWZ0ZXIgYSBmZXcgaG91cnMgd2hlbiBzdHJlc3MgdGVzdGluZyB0
aGUgRFVULiBUaGUgZml4Cj4gc2VlbXMgYWxzbyB0byBmaXggYW5vdGhlciBsb25nIHN0YW5kaW5n
IGlzc3VlIHdpdGggRUVFLgo+Cj4gVGhlIGZpeGVzIGFyZSB0ZXN0ZWQgb24gYSBBWEcgYm9hcmQg
YnV0IHdlIHRoaW5rIHRoYXQgdGhlIHNhbWUgZml4IGlzCj4gdmFsaWQgYWxzbyBmb3IgYWxsIHRo
ZSBvdGhlcnMgQW1sb2dpYyBTb0MgZmFtaWxpZXMuCgpGb3IgYnJvYWRlciB0ZXN0aW5nLCBJJ3Zl
IGNyZWF0ZWQgYSB2NC4yMS9kdDY0LXRlc3RpbmcgYnJhbmNoIChvbiB0b3Agb2YKdGhlIGN1cnJl
bnQgdjQuMjEvZHQ2NCBicmFuY2gpIHdoaWNoIEkndmUgbWVyZ2VkIGludG8gdGhlIGludGVnIGJy
YW5jaApzbyBpdCBnZXRzIGEgc3BpbiB0aHJvdWdoIGtlcm5lbENJLm9yZywgYW5kIG90aGVycyBj
YW4gZWFzaWx5IHRlc3QgdGhlCmludGVnIGJyYW5jaCB3aGljaCBoYXMgYWxsIHRoZSBvdGhlciBz
dHVmZiBjdXJyZW50bHkgcXVldWVkIGZvciB2NC4yMS4KCknCtGxsIHdhaXQgZm9yIHRoZSBkaXNj
dXNzaW9ucyB0byBzZXR0bGUgZG93biBhbmQgdGVzdGluZyByZXN1bHRzIGJlZm9yZQpkZWNpZGlu
ZyB3aGV0aGVyIHRvIG9mZmljaWFsbHkgcXVldWUgdGhpcyBmb3IgdjQuMjEuCgpLZXZpbgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
