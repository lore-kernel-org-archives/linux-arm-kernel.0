Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E430C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:32:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDCC22073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJgNi/Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCC22073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ftLOI8Scm/rz7GKCrKPE57gEDAb+AYRLnP3MTR3NBqY=; b=JJgNi/ZckvevXn
	4JmWRslZHlYCVXkNgBRCeHYIgGNGV2bRYLhsEjzkFbfqtg6puTE/1eVVOErolYcYYdAlfKKQiBrlA
	fHB4ZVZOnJh9chFvgnyWdehn8QCZRgRXQr8fN8mphse+56NCikh2CRypqg+WGWcJlMSOcybOA+5m4
	5ZyYopdu94F8FhxmK1t0yzgaGypGwn4R3l+peddRlFTwIAuuIezsxmMgyrkXGN/uuWXUzIVhzP1mt
	Uksfmmlgeo3bne8sVzNYt5rGkJjSW4J7xmCDwMJiJ2L8F/8WhKxTOubtnfPvAPmDZ16MvUpK2VZzg
	Bpx2os7sjfDyi4F4GVwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsm6-0007H1-Mh; Wed, 13 Feb 2019 11:32:22 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsly-0007FS-Tb
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:32:21 +0000
Received: by mail-ed1-f65.google.com with SMTP id h58so1622546edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 03:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ej2HPo48zSYWpfb8Z7VwdI7nxMv39cKnnirC71cYBxA=;
 b=ZT/vMKG0vFn2mZFp7JPEDdB3m8VXXk3qrDx1ggFNo/z98Zzv8vGijLgjuZ8DobCyY/
 kAjMJkxW2X0CzcRtQ4E3+UWk0IRnztXxA1myMtRw/Q/hbtAHKVClWGNVDFhl6tX7AmSp
 bUzkjqceha2rV9mXRph/pmBC9Kd+Im4cLCGzcCiIW3HgeJAyXAdKh3arZjRPtFrV0vyY
 /eRM58iX8T1bSA3Kir9VXI4pA60zRBoex8EAmYdx6/IU4+Jb0HyBhN05M91iF0egV3i+
 UiJZbH1/pfBvqQ7ZztMY7pzZVL/jIWP62rFCToLv6fuxQN4i6Vb4YblkstHNZ/MzHwQu
 NfHQ==
X-Gm-Message-State: AHQUAuaiXlz8B4o+dOOCbilkpyNAU1fi6Ywe2HBNm6Lt8rQiptFfo35l
 emdWPXNcqvd5cPPnO3BRJ4IWBNK5T6k=
X-Google-Smtp-Source: AHgI3IYVVRwGKU0P10a7rwaDMi3vgbEu/x5jutSamTFgIfEVi7TMYNlx32FqY270IuKDWmwDadVLuw==
X-Received: by 2002:a50:a086:: with SMTP id 6mr32443edo.88.1550057532483;
 Wed, 13 Feb 2019 03:32:12 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50])
 by smtp.gmail.com with ESMTPSA id p36sm4552248edc.78.2019.02.13.03.32.11
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 03:32:12 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id d15so2062007wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 03:32:11 -0800 (PST)
X-Received: by 2002:a7b:c00f:: with SMTP id c15mr48932wmb.14.1550057531489;
 Wed, 13 Feb 2019 03:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20190206033239.3619-1-wens@csie.org>
 <20190206033239.3619-2-wens@csie.org>
 <CACRpkdZFwG9-ap3jMe+eGDCgzG9+fKRXVEb4Q=pWasd5GUs9tQ@mail.gmail.com>
In-Reply-To: <CACRpkdZFwG9-ap3jMe+eGDCgzG9+fKRXVEb4Q=pWasd5GUs9tQ@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 13 Feb 2019 19:31:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v64VSvr9x8N3nXrtz5QYLf95K0BA8+VEqiVoXfmxVnFsJg@mail.gmail.com>
Message-ID: <CAGb2v64VSvr9x8N3nXrtz5QYLf95K0BA8+VEqiVoXfmxVnFsJg@mail.gmail.com>
Subject: Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on
 A80
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_033214_952585_6A8002FC 
X-CRM114-Status: GOOD (  21.21  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Corentin Labbe <clabbe@baylibre.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 4:21 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Feb 6, 2019 at 4:32 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> > The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> > settings would make the affected peripherals inoperable in some cases,
> > such as Ethernet RGMII signals biased at 2.5V with the settings still
> > at 3.3V. However low speed signals such as MDIO on the same group of
> > pins seem to be unaffected.
> >
> > Previously there was no way to know what the actual voltage used was,
> > short of hard-coding a value in the device tree. With the new pin bank
> > regulator supply support in place, the driver can now query the
> > regulator for its voltage, and if it's valid (as opposed to being the
> > dummy regulator), set the bias voltage setting accordingly.
> >
> > Add a quirk to denote the presence of the configuration registers, and
> > a function to set the correct setting based on the voltage read back
> > from the regulator.
> >
> > This is only done when the regulator is first acquired and enabled.
> > While it would be nice to have a notifier on the regulator so that when
> > the voltage changes, the driver can update the setting, in practice no
> > board currently supports dynamic changing of the I/O voltages.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> I merged the v5.0-rc6 into my devel branch and applied this patch on
> top now.
>
> All the DTS file changes should be merged through ARM SoC, and
> they should work fine now.

Thanks. Maxime actually merged them last week.

It seems this isn't in -next yet. I'm not seeing it in your git.kernel.org
repo either. Might be confusing for others that want to try it out.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
