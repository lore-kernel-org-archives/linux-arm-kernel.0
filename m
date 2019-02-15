Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A323C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:59:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC2621927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gq4YxA2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC2621927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Urncxmec7yKW9YCTDmCEzBn02qC4mA+5HuDxbjUnfA=; b=gq4YxA2ATpE5Rr
	MxbJJcPNTmrrY3HeIUkHMPZ5+R9etVl+YY2VmVBrkq7l4KVjKzb4xsT5kEtXDCLWleFokgXxFtL11
	V3ueVA1l0QQtCCA9cHPQbZEvticvKOIRdPnNlVL1u/0S9l3MhmZSKtl3f0MZ3QB7ZtSUIWvMdGUyk
	R4CIXKvtUav4scLkkr0qcWg0/dySegfo03u0PNwNd8RqrsRvjyVkPHaOqiIJRhw9FAyzcMTYSjqxZ
	fNG5wZ9zDFBQYBeLcEGmFdKe7msdQN+723oGCDbFsWpA9qaj66lg6zKkptXw0gIeANtGjRuXXPT3d
	m68mx0Oqmn4H7WQL9h6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufu2-0002ZS-CC; Fri, 15 Feb 2019 15:59:50 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guftE-0001mU-3v
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:59:05 +0000
Received: by mail-qt1-f196.google.com with SMTP id w4so11437894qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=im/pGuB5lr//i1kyXF2WH/3DwdPxP9R41thZBnXp7zc=;
 b=Ey3wcwHgYMu31eb7Ai72hwVV10y3RysrfC2LGX8VhgY7rhY790nDyiXLAwFR9uAkN+
 DMRqgEWlbqtMk/Wqb5ZXqL++9w8A1PgdvX4oj4Ieoi9xZ4iBXKfCZsArSwrrOPw9DAJL
 IjtTPgfkS0pu+qxs2qg0bCzLuzsFyu076u0NnyhCMSknXw9WRUjUwrUUWk89K6/9ty0m
 o4o5K/rQEXmv9XgrgYFPd5HpA8Yyw/bg2j1Oy+YhGH/be6W31veLkuQyUTuxgBaDGLaz
 eoXGX/cEAFNZJNhoMjMSQZKX0hqLhbBQnvq3BYBZDyhkJgLZKhLi8cNmlgfCJ13foD9d
 ZwUg==
X-Gm-Message-State: AHQUAubXDKxcSY42+tGOhYaTamkXmHXDPOxOxLNKrkwLKbYOYBnwfOLj
 srkG53XStSvbA3eKipUxdSrcq0Lk7WRJKwYtnLx2vw==
X-Google-Smtp-Source: AHgI3Ia+V89gPadzUlhhVRvoS6HCXOpwZC9KOgGtsuTZHHMSZDpITCEiqUJxFCE/S6OVF7QX3ZtHu1IIPWh4j35dwe0=
X-Received: by 2002:a0c:c60f:: with SMTP id v15mr7691534qvi.40.1550246338998; 
 Fri, 15 Feb 2019 07:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20190202172237.11147-1-f.fainelli@gmail.com>
In-Reply-To: <20190202172237.11147-1-f.fainelli@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:58:42 +0100
Message-ID: <CAK8P3a06r0cj=e_jA0NyTPmjxQ-nycPSiacwEeTrrvEVGaY9pw@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] Broadcom defconfig changes for 5.1
To: Florian Fainelli <f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075900_711028_532DFC85 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Kevin Hilman <khilman@kernel.org>,
 Eric Anholt <eric@anholt.net>, arm-soc <arm@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 2, 2019 at 6:22 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> This pull request contains Broadcom ARM-based SoCs defconfig file
> updates for 5.1, please pull the following:
>
> - Stefan enables the MMAL-based V4L2 camera driver for the Raspberry Pi
>   devices
>

Pulled into arm/defconfig, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
