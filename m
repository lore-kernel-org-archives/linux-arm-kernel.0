Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BF6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:02:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910212086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nXYKy9Y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910212086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M+/v/YNoDjEKqFzeLuL9K3lWH8tdbqNXlnBtwE+mnpA=; b=nXYKy9Y5ALq0Z7
	NYsueqQ8wr/Ig4sbJSMnwBgmnbqldGmvzs3VEi0poM0GfnFg2/ykamEgdMy9CtBq6BjyL62lpG1uF
	B5aNrUP/2/Teq3RfVwYPAEJyq+C40wZVKstE1NiZtHEqWurAQ0aoeaopTm98TkYZyybZ6M7RTHw/W
	s339gaDLLcKpVFF5D5vg4s9nj7O1jj8vAAe6llu4osiTojv3WWTsF8mc8SJDdOoDx+aNfJjL0c27H
	ofEXRQEvi3/q9NazrwJYXDPv2Y8mwacqFeit9CK/NHQBXLn2TvR0uOR9NamUHBICVRnoyH8Rub4y/
	nmFBWK9iouIOPLwxLbZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWbZ-0007aj-DJ; Fri, 18 Jan 2019 16:02:49 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWbQ-0007Yn-Fy
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:02:46 +0000
Received: by mail-qk1-f193.google.com with SMTP id c21so8309559qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 08:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SDodKVKZE68GaTWQnw/8diyvuXpkz6/WYntpU/2umcM=;
 b=S2cG9jdhwdqc61RGMkQ5965XZnM01YJg/5pMnE47OVy1n21Nlm6AY6LHi+1MqmEbrN
 C7kCItslcnmHVWuEeBCK+TxpYWuP4ta3afH9eyoNvUzUuBaKxJm3/gM4os7AaFJS7OCE
 +cP37D5DZoK8FGfucR2TfRximtkMf3ar9bbXV2vTh2uBtyNxviZYL5hBQdmqrGOOTJcu
 jrtj9/EJZJHSn4SEjoI3ZyuiPLRy4lHDRjqMPyykKRLWyY0H3gbaLe1iGdL8vKcIm9Mg
 QZX00hA1SJMqPSt6qI1B2bIPriZ3kMfyhkJSUgtpz9F1RI89xi+JHioK7f4R4m6aQKyM
 Y8CQ==
X-Gm-Message-State: AJcUukev5nchBh+KRRLMFVi4Ps7RceU95XNxKR/edtybdRVD6UAjEjOz
 Gq6cSBnSxvtsiY1y1znQPFmsuy6W5SvQsk8ZpDs=
X-Google-Smtp-Source: ALg8bN6pE87HFJeIEYKnf1asy3R2yG9dZIxH+fpuakhGTiL3Whec42E8wvd9lm9HoVlK17a+U5oWtuQtlXKiaYl5cVw=
X-Received: by 2002:a37:324a:: with SMTP id y71mr15685363qky.291.1547827358315; 
 Fri, 18 Jan 2019 08:02:38 -0800 (PST)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com>
 <1541089538-175682-5-git-send-email-lsun@mellanox.com>
In-Reply-To: <1541089538-175682-5-git-send-email-lsun@mellanox.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 17:02:21 +0100
Message-ID: <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
To: Liming Sun <lsun@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_080240_534271_F94DC2AC 
X-CRM114-Status: GOOD (  21.02  )
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
Cc: DTML <devicetree@vger.kernel.org>, David Woods <dwoods@mellanox.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>, linux-ntb@googlegroups.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 1, 2018 at 5:49 PM Liming Sun <lsun@mellanox.com> wrote:
>
> An external host can connect to a Mellanox BlueField SoC via an
> interface called Rshim. The Rshim driver provides boot, console,
> and networking services over this interface. This commit is
> the common driver where the other backend (transport) driver will
> use.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

Hi Liming,

I've taken a new look at your patch series for drivers/soc/ now,
thanks for your continued submissions.

This is again just a set of very high-level comments, but I think we
should resolve some of the fundamental questions first.
Incidentally, Vincent Whitchurch has recently posted another
patch series with a very similar intention, but for other hardware
and taking a different approach.

In both cases, the idea is to use virtio based drivers to provide
services from a host machine into another Linux instance running
on an embedded system behind a PCIe slot or similar. Your
Bluefield SoC patches are well written, but are intentionally
kept specific to a particular use case and tied to one piece
of hardware. In contrast, Vincent uses the existing code from
drivers/misc/mic/vop/ that is equally hardware specific, but he
extends it to be applicable to other hardware as well.

It would be good if you could look at each other's approaches
to see where we could take it from here. I think ideally we
should have a common driver framework for doing the same
thing across both of your devices and as well as others.

That would also resolve my main concern about the drivers,
which is the placement in drivers/soc/ for a set of drivers
that are unlike most drivers in that directory not mean for
running on the SoC itself in order drive unusual functionality
on the SoC, but are (at least partially) meant for running on
a host machine to communicate with that SoC over PCIe
or USB.

As an example, your network driver should really be placed
in drivers/net/, though it is unclear to me how it relates
to the existing virtio_net driver. In the case of mic/vop,
the idea is to use virtio_net on the device side, but have
vhost_net or a user space implementation on the host side,
but that is apparently not what you do here. Can you
explain why?

Another high-level question I have is on how your various
drivers relate to one another. This should normally be
explained in the 0/9 email, but I don't seem to have received
such a mail. I see that you have multiple back-end drivers
for the underlying transport, with one of them based on USB.
Have you come up with a way to use the same high-level
driver such as the network link over this USB back-end,
or is this for something else?

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
