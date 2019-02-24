Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECB1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:07:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90AA420842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NDulfMyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AA420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iqU91i8cv7RaMr0qJ8+oxMPClCdlXkEgvEi6gUfeiL4=; b=NDulfMyg2lWqpj
	rczNcsZW+BIXLqltL0YAglOFa4QNIcQ5qrL5SyMOgFcYQ8sRqrWr6A8917feP/aMVxsxW9Uj+soRV
	pbh5Tu96WLF78tpwfXzJtrvZ7ulwuHgNIxAE56CgctLmexELiY5Y3VJJFM7p7C79WtTLWZcQVejBw
	nnkksWE5lnrSHIATPbKpeuxAGWsenzQIYbr17rSjFve3OUIx+UvS0/Shxp2SLNahsivfwCjQuD01F
	KUWTzAtZSGXoL6Hmmte/1Nyz+MH9JA6ZiU2gfLb1w8npzszfFUHU0dfxejlVaiYCeMMKmlCOD8G5R
	Elj+10aYeGyolxWvVWxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy0zM-0000E7-KK; Sun, 24 Feb 2019 21:07:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy0zJ-0000Dd-HF; Sun, 24 Feb 2019 21:07:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FCE7A78;
 Sun, 24 Feb 2019 13:07:04 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B7D43F5C1;
 Sun, 24 Feb 2019 13:07:02 -0800 (PST)
Date: Sun, 24 Feb 2019 21:06:57 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64: rk3399: Add capacity-dmips-mhz attributes
Message-ID: <20190224210657.2cb54039@why.wild-wind.fr.eu.org>
In-Reply-To: <9562f9e4-b832-5cc1-821f-696ededf8a02@arm.com>
References: <20190224143525.15539-1-marc.zyngier@arm.com>
 <9562f9e4-b832-5cc1-821f-696ededf8a02@arm.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_130705_584037_C5F01B66 
X-CRM114-Status: GOOD (  24.83  )
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
Cc: Heiko Stuebner <heiko@sntech.de>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Douglas Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-arm-kernel@lists.infradead.org, Lin Huang <hl@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 24 Feb 2019 20:07:49 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

Hi Robin,

> Hi Marc,
> 
> On 2019-02-24 2:35 pm, Marc Zyngier wrote:
> > The RK3399 has the interesting property to be a so called "big-little"
> > system, where not all the CPUs are equal (the A53s are much weaker
> > than the A72s).
> > 
> > So far, we're not telling the OS that there is such a difference in
> > processing capacity, and Linux assumes that they are equal. Too bad.
> > 
> > Let's tell the OS about this by using the capacity-dmips-mhz
> > property. The values used here are those used on the Juno platform,
> > which is quite similar. This leads to the scheduler knowing that
> > it can pack more tasks on the A72s, and leads to a better interactive
> > experience.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > index 6cc1c9fa4ea6..7eab31184aee 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -75,6 +75,7 @@
> >   			#cooling-cells = <2>; /* min followed by max */
> >   			dynamic-power-coefficient = <100>;
> >   			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> > +			capacity-dmips-mhz = <578>;  
> 
> Probably better to use the value from Juno r2 (485) which should more
> appropriately represent A53 vs. A72, rather than A53 vs. A57.

Indeed. Although I doubt that there is such a difference between A57
and A72, but I guess it won't really show.

> >   		};  
> >   >   		cpu_l1: cpu@1 {  
> > @@ -86,6 +87,7 @@
> >   			#cooling-cells = <2>; /* min followed by
> > max */ dynamic-power-coefficient = <100>;
> >   			cpu-idle-states = <&CPU_SLEEP
> > &CLUSTER_SLEEP>;
> > +			capacity-dmips-mhz = <578>;
> >   		};  
> >   >   		cpu_l2: cpu@2 {  
> > @@ -97,6 +99,7 @@
> >   			#cooling-cells = <2>; /* min followed by
> > max */ dynamic-power-coefficient = <100>;
> >   			cpu-idle-states = <&CPU_SLEEP
> > &CLUSTER_SLEEP>;
> > +			capacity-dmips-mhz = <578>;
> >   		};  
> >   >   		cpu_l3: cpu@3 {  
> > @@ -108,6 +111,7 @@
> >   			#cooling-cells = <2>; /* min followed by
> > max */ dynamic-power-coefficient = <100>;
> >   			cpu-idle-states = <&CPU_SLEEP
> > &CLUSTER_SLEEP>;
> > +			capacity-dmips-mhz = <578>;
> >   		};  
> >   >   		cpu_b0: cpu@100 {  
> > @@ -118,7 +122,7 @@
> >   			clocks = <&cru ARMCLKB>;
> >   			#cooling-cells = <2>; /* min followed by
> > max */ dynamic-power-coefficient = <436>;
> > -			cpu-idle-states = <&CPU_SLEEP
> > &CLUSTER_SLEEP>;  
> 
> Oops.

Gahhhh! Rebase fail. What an idiot. Thanks for spotting this!

> 
> Otherwise, though, I was on the verge of tackling this myself now
> that my 3399 board is building its own kernels - annoyance at the
> linking bottleneck steadfastly refusing to move off CPU0 (except
> occasionally to another little core) has been growing steadily :)

Yeah, tell me about it. I still regularly build the kernel on my kevin,
and while the compilation time is reasonable for this kind of device
(and the storage media being an sdcard), the linking is just a pig.
Even on the A72.

> With the nits fixed,
> 
> Tested-by: Robin Murphy <robin.murphy@arm.com>

Cheers Robin. I'll post a v2 after -rc1.

	M.
-- 
Without deviation from the norm, progress is not possible.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
