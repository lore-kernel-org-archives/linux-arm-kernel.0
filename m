Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92160C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:20:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC902087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CJjqZPYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC902087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zGlUdG6QfNLDnvjquloH3qFSFsLp7wx6GnJv33FM3PA=; b=CJjqZPYFO3gzun
	H+7wSYs1pyAT4ESLO1oodk9tWap0BEb6cdxtB9OJg6+7PAzDJJjUd9G4RhLbzMXT/4B7mgnNFJDW4
	hMHClGAGxNtqk/CKTVhzoJfC4gKg6NuDA9jjEfefxcheaHgQKDqbWQAdQ5whvWP0AL7CxrCipIzZr
	oCfg+6I+RDTENCf13rgkzlo1Jrtc65/liHEmrWMYLN/Z8XKzlwEM+cI5lHcSD44owHLZE2R3QoP3S
	vKXL/IL4mxqHdJT3gwh2zK48O61bUjTIA3p3kc8cDgAq+TmBF3SpGFWzeNpYhT/BqGju7SIKSQqyC
	bkjKTexqp++YqVvRWVsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggoVB-0006av-AV; Tue, 08 Jan 2019 10:20:53 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggoV7-0006aI-4m; Tue, 08 Jan 2019 10:20:51 +0000
Received: from oxbsltgw36.schlund.de ([172.19.249.46]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBlpC-1gZ4j13AL6-00C9xB; Tue, 08 Jan 2019 11:20:35 +0100
Date: Tue, 8 Jan 2019 11:20:33 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Peter Robinson <pbrobinson@gmail.com>
Message-ID: <389675377.186771.1546942833612@email.ionos.de>
In-Reply-To: <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <CALeDE9PX=2nR8=9JjT9wvsb470nrZ_h6JGFsrkYkexGOoOhXuA@mail.gmail.com>
 <849520506.312349.1546937289972@email.ionos.de>
 <CALeDE9OYZi+LZCtnm3kZQ2g5oJ1BWXgfoX0MBD4X0Bz2Vj9Tng@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] staging: vc04_services: Improve driver
 load/unload
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:pUPn0R8JAL/GK+uXZtJH8ZI6Q1vQBIML13Ffuz0gzebBgzJQdJ2
 O9u/aiOJqo+YvRjNQdvmvmB8XmelliSXx2ZCTX0G47SM6FiX7bNMy5GEV7SLzq6FU3AcRL3
 8R04ogkHtWAPKCc7qmEK3IupBrb4dhqlQJ5bTcHj1ozjMjmYLwsykvOoU1rtYedgg/0d5y0
 GBqqiT2drMJ9Ryq1B8Obw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x153oaDyqrs=:PHxeY1STUi/KSwzj0nSLsh
 Mh18ONSGlEfxBIfPDC535XxViKBMYwzTJvoU3yoPBcNkqbGuzoWGtKnK/252u5yygV3V9hZyV
 BGqgGduFwrGRUV/5pD3j14fQVFD2xOrngUnkoDZOVu2xwZkbZrzT51eYD3hBufYb2iJ5DFw+i
 AWDD4HyzkkptRSSQN3iB7W/Subpex3zJTEUgGPlwyDC00clMlc+3cPHpUmVf79ynOpHXKSSli
 YlD14UeCGtOBrrnLWswyGRbsITYalDP4o0MLt+jZ0KGluzlZXKuXUTVBO/E+GT+nkSv89aV/m
 tR+yh3/QIs9+I78XxfCIuZCbc+aZaIE7CjoIArkJywMeRlCDrL6IT6OXKcyVOmPQMIJR5mBBk
 A5PopueS7TlILgFfxVDQpGLUk+aUqc0KTUcn2fYBW3IcSFIjvdaXLHhX5vjvrMaY2WMdSZQ6S
 /p4yoQ5BYDthMVujYcXZ5wYbOAtfzIiUdYhLEhlE5ugpKDoT3gvl53XiW0di3TDCuTUHCh6R+
 YNnKcvOFarQU71/5u5sBBUoJFqRGCIUBbhP9caPzDqk8sZURI0KxVG/Wq4hVqwZtZYc+ZGivp
 dZdMJt1D4QhhmHLsRQgBnnLdiCGjILxa94cZMRMHmdfbffKw6uKXH9ogeuSDZrphr/MgMJNbF
 ekpfGOBJNWViR+QdrFyGEdKJyMThcBbmWMSEtXeXLpfgkoQHs9zZSz9FUUrj3NLBx6AHmT4vk
 WGlK4CSvRf0LPc1RD0EdGbVtqAR1RnpY1XY6HVgGzypQozOhr3sw0Szn0g0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_022049_493371_E6427DF6 
X-CRM114-Status: GOOD (  26.13  )
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

> Peter Robinson <pbrobinson@gmail.com> hat am 8. Januar 2019 um 09:56 geschrieben:
> 
> 
> Hi Stefan,
> 
> > > > This patch series improves the load/unload of bcm2835 camera and audio
> > > > drivers. It has been tested with Raspberry Pi 3 B and a camera module V1.
> > > >
> > > > This series based on current linux-next and Phil Elwell's series ("Improve VCHIQ
> > > > cache line size handling"). After Nicolas' series ("staging: vc04_services:
> > > > Some dead code removal") has been applied, i will rebase my series.
> > >
> > > I tried testing this series applied to 4.20 with the camera module.
> >
> > first of all this crash should never happend.
> 
> What do you mean by that?

looks like you spotted an issue in the bail out code which is very likely not fixed yet.
But i assume this wasn't your intention. You want to use the RPi camera with Linux 4.20.

> 
> > But why didn't you applied the series which was actually applied to mainline?
> > Did you apply the rest of Phil's DT series as mentioned in the cover letter?
> 
> I'm fairly certain I have Phil's "Improve VCHIQ cache line size
> handling" patch series applied if that's the one you mean, I will
> check (I'm currently dealing with 4 different kernels for maintenance
> so I'm sorry if my memory isn't exact).

That's correct. Btw you will need a recent raspberrypi-firmware (iirc since 10/2018), too.

> 
> > > I
> > > tried with qv4l2 (from v4l-utils) and using cheese, which in turn uses
> > > gstreamer.
> >
> > Please provide the exact commandline and version.
> 
> That was the command line, it pops up a GUI and then just taking a
> still. The version is the latest upstream which is 1.16.3.

Thanks, i will try to reproduce it.

> 
> > > I basically get the same crash for both options. Desktop is
> > > LXDE on 32 bit Fedora 29.
> > >
> > > I've not yet tried with 5.0-rc1 but it looks like it has this patch
> > > series and some other bits for the vchiq drivers in staging.
> >
> > Please try 5.0-rc1 which would be more helpful.
> 
> Yes, it's on my list.
> 
> > Maybe this sounds like a lame excuse but the intension of this series wasn't to get the driver fully operational. I think this is more Dave's expertise.
> 
> Well like so much stuff on the Raspberry Pi there's users that are
> testing it and want to use it so when people bother me I test it and
> provide feedback to the patches, if you don't want feedback I'll stop
> testing and just disable it and send people upstream for details so
> they don't bother me!

Please don't get me wrong. I'm very thankful to all this feedback. I know this isn't a very thankful job to offer a very close to mainline distribution and users expect the same behavior like on Raspbian. Without yours and others feedback we wont get much further.

All i wanted to say was: please don't expect too much. It took nearly a year to fix this VCHIQ corruption. I think for the audio and camera stuff, we are just at the beginning ...

So please keep up this good work.

Stefan

> 
> Peter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
