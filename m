Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A855C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494B6218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DmWefxxG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXPqDrDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494B6218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1MUg72Qm9Q+9SMs9waM17PHtJdd7SCq3DSNINrTI8BY=; b=DmWefxxGsJMIW9
	30rYTRgm1fLos+23EUG89CIr41kQSu3KoHEeSe3q7I4agxe/A5e7Thy+80KvFs4dVParKeRZMqG+z
	rCX6b2sldL/JmiZtmuvX9Senk/WivaUqb9forh0UP2QLo/as6177rjSIbv85bMHcXejZ3QupRfXXp
	9WgoULKkdIHSnMJk1QVyjrElQ1h9DWQwDGey1APzMKJDpabAfABqpY3gO+mPO14tU1eIe3DM0qEoQ
	yx6UxRVL9QrCGqtKAsKZvRHO81k27d9EnPfUMpWk7fJ3V9aFVGfs+IIqjcW/fRTFGp3nNGEGoGP1T
	6d3hmtgkYNQ3bfXiFfLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiCH-00053p-Sw; Thu, 24 Jan 2019 16:49:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiCE-00053R-Oe; Thu, 24 Jan 2019 16:49:44 +0000
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2950E218B0;
 Thu, 24 Jan 2019 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548348582;
 bh=euAT9CB/Jdcpg0WuU2GpjY2q9AlvQzDaF+N18wlJhoY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CXPqDrDAEdHKYPZ0e0HEGObhHTh89VEsu8gMhmKqbkxi2F1Ob9TftcMuklwMarhAI
 HREhfOGxqHkqYLjRCK/ZvJSh4pESwyWucddWdBKwnx2JPZT2y/uqGuXHPuB4KSybij
 XqaaR6GPMUKLz1p0drCko7t5aED8EbpwwbGJvwQM=
Received: by mail-qt1-f175.google.com with SMTP id e5so7289336qtr.12;
 Thu, 24 Jan 2019 08:49:42 -0800 (PST)
X-Gm-Message-State: AJcUukc+/O17+hUJ+fiUOwOOnQvSSjSEOdeqeq2IYZAV0I9OwhLebI2b
 o5IC9GvXennQ7gFNVGho44kTK6ECHpeIEYq5Gw==
X-Google-Smtp-Source: ALg8bN7DMKRMSNuqqnBARNM7y3WTRvbM7dqCswmp/jMCw+JeOX3Hg6Q3URy4O5KzqZiNUfr6YwN9MzWjq+BfUHTBIdQ=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr6945862qvl.77.1548348581340; 
 Thu, 24 Jan 2019 08:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-7-manivannan.sadhasivam@linaro.org>
 <20181221023708.GC3233@Mani-XPS-13-9360>
 <9f4f05cb-f326-a4e3-e306-cfbf64b629b4@xilinx.com>
In-Reply-To: <9f4f05cb-f326-a4e3-e306-cfbf64b629b4@xilinx.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 24 Jan 2019 10:49:30 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+zfV66EZHX7psh2=r-=wDrmLLcr5PWtSzuKRNOdMR-Dw@mail.gmail.com>
Message-ID: <CAL_Jsq+zfV66EZHX7psh2=r-=wDrmLLcr5PWtSzuKRNOdMR-Dw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] arm64: dts: xilinx: ultra96: Standardize LED
 labels and triggers
To: Michal Simek <michal.simek@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_084942_821009_35F05A9F 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 koen.kooi@linaro.org, Linux LED Subsystem <linux-leds@vger.kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 12:51 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 21. 12. 18 3:37, Manivannan Sadhasivam wrote:
> > On Mon, Oct 29, 2018 at 03:12:44PM +0530, Manivannan Sadhasivam wrote:
> >> For all 96Boards, the following standard is used for onboard LEDs.
> >>
> >> green:user1  default-trigger: heartbeat
> >> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> >> green:user3  default-trigger: mmc1 (SD-card)
> >> green:user4  default-trigger: none, panic-indicator
> >> yellow:wlan  default-trigger: phy0tx
> >> blue:bt      default-trigger: hci0-power
> >>
> >> So lets adopt the same for Ultra96, which is one of the 96Boards
> >> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
> >> consolidate only User LEDs.
> >>
> >
> > Hello,
> >
> > Any update on this patch?
>
> I am still waiting for reaction from Rob.
> We are keep trying to keep backward compatibility and this patch is
> breaking it that's why I want to know DT guys reaction on this change.

dts changes and backwards compatibility are ultimately up to the
platform maintainers. Your users can yell at you if they care. I only
ask that changes that break compatibility are documented as doing so.

Personally, I'm in favor of this change. I'd rather seem uniformity
across boards and this is just a dev board and LED functions won't
affect booting.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
