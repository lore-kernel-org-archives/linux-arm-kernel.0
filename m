Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491F2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:03:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CF42184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ae8IJKRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CF42184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sKnj0FbXUQmELOOY6lSfna/QdumJBhRRTt/Ej/uRnLE=; b=ae8IJKRQx5OSOD
	Gnb7BE50ljQDR6/8JkTKTWMYv+yylkYhDftEqviBiEm7cLC2Is7vjRwpqcHFvT7XDgCEv0mPY9bQt
	XHoARHjyF+1H76FOF7PJgZQ2GGcO3XdUT01xybvLPz4GIcoItUg/fBGY+WJL1liUAersEy6eX6StF
	xTeQqZ9yK02k7VXEwo59XrHEexR+HPjFoofIWncGPUPet6RG1Yzzu8+Bs3qfGn05eIsG2z/66r9lX
	jwY5anSgR6urFPHQIUADSsbeeNxMsk1xIRhF/svbMsIP84pD/bX4K/EyHK87HYpkhS0X/K1RgOCcm
	QGuBYbAYjTaQp79CLGwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd266-0001iq-Uc; Sat, 29 Dec 2018 00:03:22 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd262-0001fg-G7
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 00:03:20 +0000
Received: from oxbsltgw60.schlund.de ([212.227.220.198]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N6bPS-1hPrB613zq-0184yj; Sat, 29 Dec 2018 01:02:58 +0100
Date: Sat, 29 Dec 2018 01:02:57 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Woojung Huh <woojung.huh@microchip.com>, Eric Anholt <eric@anholt.net>
Message-ID: <1082628525.187562.1546041777025@email.ionos.de>
Subject: lan78xx: WARNING: irq 79 handler enabled interrupts
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:hmM+6zswJo+5ewhrP0mCDqOnpyOrYMjd3z23FkJznBitYc+tWHh
 viOUMJjivMRRkhv+6xlOo4REVeXks6vLXIsASLz9C3pLUPm8hq2OLzH3Q3MfNet5LnRw+4B
 OG9z6Wt5pN2YbYnqZjYe5eTij3Vi/kAhucg3TdYu/CL5HKNGRmEuS9MKGiEa1L3P4W3k0fE
 mnVcoG0u4DyxoRXmQYFSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j39ptZ5QYqo=:+SYX+1uIDsUvW8X8/6dTtY
 w5gwroV5/BtpjR6v4rvaDJ/QNEC1ISlHbJqEpPSPZzGfNJ8pCG4POsXDR8fJ9/pRIU+VDWWGj
 k8occdT/EmdnQ2hCNVK8Tq+iaoqf1suM2bGgP1e8z9B0EHCEa8ulYRu+hhUIwOFzxJmoGpZr9
 qK+dlCn3zT5QOJIq2Di6rCx+Wwjw/E/LdG1T0ljbF4yefzPn3BZnAIclerCt67ngUyc9M+7+s
 t1ztZPlNaP+583gG7ybvBSMgzTtj25N/6WuCP3wpCmjfk1UU+5uJe8znV1H3ry8LxO+mprZVF
 PvgGOy+L3KOmpqoVwkQyQd/LAsxnifoX9obKzD7A+mA6jxorxyHtH+VcRYZ3huqMSWAnXmL0z
 m0Qi225nGqio6A538QcG1HyGJV+w4d7vVEyYON0qTlkq9JRHTzGibiqNa6LAepkDI2geManLL
 lZQZfH8l9bj4j+IKvcs4pUqItIzGZMVGoZQv5W0ENLcN/lZoIU2HEaROJy5YrH7k5v2KcO0RC
 VXGwWCIF1CQqZ+A9WDa0KKxIjP9Q4M/dmkBjXtIvfQxEZfJN0kSluSkn6U18tcJdiEDzahTmo
 fG53uXgQsgUq9FKTR2Ws2SdxjC/9WfwGY7J3dZIIz8Tx5y47CO3SFNlM2xIACUdc4XQ58bfto
 3WMYGiBjM3nOdf0U4TuovFeRw7sm1F3/m5ghOzB6qEgMMyWxmRkQxwqilb+MwOZqMWn7eLjP4
 Harl9oy0qdn69Poj09tdMRBtr1dylq5vCnxX5Ay4oTMCZpucznlAS5ssmFQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_160318_906299_D462AA03 
X-CRM114-Status: UNSURE (   9.31  )
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,
while booting my Raspberry Pi 3 B+ with Linux 4.20 (arm64/defconfig) i'm getting the following warning:

[   11.005738] irq 79 handler irq_default_primary_handler+0x0/0x8 enabled interrupts
[   11.024703] WARNING: CPU: 0 PID: 0 at kernel/irq/handle.c:153 __handle_irq_event_percpu+0x154/0x168
[   11.045293] Modules linked in: brcmfmac vc4 brcmutil cfg80211 cec drm_kms_helper hci_uart drm btbcm bluetooth microchip lan78xx ecdh_generic rfkill crct10dif_ce drm_panel_orientation_quirks bcm2835_rng bcm2835_thermal pwm_bcm2835 raspberrypi_hwmon i2c_bcm2835 vchiq(C) rng_core ip_tables x_tables ipv6
[   11.096874] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.20.0 #11
[   11.116736] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT)
[   11.135405] pstate: 20000005 (nzCv daif -PAN -UAO)
[   11.152481] pc : __handle_irq_event_percpu+0x154/0x168
[   11.169840] lr : __handle_irq_event_percpu+0x154/0x168
[   11.187018] sp : ffff000008003ce0
[   11.202234] x29: ffff000008003ce0 x28: 0000000000000000 
[   11.219467] x27: 0000000000000001 x26: ffff000008ebed00 
[   11.236619] x25: ffff0000092fe40a x24: ffff800035d7e800 
[   11.253679] x23: ffff0000091b9000 x22: 000000000000004f 
[   11.270636] x21: ffff000008003d84 x20: 0000000000000002 
[   11.287449] x19: ffff800035572980 x18: ffffffffffffffff 
[   11.304177] x17: 0000000000000000 x16: 0000000000000000 
[   11.320827] x15: ffff0000091b96c8 x14: 0720072007200720 
[   11.337364] x13: 0720072007200720 x12: ffff000008bfe738 
[   11.353996] x11: ffff80002d593c70 x10: 0000000000000001 
[   11.370541] x9 : 00000000ffffffff x8 : 0000000000000001 
[   11.387035] x7 : 0000000000000008 x6 : ffff8000393800b8 
[   11.403471] x5 : ffff8000393800b8 x4 : 0000000000000001 
[   11.419849] x3 : 0000000000000000 x2 : ffff0000091c2600 
[   11.436199] x1 : 16ca74a025baa300 x0 : 0000000000000000 
[   11.452495] Call trace:
[   11.465764]  __handle_irq_event_percpu+0x154/0x168
[   11.481439]  handle_irq_event_percpu+0x34/0x88
[   11.496695]  handle_irq_event+0x48/0x78
[   11.511242]  handle_simple_irq+0x80/0xb8
[   11.525787]  generic_handle_irq+0x24/0x38
[   11.540339]  intr_complete+0xbc/0x100 [lan78xx]
[   11.555366]  __usb_hcd_giveback_urb+0x6c/0xd8
[   11.570137]  usb_giveback_urb_bh+0xa8/0x108
[   11.584699]  tasklet_action_common.isra.2+0x80/0x130
[   11.600056]  tasklet_hi_action+0x24/0x30
[   11.614255]  __do_softirq+0x108/0x234
[   11.628097]  irq_exit+0xcc/0xd8
[   11.641323]  __handle_domain_irq+0x60/0xb8
[   11.655516]  bcm2836_arm_irqchip_handle_irq+0x64/0xb8
[   11.670667]  el1_irq+0xb0/0x128
[   11.683770]  arch_cpu_idle+0x10/0x18
[   11.697275]  do_idle+0x1c4/0x280
[   11.710341]  cpu_startup_entry+0x20/0x28
[   11.724058]  rest_init+0xd4/0xe0
[   11.736962]  arch_call_rest_init+0xc/0x14
[   11.750625]  start_kernel+0x3ec/0x418

This seems to come from the lan78xx driver, because i don't get this warning on the RPI 3B (smsc95xx).

What's the approach to fix this issue? 
Is it just simply replace spin_lock_irq() with spin_lock_irqsave() at the right places?

Regards
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
