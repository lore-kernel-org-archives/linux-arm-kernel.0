Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F24C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:27:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AF521773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jj/qXTob";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8+m+os+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AF521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+gj+Q0HWCQTrF//+2bW7HYKBpNq6rs1YE3rISHJY+b4=; b=Jj/qXTobWb2jP9
	a8Tzo1AaKIylgez55b+ogdeODb5lEBukWlZ5uGNXsC72f1GYYsgO24swaxcx0r/G2IXLyDJEamJdu
	iNCBaBnqZ/MXg7suL+1DymSNwKu8H9OnebI/RwoNOPG/D3u6+A1tC09/CEKz0WUHZu881hMcDo9jN
	YAe+y2ULXEx3QgomORWjMfDV1UuAP3p38B5NoDfGnnF6SJhBTUhHfuFEX/oXNXRinK2YzWyAiWAMJ
	EUCwrdDfhEh3GS3us9IqvcOTuFf0CfvK6ECfw1Z5ygEu+ptadhSKK+W7UndLVJdFHHAK12+Q1Kucz
	nUYO2KAfXmZyZBbKKSSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqRz-0000LX-32; Mon, 18 Feb 2019 21:27:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqRw-0000LA-OT
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:27:42 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53AE421901
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 21:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550525260;
 bh=dgV4QhL6PEiMRVBpcLd8ejsFvA3+YQz8ppEP5JARc18=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=B8+m+os+HkSQ45i0GeOpES1+Zt7tRir0r9d++ArOsDd90aGJgjSQsNODK2SpjEUHn
 FL0dh2USmVXxnizJqmEWkYqXmCRXozAAJj0vojF8HT1RCbx6p+QeeiTD6xR8szVF8o
 vAQ5c+y9d3kfzNiyucgkVhG+3o1hKmJpv4r4gJmg=
Received: by mail-qt1-f173.google.com with SMTP id y20so20778499qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 13:27:40 -0800 (PST)
X-Gm-Message-State: AHQUAuZeKnr4lPQ5cBkz8pDTJVaBxCU2gJNoVHV7iLsMb56C9+F6+CE0
 QnrcQPMh8LHJqqyx9EBynfo9hxFBGnAXGFsHgQ==
X-Google-Smtp-Source: AHgI3IZqZ2t5BKDG1Gw28dfTEKFyJBB7LdHlUw+wjB+Swm5TbiYbBXZTUCs27G/uK3W87LsT2IuGy7sjIUJAL85NkX0=
X-Received: by 2002:aed:21cb:: with SMTP id m11mr532468qtc.257.1550525259583; 
 Mon, 18 Feb 2019 13:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-14-linus.walleij@linaro.org>
In-Reply-To: <20190203214205.13594-14-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 18 Feb 2019 15:27:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKoNmG2dG8PSh7ak2Oi4p8WiTSLfgpR21sGPw7-V0956w@mail.gmail.com>
Message-ID: <CAL_JsqKoNmG2dG8PSh7ak2Oi4p8WiTSLfgpR21sGPw7-V0956w@mail.gmail.com>
Subject: Re: [PATCH 13/17 v1] gpio: ixp4xx: Add DT bindings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_132740_808212_6CBD1F02 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Krzysztof Halasa <khalasa@piap.pl>, Olof Johansson <olof@lixom.net>,
 Imre Kaloz <kaloz@openwrt.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds DT bindings for the IXP4xx GPIO controller.
>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Bartosz: looking for your ACK on this, it'd be good if
> the other GPIO maintainer is aligned with my ideas here.
> I intend to merge this through the ARM SoC tree.
> ---
>  .../bindings/gpio/intel,ixp4xx-gpio.txt       | 38 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
