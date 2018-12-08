Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 09:25:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D524E20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 09:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PU6t/gVG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js8dievP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D524E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V7RjMyNCY3sjT7Jqo+3e7U+WWZ7G2M8J5g8VaBBdrhE=; b=PU6t/gVGEN1CVR
	4CGxpPhBNJ/4WiAEkgV/sQKiX05PqyosKDLVGC0wQ6+Wh9c+UAn/hUQePk/K27deEFq1mtQsPY6Qz
	HlbERsD2/dJWyCV/eR9+qobBKqJjbJ9/DNOH3SxWm/trjnr8uE/CJ1jkcnr3OIJM4NqfBt3cTj8Il
	NUClgR1qiSYg9M8LIBwI9xYzXKF3+wJoSUIi7e2FqY7WwFQnXF9QU9LXYP4NcqtzGRF56ejPaP5Sw
	jfzzsTR/Rh9mQWzioRhTz0cu0iqZHBta6dEvVk/REtP9g3sN0Oc6LKOdznwojSd3OEeILNUJx7RHU
	aVS08Y2+j1OPZddEOATQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVYro-000564-Lb; Sat, 08 Dec 2018 09:25:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVYrX-000557-S6
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 09:25:29 +0000
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D287120892
 for <linux-arm-kernel@lists.infradead.org>;
 Sat,  8 Dec 2018 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544261117;
 bh=W+kCvVXG75noIn5Ro8KbKFhJgWoRqpHLfB7IA0RqQnM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Js8dievP+xQizMtmhHU24jbA0rfHYZvndDmkG5/HVw7nslQTrAgsRJO7Jp0FJDuvb
 Mn24Lx9OylinCUt/s9Pxot67z7FG05TzrbQNtpKHnVV4TCzN/cwT64UWlKu4N+tE5+
 IpqkX4FCixB42pTwHiFRVulr3J1m600XPeuGEuRg=
Received: by mail-lf1-f54.google.com with SMTP id p6so4752174lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 01:25:16 -0800 (PST)
X-Gm-Message-State: AA+aEWZ5IuA1mulfILpN8bC8iADRWJVxgSe7XPkM1CbrzH45kJqMFIyl
 zuc6St8l82hAJh2Kaf1LZCIemFCP/8xEEbrg7e4=
X-Google-Smtp-Source: AFSGD/VlSOnsRxoY8clHAxXygse2BUo7XSjtG9Im9p919RM+0oEUBorFfwv4zLlX5wC40agzil8jsNmoOuEShfkT2i4=
X-Received: by 2002:a19:a502:: with SMTP id o2mr3062136lfe.92.1544261114936;
 Sat, 08 Dec 2018 01:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <CAL_JsqKK4F7QX=B-CcQkMsgN--r3xv6PS4JabzOb4kqfATwtsQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKK4F7QX=B-CcQkMsgN--r3xv6PS4JabzOb4kqfATwtsQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 8 Dec 2018 10:25:03 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcUsQYuet3guXaujhG_HSsW56tg6zmE8SaqXi9DjtA0AA@mail.gmail.com>
Message-ID: <CAJKOXPcUsQYuet3guXaujhG_HSsW56tg6zmE8SaqXi9DjtA0AA@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: robh@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_012527_939650_713A33F4 
X-CRM114-Status: GOOD (  21.44  )
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
Cc: andrew@lunn.ch, alexandre.belloni@bootlin.com, tony@atomide.com,
 linus.walleij@linaro.org, liviu.dudau@arm.com, yamada.masahiro@socionext.com,
 thierry.reding@gmail.com, f.fainelli@gmail.com, khilman@kernel.org,
 gregory.clement@bootlin.com, michal.simek@xilinx.com, arm@kernel.org,
 joel@jms.id.au, andy.gross@linaro.org, devicetree@vger.kernel.org,
 jason@lakedaemon.net, horms@verge.net.au, linux-arm-kernel@lists.infradead.org,
 mcoquelin.stm32@gmail.com, shawnguo@kernel.org, afaerber@suse.de,
 daniel@zonque.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 7 Dec 2018 at 23:33, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 12:36 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Olof, Arnd,
