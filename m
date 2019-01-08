Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:21:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EBE20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FM7qCs+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EBE20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mzu6EaMx0hctGrWX6HuCYYvT+5qx5kUqHIlAN/0Q51U=; b=FM7qCs+g7tVV57
	1/qq3EDuaIRfBPMhsklg7bHO8KEHvn2GbMfGIp0aK/XwLQggBwreoXgb9/1xy7IIWXRh1GEzPjHjH
	/kTn9e6kkCs+idXj3vmrZsHv4fCFoOkYbzi+B4gZJ77FZ5vZi7Xl9VtEiOfK/NVT5MI6L+R2ePbEs
	QVmpfZz4eOcmV+lp4Pdb0F/LjacSZzT8WuBKxMDzi33m3hT5B67B4WC7CHEHIINs7tLNJQeLOYEeU
	rT3o79JH56mDll9FRaR0UKL9RY3a0QHgnhX0KHqoKgS5IAXLSwt+YEj5M/cTRdK/Y2DWJmBPKWSkd
	Tu3zbTNCoRZbEw8e0b/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzkB-0000Q7-LJ; Tue, 08 Jan 2019 22:21:07 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzk8-0000PZ-F9
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 22:21:06 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ggzk6-00032J-M5; Tue, 08 Jan 2019 23:21:02 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ggzk6-0003Jh-5x; Tue, 08 Jan 2019 23:21:02 +0100
Date: Tue, 8 Jan 2019 23:21:02 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Arthur LAMBERT <lambertarthur22@gmail.com>
Subject: Re: Handle pwm with sysfs with recent kernel
Message-ID: <20190108222102.hwv5oekspifhj7bh@pengutronix.de>
References: <20190108100739.GA9046@arthur-bzh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108100739.GA9046@arthur-bzh>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_142104_664977_6E7C7958 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[Cc: +=3D linux-pwm list]

Hello Arthur,

On Tue, Jan 08, 2019 at 11:07:39AM +0100, Arthur LAMBERT wrote:
> I am trying to update my kernel bsp from v4.1.X to v4.19.8 but I have som=
e regressions
> when I try to use pwm through sysfs from userspace. I have three pwm decl=
ared as
> follow in my device tree :
> =

> 	leds {
> 	     compatible =3D "pwm-leds";
> 	     ledred {
> 		pwms =3D <&pwm1>;
> 		label =3D "red";
> 		linux,default-trigger =3D "none";
> 		default-state =3D "on";
> 	     };
> =

> 	     ledblue {
> 	     	pwms =3D <&pwm5>;
> 		label =3D "blue";
> 		linux,default-trigger =3D "none";
> 		default-state =3D "on";
> 	     };
> =

> 	     ledgreen {
> 	     	pwms =3D <&pwm6>;
> 		label =3D "green";
> 		linux,default-trigger =3D "none";
> 		default-state =3D "on";
> 	     };
> 	};
> =

> First I have an issue with duplicate name :
> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> CPU: 0 PID: 653 Comm: XXXX
> Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [<8010dda8>] (unwind_backtrace) from [<8010b468>] (show_stack+0x10/0x14)
> [<8010b468>] (show_stack) from [<8025ef0c>] (sysfs_warn_dup+0x58/0x64)
> [<8025ef0c>] (sysfs_warn_dup) from [<8025f200>] (sysfs_do_create_link_sd+=
0xd4/0xd8)
> [<8025f200>] (sysfs_do_create_link_sd) from [<80458d6c>] (device_add+0x1e=
c/0x5d4)
> [<80458d6c>] (device_add) from [<8040b5a8>] (export_store+0xfc/0x17c)
> [<8040b5a8>] (export_store) from [<80456904>] (dev_attr_store+0x18/0x24)
> [<80456904>] (dev_attr_store) from [<8025e604>] (sysfs_kf_write+0x44/0x48)
> [<8025e604>] (sysfs_kf_write) from [<8025dcb0>] (kernfs_fop_write+0xe8/0x=
1d0)
> [<8025dcb0>] (kernfs_fop_write) from [<801eaaf8>] (__vfs_write+0x28/0x144)
> [<801eaaf8>] (__vfs_write) from [<801ead88>] (vfs_write+0xa4/0x164)
> [<801ead88>] (vfs_write) from [<801eaf54>] (ksys_write+0x40/0x94)
> [<801eaf54>] (ksys_write) from [<80101000>] (ret_fast_syscall+0x0
> =

> I was able to fix it by revert a patch : https://patchwork.kernel.org/pat=
ch/9971821/
> It is normal that this revert patch is not currently apply on last 4.19.X=
 tag (last one
> seems to be 4.19.13)
> =

> Then I have another issue when I try to enable my pwm :
> =

> # ls /sys/class/pwm/
> pwmchip0  pwmchip2  pwmchip4  pwmchip6
> pwmchip1  pwmchip3  pwmchip5  pwmchip7
> # echo 0 > /sys/class/pwm/pwmchip0/export
> # echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
> -sh: write error: Invalid argument

Just a guess: did you check that /sys/class/pwm/pwmchip0/pwm0/enable
actually exists?

> Is there a new way to handle pwm in recent kernel ? My old process is
> now deprecated or something ?

Not sure what you want to achive and if pwmchip0/pwm0 is one of the pwms
used in your dts snipped above. If the pwm is in use, don't expect it to
be controllable via sysfs.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
