Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D49C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:51:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61FC2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JRw9tYY0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tM/xZax4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61FC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KbUSx5YgEbtL971qgcpiUUdARJ0J9uEWGx9SvlYfpFA=; b=JRw9tYY0pqwhuU
	NSu9fK2LY681IP8B8VtkavCCEivQ98/whDZahUGlyS7+4ktooEoCTUifUa9ZRKVsvdicJNZ1Yw2dx
	i/U5LAiI/a0xTKGRGxHJ/FSCAZP9AI+P5ABOeQ0SbVL4GM4IrkbWDFjK0lKFHI4OW4MnyrBggMjCd
	YY0yh+MiF7SxKDr2PwrZAr7UCtAEhZJnfFK5LwgIT+zaoP0xvsCZDXcFn4ymXH8N6jIbm9n1IbqX1
	wbPmaacjnAoOrdpvcKbQEUrbwDSf4XQy07PVyfikFV7e1k8kb0P5/ikI4PASCZK4MPi+pM5CKnfwM
	Yi/6yHUqDIqLJ3swsQlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gknHc-0003Cg-V8; Sat, 19 Jan 2019 09:51:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gknHY-0003CH-4t
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 09:51:18 +0000
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D4EB208E4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547891474;
 bh=HBrjP4nc2mNBCjxtzgXzaKYXXq7POoiuBjp/ZCoUM54=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tM/xZax4JRm/Ux1Ecjbm23VR6khECWXe0JrJtZciqiZ+1+e16UWvsOgdpniBu+/6d
 tdtUlyEfkmZQfRPy773wNY+m9Pnh+Vh00/XQhr2kd9cvYY23dSyYr6S+1TD2bGnS28
 5Cl6CjdkeHGSm5k6rxGsJI6Y+SAQLyH98l6CNS8U=
Received: by mail-lf1-f50.google.com with SMTP id c16so12236823lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 01:51:14 -0800 (PST)
X-Gm-Message-State: AJcUukes+Mlia5XPZdsRIIEhC7IZxABOEqilBiwx8pycXQSX2vsEDxto
 hWdp91g1hNEUZM8PZ2Q6pAW5ZXDUSd5CxlnAqsc=
X-Google-Smtp-Source: ALg8bN5E04/Q7+E3ia0Ttk3pzkyiGjYyMCQoBayf36D0BTIFFC5J49aGa9/0gQxTyuDIpDPh0Qo69becbLkBLa9ODO4=
X-Received: by 2002:ac2:554b:: with SMTP id l11mr14164647lfk.92.1547891472281; 
 Sat, 19 Jan 2019 01:51:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
 <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
 <68b565a2-7813-57a2-1687-43568e53fade@gmail.com>
In-Reply-To: <68b565a2-7813-57a2-1687-43568e53fade@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 19 Jan 2019 10:51:01 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdbPa_iHwhRccAd41r_OV=q036BE0dNP7YsXSBogr7o3A@mail.gmail.com>
Message-ID: <CAJKOXPdbPa_iHwhRccAd41r_OV=q036BE0dNP7YsXSBogr7o3A@mail.gmail.com>
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To: Heiner Kallweit <hkallweit1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_015116_236656_AFE993A4 
X-CRM114-Status: GOOD (  20.41  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 18 Jan 2019 at 22:30, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 18.01.2019 21:58, Heiner Kallweit wrote:
> > On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
> >> On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On today's next (next-20190118) my Colibri VF50 board fails to boot up
> >>> from network (DHCP, NFSv4 root). Looks like missing network adapter.
> >>> Expected:
> >>> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
> >>> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
> >>>
> >>> Result:
> >>> [ 15.614964] Root-NFS: no NFS server address
> >>> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
> >>> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> >>> [ 15.634252] Please append a correct "root=" boot option; here are the
> >>> available partitions:
> >>> [ 15.642791] 0100 16384 ram0
> >>> [ 15.642804] (driver?)
> >>> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
> >>> on unknown-block(2,0)
> >>> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> >>> root fs on unknown-block(2,0) ]---
> >>>
> >>> Bisect pointed to:
> >>>     net: phy: check return code when requesting PHY driver module
> >>
> >> I see now in the logs:
> >> [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
> >> driver module for ID 0x00221513
> >> which is kind of misleading. There is no initramfs so there is no
> >> usermod library at this point. It is not needed. This seems to break
> >> all DHCP/NFS root boots without initrd/initramfs.
> >>
> > Thanks for the report. Could you please provide your kernel config
> > and the syslog of a boot before or w/o the patch in question?
> >
> > If you boot via nfs then I'd expect that the PHY driver is built-in and
> > not a module. Therefore it's not fully clear to me yet why
> > request_module() returns -ENOENT.
> >
> OK, I see. The -ENOENT could refer to the modprobe binary, not the PHY
> driver module. Still it would be helpful to see the kernel config and
> the requested log.

As I wrote - there is no initramfs so there is no modprobe binary
neither. The log and config were attached to the first email.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
