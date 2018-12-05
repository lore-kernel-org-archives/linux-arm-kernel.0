Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2922C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:54:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19142084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G1jx+l11";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JiaNbCoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19142084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XIQhZeRJ5zNlFtqjGBGK5TjNDy1ZM1QaYQ4ff6HTJ80=; b=G1jx+l11LpyzJi
	vZCb0Ge1RDQ35jfZqfCDyvhrNbVGM5BZKMhukjBWj/8P4TCoOScsEVmhBvoBXDjCaHOyeRIvFxaHL
	8VbgS6I13MAQE8dNQstO3fXvsDkOTvFAjZkz2kyYXuLbkjZIa4F1jPj48omu7VIxnar5nx/cWonl3
	vTJIqZE3sH58U78VbCdJqiBCEW/TEklwupnf/ceTcwM4djhYax9rsNNt3ESU3l2/2uEAW/7toj+II
	3Z0U+CvtV2mvM8zesXhPQPWFuGmfb2TsH3hNxHqUVCalst0/duXasn6HvIWNGb2M83worxSNNpDKC
	YN3PdLdB2I1ktGnJ+xpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUSwQ-0000ow-NN; Wed, 05 Dec 2018 08:53:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSw4-0000DL-Br
 for linux-arm-kernel@bombadil.infradead.org; Wed, 05 Dec 2018 08:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xmM1BEtkefoqWBGHkVzaMVo4w5j2RiYBWLoUA7VVSVs=; b=JiaNbCoiWhqeSDX6ZvoXVrbPmR
 FtvKmSH05qfiseLm+nvMj27y6qOCGLLZF/Wg7YqIp/2RhFw7YXe/5doG8L4AuJOGIW/EWEiWxwmU+
 +9k1rkkGatUe0U4sY7gM7FIxHaHvbt8v6TxV5RoDVppCukEzajKD7gyrZqnnxHCcCr65N3eagw6TK
 hUZ5vm5WsrjK7IxX+62deiDMI04KhNnDfgmqC1fvAH+JDtD6PFJNIPTDLAh0s4TZesrTqTY3VhwrF
 Ukipx095HIj0aJKs5PPZUF+wCG4561+gSif/HVzZsDPqHRxLmbnmQUTG+0MsE54LvGF2NArz3g6rP
 hy6YbWKw==;
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSjk-00041J-Qn
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:40:55 +0000
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id ABF1644085C;
 Wed,  5 Dec 2018 10:40:37 +0200 (IST)
Date: Wed, 5 Dec 2018 10:40:36 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] Revert "arm64: dts: marvell: add CPU Idle power state
 support on Armada 7K/8K"
Message-ID: <20181205084036.wjqqqruapxqa4hvg@sapphire.tkos.co.il>
References: <3ece60154be74bd6534387db8da578194f823b43.1543938362.git.baruch@tkos.co.il>
 <87o9a1w9dm.fsf@bootlin.com>
 <20181204164843.edwszhv375yyhppb@sapphire.tkos.co.il>
 <20181205065750.kv554kuygbi63pju@sapphire.tkos.co.il>
 <87k1kowf7i.fsf@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k1kowf7i.fsf@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_084053_082332_A12089C0 
X-CRM114-Status: GOOD (  30.46  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Sergey Matyukevich <geomatsi@gmail.com>, linux-pm@vger.kernel.org,
 orenbh <orenbh@marvell.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Gregory,

On Wed, Dec 05, 2018 at 09:27:45AM +0100, Gregory CLEMENT wrote:
>  On mer., d=E9c. 05 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> > On Tue, Dec 04, 2018 at 06:48:43PM +0200, Baruch Siach wrote:
> >> On Tue, Dec 04, 2018 at 05:21:25PM +0100, Gregory CLEMENT wrote:
> >> >  On mar., d=E9c. 04 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> >> > > This reverts commit 8ed46368776b3bc93d74c1f8f2bfb9fd8a9ad805.
> >> > >
> >> > > This commit breaks boot on Armada 8K based systems. Reverting it m=
akes
> >> > > affected systems boot again.
> >> > >
> >> > > Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
> >> > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> > =

> >> > I would like to know more about it because on the McBin I use there =
is
> >> > no issue with 4.20-rc1.
> >> > =

> >> > Do you observe this issue with the arm64 defconfig or do you have so=
me
> >> > specific configuration option?
> >> =

> >> I tested the attached defconfig on Clearfog GT-8K and on another custo=
m Armada =

> >> 8K based board.
> >> =

> >> Tomorrow I'll test Macchiatobin with this config and the arm64 defconf=
ig.
> >
> > I reproduced same issue on a Macchiatobin board with both this config a=
nd the =

> > arm64 defconfig. The latter produced this splat:
> =

> OK thanks, for this, I also got the confirmation by my colleagues. The
> only difference I can think of, is the firmware, but the surprising
> thing, is that I have an old firmware: 17.06.2 and that with a recent
> one, it doesn't work.

This is right. I'm running the latest Marvell ATF release 18.09.4 (based on =

upstream version 1.5).

> So I will apply it in mvebu/fixes.

Thanks,
baruch

