Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE75C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:30:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1245121927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rB4kpTOq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nh0lM93U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1245121927
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iyfat4wn509UELAy2ZMLbEGypyREqG5mC3MTr0VmP+w=; b=rB4kpTOqrUh8Yh
	udRV6Q7cNLG7AnWEL5iNGd/X+QJXHHXP+/lZIcuRT9ilul5bCf1RynVe6fpNCsErTcsFbeWbZdRJ6
	+pZGfb6R9C5aC0BDeveUG2J7BtpZ8Jv8friKW/zShcQBwbX67BgSeaU/Co0A/W4jo48nb2jIfH5Ub
	q10AUUxJupRhfbtgMrxmMNOGbpfTrbOdC58+XAHN/VLeL6RiVQRtb+qt61CmlAndFx5xdgUolif30
	ldC3dR8Eiq7adKw0GDuKXAiBMaDIpngo9AAIZjRXc3BDpotB7iP4uNpE80cGLr0jV67Hl0+1qCO/7
	3G9GR5QOnleve6JczDsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4M3-0006RP-HL; Fri, 08 Feb 2019 11:29:59 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4M0-0006R6-Kp
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:29:58 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18BTr3g110425;
 Fri, 8 Feb 2019 05:29:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549625393;
 bh=HGzvHnNfCkbD9HiE6oB+g14lGZLuNB9ZAn/E7+lLLbs=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=Nh0lM93UNTpWWMtfhdxGoBuptZTdZu7gazTdJ5g42ijxXimDxxI8xyKBX+r/UmWZ4
 L7KzC8XdcUrEB/r0/+Afzsa6h10cyL4NCGenZU1NeUdAGAxkN274c3jO6UM1YaqsDT
 XnHfwvrddq+VET69MSHTCt2LdLDOMViy6cb1q234=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18BTra8113898
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Feb 2019 05:29:53 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 05:29:52 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 05:29:52 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18BTnEa007496;
 Fri, 8 Feb 2019 05:29:49 -0600
Subject: Re: [PATCH 5/8] usb: ohci-da8xx: add vbus and overcurrent gpios
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
References: <20190205102546.29457-1-brgl@bgdev.pl>
 <20190205102546.29457-6-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <d666c2eb-8193-6c63-c379-181482607a9e@ti.com>
Date: Fri, 8 Feb 2019 16:59:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205102546.29457-6-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032956_769959_FF459BB8 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bartosz,

On 05/02/19 3:55 PM, Bartosz Golaszewski wrote:
> +static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
> +{
> +	struct da8xx_ohci_hcd *da8xx_ohci = data;
> +
> +	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio))
> +		gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0);
> +
> +	return IRQ_HANDLED;
> +}

Its pretty strange to see gpiod_get_value_cansleep() being called from
irq context, although I agree right now it uses SoC GPIOs so it should
actually never sleep.

Isn't it better to use gpiod_get_value() instead so you get a warning on
incorrect usage?

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
