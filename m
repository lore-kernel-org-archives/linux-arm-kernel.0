Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:07:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA81F20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B3EFrwNF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="duPXXMD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA81F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yePMvhn68yWVy3EbQhsxjTZ1F1JxV47CX6D7RoLEwXA=; b=B3EFrwNF0XgITe
	WBIIUs+eqr8ILz2LUKX3yRjwq0DqMgQMX8jxc4NgbpCvrFWdIyGinyghBYOmhra5txjF05NFLzHX4
	bDx63YVs1ZmpWg5uhAsRq3jc6A5NzXpNovrTGlF0ye1SsL5EVxnmNO4hZyGkEFw15wSY3E14BRxnC
	31bEJSOZJmyGq5hTr6mfJCll5xifTfg1gwYno/fdUotCCjt6vdGXwve4U+GOFVX219mwyg/FKbUFw
	9MBpophzqGUGhJK2XS+L7uS7u1fpdWPc07dIeiCC0MQgO+rl0nVZL5A5lGoWUXGeqxyHBygqr+6fN
	yPNELAGbYIRTHhC0jt0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSgeC-00026e-Db; Fri, 30 Nov 2018 11:07:48 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSge8-00025c-HJ
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 11:07:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xm3GtPoyMLfyE7dcaanJdP5XZ9duT9aSerkVkuOSze0=; b=duPXXMD2w7C5f4wHR2EDHDqYF
 7svGwFb2Qju+jY0E6YhmK0J12Zlr2gMtToJbKXjGfBrnpgh5RAg8v75ghNlHxz+bOocbS0c7t9Xdw
 8IuaU6xLrtoHlpXhK1xcDRceWrT4XgV5AQkSDbkmFPYMxJfmsB+MhEsqRS2mU7q7xF8po=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:41136)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gSgdQ-0007yq-FX; Fri, 30 Nov 2018 11:07:00 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gSgdM-0005Rj-7C; Fri, 30 Nov 2018 11:06:56 +0000
Date: Fri, 30 Nov 2018 11:06:53 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181130110653.GF30658@n2100.armlinux.org.uk>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130105022.GA15388@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_030744_575846_1AE719E1 
X-CRM114-Status: GOOD (  16.05  )
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
Cc: linux-doc@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Daniel Kurtz <djkurtz@chromium.org>, Sebastian Reichel <sre@kernel.org>,
 David Brown <david.brown@linaro.org>, Lee Jones <lee.jones@linaro.org>,
 linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Andy Gross <andy.gross@linaro.org>, Huang Shijie <sjhuang@iluvatar.ai>,
 Guenter Roeck <linux@roeck-us.net>, mazziesaccount@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, Akshu Agrawal <akshu.agrawal@amd.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 12:50:22PM +0200, Matti Vaittinen wrote:
> Hello Stephen,
> 
> Thanks a bunch for taking the time and reviewing this!
> 
> On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > > With MFD devices the clk properties may be contained in MFD (parent) DT
> > > node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> > > subdevice not to MFD device (parent). Add
> > > devm_of_clk_add_hw_provider_parent to tackle this issue.
> > > 
> > > Also clkdev registration lacks of managed registration functions and it
> > > seems few drivers do not drop clkdev lookups at exit. Add
> > > devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> > > releasing at exit.
> > 
> > Please split this into clkdev and non-clkdev devm functionality.
> Allright. I'll split this to two patches.

Definitely, please note that clkdev is separate from the common
clk stuff, and is actually maintained by a different person (me)
although I currently defer much of the review to the common clk
guys.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