> > [   22.868568] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [   22.874694] rcu: 	0-...!: (1 GPs behind) idle=3D408/0/0x0 softirq=3D=
251/251 fqs=3D0
> > [   22.881950] rcu: 	2-...!: (0 ticks this GP) idle=3D7b4/0/0x0 softirq=
=3D168/168 fqs=3D0
> > [   22.889465] rcu: 	(detected by 1, t=3D5252 jiffies, g=3D-967, q=3D29=
4)
> > [   22.895498] Task dump for CPU 0:
> > [   22.898739] swapper/0       R  running task        0     0      0 0x=
00000028
> > [   22.905819] Call trace:
> > [   22.908285]  __switch_to+0x94/0xd0
> > [   22.911702]  arm_cpuidle_suspend+0x30/0x38
> > [   22.915818]  arm_enter_idle_state+0x38/0x68
> > [   22.920019]  cpuidle_enter_state+0x1d0/0x240
> > [   22.924306]  cpuidle_enter+0x18/0x20
> > [   22.927898]  call_cpuidle+0x1c/0x38
> > [   22.931400]  do_idle+0x254/0x280
> > [   22.934641]  cpu_startup_entry+0x24/0x28
> > [   22.938581]  rest_init+0xd4/0xe0
> > [   22.941824]  arch_call_rest_init+0xc/0x14
> > [   22.945849]  start_kernel+0x3d8/0x400
> > [   22.949524] Task dump for CPU 2:
> > [   22.952764] swapper/2       R  running task        0     0      1 0x=
0000002a
> > [   22.959843] Call trace:
> > [   22.962299]  __switch_to+0x94/0xd0
> > [   22.965715]  arm_cpuidle_suspend+0x30/0x38
> > [   22.969828]  arm_enter_idle_state+0x38/0x68
> > [   22.974028]  cpuidle_enter_state+0x1d0/0x240
> > [   22.978315]  cpuidle_enter+0x18/0x20
> > [   22.981905]  call_cpuidle+0x1c/0x38
> > [   22.985408]  do_idle+0x254/0x280
> > [   22.988648]  cpu_startup_entry+0x20/0x28
> > [   22.992590]  secondary_start_kernel+0x15c/0x170
> > [   22.997141] rcu: rcu_preempt kthread starved for 5252 jiffies! g-967=
 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D2
> > [   23.007534] rcu: RCU grace-period kthread stack dump:
> > [   23.012606] rcu_preempt     I    0    10      2 0x00000028
> > [   23.018116] Call trace:
> > [   23.020572]  __switch_to+0x94/0xd0
> > [   23.023987]  __schedule+0x1e0/0x5c0
> > [   23.027488]  schedule+0x38/0xa0
> > [   23.030643]  schedule_timeout+0x198/0x338
> > [   23.034670]  rcu_gp_kthread+0x43c/0x7b0
> > [   23.038524]  kthread+0x124/0x128
> > [   23.041766]  ret_from_fork+0x10/0x18
> >
> > baruch
> >
> >> > > ---
> >> > >  .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 ---
> >> > >  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 27 --------------=
-----
> >> > >  2 files changed, 31 deletions(-)
> >> > >
> >> > > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/=
arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> >> > > index 64632c873888..01ea662afba8 100644
> >> > > --- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> >> > > +++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> >> > > @@ -20,28 +20,24 @@
> >> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> >> > >  			reg =3D <0x000>;
> >> > >  			enable-method =3D "psci";
> >> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> >> > >  		};
> >> > >  		cpu1: cpu@1 {
> >> > >  			device_type =3D "cpu";
> >> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> >> > >  			reg =3D <0x001>;
> >> > >  			enable-method =3D "psci";
> >> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> >> > >  		};
> >> > >  		cpu2: cpu@100 {
> >> > >  			device_type =3D "cpu";
> >> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> >> > >  			reg =3D <0x100>;
> >> > >  			enable-method =3D "psci";
> >> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> >> > >  		};
> >> > >  		cpu3: cpu@101 {
> >> > >  			device_type =3D "cpu";
> >> > >  			compatible =3D "arm,cortex-a72", "arm,armv8";
> >> > >  			reg =3D <0x101>;
> >> > >  			enable-method =3D "psci";
> >> > > -			cpu-idle-states =3D <&CPU_SLEEP_0>;
> >> > >  		};
> >> > >  	};
> >> > >  };
> >> > > diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/=
arm64/boot/dts/marvell/armada-ap806.dtsi
> >> > > index 073610ac0a53..7d94c1fa592a 100644
> >> > > --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> > > +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> > > @@ -28,33 +28,6 @@
> >> > >  		method =3D "smc";
> >> > >  	};
> >> > >  =

> >> > > -	cpus {
> >> > > -		#address-cells =3D <1>;
> >> > > -		#size-cells =3D <0>;
> >> > > -
> >> > > -		idle_states {
> >> > > -			entry_method =3D "arm,pcsi";
> >> > > -
> >> > > -			CPU_SLEEP_0: cpu-sleep-0 {
> >> > > -				compatible =3D "arm,idle-state";
> >> > > -				local-timer-stop;
> >> > > -				arm,psci-suspend-param =3D <0x0010000>;
> >> > > -				entry-latency-us =3D <80>;
> >> > > -				exit-latency-us  =3D <160>;
> >> > > -				min-residency-us =3D <320>;
> >> > > -			};
> >> > > -
> >> > > -			CLUSTER_SLEEP_0: cluster-sleep-0 {
> >> > > -				compatible =3D "arm,idle-state";
> >> > > -				local-timer-stop;
> >> > > -				arm,psci-suspend-param =3D <0x1010000>;
> >> > > -				entry-latency-us =3D <500>;
> >> > > -				exit-latency-us =3D <1000>;
> >> > > -				min-residency-us =3D <2500>;
> >> > > -			};
> >> > > -		};
> >> > > -	};
> >> > > -
> >> > >  	ap806 {
> >> > >  		#address-cells =3D <2>;
> >> > >  		#size-cells =3D <2>;

-- =

     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
