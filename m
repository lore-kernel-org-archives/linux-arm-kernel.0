Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_DISCARD,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:30:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0A521720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uZ0TFreZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=megous.com header.i=@megous.com header.b="EVycJ9GE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0A521720
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t8kUtm/s6Qa5m/N+9+MW0WK5ddf5splfWJxk2pO9dOo=; b=uZ0TFreZ5Drjaw
	9aW+DAGPF38iNvvGtkmExNzM2URZDUi6ffONzeOxkGcRkPPrvjhN+mK4ZE3pXjgcDIF6W7oQVCQTk
	p9fPoQyt7O4Z4k7MpZtgtsW8GHjM+/TaCecfKRnnZhdc5sccvG1IlEYJBUumh4lH59zm3bGivRKh8
	qNdjXXrNUwsT+xNNvwT/bGAEvPIxuFftNmvmS/M/Qi7XWnwqYGafP8Z7cxTnR7BlvWrRSTVTuuRX8
	SVAPcZKfWXPEyHbynoxXXI5uk+u8XT6mnvmZlWJ9ybM0yKYrCJmINpB2XHea8YgOyJpMY6++pSlnK
	7ekPNrP6k+4ddSP//JYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc6Rm-0004Nv-Or; Wed, 26 Dec 2018 10:29:54 +0000
Received: from vps.xff.cz ([195.181.215.36])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc6Rj-0004Mq-7C
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 10:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
 t=1545820176; bh=7jlh9sob4kpgPWzz20asCkW9HTckjcCtJKHZxR1+jJ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EVycJ9GEMR7Axwr+gNniLH/dLHWVCqG5Z3ioCUTHBZlBxsDqlNDz13wuVbl2KAjJE
 MCzhfnuUS8RH1CuZzdrCT8xk+pJaPUp4lwVv1eRoluILz85yilvDgZ+926AF/1atYs
 SsT4dbFxZHrtz/K4LlbMM1pna+sVulhBqCMyfiTU=
Date: Wed, 26 Dec 2018 11:29:36 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To: Yong Deng <yong.deng@magewell.com>
Subject: Re: [linux-sunxi] [PATCH v12 0/2] Initial Allwinner V3s CSI Support
Message-ID: <20181226102936.2xxu7lii4kcg7656@core.my.home>
Mail-Followup-To: Yong Deng <yong.deng@magewell.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Jacopo Mondi <jacopo+renesas@jmondi.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Todor Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1540886988-27696-1-git-send-email-yong.deng@magewell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_022951_419842_1975780A 
X-CRM114-Status: GOOD (  13.17  )
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
 Neil Armstrong <narmstrong@baylibre.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-sunxi@googlegroups.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Todor Tomov <todor.tomov@linaro.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Tue, Oct 30, 2018 at 04:09:48PM +0800, Yong Deng wrote:
> I can't make v4l2-compliance always happy.
> The V3s CSI support many pixformats. But they are not always available.
> It's dependent on the input bus format (MEDIA_BUS_FMT_*). 
> Example:
> V4L2_PIX_FMT_SBGGR8: MEDIA_BUS_FMT_SBGGR8_1X8
> V4L2_PIX_FMT_YUYV: MEDIA_BUS_FMT_YUYV8_2X8
> But I can't get the subdev's format code before starting stream as the
> subdev may change it. So I can't know which pixformats are available.
> So I exports all the pixformats supported by SoC.
> The result is the app (v4l2-compliance) is likely to fail on streamon.
> 
> This patchset add initial support for Allwinner V3s CSI.

I've tested your patches on A83T and CSI works on that SoC too. I'll send
DTS patches later.

One thing I noticed is that, when you cat the regmap registers file in debugfs
while streaming, the kernel locks up hard. I was not able to extract any logs.


regards,
  Ondrej

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
