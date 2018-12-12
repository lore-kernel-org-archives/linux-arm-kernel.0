Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD1C20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ggXHoife"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD1C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6mVlELD9LE6v5uFIqLaSFD0cWRDumezY2J+7t6/PgXs=; b=ggXHoifeijQLD+
	SagtGfUYXiXpC6rHbizmg9S1CWGaxmXazHqSxJF+BiP967IyFbrjVvxGN6gfQaMDaX5AWzXg9Ylp/
	JPS9a/KbS2VG8UgMk16zpmz9QolH2XyvHTGngZOcn7Zu1S3FutjYUVGV6AXK8va14Coj5v/QaihwM
	4rfvuRGTpnKcLQQ/MtwQ1/O0MxP1zm36awd1Kx1i9/eGkyV3MS/hQKv4CsVuNMvtEPLd3sK5RjRic
	M9rqdtpYKc93ucB8A/PchxkPkzgjktC2a+T6h3jwRIWWu+pBdrACNL+1M3WjLB/7yfF+nosyknH/s
	sqiiXNI3ynKAVpRB0M6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWzIh-0006ob-KD; Wed, 12 Dec 2018 07:51:23 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWzIc-0006mW-RF
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:51:20 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gWzHy-0003fM-0X; Wed, 12 Dec 2018 08:50:38 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gWzHq-0005CD-LG; Wed, 12 Dec 2018 08:50:30 +0100
Date: Wed, 12 Dec 2018 08:50:30 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Hossein Radhasani <radhassani@birjand.ac.ir>
Subject: Re: MMC driver programming help request
Message-ID: <20181212075030.rjx7zoa3dlxu6nya@pengutronix.de>
References: <2352226718-734184@post.birjand.ac.ir>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2352226718-734184@post.birjand.ac.ir>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_235119_038691_1F8F037A 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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
Cc: chris-github@printf.net, wkernelteam@gmail.com, alcooperx@gmail.com,
 chris@printf.net, linux-kernel@vger.kernel.org,
 wsa+renesas@sang-engineering.com, will.newton@gmail.com, info@pengutronix.de,
 info@sang-engineering.com, markus.schuetterle@intel.com,
 matt@console-pimps.org, marcus.folkesson@gmail.com, olivier.gay@a3.epfl.ch,
 sebras@gmail.com, hashcode0f@gmail.com, cjb@laptop.org,
 tomas.melin@vaisala.com, ubuntu-motu@lists.ubuntu.com,
 bengardiner@nanometrics.ca, peppe.cavallaro@st.com, svenkatr@ti.com,
 linux-arm-kernel@lists.infradead.org, baolin.wang@linaro.org,
 iwamatsu@debian.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
 ben.l.gardiner@gmail.com, Avi.Shchislowski@sandisk.com,
 yaniv.agman@sandisk.com, alexander.stein@systec-electronic.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Wed, Dec 12, 2018 at 11:09:31AM +0330, Hossein Radhasani wrote:
> I need some help.
> I have device with eMMC storage and wnat to write on specific page of it.
> I was trying to use MMC driver, but unfortunately have some problems.
> Would you please help me?

The usual approach to get help in the FOSS world is to start describing
the problem you want to solve including the motivation for it. Then show
the things you did to solve the problem including a description how they
failed. And then choose the recipents of the resuling mail carefully and
don't put everyone on Cc who might have mentioned a relevant keyword
once.

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