> >
> > I've put together a script to move the dts files and update the
> > makefiles. It doesn't handle files not following a common prefix which
> > isn't many and some includes within the dts files will need some fixups
> > by hand.
> >
> > MAINTAINERS will also need updating.
> >
> > A few questions:
> >
> > Do we want to move absolutely everything to subdirs? There's quite a
> > few platforms with only 1-2 platforms. I haven't added these to the
> > list yet, but can.
> >
> > Do any vendors need another level of directories? davinci, omap, nspire,
> > etc. for TI for example.
> >
> > What to do with armv7m.dtsi? I guess it should remain and we just fixup
> > the include. There may be a few other cross vendor things.
> >
> >
> > Sub-arch maintainers,
> > 'vendor_map' below is the mapping of file prefix to new subdirectory
> > (the SoC vendor prefix). Please comment if there are any issues.
>
> Here's an updated mapping filled out with the rest of the platforms
> and using SoC family names in some cases as discussed. The move is
> completely scripted now including include fixups (though any new
> includes could break things). So mainly just need to bikeshed the
> directory mapping. Not sure if marvell should be split up more or not.
> I split out pxa2xx and pxa3xx, but then there's other pxa chips I
> think aren't really related. TI is still all one directory except
> nspire. I was going to split out davinci too, but it's only a couple
> of files. Sub-arch maintainers need to chime in with what they want.
>
> A branch is here including a fix to dtbs_install:
> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm-dts-move
>
> vendor_map = {
>     'alphascale' : 'alphascale',
>     'alpine' : 'alpine',
>     'artpec' : 'axis',
>     'atlas' : 'sirf',
>     'prima' : 'sirf',
>     'axm' : 'lsi',
>     'cx9' : 'cnxt',
>     'ecx' : 'calxeda',
>     'highbank' : 'calxeda',
>     'efm' : 'efm32',
>     'ep7' : 'cirrus',
>     'mxs': 'mxs',
>     'imx23': 'mxs',
>     'imx28': 'mxs',
>     'imx': 'imx',
>     'ls': 'fsl',
>     'vf': 'fsl',
>     'qcom': 'qcom',
>     'am3' : 'ti',
>     'am4' : 'ti',
>     'am5' : 'ti',
>     'dra' : 'ti',
>     'keystone' : 'ti',
>     'omap' : 'ti',
>     'compulab' : 'ti',
>     'logicpd' : 'ti',
>     'elpida' : 'ti',
>     'motorola-cpcap' : 'ti',
>     'twl' : 'ti',
>     'da' : 'ti',
>     'dm' : 'ti',
>     'nspire' : 'nspire',
>     'armada' : 'marvell',
>     'dove' : 'marvell',
>     'kirkwood' : 'marvell',
>     'orion' : 'marvell',
>     'mvebu' : 'marvell',
>     'mmp2' : 'marvell',
>     'berlin' : 'berlin',
>     'pxa2' : 'pxa',
>     'pxa3' : 'pxa',
>     'pxa' : 'marvell',
>     'arm-' : 'arm',
>     'integ' : 'arm',
>     'mps' : 'arm',
>     've' : 'arm',
>     'aspeed' : 'aspeed',
>     'at91' : 'at91',
>     'sama' : 'at91',
>     'usb_' : 'at91',
>     'tny_' : 'at91',
>     'mpa1600' : 'at91',
>     'animeo_ip' : 'at91',
>     'aks-cdu' : 'at91',
>     'ethernut5' : 'at91',
>     'evk-pro3' : 'at91',
>     'pm9g45' : 'at91',
>     'ge86' : 'at91',
>     'bcm' : 'brcm',
>     'exynos' : 'exynos',
>     's3c' : 'samsung',
>     's5p' : 'samsung',

Since Exynos is Samsung, I would prefer consistency here so let's put
everything under vendor - samsung. I understand that It will be
different than arm64 but that's the problem of choosing non-vendor
name for arm64 at first place. So let's go with:
     'exynos' : 'samsung',
     's3c' : 'samsung',
     's5p' : 'samsung',

Best regards,
Krzysztof

>     'gemini' : 'gemini',
>     'hi3' : 'hisilicon',
>     'hip' : 'hisilicon',
>     'hisi' : 'hisilicon',
>     'mt' : 'mediatek',
>     'meson' : 'meson',
>     'moxa' : 'moxa',
>     'nuvo' : 'nuvoton',
>     'lpc' : 'lpc',
>     'owl' : 'actions',
>     'ox8' : 'oxsemi',
>     'picox' : 'picoxcell',
>     'r7' : 'renesas',
>     'r8' : 'renesas',
>     'r9' : 'renesas',
>     'emev2' : 'renesas',
>     'sh73a' : 'renesas',
>     'gr-' : 'renesas',
>     'iwg' : 'renesas',
>     'rk' : 'rockchip',
>     'rv11' : 'rockchip',
>     'socfpga' : 'socfpga',
>     'stm' : 'stm32',
>     'sti' : 'sti',
>     'st-pin' : 'sti',
>     'ste' : 'st-ericsson',
>     'spear' : 'spear',
>     'sun' : 'allwinner',
>     'axp' : 'allwinner',
>     'tango' : 'sigma',
>     'tegra' : 'nvidia',
>     'uniph' : 'socionext',
>     'vt8500' : 'vt8500',
>     'wm8' : 'vt8500',
>     'xen' : 'xen',
>     'zx' : 'zte',
>     'zynq' : 'xilinx',
> }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
