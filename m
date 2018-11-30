Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A549C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:12:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C776C20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sXRcs9DM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LqkQ9cIg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="BJYu+dsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C776C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lc4mZy9GarAjrDhUfCO5RnvclVRD6nBscTfhI2SGorc=; b=sXRcs9DMiJs8gy
	w3Y0n4RV9v59Ch5UEzWz58LFiel54cumJNVuQ8007GDRHTnKvVni95aeiiSr+U31jj1sdPVsd11WP
	LGLHik6Qt/kSHxXMSp4NvV+DasUHqhwCJuUaX0h0YUG2RwGxwUOz+DbzguFyoLK6jA7/7m8qrTjBF
	J61Mj27flwS0+IHfUjxV1ajcGqWNM0TMe5Ni0jTufPu9ymc/t5jXEEuy6c6W630908Dds9xn0mMW8
	nOGdURcb8UsV/2O+bWGf03Jb2tW/gqQtWoRxyOvhvVQ0f1FyOgxa2N5UHAguK0Q1EHN/9r/ZtCiK/
	r3RnmJCSrB+6lPBVXz9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSstn-0004YI-Ql; Sat, 01 Dec 2018 00:12:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSstm-0004WB-EB
 for linux-arm-kernel@bombadil.infradead.org; Sat, 01 Dec 2018 00:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bog9RbcReh2TVfdmWMrAjFIKK/3eT2sGrZ7SIoXfH34=; b=LqkQ9cIgLnsJQPrGMBlIXxco9
 jcj203fxDiykvvc0LXag3p45K/I74tibil1LSx7DGqEq2QNFcy1dmEjwEoY7oOjVvAE5izk+I0kZm
 I6YrfVQDLOIZJAiWwUaJpviursePgiOoslbEPzDXaQEUVp5Rltfdk6/funbeq+0yL18mC552rmfQv
 ph3U+upwxzqmbIH91BW7PZi9PIgbk8v04dNDDAdVUROX6IujdGaC0IPCj5va2q57J0n2Srak+BjCl
 dzEY6P5G78g4+m6Of/LnIbwl9BtX0eJ13aeFZJhA2/ZubeqoAgQoCXdZ6W7vGYgoJ4f/dneGLvLLi
 GQh87ZCCw==;
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsi1-0002Et-FN
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:00:36 +0000
Received: by mail-lf1-x143.google.com with SMTP id l10so5315400lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bog9RbcReh2TVfdmWMrAjFIKK/3eT2sGrZ7SIoXfH34=;
 b=BJYu+dszxS+cHNB42uEF5A2YssZuQV6Syt4kU9F7fARv7G2JMIj3nabq22rtHkt/Qv
 eE2X+jDFuWCX9CdhrqrVV5lPAVFZF4lOOaj3kFfqD7AuZG0iCN6gTH1LYtX5S+/YSkww
 UiSAJvnzj2fveTFKLAUywPtDR5vSqjjWs+GJX8ssya8djaj5Hn+dwHUYaU+lpOiYq/fk
 aEkUNepj/y55vddXcfp1+caiE1imY2NL8cBOxHNk/ZN/BUnRCRb0ONx2xC4jsQE35qR5
 RNfVU9mJJY0sFrOWQ0uAAm0dgmsoSZAGJeDcFJglpnPd8p5MRGC+4WnQCedD71b2A9KJ
 0Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bog9RbcReh2TVfdmWMrAjFIKK/3eT2sGrZ7SIoXfH34=;
 b=UBm3sxJ1u1FXdnKUwbdk4r0RDZs7RQxR8gp19BtggICgFq0Rmz4mLzSJ71wHGsjI4q
 rK3VscBgqisJ9rgRxujdjMFEcd9Mfs1Ole+phXjcdTluMuEc8TptLEutmz+ChOnxCdrF
 RsC2yVDoFVu+xGuS8qP/IdX5uDeuNWxzzoLGvzGkbBhClQBuD1pjxX5Hf2vr3J9JODTo
 evyVdPoCyxr3PORbM3Z3rCkyj2wePBDJw4bUy/LfJsL42urbpmY8aVqh3TaHNBoUgA74
 baeF2fV+3ytqTumm00EPqddkOf52DO1r0u3qDVdrt6YRaVTAk8q5CkGGI7lAibL5bciu
 3xBw==
X-Gm-Message-State: AA+aEWZsP5dX/YIwPixvguPMU7pKTRggnRP9ZY+GeOP4Jyy4X8lNCmf3
 zyOKowOeRJseBQzJxvixS1nlhQ==
X-Google-Smtp-Source: AFSGD/XcWYyHGW2FeDYHNRSdBA9P52a0xBk6V5RFy+QXFCm9xOk5/OjJkHflcvWNFb3iXBImNld1sA==
X-Received: by 2002:a19:789:: with SMTP id 131mr982957lfh.11.1543622421717;
 Fri, 30 Nov 2018 16:00:21 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id x29-v6sm1029636ljb.97.2018.11.30.16.00.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 16:00:20 -0800 (PST)
Date: Fri, 30 Nov 2018 15:59:48 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 17/20] ARM: mmp: add a pxa-usb-phy device
Message-ID: <20181130235948.o22ywxk4e6ixfh3s@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-18-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-18-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_000035_134939_64F8A139 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 06:53:21PM +0100, Lubomir Rintel wrote:
> This is to replace the USB PHY initialization code (pxa_usb_phy_init(),
> pxa_usb_phy_deinit()) with a proper PHY driver.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/arm/mach-mmp/devices.c | 21 +++++++++++++++++++++
>  arch/arm/mach-mmp/pxa910.h  |  1 +
>  2 files changed, 22 insertions(+)

Applied to next/soc. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
