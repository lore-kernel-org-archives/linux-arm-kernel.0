Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D56C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:10:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEA921900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MVPwwThw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c49xcXTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEA921900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FOuI9iT7Wr7HUCjgbgmR1tnHAYZGL4zO/v5GdjZ7MH4=; b=MVPwwThw2ZEXhyoA9QKHHgcVhB
	swuBtXz9lhie5IJu4MYRQ4YAMuJdS7rKCysn+Sh9T/qsv3ZgWobwwHmDjR7GqK/TScCHfpRstidUE
	aYOAz1sTMWcXnyHPFfKzFdfnFitJ3vqDL/ApXDpVnxEqKP2nwUYVcbyHfe9rwT+f7apiKOedDqeNh
	K4igEsduM4uY4piuSxbyD3bKIiQ+Csdv91TCypXgJyLT7TmuGuueum91ZIdZ7Yvz7qjtTafFtD+jM
	bt9puOPGhE1D7IS+m8h1AOYQr79rGQ0jWk1ht52vqqyU6beu7NReCCZTpMyKINmpWGYfnIz789G9+
	fh5EtFmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucKM-00085S-E9; Fri, 15 Feb 2019 12:10:46 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucKH-00084L-Tb
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:10:44 +0000
Received: by mail-ed1-x543.google.com with SMTP id m35so3805570ede.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=tL2ffv1V8sAnBnW7dhYpnxhuR62iC/h7erMqMK8Fj9M=;
 b=c49xcXTpD+KdV/RUUUxEg/dnd9h3qPOI2A/tvJfHSyeLe4U/kh6fsNmYJI8ES2jH9t
 8IFMa3i3IckxYpMu1dZxuqmykwvoEN9DID0bGGrgYxUcaMiYnmjjEtlveOWiHHximSnr
 Avzw5JVguxjq0XcKsxDwKIP0WLpZEQA5liPqJFJZ/Ki3g5InymHuxJKRXvNsudF+2Vkx
 40NYxNDCwrwbw92mAeMaAfr1qUYPeYIGjW5K7Wpqor5+lGLfyGcIAuP8BtIeZCbsbooN
 7BYcTMxFvPmGsj/CwhmISu7WXvbTmgHbBhWtdR8M3ROHmu/+NUptPpZ+rVIKq9tg92YS
 1pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=tL2ffv1V8sAnBnW7dhYpnxhuR62iC/h7erMqMK8Fj9M=;
 b=bY/Lc71hRKzr/K2QJMXs3nb7WtGcPmyqVL+rRjfPETbuYUWZJ1mltnjvBlwFPEvRb7
 +qdwIzc3+whrkrs2m05F0hk+dN9SUtuYwdg0bzjzzpbQ7f1Ygb+Kx13lPh7vMUVOp0PA
 XdT5meetaMKRamFw7oLG919zVgpuxEaaJZu7S8V69opWyB29G/FtnV0spMyqlOM3ywyV
 k4fesZN19+YelwQ0oBylhP7C5P0yABHjKyfTTA297E1vPRR/vfi+Lqbr7Vr0cgdw/ddy
 /UlT113u6izk1f3KQh7hyGPkH18C0Ipw2tPf1IAqaatlyAtcu3du32tZ4McDQv9hj6Ur
 aWmQ==
X-Gm-Message-State: AHQUAua0LHkoxkpuZ/yoDLo+tn3KUFf2EEINKEow9blFwfgONnTDh+eo
 7QDmvV9CY88SZauJ9cUobnMAlA==
X-Google-Smtp-Source: AHgI3Ibo+UUOXahAe+emIXgt+1BXKHGn8Isgb0YeuLfpyClDYzSD8m3L/UVIj3oskProlq5otWKfww==
X-Received: by 2002:a50:da0e:: with SMTP id z14mr7127378edj.244.1550232639501; 
 Fri, 15 Feb 2019 04:10:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2b])
 by smtp.gmail.com with ESMTPSA id d31sm1475619edd.84.2019.02.15.04.10.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 04:10:38 -0800 (PST)
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost> <867eeo7pjm.fsf@baylibre.com>
 <20190211083349.GU4686@localhost> <86mun2v27r.fsf@baylibre.com>
 <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
 <20190214091121.GI28278@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190214091121.GI28278@localhost>
Date: Fri, 15 Feb 2019 13:10:35 +0100
Message-ID: <86ef89fe10.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_041041_958019_918A5A74 
X-CRM114-Status: GOOD (  15.76  )
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
 <devicetree@vger.kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Loys Ollivier <lollivier@baylibre.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On Thu 14 Feb 2019 at 09:11, Johan Hovold <johan@kernel.org> wrote:

> On Wed, Feb 13, 2019 at 04:24:00PM +0100, Loys Ollivier wrote:
>> On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:
>> > On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:
>
>> >> Right, but please do look around for other receivers using this chipset
>> >> so that we can make the binding generic enough to cover those as well
>> >> (e.g. by choosing representative resource names).
>> >>
>> > OK will have a look.
>> 
>> The only mt3339-based receivers I have found are:
>> - [0] Globaltop
>> - [1] Locosys / Pololu
>> They both only provide the UART interface and do not list the I2C/SPI
>> interfaces.
>> 
>> [0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
>> [1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf
>
> I found tree more:
>
Ah nice.

>  - Globaltop PA6C
>
>    - https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6C-Datasheet-V0A-Preliminary.pdf
>
>  - Linx RM series
>    - https://linxtechnologies.com/wp/wp-content/uploads/rxm-gps-rm.pdf

This is a different chip: MT3337; Apparently this chip only provides an
UART interface: https://labs.mediatek.com/en/chipset/MT3337
However it looks interesting. I'll look for a sample to test it in the
future :)
>
>  - ublox IT530
>    - https://www.u-blox.com/sites/default/files/products/documents/IT530_DataSheet_%28FTX-HW-12008%29.pdf
>
> All with uart-interface only and similar pins names, although the ublox
> device do have some additional features we can worry about later.
>
> As all but the ublox device use VBACKUP for the backup supply, do you
> mind if I change the binding to use "vbackup-supply" instead of
> "v-bckp-supply" (which is a ublox-ism) when applying?

I don't mind. You can go ahead and change the binding.
For reference, the v4 patch serie:
https://lkml.kernel.org/r/1550070569-18588-1-git-send-email-lollivier@baylibre.com

Thanks,
Loys

>
> Thanks,
> Johan


-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
