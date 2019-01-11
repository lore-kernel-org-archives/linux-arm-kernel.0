Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF07C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:17:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8032133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DuBUNyaI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyzkOV3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8032133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TCy8Y8LwM3xljG6ZG3h4yIJhwtHJwBpo4CDrX7g3/Xk=; b=DuBUNyaIPa191m
	fFAoTtHrj/SbJt9hYv6Oywp58tqnQ6iTNbdhkKefKHN2zSNKGGxkMAz/BlSUZBN6kbZjGJ8AkthBt
	KN+YtK7omKdYflI9z95fFfEMemsolQQiq2RNVY9putCBoG0Xj4lz2ihibLcobzbzyrKZMb6at2Aml
	1ZRoeoo9j3eK60JQoqZTXzXmDINuNPOpADjb9PPdUmiwOWiNm3GCtlZ0MNzSOlFuypQOpFW5eyHYW
	l/UGHp01+e4FTQZ+G4yct322JlrqmhzFUk1ux+4QUPya6Sqpa4tHniJWG7ZguBduSDcWnvt8iklOZ
	O4GJccm+BhRvqvMCjjsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghzUd-0001cg-PA; Fri, 11 Jan 2019 16:17:11 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghzUb-0001cG-7Q; Fri, 11 Jan 2019 16:17:10 +0000
Received: by mail-oi1-x241.google.com with SMTP id v6so12623315oif.2;
 Fri, 11 Jan 2019 08:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bWNIUmVkQq9RqCOAhq6V7vBzdtgOZN3aim6OqBC9ISw=;
 b=qyzkOV3XpP2QSnQcYovZSZ/p9yP6u1dFCjziL1iPRXVsZ9NHVu0rg2qAjMvxc8WIqb
 X30fz4ESX+mqReTDbBiMlumG0bO5yFMLMSazEayxK4CcsZwUbo2ehSDRuKNoOQUwbE0U
 Dl0g9plrBaDDJ29E0NGBgqZZLupZw3HUuKZFe+xIral4slgQjf0LhUIWQBrEdrTUQY4x
 Iiw8AA999b1WFHBpzJR8SDRkMjU4YNh0Ay13KyiRWOQlIxr2OiSDkiIEmVYZus2qRrpl
 nZsHHq4gagublhLh5X1unExoZJUwrzrm9t403SGP8dnFInxZB2no+gDQPhIqI+ycBgJw
 ZYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bWNIUmVkQq9RqCOAhq6V7vBzdtgOZN3aim6OqBC9ISw=;
 b=Y7OgtLuC9IGyfBc40ZgeUU0dgysZJ7dtOgBX5hYlqxjQThz0FimvDUIXkHXIfWKthQ
 s8wjDBbzvCdlptbLKD36fjcSO44Z5t1O2a7BOIGOhWGaMJEBYDlIKbbzXM3x4Dlf+04l
 Nbw6dnokt2ENORwxhoBsTUm9aUzaXYQq9Isl3+Jm+AzugSpD90LKLSWWL+UVSAYbb0RG
 TJxA6w+6zw9km57s6wdImwrIR7T3//E9BsFuwHFwnkoh2wIV1sYmTA2Cs66hRaTW1tvh
 vEjNhiIvNW8MNdz0l5taXHvCIlv1VeZbsbW2XIdjJdAX31oHod0rDp94yb3/tkNUdvEo
 0L9w==
X-Gm-Message-State: AJcUukf59l8NLb3dl64lPHXJtQYbPlqd95T09FAVS/qSD/jkXnYvql2m
 y8A0VsIghuIN9dAlnFdPNFt7AIr2quS87yz5kpbm5g==
X-Google-Smtp-Source: ALg8bN7yzKlmiVp0aUaPqAYAlcqGrt+sXHqjwCj/dwiD7FfIOJFw5yrBwyDp24QeSfHEB8dykoZaNONHyhR/qx8kRMM=
X-Received: by 2002:aca:5b88:: with SMTP id p130mr9138692oib.96.1547223428215; 
 Fri, 11 Jan 2019 08:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20190111092235.28161-1-linux.amoon@gmail.com>
 <772bd70c-2cd9-a1be-d18f-7824a9ea0556@baylibre.com>
In-Reply-To: <772bd70c-2cd9-a1be-d18f-7824a9ea0556@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 11 Jan 2019 21:46:56 +0530
Message-ID: <CANAwSgTX4Rs7xXzjpNi-zizRyyO0FiFF0baOuQZ0fx9WEM9NCA@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator
 warning
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_081709_292922_E39751C9 
X-CRM114-Status: GOOD (  10.37  )
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
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Neil,

On Fri, 11 Jan 2019 at 19:10, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Anand,
>
> On 11/01/2019 10:22, Anand Moon wrote:
> > Add missing vin-supply 5V regulator node on usb_phy nodes needed
> > to power usb bus ports. Override the dr_mode from "host" to "peripheral"
> > for initialization of dwc2 usb0 phy node,changes fix the below
> > warning for usb initialization.
>
> I would have switch the dr_mode to peripheral in another patch,
> fix the regulator issue in this patch only.
>
> Neil
>
[snip]

Ok will split this into two patches and send after next dts updates.

Best Regards
-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
