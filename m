Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:46:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EAF21906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wi/i77w5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0G1YeMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EAF21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y4Ev23qEEOR2lw/qMEK+hblMGcsypJhPrhRL5nw51ps=; b=Wi/i77w5tQcHbY
	OKlhYMZ584GxOzp2YHb3jtJsKEoGcgJWRTeTFKzhwr5POl61lAYGqB+/bFl9PprWN0jMBBDw7GGF9
	5ABehrrhPoAqpr1MKCkqOUbRjzwMwSjcqMbrduvyIPVksFB8o5V7mX3k6XzQ0Zr2hcMMz9kD41Z0/
	ln93/kkbqpdy1qJF4mD7EdoW0D6g5O2TNRkq33/treTGzoVAcm7+d3xm/Gx4x5d8Ebj6AW8HARfVQ
	0lZChdfGYwbjzq5RC6LqrWpKNzR1z+Iwa2x+pIIn/7vRtgK2Ad6V62TNOZeQFyX6CnMhQANla5TZt
	XI8qNsOiNy1K027pHzNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIKD-0003pW-EI; Fri, 21 Dec 2018 10:46:37 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIKB-0003ox-4I
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:46:36 +0000
Received: by mail-lj1-x241.google.com with SMTP id s5-v6so4294936ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YJtNNfGa2haQRFkmBC7eEcakpsa31ksdh6qKOp7LVz4=;
 b=g0G1YeMiKxcLc2ymUxy5FmwRkidpr4EgczZ1bhMlYNVIcItmyoUkDbK27xL05L9DK6
 Jp/iJs7EvoqnzDyi6fbRcgd5y9If9JMiOhLrSiqKP4+PZD8ER1Fw2jOXo+4KzFeM3F87
 y3dWUTT97pPu4Jg6VQ4cL29943HOjf2zV2Kbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YJtNNfGa2haQRFkmBC7eEcakpsa31ksdh6qKOp7LVz4=;
 b=H+ds/K1CnCB8kG/82u+uJn+jF54QUQLPOAccN7/kX32R0yKzJc4+m/CV8+ubC2WHYT
 uaUECM1iUa9xQHKcDkv0ytrG835gXgvPPmQptf+BaZdam4qlETkKo/ZGC6ypEugWHA51
 ynJHzcEWytA704RjNzEDkXq5aib3awUI+2DJJvrbJuuWNw07EmxHb1nr/cghUSPdmWey
 D7NVwa0b5hG0O3YsddCF2Nqw1jUl5VeBMz2eUSlMclQe5T80zTYHrXc5Zq/HlfJLudCA
 WFbQLA09wZ5bAovImOAq64h/xgyyU1+6RwP7JCwA5APXShL4z5QoTCL8By9VvJaWeY6r
 M8PA==
X-Gm-Message-State: AA+aEWbVSYltFlnCBytIUm3P0iUsIcgD8q8d4qBF+ctXG4nL4e2LMIcx
 n3KPEVKn6NlaBKysFkSsYn05Lurf1gHwhBf97hu+IA==
X-Google-Smtp-Source: ALg8bN7Ifb/j18kTXGHNES4m8Ssr9jshATaNu/lrNWaPheEO3aDmWVv6JRz7A9Qz7jsSNsr4qb+8p7I44rakzuBL4+w=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr1251078ljg.23.1545389183421; 
 Fri, 21 Dec 2018 02:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20181218155808.19517-1-zajec5@gmail.com>
In-Reply-To: <20181218155808.19517-1-zajec5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:46:12 +0100
Message-ID: <CACRpkdbw1Oy2bX6BV-gtYgncx4_wVpXvU98iU9Q71vkGnjC9mQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm: ns: support updated DT binding as syscon
 subnode
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_024635_169750_CF859771 
X-CRM114-Status: GOOD (  11.63  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBEZWMgMTgsIDIwMTggYXQgNDo1OCBQTSBSYWZhxYIgTWnFgmVja2kgPHphamVjNUBn
bWFpbC5jb20+IHdyb3RlOgoKPiBGcm9tOiBSYWZhxYIgTWnFgmVja2kgPHJhZmFsQG1pbGVja2ku
cGw+Cj4KPiBEb2N1bWVudGF0aW9uIGhhcyBiZWVuIHJlY2VudGx5IHVwZGF0ZWQgc3BlY2lmeWlu
ZyB0aGF0IHBpbmN0cmwgc2hvdWxkCj4gYmUgc3Vibm9kZSBvZiB0aGUgQ1JVICJzeXNjb24iLiBT
dXBwb3J0IHRoYXQgYnkgdXNpbmcgcGFyZW50IG5vZGUgZm9yCj4gcmVnbWFwIGFuZCByZWFkaW5n
ICJvZmZzZXQiIHByb3BlcnR5IGZyb20gdGhlIERULgo+Cj4gU2lnbmVkLW9mZi1ieTogUmFmYcWC
IE1pxYJlY2tpIDxyYWZhbEBtaWxlY2tpLnBsPgoKUGF0Y2ggYXBwbGllZC4KCllvdXJzLApMaW51
cyBXYWxsZWlqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
