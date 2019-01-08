Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB40EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:46:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B05B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W9YacZM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B05B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YFDOR147qAktEtj2F6xCNuP2HIHTsV9cmBPzGySDrz8=; b=W9YacZM/iaLI17
	kfPKXJqeXuNy9aw9SBdctkoNJFD8E143XhGZ88L7NisIASl0ZzLxBo7PxrzLHsAIy9mJAal077Okc
	AX38dtgSwo4E4Py0BFQm2rM6VgjHjer0XRn+JNlPheqyvMhhA40+A8woVspnPKZ35iKOsfBRKp4Kz
	NiKBEO2D1QRr01wN+Lwe8PfUr40sygwmXzsGWT7oNd/8aL4SS8BT2T/vnrWKk/tLMK8rqoXwLWMks
	AvFOkVHHAMIkJOHnbZyS3Mj2nFTVprXwSnOBaEh0bqkwzRLjHFXNC8zLmqD/itLYUk216txoViwUb
	xxfUUqdar9CV0XsYygow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggpq9-0006gP-IL; Tue, 08 Jan 2019 11:46:37 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggpq6-0006ff-Rf
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 11:46:36 +0000
Received: by mail-oi1-f196.google.com with SMTP id v6so3062238oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 03:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=th4IqVR880tViL35e0Azqd3RbttlYjSzwniMxu3gx8U=;
 b=N4LbJAJ2uuTNsbEEi58I6QpBFuULqatYmKZlYOmGIOkffyar9T06mPz4lXAiVJ97GO
 dnZRDNML6Ru6AWIbjfYscooGHSt58f1pYsDj66PyyInY1I+XF4+FD+Xx6hhVZSTgD/lj
 mmYTcEV3YgNxU9HKhLe3giKDM6cbDx3MsSpwkfowl/CZKhgYF3NfqzIAMNyAQIFr8eoZ
 Fb7nSZ1iDsg9vgGrkj+dFaWhymaV7hWjy5Z8pEZjYlc+AyMCnsb+PunOLsXsIdXtFGqa
 LWuH773OMp36KQXJ8ieI0YyEUH8Cp6HepB9g5fDYIl8NkSjNCmvolwZRX1ktbNMa2s0G
 T42Q==
X-Gm-Message-State: AJcUukd02q4Ktk5WkHpWNFqwsG0OyAi0bXDFgwpmxqbha3RBvNYo5sX5
 zPOi/uNYZRx6QjdAWTwvzSIB3GqRlVOFZ+1sJa0=
X-Google-Smtp-Source: ALg8bN5puYaxcTMmLmN2X+goVTJphamUv1E3hBOxe7MN8uU4YVVR+B6ntDMhOM0Wnazn8Hcek3l3+K/qZGBMtkPNMmc=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr954812oic.33.1546947993253; 
 Tue, 08 Jan 2019 03:46:33 -0800 (PST)
MIME-Version: 1.0
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jan 2019 12:46:21 +0100
Message-ID: <CAJZ5v0gohGWgpmTx8mzuWdru2M9xbSGoOV=WBxzVo07JZW3G1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] add support for power off check in suspend
To: Claudiu.Beznea@microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_034634_895756_18CD9474 
X-CRM114-Status: GOOD (  19.49  )
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
Cc: Len Brown <len.brown@intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Ludovic.Desroches@microchip.com, Mark Brown <broonie@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 8, 2019 at 11:56 AM <Claudiu.Beznea@microchip.com> wrote:
>
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> Hi,
>
> AT91 platforms support a power saving mode where SoC's power is cut off (we call
> it backup mode). The resume is done with the help of bootloaders.

But still the contents of RAM are preserved?

That would require at least the memory controller to be under power AFAICS.

> To be able to
> suspend/resume Linux to/from this mode all the drivers suspend/resume callbacks
> should save/restore the content of all the active registers. We have 2 problems
> we are trying to solve:
> - some of these drivers are shared with other non Microchip SoCs (e.g. macb
>   driver) and we don't want to disturbe other users of corresponding IPs with
>   all the register save/restore operations;
> - the suspend/resume time for the rest of the power saving mode we are using
>   could be improved if we would know in drivers the suspend mode the platform
>   is switched to.
>
> A solution that would have been solve our problems was proposed in [1] but in
> the end it wasn't accepted. It ended up with the introduction of
> pm_suspend_target_state variable that could be used along with the changes in
> this series.
>
> While the discussion of [1] progressed it has been proposed (in [2]) to
> implement a function that would tell if the platform's power would be cut off
> at the end of the suspend procedure.
>
> The patches in this series does as follows:
> 1/3 - add a new member to platform_suspend_ops that will tell if platform's
>       power will be cut off at the end of the suspend procedure; drivers could
>       use it via platform_off_in_suspend()

I would rather avoid doing this if possible.

Thanks,
Rafael

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
