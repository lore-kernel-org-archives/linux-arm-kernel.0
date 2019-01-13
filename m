Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08D5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:12:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA6F2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 06:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HKbdqiZp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rEEWH00L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA6F2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VxfD2LpTCVJq1PZjVshOGXuIa+uUMPh3BKC7TOmZKM=; b=HKbdqiZpKlnIyp
	BLClb5BXkRMg+EfH7q/aZBOCS3oVX3O1NOQ8nVfRx+puZS/7SBGRR+eeOx2hdSC9SeieOtDXKf5hn
	QfZVJ8CLsUVtGF4P9fpwuUgCt4ilmW+cun536FvU0Ame1CwLIopDeZSXHVtw4xwdbwjxPgthdmEGC
	OuXTB6VRq9B4l2RPI6xDQvXK4xw/T6JMArR3JJ6tUZ5T9CjRK6WYek9XByhxCzR8TTGGmFHypFVXu
	Kb6pTCTbtWOI2B1XTRP8lDkpZvkZG2uR4wVq0OJUd7L0QEu7DM84J9mTuxfY82z1zssijuT9v2VD8
	0Tgw09LP2VLhq9+2oGZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giZ04-0004a6-Fp; Sun, 13 Jan 2019 06:12:00 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giYz1-0003c7-8w
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 06:10:59 +0000
Received: by mail-lj1-x244.google.com with SMTP id v1-v6so16288462ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 22:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Bz5dcitNEPakAxDAumc42S6KsLZ0vzGAdJHHtTKEJQk=;
 b=rEEWH00LfNQSDpI1U0QpDNNGCC0ZQOZhYVtOOk8ozsNnkjhLoYb1CBn6B+YyFkg1di
 6f83EUgMd0CgStBk2IJhmsMjeRxZnCqtZUA5aqBXWdVBnOb0Ro3id9cy8H9VjlkVcmOo
 UYy0oXtPQuptixf3Vy2U/eTTIY3tNqTWbHq1cIv/CWRYWbhWnBt9OSCVQ+/oc2frpGZD
 uGvHZHjK0lqStLlz7AmNzXVe/CHiYboqviAfHarmSe0mzni1+R7CIoV4T1nJh7kJsVm1
 2Z/qSBZcHNntfgMPwSvYtSxLEVMeorQeQAQ88bG54fJGPnp3JXrDVM5xrRW0WsDvGE7c
 RE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Bz5dcitNEPakAxDAumc42S6KsLZ0vzGAdJHHtTKEJQk=;
 b=DyG5h+ECUo8MXiHdKdYTHploGrJUSdhw2kHjvezprH5GyeR1ECUKAWt9KV8Z6KfTbV
 LKllzC9vmpRGNGIuHhrqqAzoaYY1XVylrI33gR/sac/6ZaHhi9+tLsKh+g6RGav1MIj8
 dNVsFdmULV7mRIJTrp9ii5YAvkBA7mnTEWNehxdEu8h+3b+8i+dr99I/rEpX6FqvUhXJ
 FzOt/LnIjLb+bS5EqHTH0z0xppljKMCGYrVChi+XLi47DocDiBwo8xokq0PK8oVr+sbc
 XA7ibc3tadUCTEtOj3t2mFiLW7LOoGdD+bR8oEn0K7lUyVlq8WvdfPmWkHffDJk2DFTc
 E0tA==
X-Gm-Message-State: AJcUukcRS+BpATyQN9KU90DdgVCmqsbgeHZLwwy1eTJgKemPiP8RPmGm
 VCizN4EHKwkHy9Dr/MZuytt1+/0AuoA=
X-Google-Smtp-Source: ALg8bN7c34qYIaQpL4aZUZ1dX2WbS+8QMFk8ur0smu84iwx47/beE8E5UN5xpWSncmuJgSysvWr/wA==
X-Received: by 2002:a2e:4784:: with SMTP id
 u126-v6mr11690647lja.124.1547359852983; 
 Sat, 12 Jan 2019 22:10:52 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id u65sm16434012lff.54.2019.01.12.22.10.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 12 Jan 2019 22:10:51 -0800 (PST)
Date: Sat, 12 Jan 2019 22:04:17 -0800
From: Olof Johansson <olof@lixom.net>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [GIT PULL] ARM: mvebu: fixes for v5.0 (#1)
Message-ID: <20190113060417.veqxbl2fq2rvpfcl@localhost>
References: <87zhs7qgfr.fsf@FE-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zhs7qgfr.fsf@FE-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_221055_727255_9881715E 
X-CRM114-Status: GOOD (  15.52  )
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
 Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 05:58:48PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for fixes for mvebu for v5.0.
> 
> Gregory
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-5.0-1
> 
> for you to fetch changes up to b5f034845e70916fd33e172fad5ad530a29c10ab:
> 
>   ARM: dts: kirkwood: Fix polarity of GPIO fan lines (2019-01-10 12:23:47 +0100)
> 
> ----------------------------------------------------------------
> mvebu fixes for 5.0
> 
> They are all device tree fixes which also worth being in stable:
> 
>  - Reserve PSCI area on Armada 7K/8K preventing the kernel accessing
>    this area and crashing while doing it.
> 
>  - Use correct PCIe reset signal on MACCHIATOBin  (Armada 8040 based)
> 
>  - Fix polarity of GPIO fan line D-Link DNS NASes(kikwood based)

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
