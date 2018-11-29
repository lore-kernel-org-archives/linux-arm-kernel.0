Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BC8C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:42:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8F121104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FUWmCqjh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JKUe71Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8F121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gjvfftX7A1lW5IFdldVVGgIYDxVEGNPDuPg+9NGhVrY=; b=FUWmCqjhDKwfJx
	XrQ8MwwD/Om5rF3OvT1b5xhPRmhI2L5mmPOLW06tFDVaL6GBZITtiE0HkFBIy3fVQsSSd9cnDcIbo
	O5XR00uJUcxwcKaFDxMFNq2dJgMs118b8EhUG0JzgL8eJJhizgDigdmqDU8x+N4X4rwQhrTJugmj+
	CCIN+GX+Px0wJyKPJxlC/Mfd1SQTFPT5YYj1zmMEQFEysJWnfsZDKUaBc4wux5ffpQ4jWL5pXv4pv
	nsz4lo7J3xtSKl1NoQibFJfNDxIhW3lNlUQesLKlF++yqxk1g4eAWx9nCndx3ueRjKJ/ONXNKdNZH
	wlzKgwZozjpA3KKD1HvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQKj-00070q-NB; Thu, 29 Nov 2018 17:42:37 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQKf-0006zV-Kz
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:42:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=disJopwsWR4e6dryUiTZ+n6g9HIGVxTSpsM/XTB5PlU=; b=JKUe71Zcr4w7lD382W+SHholR
 dPYyWnbwoT1SuVuBk05/T0dew7pl6sHoREuV/bcIXXHPEhwNkWKTIqT3DGQP8QwFaj9FNm0WQU0FF
 rW5+0sjdLKpydCsgUt7exgGMGvw7zJKAn9UbGa28AapxAIcRvzfrK/uYL1Hot0AUOWCUg=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:57518)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gSQKO-0003kR-SL; Thu, 29 Nov 2018 17:42:17 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gSQKK-0003VO-TX; Thu, 29 Nov 2018 17:42:13 +0000
Date: Thu, 29 Nov 2018 17:42:10 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 5/8] ARM: pxa/mainstone: switch PCMCIA to MAX1600 library
 and gpiod APIs
Message-ID: <20181129174208.GA30658@n2100.armlinux.org.uk>
References: <E1gRxl8-0001uz-6u@rmk-PC.armlinux.org.uk>
 <874lbzzt65.fsf@belgarion.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874lbzzt65.fsf@belgarion.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094233_836297_96FBEE62 
X-CRM114-Status: GOOD (  19.06  )
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 06:32:02PM +0100, Robert Jarzmik wrote:
> Russell King <rmk+kernel@armlinux.org.uk> writes:
> 
> Hi Russell,
> 
> I reviewed the code, and I didn't quite understand this chunk :
> > @@ -68,62 +67,18 @@ static void mst_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
> >  	 * as needed to avoid IRQ locks.
> >  	 */
> >  	if (flip) {
> > -		mst_pcmcia_status[skt->nr] = status;
> > -		if (status & MST_PCMCIA_nSTSCHG_BVD1)
> > -			enable_irq( (skt->nr == 0) ? MAINSTONE_S0_STSCHG_IRQ
> > -						   : MAINSTONE_S1_STSCHG_IRQ );
> > +		mst_pcmcia_bvd1_status[skt->nr] = state->bvd1;
> > +		if (state->bvd1)
> > +			enable_irq(skt->stat[SOC_STAT_BVD1].irq);
> >  		else
> > -			disable_irq( (skt->nr == 0) ? MAINSTONE_S0_STSCHG_IRQ
> > -						    : MAINSTONE_S1_STSCHG_IRQ );
> > +			disable_irq(skt->stat[SOC_STAT_BVD2].irq);
> >  	}
> 
> In the former code, the enable_irq() and disable_irq() were called with the same
> interrupt number. But with the new code, if I understand it correctly, the irq
> is different. As I don't fully grasp this chunk, I'll pinpoint it so that you
> can have a second look.

Good catch, that's supposed to be SOC_STAT_BVD1 not SOC_STAT_BVD2 there.

