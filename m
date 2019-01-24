Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47D9C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:57:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A078F21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VNAFiu6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A078F21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VgbZaVD2TnD1EUGg5lLpFb2N01118FLxj0mYFTinb9Y=; b=VNAFiu6g2u7A7j
	JOtrvHrIzTj+VggJP2wadHwCTsvQLRMaiNgfDU2aUEyjbefRFbn/G6aoFq6XlHZN8jhuTLWQTW6uq
	Deh8mkV9MtuaWg5IW+YO+fMUOo/kjxBIXGYIqnIr1SyBLymtMDvDu7rwRlDAp6yfsQLHRSeYQio8y
	DhJW84dwNnkQ7yLbKkvQ3hfYCSgO4qNORXtaYfxKTh1mnKr3FtgZ3tdnWkzsL5unhgQZcVhwpLoS/
	5+K2VpXKsEtkCIwr1BQImfrl76Z5ptxqDUKCeymwWm97vrts695bPlgaP+OGskmsxbxv4RibBIuuX
	xVphkzaVEYJ58BAfr7fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmaox-0001ew-Sr; Thu, 24 Jan 2019 08:57:11 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmaou-0001eR-RM
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 08:57:10 +0000
Received: by mail-ed1-f68.google.com with SMTP id o10so3892306edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 00:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y+Ga4HcAj4PEPantT0zK17Jzcxuvsr4InP65q9Oyi8o=;
 b=Fx9c3KISxW3RrWqoMDyTt1prMC/z7Q9/060a1z9vw7My0q0pyTKx6svU+ISs3a/Ll5
 gG9l51IDZGPRHYDAwZbNo43NO9242cFH2RvcbXHHnVmb38yWzfAFv2mypp4WJnWjJKLI
 GV6UgVSlXWVGbF0L6NdVvh1Fff3q0w58grWV6vIFWkGuzsC7tvuoGAz/v8hd/71NAoy8
 hr4Cz9ravx5IUIEJVicfqU6umEPsBzosNyjwrMuyaW9aTR3fJSOSC50GpQ2zmp1hvDma
 RJnZ9xbCr6Px50aqHN0T7/eWGa8Zd1SJG00m33D+KzdJZD9uR164lcnuHO14o+dOnTOC
 8jiA==
X-Gm-Message-State: AJcUukd9emjguAwmEy5HL1Srg/1P4jkD8bw8e3DJZGusuUrnGbqqV5y3
 7X3eTdAj+qig8myWapZx5xKcL4aCFH4=
X-Google-Smtp-Source: ALg8bN6Y7hg98bwbxh43nobpUJLOw7Zjh4DcEpUm8QCe1ozzEBVvstG8pynd3YUmzfwUTbXxzEi7pQ==
X-Received: by 2002:a50:8f04:: with SMTP id 4mr5861672edy.95.1548320226400;
 Thu, 24 Jan 2019 00:57:06 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45])
 by smtp.gmail.com with ESMTPSA id m44sm11359247edm.54.2019.01.24.00.57.05
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 00:57:06 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id m1so2219277wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 00:57:05 -0800 (PST)
X-Received: by 2002:a1c:578e:: with SMTP id l136mr1631590wmb.124.1548320225556; 
 Thu, 24 Jan 2019 00:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20190110062207.18787-1-wens@csie.org>
 <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
In-Reply-To: <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 24 Jan 2019 16:56:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
Message-ID: <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
Subject: Re: [PATCH] clocksource: sun5i: fail gracefully when clock rate is
 unavailable
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_005708_882015_F94DE565 
X-CRM114-Status: GOOD (  13.54  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 5:19 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/01/2019 07:22, Chen-Yu Tsai wrote:
> > If the clock tree is not fully populated when the timer-sun5i init code
> > is called, attempts to get the clock rate for the timer would fail and
> > return 0.
> >
> > Make the init code for both clock events and clocksource check the
> > returned clock rate and fail gracefully if the result is 0, instead of
> > causing a divide by 0 exception later on.
> >
> > Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>
> Applied thanks.

I'm not seeing this in linux-next, nor the patch

    arm64: arch_timer: Workaround for Allwinner A64 timer instability

Any idea where these ended up?


Thanks
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
