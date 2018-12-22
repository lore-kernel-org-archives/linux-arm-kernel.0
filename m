Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4DAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:34:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC00219FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JKZ88bhA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZJjRaR9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC00219FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mfp+WehP8gYcAoYFcgVz/irs/F/AVo57RaozEikrTF8=; b=JKZ88bhAAI/BWu
	Wl67hWf2JIkrugrLrmjwjEHOGLbZQtF0jaeZeBfH53pZZ9/7kdEQ6e93diYp38YCVGCojvpVmektE
	456uZVS9JrUQBhGTOBHHdNcMtuljovQnpOt9/UMISNvb8oAI6FRWqB2ay6KxfQHM+u3WEK5AFloso
	6vCqCAG4nmMy7rRvYRkQ0XQzeiTE4NKZrWWwXhNaUK3GtICFnZbpBn8ytB+ip9dsuhIYfabYl0nfb
	gtSCbuyVAv5eDgyQrG78sxGcmnRFQl2sYDUTAi27j8ZJ0I6IilOYJmkaPAsV7AFTwzPPSFaez3zgG
	m1V7OQ+uWLsvEsYXiUAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaebU-0002Te-O5; Sat, 22 Dec 2018 10:33:56 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaebQ-0002Sc-0U
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 10:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0RAEx+rqk0245sfqBVPVCp8l7IXkwUfhdlXdcvWRYb0=; b=ZJjRaR9Dc3LZTPFF5ld/UQjm0
 phOIA5g3OFoma2VGkgL6D27MLuB2eTse5qbgCGG6IRsXcURVDhRDb7TjE0wmBcK4GehyEVkMuhYhS
 jIePv8zQyEmFZpSgQLGALuDT8XKUR9Y8O0GcuQoCPkfgxKN5DURq07Hmp6Ugl56xP/qOQ=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:46477)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gaeaz-0003YD-7G; Sat, 22 Dec 2018 10:33:25 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gaeaw-0002g3-Af; Sat, 22 Dec 2018 10:33:22 +0000
Date: Sat, 22 Dec 2018 10:33:20 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] driver core: platform: Add an error message to
 platform_get_irq*()
Message-ID: <20181222103320.GW26090@n2100.armlinux.org.uk>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20181222072452.186726-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181222072452.186726-1-swboyd@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_023352_218831_8F580F04 
X-CRM114-Status: GOOD (  11.76  )
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
Cc: robh@kernel.org, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, javierm@redhat.com, linux-kernel@vger.kernel.org,
 a.hajda@samsung.com, andy.shevchenko@gmail.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 11:24:52PM -0800, Stephen Boyd wrote:
> A grep of the kernel shows that many drivers print an error message if
> they fail to get the irq they're looking for. Furthermore, those drivers
> all decide to print the device name, or not, and the irq they were
> requesting, or not, etc. Let's consolidate all these error messages into
> the API itself, allowing us to get rid of the error messages in each
> driver.
...
> +error:
> +	if (warn)
> +		dev_err(&dev->dev, "IRQ%d not found\n", num);

Please don't use the notation IRQn - this is normally used when
referring to interrupt numbers (such as those seen in
/proc/interrupts) rather than a per-device interrupt index.
Grep for IRQ% in drivers/ for many examples.

dev_err(&dev->dev, "IRQ index %u not found: %d\n", num, ret);

would be better - note also the use of %u for unsigned integers.
Using %d for them is IMHO sloppy coding.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