> PS: The "regression" I'm talking about, which is there before your changes and
> after them as well, is in the exact same area, so I'll leave you the backtrace
> of linux-master (without your patches) for information (but not analysis,
> spare your free time) :
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 114 at kernel/irq/manage.c:559 enable_irq+0x34/0x6c
> Unbalanced enable for IRQ 314
> Modules linked in: pxa2xx_mainstone(+) pxa2xx_base soc_common
> CPU: 0 PID: 114 Comm: modprobe Not tainted 4.20.0-rc4-00098-g60b5482 #2931
> Hardware name: Intel HCDDBBVA0 Development Platform (aka Mainstone)
> [<c00101ac>] (unwind_backtrace) from [<c000db80>] (show_stack+0x10/0x14)
> [<c000db80>] (show_stack) from [<c0019e38>] (__warn+0xe4/0x10c)
> [<c0019e38>] (__warn) from [<c0019e98>] (warn_slowpath_fmt+0x38/0x48)
> [<c0019e98>] (warn_slowpath_fmt) from [<c0051ff8>] (enable_irq+0x34/0x6c)
> [<c0051ff8>] (enable_irq) from [<bf00a140>] (mst_pcmcia_socket_state+0x5c/0xe4 [pxa2xx_mainstone])
> [<bf00a140>] (mst_pcmcia_socket_state [pxa2xx_mainstone]) from [<bf0007e8>] (soc_common_pcmcia_skt_state+0x134/0x1d0 [soc_common])
> [<bf0007e8>] (soc_common_pcmcia_skt_state [soc_common]) from [<bf000b00>] (soc_pcmcia_add_one+0x27c/0x374 [soc_common])
> [<bf000b00>] (soc_pcmcia_add_one [soc_common]) from [<bf0063e4>] (pxa2xx_drv_pcmcia_probe+0xbc/0x138 [pxa2xx_base])
> [<bf0063e4>] (pxa2xx_drv_pcmcia_probe [pxa2xx_base]) from [<c0267128>] (platform_drv_probe+0x30/0x80)
> [<c0267128>] (platform_drv_probe) from [<c026507c>] (really_probe+0x1e4/0x404)
> [<c026507c>] (really_probe) from [<c0265450>] (driver_probe_device+0x74/0x1c0)
> [<c0265450>] (driver_probe_device) from [<c0263174>] (bus_for_each_drv+0x5c/0x8c)
> [<c0263174>] (bus_for_each_drv) from [<c0264dfc>] (__device_attach+0xac/0x140)
> [<c0264dfc>] (__device_attach) from [<c02640f8>] (bus_probe_device+0x84/0x90)
> [<c02640f8>] (bus_probe_device) from [<c0261ee0>] (device_add+0x3e8/0x5e4)
> [<c0261ee0>] (device_add) from [<c0266e34>] (platform_device_add+0xbc/0x250)
> [<c0266e34>] (platform_device_add) from [<bf00c040>] (mst_pcmcia_init+0x40/0xc0 [pxa2xx_mainstone])
> [<bf00c040>] (mst_pcmcia_init [pxa2xx_mainstone]) from [<c000a640>] (do_one_initcall+0x48/0x1ac)
> [<c000a640>] (do_one_initcall) from [<c00790c4>] (do_init_module+0x58/0x2fc)
> [<c00790c4>] (do_init_module) from [<c0077eb4>] (load_module+0x1adc/0x2080)
> [<c0077eb4>] (load_module) from [<c007855c>] (sys_init_module+0x104/0x16c)
> [<c007855c>] (sys_init_module) from [<c0009000>] (ret_fast_syscall+0x0/0x50)
> Exception stack(0xc294dfa8 to 0xc294dff0)
> dfa0:                   000b86c8 000b85d0 000b96e8 0000155c 000b85d0 00000000
> dfc0: 000b86c8 000b85d0 000b96e8 00000080 000b86c8 00000000 000b78bc 000b9600
> dfe0: b6f7b1bc bea76b7c 0001ca3c b6f7b1cc
> ---[ end trace 36648ae9205933e8 ]---

Please try initialising mst_pcmcia_bvd1_status[] to 1.

Thanks for testing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
