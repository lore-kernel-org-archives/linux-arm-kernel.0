Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:08:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72A620848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HPOaFQmY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZdFlTXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72A620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OOpLuoKW//qs3LFi96OmzTwPcHL2m3edCRBDMwrfaag=; b=HPOaFQmYrIasuI
	hFv2J+uwgOSt8OxQKH+mOYnB6wInl9PmZ2bYGGFOviVFL8VUEAiIGUR8IxpYB3YoLqHULvLMsbk1j
	+A6prPvNkMDD90aqe7k9+iQkQac62xj/L9uev757AFbzehki+kVtqIKaoL2EJkeEyHibfRXz+yS0h
	IVfFqjPG3g2Vgly/0Lzh/HvF+1WuPs1hUfx7cWKapATmbsfWzgA6LeL5ijtDhUn4kFapQQiyROHNL
	iAOKj/X0urMSBaq1wMVgQnAAJZLT6cpzbbwga2VnWRymJQENIGtdr1w722vF2f4JjFOdXTVsbZVRP
	D0ROK272ydwkL8FGTw7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtaC-0005ZJ-SC; Mon, 03 Dec 2018 19:08:40 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTta9-0005Xd-SG
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:08:39 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so13361258wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CytzOKiCHdHUl8JgtAdUEWHOwsuMVACHkaAxlaVQGck=;
 b=rZdFlTXWTFSWkxAETb14J3bHUJDuirxg6NkZw/84g5xh1kEtL5yvlhLwceLd9GbVYc
 zWNl7TGsNy7YuBmeOFRw4saQ0oDgcTI2fVW+CzD6WERZ+e5M2nDZgwhnIxB1UVnm/5mk
 mZh4LLXo74uBj097eE9JJ3veeUjzhdMq7fkuSy9wjAp9n5iB/uU2AZZ3E+mL2qofS1Qs
 pArXLmQuOkuCvtqCIkF+6rKr/1EcKxrO5xv2B7bXP6O07zy8NfzdXWDrHB6ZJE4rIRib
 HCsNr4LReAQgfZm1AEz3Iq4wR532CVyeAHiZUquVFUWxeKtj1O2di1AUxZ4UWxMHSfsp
 48hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CytzOKiCHdHUl8JgtAdUEWHOwsuMVACHkaAxlaVQGck=;
 b=VLM7WyqcN5d1JN/gBBf9/pLiVLcgvqOb1hupE/CFkZKCFwP25eY563LIqgZc0UVDNJ
 mWulDkxSQjKQPfMt342UNr5LBObYIbkNTMZPYj+12/oOLf2QLueCZ2WGixkX7APhOEpl
 7AnPK0eaqT+9EtaY9ZncATm+VkZfnb+pxDZzpXfQueOY3VXaY2Y/FE2fPNaMJV+/fJs5
 fkaAK6QDaHDQmW3AxgM6m4ZROOU80O1zbWgDnw3LY4axzmZHg8v6c1ecC8dyUTV+n8pL
 ioJhVmQhriR4HokGz4cBHvIHXnVnoXYYuLfkLCN5D8Ja3fYYLrT/FhDTvdWFRSrCPx7k
 DKsw==
X-Gm-Message-State: AA+aEWYhBaSyuV7OuDM0Osk9wjR+1tbSvUnIIiyTH1PWRdpzQ8p3TAE6
 B2JAKstTeEl7jB55Rh1hU88=
X-Google-Smtp-Source: AFSGD/WjStCFr26vctCzUlqlds53he+VgetjQHiSJ60h7DBFdo/3P65LTVYVr8IQ4lGI36PxuNMHyQ==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr15767752wrn.261.1543864104522; 
 Mon, 03 Dec 2018 11:08:24 -0800 (PST)
Received: from localhost ([185.219.177.226])
 by smtp.gmail.com with ESMTPSA id c14sm3807910wme.13.2018.12.03.11.08.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 11:08:23 -0800 (PST)
Date: Mon, 3 Dec 2018 22:08:22 +0300
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v6 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Message-ID: <20181203190822.jt7sieazcapm722w@ThinkPad>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
 <b3d266d9f5f0f7504701c3bbec819acde6d19257.1543781680.git.mesihkilinc@gmail.com>
 <20181203085531.exlmkfs6b4ejv5dr@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203085531.exlmkfs6b4ejv5dr@flea>
User-Agent: NeoMutt/20180716-631-34bcda
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_110837_924973_FE989F12 
X-CRM114-Status: GOOD (  17.45  )
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
Cc: devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/12/03 09:55, Maxime Ripard wrote:
> On Sun, Dec 02, 2018 at 11:23:47PM +0300, Mesih Kilinc wrote:
> > diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > new file mode 100644
> > index 0000000..ea335a6
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > @@ -0,0 +1,541 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> 
> This isn't the proper SPDX format, and this is reported by
> checkpatch. I've fixed it while applying, but please make sure to run
> checkpatch.

Thanks Maxime, I will be more carefull next time. I actually saw that
warning, but I couldn't find what to do. I have looked to [1] and saw that
its spelled correctly. Now I think problem is, the licencse identifier
should be separate comment like:
// SPDX-...

Thanks!

Mesih

[1] =
https://spdx.org/sites/cpstandard/files/pages/files/using_spdx_license_list_short_identifiers.pdf

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
