Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D06C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:59:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD1E2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MZWU81hf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR5MTue2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD1E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E5TUui6U+U5QEUzaGnav38kBkuZsvmSzovM1Xvcji1Q=; b=MZWU81hfQePnjy
	qBrqlt57rCROxo3LjuZyQirPEQUvqgANEjSFziamYt8TbeVgB1qwmyEl5peG8jhHRPQC6Q4D86Cck
	7nSCvuG4z+8/TzwXPVYvYQrPqHnvG2OMIdGROBXeft8gJFELBlZwgJumvP5DAXglO19Il1jMYyxgO
	r4Vr5j2eH202xc50gXHa7IhF4Y9Yv3hxow3jECZbAXF2PVT94tA74effhpDt6WfX6tYePYrygc6jq
	f4QMDQMiHT1FLNeBIL1fTh/12KxnRfkYPXRzJMgQXjB0jEyLd2H3DAjBBfDdBczGpIpFLdXj7Uy/T
	74/Vma4IuN7tSnmRn7ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwUH5-0007pW-EY; Wed, 20 Feb 2019 15:59:07 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwUH2-0007og-Ml
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:59:06 +0000
Received: by mail-it1-x142.google.com with SMTP id e24so2679075itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eRy3uxH0iZwIyYb3x/PVcOXd1aXhSn6gDIBvGBVJD3U=;
 b=ZR5MTue29eRVcVQa5EpI0nASuUtoyfXdyRsO8HKguw8lN+yjbxjbuXfjWjBdT2CgOu
 J+GMkktV5/LOoPiXITntaRKSN3kowPm3KmU3tv5HF4cEN6wuDDn1gaWpPVdB8VeIyNqH
 ZZWykwCvrjnx/m+9VZUaRo4flzuAMCiW/DY9m8ZkcyWHDVAt9gUBG1CRJw50Rt7opSZE
 hfYvmWF9BIfDa8acdOOut5PmnFCFGOsLywcy3HbOdNUZAFHCzvYt42KUFPrcxgBP98g+
 stcGJhqkVjIdTcW3Yz1cCVRCbT1Hdw6FgJcWv7YAoL2tstdDIDfQUWfAoZexBwfu1nkm
 EEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eRy3uxH0iZwIyYb3x/PVcOXd1aXhSn6gDIBvGBVJD3U=;
 b=FSwg9uErXO8pBK16I1oS7WLv5egCTE44P5kIonycQNpveQ9RIDOTwV6Si/vWL0XMZO
 4HajZsgn91gJcAuFJPpqHg6HEN6yF8U+Z+6BeGc5aMN+qqpTPyo8BetjMa53cIw1pXuT
 eIIsYj1ng14NGhBEO4IDqUUUUn7uuvo7d3h3WXkwCKf1UfDKdxuFMuX16k0TA535/0qN
 HUF6diRprlOGfQmnC/06ugQWQ58YKEDKNuTSUxEQOZk1his8F0ZrcX6yJvAP/geW3VB4
 7OPJMvzKqIJMxr4KfGpSDAuPkEzUmI3VMzRfZ/KIOwQxmq90gFnjPjNPaANqqSxAghgw
 mGaw==
X-Gm-Message-State: AHQUAuZAhSQZQVl5l2SmgzGpwqmk9436t2sjG7nq/FQP0kuOuw4CzxV3
 BJd6HPbm//EXDZR3FW5zDQubJf3A5ru2/X/4geI=
X-Google-Smtp-Source: AHgI3IZ5RaAkoo/zINmBQafHGkYFtuUV8E9oZeeMuarImXlHUQD2a7XtASO/0lY1uu9fHPSOGlNSzCsRvG0g8EOIP7Q=
X-Received: by 2002:a5d:8701:: with SMTP id u1mr21819978iom.69.1550678340417; 
 Wed, 20 Feb 2019 07:59:00 -0800 (PST)
MIME-Version: 1.0
References: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
 <20190220154658.GP15711@atomide.com>
In-Reply-To: <20190220154658.GP15711@atomide.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 20 Feb 2019 09:58:49 -0600
Message-ID: <CAHCN7xK4PjCfNgJeQ97kQGOJfjJ927igFELWniu6kuzgJ-Hgiw@mail.gmail.com>
Subject: Re: da850 dt cpufreq support
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_075904_770160_2812C78A 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
 Christophe Aeschlimann <c.aeschlimann@acn-group.ch>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 9:47 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> Adding Bartosz, David and Sekhar to Cc.
>
> * Christophe Aeschlimann <c.aeschlimann@acn-group.ch> [190220 15:34]:
> > Hi,
> >
> > I understand that today the da850-evm is supported in two ways in the
> > Kernel, using board file, aka "legacy" and device-tree.
> >
> > Am I right to say that when using the device-tree there is no support for
> > cpufreq available ?
> >
> > The "ti-cpufreq" driver doesn't target the da850 SoC and the
> > "davinci-cpufreq" driver doesn't make use of the device-tree bindings.
> >
> > Could the generic "cpufreq-dt" driver be used ?

A while ago, David L posted a message on the mailing list pointing to
a git repo that hat some patches that weren't mainlined.

https://github.com/dlech/linux/tree/da850-dt-cpufreq

I was going to try and test them, but I never got around to it due to
other work projects.

adam
> >
> > Best regards,
> >
> > Christophe
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
