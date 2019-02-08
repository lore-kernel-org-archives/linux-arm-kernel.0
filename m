Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9690BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:35:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B0D2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKo4nRFq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G99yMd8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B0D2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B26UPXCh/yglqrl3a6MZFIOAXmpcP2vwtfgGL2dcmKo=; b=lKo4nRFqwwKvfp
	GWprOmtoaXhijnKfAOqspYh/R+O0cgFLCDpbY+/Q2jQT0BdgKj2rSabVB3XKyuwwVbgZO4CP5tgvQ
	zAqIZK9jy8nBdP/mY4oPLVLKNuMI7laWfPAAO+qsL57ttjooRRmKHRLZPLpbYatJ0Uwmb/GlstK/G
	S5kM2Cgp1U9lTgik37amStwhXbGBHgs6I6LR+0KZL9b5kEoIt3DYywnV6JkFUhX4jXfoX/8JiExt+
	nAeoCf8lTzIE7p/kyZQOI/si3jnp/0/g10xxcY8BsGtccW5r1fHgjhXvAI65AC8PfmqJVQWPOMKkG
	0mH5fodYHEckOIPFmwNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5NJ-0006bj-MG; Fri, 08 Feb 2019 12:35:21 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5N3-0005Kg-4C
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:35:08 +0000
Received: by mail-ot1-x343.google.com with SMTP id w25so5447574otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=akSIvd6WCcF7HY3F6oGHn8ulHVn3lvhcTG9kZsVe9vA=;
 b=G99yMd8XaurWpkZ6qCL2c5XTrfPrfqEca0MfhXjJ84R2LyXk/WlN0KWy7rTk+uMHGP
 X89gZFWtFPF8sAdJkkjXKEjgC5x6KJODdZKfTr/6UvlCatSt+HIeIA//XD3h2REjx6dO
 YUiB0aZJ/CH/JkkTLqIGVJHHsZBxefrm1WqNlMKrOo+WwdjcW8JSocZJVWKjbIYt99Va
 Ga+zIzcI90V4JiOlPWPPK2gCW6GXqxf8WbjRPqyNYlj75tWbXj1YXvvGfExAU/jJJtqz
 SiphsKMDlOMyiyXQRwZT9Duh+c94ES07qXmU9yD1lVLIjqum6SMVtnSqDtwKCiYuUbWH
 qjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=akSIvd6WCcF7HY3F6oGHn8ulHVn3lvhcTG9kZsVe9vA=;
 b=FJEQUyejAjwR+fWcodXQh4hK1VXtPJD6yJxU6FAACLjwojdo2pZYBwuch7f/zlYuNa
 YvU9ih9vQ2kyQHUrYmlqv6QSt5nCZe3v3qmcM5QL3GTigndj09I10WVxi4N3VXsGtBO0
 5pLuo/s03USfS352hDDY6wgEtDMLkoRzl1x1hvRAtSzMqluY+f7QzejRg19bCPQkr9sO
 CiBulC8VYAhE/KfkjDdGjy8Mk1qKNc4BepcoVH8CwRmXeOiq4nbW7OJLeujhW3JJdUEI
 mPBB5ItQ7M0gZ32Wkk4GlUv37NfSv8cIWHuPWHSWv4NZv1HRBB5zmqcuT7eQ8hmS3dDr
 iH5A==
X-Gm-Message-State: AHQUAubJqjWRpb9FXP+vDBE6so8aCgYu6OqEUeKRVgYm75vJFuzTsjTv
 TJvAqKTcI4gLw/G+frx3dhTX1ExUnPCJn4TLiNn4Mg==
X-Google-Smtp-Source: AHgI3IbrmbNlc7e2FCle4ibP6LEu4vFy5LDv5e8hWf9/mVAjU3HkyOWXVv3AKl3LeSu7nDCyeMO63rJUOP+l91XsJx0=
X-Received: by 2002:a9d:7c1:: with SMTP id 59mr13633936oto.191.1549629303596; 
 Fri, 08 Feb 2019 04:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-6-brgl@bgdev.pl>
 <9d423e18-8c85-731b-388a-1843067db242@ti.com>
In-Reply-To: <9d423e18-8c85-731b-388a-1843067db242@ti.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 8 Feb 2019 13:34:52 +0100
Message-ID: <CAMpxmJW0qMi0BmiK2SOwdagw2-t8+1g20XJR418mWb8f1dwxtQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] ARM: davinci: da850: switch to using the
 clocksource driver
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_043505_682811_9F8D9F71 
X-CRM114-Status: GOOD (  10.52  )
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
 linux-devicetree <devicetree@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cHQuLCA4IGx1dCAyMDE5IG8gMTM6MDYgU2VraGFyIE5vcmkgPG5zZWtoYXJAdGkuY29tPiBuYXBp
c2HFgihhKToKPgo+IE9uIDA0LzAyLzE5IDEwOjQ3IFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdy
b3RlOgo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGF2aW5jaV90aW1lcl9jZmcgZGE4NTBfdGlt
ZXJfY2ZnID0gewo+ID4gKyAgICAgLnJlZyA9IHsKPiA+ICsgICAgICAgICAgICAgLnN0YXJ0ICAg
ICAgICAgID0gREE4WFhfVElNRVI2NFAwX0JBU0UsCj4gPiArICAgICAgICAgICAgIC5lbmQgICAg
ICAgICAgICA9IERBOFhYX1RJTUVSNjRQMF9CQVNFICsgU1pfNEssCj4KPiBTWl80SyAtIDEKPgo+
IFRoaXMgc2hvdWxkIGhhdmUgcHJldmVudGVkIHdhdGNoZG9nIHRpbWVyIGZyb20gZ2V0dGluZyBy
ZWdpc3RlcmVkLgo+Cj4gVGhhbmtzLAo+IFNla2hhcgoKTXkgY2xvY2tzb3VyY2UgZHJpdmVyIGRv
ZXNuJ3QgY2FsbCByZXF1ZXN0X3JlZ2lvbigpIHNvIGEgc3Vic2VxdWVudApkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoKSBpbiB0aGUgd2F0Y2hkb2cgZHJpdmVyIHdvdWxkIHN0aWxsIHN1Y2NlZWQuIEkK
bm93IGZpeGVkIGJvdGggdGhlIG1pc3NpbmcgY2FsbCBhbmQgdGhlIHZhbHVlIGhlcmUuCgpCYXJ0
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
