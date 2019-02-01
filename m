Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282ACC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:05:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB582218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lF68AiQp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGss0F3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB582218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YEvWz+oIHTOKDJdTW9+MbuPGBhMimd+H4Ob790UUsVg=; b=lF68AiQp2SUdMO
	p79siuAUWC7qPn7uT4alv5EkY0LEKQ27k7+mscV//z8rfpbtsgitXcLEDpLzaGuJwqxQJ6C1h8V3x
	XQZ4R6rfNeAkq6bUit+5Vvi7N/PkawqBT315jElaW3+sLJHNDx/O7jtQxmpFT0MymuobSCtDXzCXX
	SjjBfvJ555hhaBCFWlsQ5z+jfZB3GbfCejgLOJfiW6t/tEbQqJ+edxwn7L6CWESncnzJ5jq/P8+Y0
	RsiBygS7ur8rRQxN9onAe+jpfETKTXgBNhTjI07iRvm0w5sTyYSEExLW4MP0j/aGgmLNB0lwLsFT2
	8QnspzxcBVpK1MYGhA5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpXZt-00078b-Iw; Fri, 01 Feb 2019 12:05:49 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpXZr-000787-1X
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 12:05:48 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so5610964ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 04:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h9WunhkcVNnc7qqwFVSoWpkdTQdxgKjD8Aq4PO7VEJ0=;
 b=PGss0F3MD3HT4TDT+aNQPtMqr05rGuhCO+vOOV3bZbgCqnA2zwjSRVZ1ypph54jNSu
 1mOTJLiEdCwPIbEWakyv0b68IPgpQ0jyOcyGoqOhQ7VggF4oODzid4xXwj6MSv3oTp9p
 ZqNApiq7O06Peys+bWPCmzDPxjzeZ2aul9W98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h9WunhkcVNnc7qqwFVSoWpkdTQdxgKjD8Aq4PO7VEJ0=;
 b=b3pJI9sJFm0p0najVWYqQlubjIkMCDqghlOqIxQjiHUyYroEZfp2U/DgEqxd8a7Fxh
 REk5Xuij6bREtg2AEW/ZrgyyJx/CujaSzzo9eMZC5FC8uAugi/qbteqg1nPIiCtbI3Ce
 5iJ5zI1vSpHPvFW0y5pF2Nr1l6PUvDmDwlGa2l8XiJLKVEg4Ev/XfDRyiho7Oz7P3ZBW
 WIGUTtvcsmW3/HOYSJPqiLqh3Jhl9J0lFAeBZxHF9twf4ERIXdAco/bGMPCUfXIqxDmd
 lCknTGw8quqIguz3+zyVoHW2gz6DvPZdZ2dlfMPGmYEiMK5ZyjACqwdmpGFAXfOza12k
 o38w==
X-Gm-Message-State: AJcUukddpPkFGkaoKLMHCT6JZLmNndH3E91AHG3B9mNJ6bviDn93q3+q
 lLT7+VGOxePp0Cwn70aZD2SMOrZJM5KXIXOv7vsRhA==
X-Google-Smtp-Source: ALg8bN46lO7K3tOta5hrw+lUf9nsJnwT3Nhnoa6ufjpRecAKxQwcjlL+q7k6lud3a5WJwsBsXQW90ZZ+JQsKne5SI/w=
X-Received: by 2002:a2e:9d8e:: with SMTP id
 c14-v6mr32846984ljj.146.1549022742822; 
 Fri, 01 Feb 2019 04:05:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org>
 <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
In-Reply-To: <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 1 Feb 2019 20:05:30 +0800
Message-ID: <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_040547_089320_2FFA991B 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On Thu, 31 Jan 2019 at 00:46, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 21, 2019 at 8:39 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > This patch set adds charger and fuel gauge device nodes for Spreadtrum
> > SC2731 PMIC, it also removes redundant irq trigger setting for PMIC
> > devices and adds nvmem cells for ADC to calibrate the ADC channel scales.
> >
> > Baolin Wang (4):
> >   arm64: dts: sprd: Remove PMIC INTC irq trigger type
> >   arm64: dts: sprd: Add ADC calibration support
> >   arm64: dts: sprd: Add SC2731 charger device
> >   arm64: dts: sprd: Add SC27XX fuel gauge device
>
> I did not apply these because of the 'sc27xx' wildcard matching.
>
> Please fix those up and resend.
>

On Spreadtrum platform, we use one mfd driver [1] to populate the
SC27XX series PMICs including SC2731, SC2721, SC2720 and SC2730. So we
use sc27xx to be compatible with different PMICs' devices, otherwise
it will be difficult to define the mfd cell arrays in mfd driver. Do
you have any good suggestion? Thanks.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/sprd-sc27xx-spi.c

-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
