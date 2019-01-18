Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDA8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:49:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB09B20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tR5dimFk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T53reYfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB09B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FzC15oTOuwtNWJrjQ15L2CXRfPYVXdeAZKkiIvMvOxE=; b=tR5dimFkys6OW77+HkYVtxKA2/
	6C7srd5VBrKA0DHpujJUwH9Iv2aSG1O8cUrTdPmaE5zLBtoLuISWqpoYjwtRnsFNKMk0jKIOXce+H
	SHnuLFbsPVy3683YmfORj8sCc0yKsreNrkqc93SrGmdfAHs8CbxIKeX5AhA4Z8gMtegF2mZkv7Y1r
	w5o26D65TR4Suct2PIazpKjuF/rHk8ZkiVADoKH5KOrkKW3VuCOgCuA8eo8ZpLN4Bl1zlrx9YubeR
	cUgoU47BzhF+sRiuoP6NAxHInGXMIcbcfC3w9ACtPaX/q+PMiw8poTyle3MUpvdsfqIIK6rzUSWjN
	y+kleWsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkPq0-0008VE-56; Fri, 18 Jan 2019 08:49:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkPpw-0008Ur-FV
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 08:49:13 +0000
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C211120883
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 08:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547801352;
 bh=PfX/qo5bHBPtw9Z5T0H6GdhgQkWlAb9EfUxVj3N/U7g=;
 h=References:In-Reply-To:From:Date:Subject:To:From;
 b=T53reYfgFHCnoicOTGkXjqkpzo7p94iGsOH9g3giXgbAEo8HJ8/byI0KdU2gjOUIm
 eCQdQ2Ue/ymaP1DqAPPrYFm6Q7wcnsXxLJKLB0X1naNizcUXMQ20oiK9xqAEKmL7U0
 MWWDXNBkeRDSQHHCUtSJOxXQ4HR6ec/K7P8sD78A=
Received: by mail-lf1-f46.google.com with SMTP id z13so9878672lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 00:49:11 -0800 (PST)
X-Gm-Message-State: AJcUukcZ+GPjQbwzR1wo76bgBpCbvPvXbPRV7TAQXzuhlB6yZK2m+G0o
 u6JvPAL//ysA7AZnMF6BYtNLHFFjYRusurs94FE=
X-Google-Smtp-Source: ALg8bN4GiYrnkTzFXO80ibhyb127ymDN6vDF2esfH/C+kgjjrSjSVn38giE+a3KIIvNDDW3DgSW8d+wReXWe6VAiqUA=
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr12830880lfc.124.1547801349889; 
 Fri, 18 Jan 2019 00:49:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
In-Reply-To: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 18 Jan 2019 09:48:58 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
Message-ID: <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Stefan Agner <stefan@agner.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_004912_541450_150B4EE5 
X-CRM114-Status: GOOD (  12.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> On today's next (next-20190118) my Colibri VF50 board fails to boot up
> from network (DHCP, NFSv4 root). Looks like missing network adapter.
> Expected:
> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
>
> Result:
> [ 15.614964] Root-NFS: no NFS server address
> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> [ 15.634252] Please append a correct "root=" boot option; here are the
> available partitions:
> [ 15.642791] 0100 16384 ram0
> [ 15.642804] (driver?)
> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
> on unknown-block(2,0)
> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> root fs on unknown-block(2,0) ]---
>
> Bisect pointed to:
>     net: phy: check return code when requesting PHY driver module

I see now in the logs:
[ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
driver module for ID 0x00221513
which is kind of misleading. There is no initramfs so there is no
usermod library at this point. It is not needed. This seems to break
all DHCP/NFS root boots without initrd/initramfs.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
