Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65187C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3421220867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eDDA4/t5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="f+Evjle/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3421220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+21Qj6RPFl3FTYq/pRkfJGZmXTyz7CV7o66HLdCZHFA=; b=eDDA4/t50Zu2hQ
	VSlZuXRzLEsyncTz5JwqHU4xYNzdlHa/uf3sJcR6G3AaXsNtPWW5IpDDCJ+NQ+wrQTPkZcnowbvVs
	OWyn+qnnVG3ho8qWK0PsuNTlF0M92c0IDHZr50PJUhoHyxIKsbrMn8b+P2NMo2e/lWNxw4JTszp+R
	+w4XcZDJgyaB0Sr2BA6kz2G7ro+SRVq/Y5UM9LfTnbilcsRTwuyIN0qQZXf0x2KNv38IhDmJgl9Uz
	VkUKJ2+2CJpjg8OSZDukzs5gjpkXfLrS0gSuDOAFSVClSPyApl7TrzY8wmI2iBzJCJgmnKldGMkBU
	FdJiFpa/LO0nbZM/yyUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsiG-0006pL-KZ; Sat, 01 Dec 2018 00:00:48 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsey-0002Rx-QH
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:45 +0000
Received: by mail-lj1-x241.google.com with SMTP id e5-v6so6499005lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3q7hEzfX4yp16DPPqiDQPlBHy9EvBQV70eHnJM8kSmM=;
 b=f+Evjle/kmFCGqrFBwVafVCuNAb8kfi8b8yr3ejwRIXXoFaNhHmYuLh+32CW9mEnz8
 t/JJf6DU47CCCyYZybmgjGesiGVUotlEbrWqHAPKKMu51wVJfLEdDhjG8fyCYdamooD+
 XT5vR6vfC+na/jlJvqun1T/A8EXXd+z8nKJWPyJoQC2WaOcXrlQgaVRLgdFiujdkR+Ue
 ZZHbdIBodSjJxnJHhKLhjRdp4IHsbsui8BIP2A99YafdX5b8tqiSNHUwMZVrwFXoVMr9
 bzsi1Tj56fW1KI735fw6uzZBj4/FjUBgdWgicPJFhGOY1Mo3DwQfr5y3v17Gop9S3MW1
 V99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3q7hEzfX4yp16DPPqiDQPlBHy9EvBQV70eHnJM8kSmM=;
 b=p4s8/wbxBw/OTzDkJIVI2xxJnuJHIayzzkL+6ssov4PRVaStwjcQsvRdv0LwmU+eK+
 bBt6ONz2bo8tr5jZbBzOOMuJigVH2znVqQE3L+04PwignIUD/AGsAc6HCDepR6mNxp+L
 N/zJhBaHGStr03wAuO976uE+I0L/vC3bK3VbPDaydPtNI0QLqA7oplu4kL2ZIXv8KbTF
 oSUamlenFwgO7bSY7/wD1ct52D1UC3xJWMkoaz8+svmUBpzbo/7wQUQa68Qkil7Yjrmt
 +Z6CcP0KGgvUbgtQvufRd4VxE0WPzTdyHQF7IDyHkGCFyurLdbXRuQ4+yGLh1zgtqsoQ
 ZnMA==
X-Gm-Message-State: AA+aEWYQvyYZ8x3AxqhxrMhkE9aOfdDAuBke/W2Y74PMKcERiiq0vYif
 gYcUWaZXKhvwvdXH6ngyE+6KlQ==
X-Google-Smtp-Source: AFSGD/W5iqHC1pjIenhW59r8XYbhtadF4/81VNadn53WuCOKLRitQNinSOEvtYpKfSEkI5ExPbredQ==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr5409472ljd.21.1543622237523; 
 Fri, 30 Nov 2018 15:57:17 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id o14-v6sm1034761lji.70.2018.11.30.15.57.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:16 -0800 (PST)
Date: Fri, 30 Nov 2018 15:42:39 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 20/20] USB: gadget: mv-udc: use phy-pxa-usb
Message-ID: <20181130234239.5hdqd4bulyoq4phc@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-21-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-21-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155725_675336_1A0BC638 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 06:53:24PM +0100, Lubomir Rintel wrote:
> Use a proper PHY driver, instead of hooks to a board support package.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Same here, please get Felipe to ack them if you can. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
