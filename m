Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11CEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6684020834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ldp6fm0h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SC1Lf6aD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6684020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rCYPPYlKh1pOCadd2i7nGvhDee3/YePuR/O/QB3RLXE=; b=Ldp6fm0hjndGu3
	WETPJ3hpzy25e/eRurA9fRIgCPHh7hya6jp4LGRYOaKNwM0XxllzwA574VJzkG9hmnx8nO+hl6htg
	IXF3mgPCuXlj9uAipxKNOM2rCNDc+QSpCGK23nGDc2DcaHDqnIYjLzNs50AHU8d3bg0y0I5oOhNAr
	0I3gUsxqeI4uU0EEG3AyPgAwBQQQbwJ0tgKJdkcFvYLLAGUCxLjm99bZApO/rPA5DOE/PX3QUJX3V
	jALolXxq7jLrP8coO5wCJjry38UqDnAIl9SAO2dAX0lDGPyyfgWw7uUH8RVS+MX4Fk7BUa1EZ5CQL
	JUfg9lYHtR2Qs5ThnHZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSriK-00046T-44; Fri, 30 Nov 2018 22:56:48 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSri6-0003v9-Uk
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:36 +0000
Received: by mail-lj1-x243.google.com with SMTP id x85-v6so6407665ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=D2hp/Ir0gBlnqWcUXzziRNf+Jis9t1VhUFTTdvJjBRc=;
 b=SC1Lf6aDLPjRP0JOUQoUj1dytI3cZdU5eDX1AxmL025ahvjfNxiC9+hqH6zA6KsDj+
 yQzEH0lOl332nbvYrSuopMgodlP+XrHkayXTEkhdtaSxpmPiujcZ1pRCKatLBIFjgYpD
 F6oA/3oqvvWacuukkqVquHuiWeCG1Pr032pbeiPygpObRjBF43ic/eLKcICxCr4gD5LO
 Wjt8J0BEJTzD1UGiO8g3Xyhas5e2LSy0voSlzD5Pkl9UCifkgUU4JzB8DhQVSynw12jX
 CGljiNu8k8fEulyz6NWdt1PKXpeSqVEpBD48xfBNeULmrasehxkxJ89zmdLL60Ps3/1o
 bPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D2hp/Ir0gBlnqWcUXzziRNf+Jis9t1VhUFTTdvJjBRc=;
 b=VcZw3miLWHzJSYvJYakW27ieaHQpLqS7zv6t3ZjaMGg/wu8vNROrIJWsaCpuL2bPB/
 GyIy04T0QcXFoFtFzZEjRJ04FHX7ZUGost+IkZu9BO9DytK4XE+h+onbDeiSyCuYGrTW
 7/AfEgH11S+R4xU5/b0hUj4LE7zOLcmhi/spne0PhyDCEChTlienxVLCRZ6aaGH6XTFJ
 7fdo/CNobed+OdHGbE+CAKvJjxI7JzTFApDfjjjTlQlmos7k8sxvkIzRJLbyWO094bIy
 wrc56g34mh3Iz30k6okDm+QJXS620yBV5uMpWQM2v722yWMB/F2qU3U4T464b3pWeodS
 qF+Q==
X-Gm-Message-State: AA+aEWYPwmYGaBQim4ylgqUbhQCGPneE2bnVbWVxtxi4accTCPFv9cRT
 K0q0KHsgaCHlyagXeBh6MlZPbQ==
X-Google-Smtp-Source: AFSGD/VbTI/4U1VT41i7x5ClnS7JN+PeiNmFfZw/R0ZuiILEih03rWq9gADRYveyGS/GzhN/cfpVHA==
X-Received: by 2002:a2e:9603:: with SMTP id v3-v6mr4293247ljh.15.1543618584252; 
 Fri, 30 Nov 2018 14:56:24 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id f8sm1143749lfe.72.2018.11.30.14.56.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:22 -0800 (PST)
Date: Fri, 30 Nov 2018 11:48:18 -0800
From: Olof Johansson <olof@lixom.net>
To: Rob Herring <robh@kernel.org>
Subject: Re: [GIT PULL] sprd dts for kernel v4.20-rc1
Message-ID: <20181130194818.7v5ysbwkoq6buzko@localhost>
References: <1539854253-4784-1-git-send-email-chunyan.zhang@unisoc.com>
 <20181102183246.r5xxwsic2mxwihsi@localhost>
 <CAL_Jsq+HFPnzw4Fo3rLRMxber8_itGZ=LjnUeyvvDOt4_txm3g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+HFPnzw4Fo3rLRMxber8_itGZ=LjnUeyvvDOt4_txm3g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145635_072190_315C212B 
X-CRM114-Status: GOOD (  17.53  )
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Lyra Zhang <zhang.lyra@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 chunyan.zhang@unisoc.com, ARM-SoC Maintainers <arm@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 09:18:34AM -0600, Rob Herring wrote:
> On Fri, Nov 2, 2018 at 1:50 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Thu, Oct 18, 2018 at 05:17:33PM +0800, Chunyan Zhang wrote:
> > > Hi Arnd,
> > >
> > > For 4.20-rc1 there's one patch only for sprd devicetree, please pull from my git tree:
> > >
> > > https://github.com/lyrazhang/linux.git m-v4.19-rc1
> > >
> > > Please let me know if there's some problem.
> > >
> > > Thanks,
> > > Chunyan
> > >
> > > ----------------------------------------------------------------
> > >
> > > Suzuki K Poulose (1):
> > >   arm64: dts: sc9836/sc9860: Update coresight bindings for hardware
> > >     ports
> > >
> > >  arch/arm64/boot/dts/sprd/sc9836.dtsi |  78 +++++++------
> > >  arch/arm64/boot/dts/sprd/sc9860.dtsi | 215 ++++++++++++++++++-----------------
> > >  2 files changed, 151 insertions(+), 142 deletions(-)
> >
> > Hi,
> >
> > This came in right before the merge window so it wasn't included since
> > it's more of a cleanup. Please resend it after -rc1 is out and we'll be
> > happy to queue it up for 4.21.
> 
> I'm enabling by default the DT warnings that this fixes, so please pull it in.

It was merged on November 13.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
