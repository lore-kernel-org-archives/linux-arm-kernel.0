Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F31C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:58:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0444C2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hd+pkJSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0444C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Df6ofAG5Uspq5lGk4zDFqQq5kC/t0Bfmifk+CNBUy8=; b=Hd+pkJSSDjpvTn
	6NKlp4USGsrg0Tz2xI9Rmspcxf0Kt1T5upw96jqk9cSmyUFCMs8dyRkZ9hr+/eSdNowNFL1E8Yhih
	beKOefHbpdc3KrEkBhAIKsDevMdY14bRqd79v49AcLFtv9mGfwRi5JT0EoiJpAg9jJBW2TeQEtYX/
	+3Bsed4wRgYKzNVf9b3q6NabCSkggiAn3+U23SHoZTJQyh2KXNPfg1TlEAtNG6YnS0aaOWzDKbtZM
	0EL2u3TR2jl3gPO5uT5NUjE5BRttLVrrWHSc6uzyzMNxxSw3J8F/xvtqxG/urr3gqiP+tQEpckIir
	j2tzlQ7ybw1zXgiat8tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWLB-0002xR-1o; Mon, 21 Jan 2019 09:58:01 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWKw-0002oi-QX
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:57:56 +0000
Received: from [192.168.178.52] ([109.104.39.100]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGR3r-1gzZ6N2YNp-00GuKF; Mon, 21 Jan 2019 10:57:38 +0100
Subject: Re: [PATCH RFC V2 3/4] pinctrl: bcm2835: activate strict mux mode
To: Lukas Wunner <lukas@wunner.de>
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
 <1548054685-3781-4-git-send-email-stefan.wahren@i2se.com>
 <20190121073419.iosy3bd6tcnexya7@wunner.de>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <db62122f-00fc-b251-6fa7-7d02a4d7d9c5@i2se.com>
Date: Mon, 21 Jan 2019 10:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121073419.iosy3bd6tcnexya7@wunner.de>
Content-Language: en-US
X-Provags-ID: V03:K1:3dOHuwY1fKnMvmIbNKHdOZwM3NHkPmgrUYe/oD9XopJT98qmYwf
 PZFoeBYTERkIw1bHqtm6GZUuL3O9gMgxE/H4xVqO1Y0AvkEz8CJshmkK9vcQ9ibWfQ0kW5G
 CAXom4604o1HXrP9WHfojawkPad5qgKsMbdaN0NYfDgx+Q6EdgzXDA0EgpWqS8I61Br8tBk
 Dp/a0FpmzJWpws2q0utPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fm4oqO38Y1E=:pGJteqNQIikaWr2cc5LpiF
 zFRJVtlAItCXPwsD2KJyHojAhNf4L120ni6vfF/lPU3rqfZ2WjBo88mVQBjU7XiqQuQsuUmal
 u55sRNacKj5krAarceI4XQAso3kO/5Baz9Fr6fM0yoOLeM3WpUx0nivYZG2YIPL4t6JcU4Y3V
 Ih2irgjQQpqhACWfuLqoEur2aA24BFZ90Ubi/Fn0bshYIh0QPLzccBcTsgeiLiHnFGQzrPtvy
 WMxLzY45eibaY2ky16OFbY5XnqUJfVmT+xuWh4VCeTZcLgV6U63v1vncw1G179WyitlU/OPuv
 YGBrqF/BrhylJJGAgPmJQZWanqLbtdLYMtj8x2jChJlxEHABrB/luiR+IjHNLRIWZC7+MzsBi
 CE+ZW2p54v6WVeiT++RyWwI/Kv8ZbujGPoG5LxVsSwzqYI7J8x6qqRAWtSTJembrHowZ35x1R
 w3PurP8o4iPmM8hDZ0QakDGpteQrgI/LliGFRdT1a+jP1wj6WcjZMrgeYe7a5A61QAMwPWmqS
 pYEpQ3Z/rfqnnd8tEzlKOy8INLKIS2RW8tZzXsHltAzqJgqlw0Sogk7Yq+8z+zJorWdBnfpgG
 NfqF6CrKXc2cf2YLlm0DW1z2CeLSmgz1On/NLEJkvYqUIkHcvA/7+OieOC0+cz3UY/gZcG2qK
 NOvex8InNtpnzc1I1Gwh8Cd0zMGBRf/L1UTvjLE0H4kgRnMsTnwZ5XR+ZluWyw65e6uaEU+a+
 v7NkyXcZTwMXgDaWhEuyzHmmxjPZ3nPGnAhTuI9mJestEPox91rQulrRs4I=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_015747_516016_3E11585F 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: linux-gpio@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am 21.01.19 um 08:34 schrieb Lukas Wunner:
> On Mon, Jan 21, 2019 at 08:11:24AM +0100, Stefan Wahren wrote:
>> This activates strict mode muxing for the bcm2835 pin controller,
>> as the GPIO Function Select Registers do not allow GPIO and functions
>> at the same time.
> bcm2835_spi_setup() in spi-bcm2835.c converts a native chip select
> to a gpio chip select.  So pins 7+8 and/or 35+36 may be set to
> function alt0 but in reality the pins are requested and driven as
> generic output gpio pins.
>
> I'm not sure but doesn't this break in strict mode?

That's a good point. I hope that isn't a problem because owner should be
the same.

But i didn't test this scenario. Do you mind to give this series a try?

The only issue i found so far was a unnecessary pinctrl on the Raspberry
Pi Zero W, which should be fixed with this [1].

At the end we need to switch to strict mode, because currently a simple
gpioset can "destroy" the mux setting for I2C or SPI.

[1] - https://marc.info/?l=linux-arm-kernel&m=154800402627578

>
> Thanks,
>
> Lukas
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
