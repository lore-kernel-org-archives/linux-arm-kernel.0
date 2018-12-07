Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261CC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:44:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6132520837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FtXwpxOY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="0P2G5T3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6132520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tray3s0uBeeIK6L6QXPvWrqEVM2jW1uDXMLRMwR6zhg=; b=FtXwpxOYTGrYty
	kX+Zidekd+p59d7g0Z99WPFSdSWRFaMvC5PCV7u4P3jItmHVy2O+xbegXzjv1ryGWRyfCAIXzC2OT
	ZHKiKbDh+9TW7rt6vbfqqjMZ9jONPrLEknOxEjlvigp/ey9GAzMA6bKthYeSsPg7Qvsl9argcejnE
	QuNNLBdE+1RgZ0lIvSpNVWQdpfrkCBBUueMDy1hsSQiEmPsMGFGAK9Q3TaXpZXa+jZ9OmXgx8t2uk
	bFgA7tSY3WYym+83Ux5JNErvnbDBk/EXfZj2B2E25xC6MFpuOMNim8+hqAli4QYakEm7DG7/dngXf
	FMFJuSyd2gHiMwPJBKmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVL6g-0000Lf-Sk; Fri, 07 Dec 2018 18:44:10 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVL4m-0006X4-5l
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:43:01 +0000
Received: by mail-it1-x141.google.com with SMTP id c9so8573152itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BrG+ifZknwTyKCqlnxXZ/FhEU0RN2HO35sjZ9PctGMY=;
 b=0P2G5T3MRE8/JXwdWd+H0nZjpSzKrYM2zJtg31/roA0EVcgShg14uiK1/2vPUTtJup
 /VTuTiDQoMd0segGSwzILEoC+YIKK+C2HwJUwvH30VFPsjhu0XrRpiWFIcdAO0psNqU6
 u3/FSBjisUSBu4o+P6ADo8UPH5j09oLzLD3FmL5J7N1U3nQ9tEUyNfYg7p2It5flACNI
 qJUD7rAmPQoNv6xERILW/C5Blhh1/J4EO/QLN+mBM8tuHuvtxeQfjzBOj33QhJa9gjTS
 6yEtAC+pNFyEncFA2leEzHLurXafCdsWxsDsVXvnfNlOhB+AcVyuKOklbb5s3Esr6JeB
 QWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BrG+ifZknwTyKCqlnxXZ/FhEU0RN2HO35sjZ9PctGMY=;
 b=Jjrh9zSVY1DBvkmOgrhApO0f5bRd1LhuJXVW9b8kbLz+Z0KCympKzXnY8R9zjdIHe+
 bmknvpABUzPvaoueLkcO0v/eotIvKUWsQA5te+96XDJh52uGA4VEOs+vy4/oqYo9BkkY
 Z/QeGQRF57N/Lczkcs6ThJzLiswB//oB8qvw8mo4Fxa3XCvPMl3RhCiyCWya25O3AsSo
 gZyqkZWLSW5nJUiZXO4aucU5nALsf45LeRxQqnbwR1VqtEfOHww/f9sDkS4n41qAFsd2
 GYGgeTmIV7+BsRA2VOpFKkmv9lrLF+NbTGaq3r3B+AMW93mtoRABWrxAI0WMyWOSi/Ni
 pyQQ==
X-Gm-Message-State: AA+aEWajh+kd/qHTLHtpE1lnG/5aLFKcWA2aIT6bbg6zLK4o1vWcOwKd
 deh3TMqSOmmu2aBXMTHIEC5xl1m6L/6rijl9c+ACVrcm3hhLoA==
X-Google-Smtp-Source: AFSGD/WJIYaqlKiD7sikFlppUk1yXij+/MZO3SP9VC9pZXb7oDi1MQWtCf5VIcekBDOfrgA94b41QEYUSwqQrbu2Lks=
X-Received: by 2002:a02:89dd:: with SMTP id e29mr2916719jak.21.1544208120942; 
 Fri, 07 Dec 2018 10:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
 <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
 <CACRpkda25cuiPCe9ouvDDSpFwZ2z=Pm8pK=5jC-7OAcYwPSvvA@mail.gmail.com>
 <c1f63dd8-1c06-1797-025c-2cd4891d905d@gmail.com>
 <CACRpkdYCsh3AfmV-7ym-ffjp2k-kaNRqY1O3rd9h-WoUPYM_bw@mail.gmail.com>
In-Reply-To: <CACRpkdYCsh3AfmV-7ym-ffjp2k-kaNRqY1O3rd9h-WoUPYM_bw@mail.gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Fri, 7 Dec 2018 10:41:48 -0800
Message-ID: <CAOesGMhcBXLRRKdOMdq3Bg8fOGX6F0gWMJ3zzg0jW9bg9VeW7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: Add devicetree bindings for
 MT6797 SoC Pinctrl
To: LinusW <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_104212_908875_FA4B41F5 
X-CRM114-Status: GOOD (  24.16  )
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
Cc: Sean Wang <sean.wang@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
 ARM-SoC Maintainers <arm@kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 4:01 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Dec 3, 2018 at 2:08 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > On 15/11/2018 11:04, Linus Walleij wrote:
