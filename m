Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43110C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 22:22:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0320D2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 22:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DL8/9xjc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=astier-eu.20150623.gappssmtp.com header.i=@astier-eu.20150623.gappssmtp.com header.b="C2ThJSJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0320D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KfbbttfsaxDhblVMNBq9hxnBOKgkD8eEQ7LRS399gfM=; b=DL8/9xjcBexqfa
	NZdTOfrOmPO0SqBQ1jMSXMWrLtZXgzzDOXETprlR1bHQ9NH31CHrENYRDb6hSQA+xSZoOHia5EK1G
	a5ffEgQ564WIEw/tfUjfBjrDRpQiNmFpYzJEEZ/LEYijkQDS43IWBFwNJtQHULXxCA7VBHfE/CxzG
	vraPSLQv3dF0vDNHy2DzdMxmKnkNTg48QW7FN7C3/CRKorkF+5dpTOr+R50xIOmm6qg39rj2dWFQG
	/dMI8SWEgU9ZDFiBfvzk9uk6xaWGDP66FNnd2axkDtgnEnRDre9c54HGcZgBhQ/ntCqp0uZPreeOA
	2CZRwr1m8kM+ekf/K+8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glLTY-0001lZ-Mz; Sun, 20 Jan 2019 22:21:56 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glLTR-0001kc-CB
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 22:21:53 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so21178108wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 14:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=astier-eu.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ND1NftFWyS/tgyoYicMUwFG6MNxVNmzE2sPX5uNe/6Q=;
 b=C2ThJSJ81dbZfpDfsNByFI99nf552Hp5LXkf8DF9hhMOcTGz3PCvYvUtg0IS/RcT2u
 J4gp24ehtOe3X6WWR65v3fbkroWNa+c8vT9+odNTJ2JX0ahmly3cvvgJzHqwk39+tPnR
 r2QXypJCd0//T1QPPBpCZJhnLCIQoVMg7L7G+RD9cGhZzJN61u93L+BYZOVxM56ZvANE
 o2rx/ulwFyjQCv3U1n+aKysaTdBzsYnLe8B13RGF797YS7MWs6oJBXiADeCxi0Mucngy
 YpLlovOIGwO9wYXKG+g54kz3SmM9KzWKJ+NHVeM7ibrlM1FnFriwc+eYsMkoHb9a7riU
 nVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ND1NftFWyS/tgyoYicMUwFG6MNxVNmzE2sPX5uNe/6Q=;
 b=Mesilx0ejhAbFHxP1KVUNQQYgBDbZ6T4aWOgghIMKCzQC0psKaib0lltULrd41yS1W
 BBX63swkQSsywMy1YktHuocsmHJSsSMdnVm8hIC33MmS+V4bZZedwxSTozI996PSrYXz
 ertaJzCJOChtzixBNvDZS8phIpx4zDj+KBHy2yT+RnhegblUY0CU6/yV8BQ57S948yCT
 yJdnKaBs9MOtAxWoPtWcrr2VzxL7GHF4BNglgdLFlLJ/ZyuE4wmnX5ntyn5O0mYf/bTz
 WxlSIAeCiUN6Tf0v4RuenOIGnHfXnF1VLxj+Y75DnpjeLYRvkkoxgJdoB2itLz0DznpT
 u0kg==
X-Gm-Message-State: AJcUukdvPBl+Lax4/9mjaXHCZRGJE3Q2usqfHVNlZlmXV8mxxxtKhqni
 m7G3ykRcXZqzU9rqBkMkM2zsMA==
X-Google-Smtp-Source: ALg8bN7dHLaQBmLcK6XXGIGffyD37cpz259MES2qb4oYe0nWxor+OcxjVthC1jmDAUv3558RFSGbEg==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr26481275wrm.223.1548022902884; 
 Sun, 20 Jan 2019 14:21:42 -0800 (PST)
Received: from jaya.lan ([2a01:e34:ef92:b70:7ee9:d3ff:fef0:777c])
 by smtp.gmail.com with ESMTPSA id y13sm51950902wme.2.2019.01.20.14.21.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 20 Jan 2019 14:21:42 -0800 (PST)
Date: Sun, 20 Jan 2019 23:21:40 +0100
From: Anisse Astier <anisse@astier.eu>
To: Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH] staging: vchiq: Fix local event signalling
Message-ID: <20190120222140.GA6626@jaya.lan>
References: <1547206493-105303-1-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547206493-105303-1-git-send-email-phil@raspberrypi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_142149_565945_CB5A633E 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org, Dominic Braun <inf.braun@fau.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Phil,

On Fri, Jan 11, 2019 at 11:34:53AM +0000, Phil Elwell wrote:
> Prior to the recent event reworking (see Fixes), thread synchronisation
> was implemented using completions, the worker thread being woken with
> a call to complete(). The replacement uses waitqueues, which are more
> like condition variables in that the waiting thread is only woken if
> the condition is true.
> 
> When the VPU signals the ARM, it first sets the event's fired flag to
> indicate which event is being signalled, but the places in the
> ARM-side code where the worker thread is being woken -
> remote_event_signal_local via request_poll - did not do so as it
> wasn't previously necessary, and since the armed flag was being
> cleared this lead to a deadlock.

This fixes an issue I've had on linux 5.0-pre to 5.0-rc2+: the
bcm2835-audio driver would block on close, and then nothing would work
until the process was killed. Sample log:

bcm2835_audio bcm2835_audio: failed to close VCHI service connection (status=1)

> 
> Fixes: 852b2876a8a8 ("staging: vchiq: rework remove_event handling")
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Tested-by: Anisse Astier <anisse@astier.eu>


Regards,

Anisse

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
