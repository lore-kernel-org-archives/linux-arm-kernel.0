Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B94C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:23:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FC621924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WjzHHOWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FC621924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d4z9PDReLvXN9sXDvdRg4fhnIY6FeCZ4dQpPtjCx4ho=; b=WjzHHOWf4o3+V+
	pDp0PkPIyfqo4MXrTvBMy+DTtdP68jcbrDElxjskHFEqtbs4yRj9bDEsnNYS5ME8lS+KTthgdtnVg
	2YD40E3Xm3EErGI3Op8prJTAAsqJRLC9QT48UvPGcyiXe3ac7bZWLcH0Ede1YQ8/BFTKDa5uD9NiK
	0hBeaxXyAQShYbW/fTL72EEyaQ4vZtPI6F0jP7WXVvhBeo2buDrpWsAG2dhPQNfX3s/l27Gq+4rBH
	uK71mUyP2/hj99vuaGC6cIkPdwhRp3/R+sUycs6cQZwnqApSvRXp2XN8XvPjrPBp1KYrL2dTIIZhm
	nP9gqMzFFFLgxLQ7+O3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugGY-0006zn-O1; Fri, 15 Feb 2019 16:23:06 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugGV-0006zL-VE
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:23:05 +0000
Received: by mail-qk1-f195.google.com with SMTP id f196so5988231qke.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wWMuB6Q3NBKhtkNbEbTIvqCFa/p2FcoV+Ta6c7IOXvY=;
 b=JodWlyrqcPxl30690dHTOn0PrAtG1xtAF8MhShobnr5D8WZ1X9V9kRZ7/xdvJUa15Z
 4AQsV6PBbDOgmkF/urnG15+F8XXTR4w9CpXfEL0hIPlQoom+e9slhmm0tNWEvC15L2SQ
 ls4o8yIixKVKHnk0idrZrjqfs/R9xz7c26Br4kDMYScG+Eq94KvLOZepSUdKvV/6SXoH
 JpbW2P1zT78lAid6DPENMPygSbgVel0AZJTj6iHKm1c/RINGcqs7p5i845+YQ2mjgaAj
 VjdLmMUo7fMH0NRAghosfRhW4JYaSXwcKiYxwX2wVtt51sVr/FszD+FlTe3hCNevWhrs
 IbsQ==
X-Gm-Message-State: AHQUAuYkqqDl9OPf1E+mvKYO0dsfTrToS5el3AhLqHOPhO3ADyg+bxUd
 IPHuhaFSLzVI1b0rHLU5rYn5yWtdzrABpVXpd3s=
X-Google-Smtp-Source: AHgI3IYEwOQ9JQKDFjos3XTced1IRvGaURDNcpdm3N6/W/Jtn92y+tbVkVtx0EGR1Z3axlsiHI/maw3NgnhTZ6YFImc=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr7268248qkf.107.1550247783068; 
 Fri, 15 Feb 2019 08:23:03 -0800 (PST)
MIME-Version: 1.0
References: <1549644664.24981.1.camel@pengutronix.de>
In-Reply-To: <1549644664.24981.1.camel@pengutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:22:46 +0100
Message-ID: <CAK8P3a3DnDF+Jq1YaFj+tOie4Ti_LG6Jxsb-sW89mv8G3D=BGg@mail.gmail.com>
Subject: Re: Reset controller changes for v5.1
To: Philipp Zabel <p.zabel@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_082304_001523_6B2F2CAF 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: arm-soc <arm@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 5:51 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Dear arm-soc maintainers,
>
> The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:
>
>   Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)
>
> are available in the git repository at:
>
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-5.1
>
> for you to fetch changes up to dbfc54534dfcaee004d54137d9b34d000f847e41:
>
>   dt-bindings: reset: meson: add g12a bindings (2019-02-08 17:31:33 +0100)
>
> ----------------------------------------------------------------
> Reset controller changes for v5.1
>
> This adds the include/linux/reset directory to MAINTAINERS for reset
> specific headers and adds headers for sunxi and socfpga in there to
> get rid of a few extern function declarations.
> There is a new reset driver for the Broadcom STB reset controller and
> the i.MX7 system reset controller driver is extended to support i.MX8MQ
> as well. Finally, there is a new header with reset id constants for
> the Meson G12A SoC, which has a reset controller identical to Meson AXG
> and thus can reuse its driver and DT bindings.
>

Pulled into arm/drivers, thanks!

Not sure if we should use different naming scheme for the drivers stuff
in the soc tree, as this is not necessarily ARM specific.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