> > > On Wed, Nov 7, 2018 at 6:49 PM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > >> Add devicetree bindings for Mediatek MT6797 SoC Pin Controller.
> > >>
> > >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> > > Patch applied.
> > >
> >
> > Could you provide a stable tree for me, so that I can take the dts parts?
> > I just realized that my build is broken because of the missing dt-bindings
> > header file.
>
> Since I pulled other changes on top it is too late for me to put that
> in an immutable branch and merge into my tree separately,
> you would have to pull in the whole "devel" branch from the
> pin control tree.
>
> What we sometimes do is simply apply the *EXACT* same patch
> to two git trees. Git will cope with that as long as they are
> absolutely *IDENTICAL*. (The patch will appear twice in the
> git log with different hashes but they will merge without
> problems, a bit unelegant but it works.)
>
> So in your situation I would extract this patch from the pinctrl
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=devel&id=95d2f00657ad4c2c3eacd8a871a7aa022c3fe7d9
> and apply it with some notice to the maintainers about
> the situation.
>
> ARM SoC folks: agreed?

So, applying the patches in parallel is fine, but this made me look at
the actual patches and file contents, and they seem to be a bit messy.

This feedback is more to the MT maintainers/developers than you, Linus
(obviously):

These header files are huge, and they're inconsistent in the way they
define these constants:

include/dt-bindings/pinctrl/mt7623-pinfunc.h:
#define MT7623_PIN_21_PCM_TX_FUNC_GPIO21 (MTK_PIN_NO(21) | 0)
#define MT7623_PIN_21_PCM_TX_FUNC_PCM_TX (MTK_PIN_NO(21) | 1)
#define MT7623_PIN_21_PCM_TX_FUNC_MRG_TX (MTK_PIN_NO(21) | 2)
#define MT7623_PIN_21_PCM_TX_FUNC_MRG_RX (MTK_PIN_NO(21) | 3)
#define MT7623_PIN_21_PCM_TX_FUNC_PCM_RX (MTK_PIN_NO(21) | 4)
#define MT7623_PIN_21_PCM_TX_FUNC_CONN_DSP_JMS (MTK_PIN_NO(21) | 5)
#define MT7623_PIN_21_PCM_TX_FUNC_AP_PCM_TX (MTK_PIN_NO(21) | 6)

include/dt-bindings/pinctrl/mt6397-pinfunc.h:
#define MT6397_PIN_24_ROW4__FUNC_GPIO24 (MTK_PIN_NO(24) | 0)
#define MT6397_PIN_24_ROW4__FUNC_ROW4 (MTK_PIN_NO(24) | 1)
#define MT6397_PIN_24_ROW4__FUNC_EINT22_1X (MTK_PIN_NO(24) | 2)
#define MT6397_PIN_24_ROW4__FUNC_SCL2_3X (MTK_PIN_NO(24) | 3)
#define MT6397_PIN_24_ROW4__FUNC_TEST_IN15 (MTK_PIN_NO(24) | 6)
#define MT6397_PIN_24_ROW4__FUNC_TEST_OUT15 (MTK_PIN_NO(24) | 7)

include/dt-bindings/pinctrl/mt6797-pinfunc.h:
#define MT6797_GPIO34__FUNC_GPIO34 (MTK_PIN_NO(34) | 0)
#define MT6797_GPIO34__FUNC_CMFLASH (MTK_PIN_NO(34) | 1)
#define MT6797_GPIO34__FUNC_CLKM0 (MTK_PIN_NO(34) | 2)
#define MT6797_GPIO34__FUNC_UDI_NTRST (MTK_PIN_NO(34) | 3)
#define MT6797_GPIO34__FUNC_SCP_JTAG_TRSTN (MTK_PIN_NO(34) | 4)
#define MT6797_GPIO34__FUNC_CONN_MCU_TRST_B (MTK_PIN_NO(34) | 5)
#define MT6797_GPIO34__FUNC_MD_UTXD0 (MTK_PIN_NO(34) | 6)
#define MT6797_GPIO34__FUNC_C2K_DM_JTINTP (MTK_PIN_NO(34) | 7)

So, is it a pin or a GPIO and why does 6797 use different naming
scheme? Why do some of them have __FUNC and some _FUNC? Why do some
have the non-gpio function as part of the name and some do not?

Also, "pin 24 row 4 func row4"? Seems to have very limited value to
describe it in that manner, it's just overly verbose without adding
information.

Some other SoCs tend to use a pinctrl specifier that is two-cell <pin
function> instead of trying to pack them into one integer. That seems
a lot more practical, especially since the base GPIO function seems to
generically be '0'. So the pin number would go in the first cell, and
the function in the second.

Finally, I don't see how the header file is used in the code at all?

The main idea behind the dt bindings header files is that they would
provide shared constants between the DT and the driver in the kernel.
If the constants are never used (i.e. they're just register values,
like today), then there's no need to merge the dt header with the
driver at all, it should go with the DT contents instead. So, for
example, if you used something like a format of <pin function>
properties, the header file could contain both the string
representation of the function for debug, as well as the values, all
derived from one place. Today all you have string representations for
is "func0".."func15" through mtk_gpio_functions[]. Seems like an
improvement all around?


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
