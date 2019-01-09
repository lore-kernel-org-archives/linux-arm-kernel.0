Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:38:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8FB20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YnEoebSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8FB20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vdjne/+hv6y+e7YzEtYUICEMaQWRxGDj3nelgWRtAqM=; b=YnEoebSBoYtGL6
	DxuwRFfrtABh/It1gFjbuYrh7scRRP0pqz7ThvHFEBgodN/LEH7RwijcqLGHMMXfubzWH5TSCFqGK
	rKHJCoHpK9ffGYetdaGraCFqP3LoMU/2Vy7kZnwKLhPnTR3g91OYUiIvHKceK0c3etEcp73Mmix47
	p5PhtIBaT86yRdEnwIlJtExVAERRS844IhhxwVyhx5Wn/jCe19Fj9+59BVtz/ZBWVFY1ZvTbIlbNR
	MLmZHmrz5aJO0QXhovvisCmMeheSNx980wmM3QT8/HGjZOARtVKSOkKtg9ITpXZAYdyNB9sBrROoC
	3e2863ZEH1XVcOpvMCXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIkg-0004N0-7w; Wed, 09 Jan 2019 18:38:54 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIkS-00046l-Pi; Wed, 09 Jan 2019 18:38:45 +0000
Received: from oxbsltgw02.schlund.de ([172.19.249.19]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MplLZ-1h4kKL0zaH-00q8pn; Wed, 09 Jan 2019 19:38:32 +0100
Date: Wed, 9 Jan 2019 19:38:31 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1330816632.286127.1547059111664@email.ionos.de>
In-Reply-To: <da219894-4bba-21a3-94dc-da7ff7e63896@gmail.com>
References: <20181127211301.30296-1-eric@anholt.net>
 <da219894-4bba-21a3-94dc-da7ff7e63896@gmail.com>
Subject: Re: [GIT PULL 1/4] bcm2835-defconfig-next-2018-11-27
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:t8L12O4nzJmtIwGh5MeTOnxU6VYpEx+cvMEAexXAqXuT6M3sJBz
 eE1EC3Fn3verVZwT0zsXOqbMq931XXOKKgSnE0EaMGUZvt+9lA132elMnU6Dp1GtcG9Ni8r
 QRPCEUPzFCPn/ciMbd5CjdoIuGlj/QZzb1zklQOkKvy27KuvIIdjFG06Hrsl5Yqps6Gc49e
 GD0Y5mMy5oNuPuU+ReonA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ag583qZbjgo=:AUkVtI8ya9sh4KVi5DdtfQ
 KLAuSO3T53Tzjrc92RhVy9V78syFwemMeIA2iGS2E8/sSBhIgSsCDTtpJSJ7mnvR/3BHtclP1
 E7nspaM2hgO8ENAoA0rJ5b0lkdhVf+KFnEhts8kCzN/qpsgXg3fbe+K8qgnJgCJEL8Gx6Aaga
 1vjnkiNrUpzp6bf4oiBe1ZU/XagOHi44ljJ0K1Xv4S5+2hFMjcKuTxN4bEi5Gpmi9ypUs+SoW
 3SVeFAvf8y3O9Brb+ASw+cTTU83qULKaij/A7O++WMgLaJR41AeSYbLd8X6dy1njyKFUVGVOU
 PM0A+sHJynAqF+3Yedr+4LG/m8D1ByCyA7HcDLvy+V+iVTFADjSfOQtz1dfLUT//+4r5Sihfv
 gVHYd8fRE23AZCIsjHjKwTiA/ppVbLt0ceRdHoGxAWQytunuoyw56qKrXxWqdl7JRl60vSrQJ
 tGxTgbDaN3B3I+DJAcKT8yqvXmHTFW7TPCe13sB01U8i2Rk5zGOGcaENdpR0gbU8wbfBtIpSN
 E3XjcYAMw5o8WqRpdEB625k98Na1+B1NYrm5hopARPymM53M6Q2Q/mDfoSlo9pyM8FdZy2aL1
 QUTWehDysQt3o7L5+UpekDmDzQYO2Ha4ecHxRNA4ZukcdWaxMH3IaOfiWB7hIGE4Uv9eDWKXL
 tDHhfh0Cgl5a5LbAhAWaDJnRy3LS0zsJSmGrWaRI9XK57j2qZEbW/OUvWTxGY3WSQh+lGmzxt
 wpGo7fUUlYrKVBhCx9vWNeS2ULUfsvj9S/nBJ6VA3yTlCpt8MMVtovs3Gcw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_103841_633040_19873FAE 
X-CRM114-Status: GOOD (  16.40  )
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
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Florian,

> Florian Fainelli <f.fainelli@gmail.com> hat am 28. November 2018 um 22:48 geschrieben:
> 
> 
> 
> 
> On 11/27/18 1:12 PM, Eric Anholt wrote:
> > Hi Florian,
> > 
> > Hopefully I'm not too late this time around.  Stefan's been doing a
> > great job maintaining the bcm2835 branches, and was waiting for me to
> > send the PRs.
> > 
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> > 
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2018-11-27
> > 
> > for you to fetch changes up to 24632d6b78a1929b14f32cab762a0859db7086f2:
> > 
> >   ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver (2018-11-15 19:07:36 +0100)
> > 
> > ----------------------------------------------------------------
> > This pull request enables the V4L2 camera driver on the Pi1 defconfig.
> > 
> > ----------------------------------------------------------------
> 
> Merged into defconfig/next, thanks Eric.

looks like this patch didn't reached Olof for 4.21/5.0.

Should i resend for the next version?

Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
