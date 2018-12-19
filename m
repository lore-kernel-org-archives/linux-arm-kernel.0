Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449C2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:01:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086B1217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f5vfZk90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086B1217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q7Dy+MniMnuPStovj/wre4rCb2PIrEQWbEc7JdOEMWc=; b=f5vfZk909WOSIr
	MfbGPEBEWkENfTY+GrcU3HIneRCE9xi3Ym0I+I3MmczGsKxUmeP8ITLvWuJEV7PHuR1e92Ue0Lfw6
	uZEKhNEOeD/PpJi5PG92+nPdyshwPEOB/0udxSQxn0Zgjn4H/MON2hkxkigg1xt8q6IviZMr8IBTZ
	A6u6Oyfxs4UG4WROx9eunUCB0oKoV9umC3krdi0uBlrv7pmPg16kCYclY8+VRc8yGA+j1Xoztm+9+
	K8ut3pNHWRPD9QswnvDrVFdWFx9Xy7w/cVPK76O3AERMAXUOzCrH6MN7I0RYiZNWOOLjutwaLJe9/
	zAzpUfKfsRfK7ZJYpt6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeHw-0000TC-4O; Wed, 19 Dec 2018 16:01:36 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeHt-0000SW-Uu
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:01:35 +0000
Received: by mail-ot1-f66.google.com with SMTP id 32so19503125ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 08:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IPlkvNM9GsyzZD67er9Zgb7zoKIvhVOUgUKubFfAp0k=;
 b=AjPRFKqXPoOl9dvkLmeZ1YVpSvn5PxeI/qJ64+xO8jtxvOZBQ4q7kjq3zK4BxpG0XL
 20pLTol+tv6GbGwjBB8Z7TsKeIwt3H3ncpczj0L2EQBmmPjpnA9Topr36cd0z2kToPQ9
 wbCL6Mg+hle0gdjlIjuDSvN724eCL49PLg4M1JUzrsHdI43lvQS3jJGVe0sJuj2DEev3
 /yxdwk2ZonNiP4q8giC00D1F9sSUR6BnfwbIR9oem/nUKTnunFdyWB17xJMETBeXNtI6
 3dgx0mEdNfLFYL21LAHCsVxosrA5srbfDslARBJ/bqCnpAtdvHh5Ud1GTPWUS4yfudBt
 ZCpg==
X-Gm-Message-State: AA+aEWYnsij/KOk1P6lFniSnatVTGDLmSYxHH9OK6WrAmp/j4tXeckM0
 vmFyaWMd7UE5sj+EQZUddQ==
X-Google-Smtp-Source: AFSGD/WIO+D0wloRt8yliL36bwmAdCFAVBOfDeBY2iMpsNzbqObhjTxN6MgXkgLnR7hAxhfD/J/6hA==
X-Received: by 2002:a9d:c6a:: with SMTP id 97mr14856681otr.163.1545235282296; 
 Wed, 19 Dec 2018 08:01:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id e81sm8769551oig.8.2018.12.19.08.01.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 08:01:21 -0800 (PST)
Date: Wed, 19 Dec 2018 10:01:20 -0600
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/5] dt-bindings: media: sun6i: Add vcc-csi supply property
Message-ID: <20181219160120.GB22708@bogus>
References: <20181203100747.16442-1-jagan@amarulasolutions.com>
 <20181203100747.16442-3-jagan@amarulasolutions.com>
 <CAGb2v66pG0kes1_xBNUj4z85fjunjP_Fe5_pPiRja=nDSOS01A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGb2v66pG0kes1_xBNUj4z85fjunjP_Fe5_pPiRja=nDSOS01A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_080133_998526_08A330AA 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:11:35PM +0800, Chen-Yu Tsai wrote:
> On Mon, Dec 3, 2018 at 6:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Most of the Allwinner A64 CSI controllers are supply with
> > VCC-PE pin. which need to supply for some of the boards to
> > trigger the power.
> >
> > So, document the supply property as vcc-csi so-that the required
> > board can eable it via device tree.
> >
> > Used vcc-csi instead of vcc-pe to have better naming convention
> > wrt other controller pin supplies.
> 
> This is not related to the CSI controller. It belongs in the pin
> controller, but that has its own set of problems like possible
> circular dependencies.

That might be a better choice, but I think most platforms put the supply 
in the module node. But that wouldn't work well if the module is not 
used and you want to use the pins for GPIO or some other function. Maybe 
we don't hit that property because most I/O supplies are always on.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
