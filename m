Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:04:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B1720866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LzK8axh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B1720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2CpQJlgMUaxD+ERBGzNtQzWuEUPHgshxFL61C+Wb4pk=; b=LzK8axh9mIz5Lo
	Di/WHqbmdGrh7RCQXCXaP7FUPKEZKxNkAXnWQsMLVRZ/QZJnKI6H43qonAh9udcjNtTI4dDSQydad
	1EyEplD4Wq6sgx3Aio3MMttYGo74a4ofb7099GIFKZy7d/xZsAlTZRtPv4L1Vluv7cwAcEIMjr/en
	YIzJUGUJzV6V+U2TzobHrXXbTL6JmZGIkvmt8gLb2ZZtw8VUyKa1MgeyU3BMf1HZ2Tc1s/UUPmiAn
	Qdm0hlx22paI869BLn8BeEx6BkHVIPfSrlOxMhEz455XtSLRnmzbx5rRHNdnoG+cCEyeEOkQYM4h+
	BNZ/Q61YXmUVEYFw0qyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjh7u-0006vu-V1; Wed, 16 Jan 2019 09:04:46 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjh7q-0006vA-Ho
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:04:44 +0000
Received: by mail-qt1-f196.google.com with SMTP id d19so6312622qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 01:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w5JLoYZyr7ko3pxF3d0m/ILrs4Xoft/sF6jGA27FK68=;
 b=PwyY5jKx0hUz0lVrEM5F1FCZQGMPbrRg3YkUurHk68NDlrMjUh0pSRwmrLlKPjcTLP
 QidPeFRabbdPbqcR7a2BgKy53P3bXf19MAEh4v9+Gon4BdrcBnB4n2S+9FDcESK6KbMw
 rdhcftW7x9/mp4GXXVAgjefVLhCddn0NdiWq6fG3F7Pa/zuxXrAktHqcy++m1CH+6BSY
 A0bUcVTE3hZtjupiMe4AMpgfYoPkvryCv/9rzharwipsHgzT8OkuRLxEVJ8gDJRi3cfr
 tQmmVa0mi9MhKhbVMbRjQnkKAq4b5pQ3iThxT0wI0cnOmUphbemCguLrHFZdNXhN3o+g
 n/Yg==
X-Gm-Message-State: AJcUukeJt2/UsKZFfz1GGgYp3VT7udkhmzUNmUTvErYWNsyxrgCdOkEd
 SKI1nrF8IeG63Qs71JbPus4dHUM+bBBsPlR5xmY=
X-Google-Smtp-Source: ALg8bN4Vid741bDPYI3y7NMmjtovum5hMwrktZH26yjLKKOBx95eEO1CrNaGdl7GBz6gC7zTEyIasKRSR7HRF2q8HCA=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr6357492qta.152.1547629478779; 
 Wed, 16 Jan 2019 01:04:38 -0800 (PST)
MIME-Version: 1.0
References: <1545351802-4354-1-git-send-email-thor.thayer@linux.intel.com>
 <1545351802-4354-2-git-send-email-thor.thayer@linux.intel.com>
In-Reply-To: <1545351802-4354-2-git-send-email-thor.thayer@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 10:04:22 +0100
Message-ID: <CAK8P3a3uoW=kUy_H2kXvtnyVZk7psF+hb3aS66GvtPZFDwpkgQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] mfd: altera-sysmgr: Add SOCFPGA System Manager
To: thor.thayer@linux.intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_010442_599453_EEAE6D75 
X-CRM114-Status: GOOD (  21.66  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jose Abreu <joabreu@synopsys.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, DTML <devicetree@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>,
 Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Networking <netdev@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Lee Jones <lee.jones@linaro.org>,
 David Miller <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 1:21 AM <thor.thayer@linux.intel.com> wrote:
>
> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> The SOCFPGA System Manager register block aggregates different
> peripheral functions into one area.
> On 32 bit ARM parts, handle in the same way as syscon.
> On 64 bit ARM parts, the System Manager can only be accessed by
> EL3 secure mode. Since a SMC call to EL3 is required, this new
> driver uses regmaps similar to syscon to handle the SMC call.
>
> Since regmaps abstract out the underlying register access, the
> changes to drivers accessing the System Manager are minimal.
>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2 Implement Arnd's changes.
>    1. Change socfpga_is_s10() to check compatible string.
>       Add new compatible string for Stratix10 in bindings
>       and add proper detection method.
>    2. Replace base cast with resource_size_t member.
>    3. Change s10_sysmgr_regmap_cfg to altr_sysmgr_regmap_cfg to
>       be generic.
>    4. Always use 4 byte width.
>    5. Initialize the .reg_read and .reg_write in S10 case only.
>    6. Remove call to syscon in 32bit ARM case and handle both
>       ARM32 and ARM64 in of_sysmgr_register().
>    7. Replace IS_ERR_OR_NULL() with IS_ERR().
>    8. Remove compatible check functions except phandle function.

These all look good, thanks for the good updates!

> +struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np)
> +{
> +       struct altr_sysmgr *sysmgr = NULL;
> +
> +       if (!p_sysmgr)
> +               sysmgr = of_sysmgr_register(np);
> +       else
> +               sysmgr = p_sysmgr;
> +
> +       if (IS_ERR(sysmgr))
> +               return ERR_CAST(sysmgr);
> +
> +       return sysmgr->regmap;
> +}
> +EXPORT_SYMBOL_GPL(altr_sysmgr_node_to_regmap);
> +
> +struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
> +                                                   const char *property)
> +{
> +       struct device_node *sysmgr_np;
> +       struct regmap *regmap;
> +
> +       if (property)
> +               sysmgr_np = of_parse_phandle(np, property, 0);
> +       else
> +               sysmgr_np = np;
> +
> +       if (!sysmgr_np)
> +               return ERR_PTR(-ENODEV);
> +
> +       regmap = altr_sysmgr_node_to_regmap(sysmgr_np);
> +       of_node_put(sysmgr_np);
> +
> +       return regmap;
> +}
> +EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_phandle);
> +
> +static int sysmgr_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct altr_sysmgr *sysmgr;
> +       struct resource *res;
> +
> +       /* Skip Initialization if already created */
> +       if (p_sysmgr)
> +               goto finish;
> +
> +       sysmgr = of_sysmgr_register(pdev->dev.of_node);
> +       if (IS_ERR(sysmgr)) {
> +               dev_err(dev, "regmap init failed\n");
> +               return -ENODEV;
> +       }

It seems odd to still have these two ways of registering the sysmgr,
from either the probe function or the lookup.

Since the sysmgr should always get probed before its users, you could
try to change it like this:

- let only the probe() function register it and create the regmap, then
  set the regmap as the private data of the device.

- In lookup_by_phandle(), use driver_find_device() to look up the
  'struct device' based on its of_node(), by comparing dev->of_node
  to of_parse_phandle(np, property).

- return the private data of the device.

That will also let you remove the global variable and make it (theoretically)
work with multiple sysmgr devices, which is generally the preferred way to
write a driver.

> +#ifdef CONFIG_MFD_ALTERA_SYSMGR
> +struct regmap *altr_sysmgr_node_to_regmap(struct device_node *np);
> +struct regmap *altr_sysmgr_regmap_lookup_by_compatible(const char *s);
> +struct regmap *altr_sysmgr_regmap_lookup_by_pdevname(const char *s);
> +struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
> +                                                   const char *property);
> +

You seem to have some dead declarations from before the cleanup that
should be removed now. Please go through the header file one more time
to see what is actually still used.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
