Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3891C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20D72070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G3IvI80U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20D72070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hW52ponUpEOmKP/ny84YrApzeyujJsX+p4hIusT/x50=; b=G3IvI80UZhJJ6E
	b3lqCLJsRMUGgO00Da+b8bkvlzcg10uLGSCmBbvBi+AxvLndFewWgyn1Wp1d+eLKONEVObYUbxwat
	1qck0zvR/XPYZoX9QxsgRlF88kgCDRzzSk8PksfI7TrD/IYcygSg1tzGH3Nx4MI+1CBm/hYTU5PUe
	wtlk/2a53vegoHTAzVV++J7Xsnid8ZzIVEovdRwd9qpkcNc9mU+osRlhhcFkt1Jkxaa0XsN0QZ3IR
	ryHBWDDsC5zA1wvs5oUUpeEVLd5hexlzypSxNLyXaH8u+45S8w+Msh6EgI053FDnKNeAifsUAYirL
	ruD01nPwGip+nJGfOwYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggn3j-0004NB-Fl; Tue, 08 Jan 2019 08:48:27 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggn3g-0004MZ-9o; Tue, 08 Jan 2019 08:48:26 +0000
Received: from oxbsltgw38.schlund.de ([212.227.220.179]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5wTt-1gfRD63GWp-007XXB; Tue, 08 Jan 2019 09:48:11 +0100
Date: Tue, 8 Jan 2019 09:48:09 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Peter Robinson <pbrobinson@gmail.com>
Message-ID: <849520506.312349.1546937289972@email.ionos.de>
In-Reply-To: <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:QQtzDWFiEBY2hDFE75f/cCYJYegBzeTxMoNXDN7i5VC1tOSPukQ
 1godxxmovAL8CUJNxdzDfgNfkGnFBxHheV6z5NbrreDiO0/seBGRvTe3WALhvItePw4sOL3
 9HTCQmnuGHaPwjeaQQbNih7KLsEYV2rjw0xmr5yxODMutdOYb2WZc2oaus/cNvcZIjvPoF3
 3YgaK0Rcj13JK/7IMYGKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PxrWlaAjpm8=:UiPw4ieeK0kRXysGTc0Cwv
 nK0RZgBt2qyTepnGe66lNjoOJ291yIN6Pb9dd5rk0HactSogkDBlfN3cIWjS8gBBYAwpJE29r
 YboXXVauXb9sCBKw1z4cUxJBKSEqGuJ47fSlNLj8MnynfN1MpOW0H6JwN8959al2cnb5V9CHm
 6y1COxd15ySRWMNRrVaJ8DrLmypAIzUMrNwS6NcVy61LClTf1DsrPEarabr5Xw/RtpmVRuAK2
 HAZiOwmsySyxP6i1D9O7p95z2pGfR+FgER2PrMC6ihBqvA0fhRnI7QJBasBR7BWl6hNgEdK5c
 Hmxg/UA0yIQH2XESJa/HXc7E2gSs01c9FjBq0XiEEgynhstQwyjifMPwnQ4CdrzFKxKDlBX7j
 h38iIPDFx5N0oLKoG23rCVj7Mqp93035+hTibghwib4R7+qGUIE4YcssjE2b5EtKJc7eWm9x0
 kSXMVN8gH+AEtD1ImTeWIguUSPqjuzG7bdsFhVdbkwz6AuSuwffob/G/diurwl4pTZtWNttqf
 pGS0Z9QrwUa/FORdsn9FilRFoCgxD2utsmoIwPZizVkH/K1FC2BZwtP8SaXKTF4aQ+8uOFfYG
 x8mgwvoBqEdTD9JxR35G2/oT9IsIg/I5SEf6grlGyTi9imgmpu2ccWNkaIU7T9z7aKLkyP3SH
 vkT/MLAuyeG4cIijVhSuWssXXFqBMMPuXFZEAorfSnjuoUHKEuE47dLAWWwAMhayJXbbIssPi
 Z3ygpkiGUQFdv1D6zrO4iJQSGxfpL7aIVLnm7sW2JMVdpKZ3lmM+Zp7ONDM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_004824_640320_FDAEA57B 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: devel@driverdev.osuosl.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 mikebrady@eircom.net, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, nsaenzjulienne@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Peter,

> Peter Robinson <pbrobinson@gmail.com> hat am 8. Januar 2019 um 08:21 geschrieben:
> 
> 
> Hi Stefan,
> 
> > This patch series improves the load/unload of bcm2835 camera and audio
> > drivers. It has been tested with Raspberry Pi 3 B and a camera module V1.
> >
> > This series based on current linux-next and Phil Elwell's series ("Improve VCHIQ
> > cache line size handling"). After Nicolas' series ("staging: vc04_services:
> > Some dead code removal") has been applied, i will rebase my series.
> 
> I tried testing this series applied to 4.20 with the camera module.

first of all this crash should never happend.

But why didn't you applied the series which was actually applied to mainline?
Did you apply the rest of Phil's DT series as mentioned in the cover letter?

> I
> tried with qv4l2 (from v4l-utils) and using cheese, which in turn uses
> gstreamer.

Please provide the exact commandline and version.

> I basically get the same crash for both options. Desktop is
> LXDE on 32 bit Fedora 29.
> 
> I've not yet tried with 5.0-rc1 but it looks like it has this patch
> series and some other bits for the vchiq drivers in staging.

Please try 5.0-rc1 which would be more helpful.

Maybe this sounds like a lame excuse but the intension of this series wasn't to get the driver fully operational. I think this is more Dave's expertise.

Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
