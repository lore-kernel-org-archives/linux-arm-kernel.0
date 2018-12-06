Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2744CC67814
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:30:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB41120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HTfl4Jv3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7cpptFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB41120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EMMQR/Np3jCyzejOLhstxR1xuJ+nVLSP+BtDT8Uv2cs=; b=HTfl4Jv3G6Oopr
	ahQPVrl9II/E+nuljCo5wX+yVUgUKujE14NALmD5/YXApLEr5usihe+BqgMsYNfbYLWMGMPpWRHhp
	Xpt62mYfCcwWO7aeT/wmJMzHClk6u8ptxWAuptX2is21N/NuEdH1V6dsbpPgrW5XPbjaFv/4TGPgS
	MrfjxF+u5TcvrHP5L2SkN2yqvBYst3uV30cCJx2XN+JsoQjO8IAWvvVin5Onp1/9o2OynW7Wqt5SY
	gmpyQWj/LtAazZBcJu6ozRLj/2R4p4wf42eO5k838+AQv2LacRdHv8HXmVf9QutAksCwM3MzryZ1O
	7fx1CfhC+PJZETIq9WPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUpzN-00021I-3O; Thu, 06 Dec 2018 09:30:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUpz4-0000oi-BJ; Thu, 06 Dec 2018 09:30:17 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7523F20850;
 Thu,  6 Dec 2018 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544088604;
 bh=zmOhEKgW7pLdvkDKL/7f1011Ko6G41GDdqhdAXagfe8=;
 h=Subject:To:Cc:From:Date:From;
 b=K7cpptFSEnFq9RxJgGQTf/4c3022gR0dhtG7Elsrel0h6kUECMSk8y0bSNEvL64F4
 Tf7syzHBJloV9shq2fazMkwzQBcFg1OX1Ofucun+OdhclMbAQss0ITdlGgpp4FjxFW
 6pWkRr+i6yZjSmCcDnqGZON6npN6MKVgdSRxtv6g=
Subject: Patch "drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config" has
 been added to the 4.14-stable tree
To: 20181124191238.28276-1-lyude@redhat.com, carlo@caione.org,
 daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, khilman@baylibre.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 lyude@redhat.com, narmstrong@baylibre.com, seanpaul@chromium.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 06 Dec 2018 10:29:53 +0100
Message-ID: <1544088593217195@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_013014_454574_D047A1E2 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: stable-commits@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


This is a note to let you know that I've just added the patch titled

    drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-meson-enable-fast_io-in-meson_dw_hdmi_regmap_config.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 995b278e4723b26f8ebf0e7c119286d16c712747 Mon Sep 17 00:00:00 2001
From: Lyude Paul <lyude@redhat.com>
Date: Sat, 24 Nov 2018 14:12:38 -0500
Subject: drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config

From: Lyude Paul <lyude@redhat.com>

commit 995b278e4723b26f8ebf0e7c119286d16c712747 upstream.

Seeing as we use this registermap in the context of our IRQ handlers, we
need to be using spinlocks for reading/writing registers so that we can
still read them from IRQ handlers without having to grab any mutexes and
accidentally sleep. We don't currently do this, as pointed out by
lockdep:

[   18.403770] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
[   18.406744] in_atomic(): 1, irqs_disabled(): 128, pid: 68, name: kworker/u17:0
[   18.413864] INFO: lockdep is turned off.
[   18.417675] irq event stamp: 12
[   18.420778] hardirqs last  enabled at (11): [<ffff000008a4f57c>] _raw_spin_unlock_irq+0x2c/0x60
[   18.429510] hardirqs last disabled at (12): [<ffff000008a48914>] __schedule+0xc4/0xa60
[   18.437345] softirqs last  enabled at (0): [<ffff0000080b55e0>] copy_process.isra.4.part.5+0x4d8/0x1c50
[   18.446684] softirqs last disabled at (0): [<0000000000000000>]           (null)
[   18.453979] CPU: 0 PID: 68 Comm: kworker/u17:0 Tainted: G        W  O      4.20.0-rc3Lyude-Test+ #9
[   18.469839] Hardware name: amlogic khadas-vim2/khadas-vim2, BIOS 2018.07-rc2-armbian 09/11/2018
[   18.480037] Workqueue: hci0 hci_power_on [bluetooth]
[   18.487138] Call trace:
[   18.494192]  dump_backtrace+0x0/0x1b8
[   18.501280]  show_stack+0x14/0x20
[   18.508361]  dump_stack+0xbc/0xf4
[   18.515427]  ___might_sleep+0x140/0x1d8
[   18.522515]  __might_sleep+0x50/0x88
[   18.529582]  __mutex_lock+0x60/0x870
[   18.536621]  mutex_lock_nested+0x1c/0x28
[   18.543660]  regmap_lock_mutex+0x10/0x18
[   18.550696]  regmap_read+0x38/0x70
[   18.557727]  dw_hdmi_hardirq+0x58/0x138 [dw_hdmi]
[   18.564804]  __handle_irq_event_percpu+0xac/0x410
[   18.571891]  handle_irq_event_percpu+0x34/0x88
[   18.578982]  handle_irq_event+0x48/0x78
[   18.586051]  handle_fasteoi_irq+0xac/0x160
[   18.593061]  generic_handle_irq+0x24/0x38
[   18.599989]  __handle_domain_irq+0x60/0xb8
[   18.606857]  gic_handle_irq+0x50/0xa0
[   18.613659]  el1_irq+0xb4/0x130
[   18.620394]  debug_lockdep_rcu_enabled+0x2c/0x30
[   18.627111]  schedule+0x38/0xa0
[   18.633781]  schedule_timeout+0x3a8/0x510
[   18.640389]  wait_for_common+0x15c/0x180
[   18.646905]  wait_for_completion+0x14/0x20
[   18.653319]  mmc_wait_for_req_done+0x28/0x168
[   18.659693]  mmc_wait_for_req+0xa8/0xe8
[   18.665978]  mmc_wait_for_cmd+0x64/0x98
[   18.672180]  mmc_io_rw_direct_host+0x94/0x130
[   18.678385]  mmc_io_rw_direct+0x10/0x18
[   18.684516]  sdio_enable_func+0xe8/0x1d0
[   18.690627]  btsdio_open+0x24/0xc0 [btsdio]
[   18.696821]  hci_dev_do_open+0x64/0x598 [bluetooth]
[   18.703025]  hci_power_on+0x50/0x270 [bluetooth]
[   18.709163]  process_one_work+0x2a0/0x6e0
[   18.715252]  worker_thread+0x40/0x448
[   18.721310]  kthread+0x12c/0x130
[   18.727326]  ret_from_fork+0x10/0x1c
[   18.735555] ------------[ cut here ]------------
[   18.741430] do not call blocking ops when !TASK_RUNNING; state=2 set at [<000000006265ec59>] wait_for_common+0x140/0x180
[   18.752417] WARNING: CPU: 0 PID: 68 at kernel/sched/core.c:6096 __might_sleep+0x7c/0x88
[   18.760553] Modules linked in: dm_mirror dm_region_hash dm_log dm_mod
btsdio bluetooth snd_soc_hdmi_codec dw_hdmi_i2s_audio ecdh_generic
brcmfmac brcmutil cfg80211 rfkill ir_nec_decoder meson_dw_hdmi(O)
dw_hdmi rc_geekbox meson_rng meson_ir ao_cec rng_core rc_core cec
leds_pwm efivars nfsd ip_tables x_tables crc32_generic f2fs uas
meson_gxbb_wdt pwm_meson efivarfs ipv6
[   18.799469] CPU: 0 PID: 68 Comm: kworker/u17:0 Tainted: G        W  O      4.20.0-rc3Lyude-Test+ #9
[   18.808858] Hardware name: amlogic khadas-vim2/khadas-vim2, BIOS 2018.07-rc2-armbian 09/11/2018
[   18.818045] Workqueue: hci0 hci_power_on [bluetooth]
[   18.824088] pstate: 80000085 (Nzcv daIf -PAN -UAO)
[   18.829891] pc : __might_sleep+0x7c/0x88
[   18.835722] lr : __might_sleep+0x7c/0x88
[   18.841256] sp : ffff000008003cb0
[   18.846751] x29: ffff000008003cb0 x28: 0000000000000000
[   18.852269] x27: ffff00000938e000 x26: ffff800010283000
[   18.857726] x25: ffff800010353280 x24: ffff00000868ef50
[   18.863166] x23: 0000000000000000 x22: 0000000000000000
[   18.868551] x21: 0000000000000000 x20: 000000000000038c
[   18.873850] x19: ffff000008cd08c0 x18: 0000000000000010
[   18.879081] x17: ffff000008a68cb0 x16: 0000000000000000
[   18.884197] x15: 0000000000aaaaaa x14: 0e200e200e200e20
[   18.889239] x13: 0000000000000001 x12: 00000000ffffffff
[   18.894261] x11: ffff000008adfa48 x10: 0000000000000001
[   18.899517] x9 : ffff0000092a0158 x8 : 0000000000000000
[   18.904674] x7 : ffff00000812136c x6 : 0000000000000000
[   18.909895] x5 : 0000000000000000 x4 : 0000000000000001
[   18.915080] x3 : 0000000000000007 x2 : 0000000000000007
[   18.920269] x1 : 99ab8e9ebb6c8500 x0 : 0000000000000000
[   18.925443] Call trace:
[   18.929904]  __might_sleep+0x7c/0x88
[   18.934311]  __mutex_lock+0x60/0x870
[   18.938687]  mutex_lock_nested+0x1c/0x28
[   18.943076]  regmap_lock_mutex+0x10/0x18
[   18.947453]  regmap_read+0x38/0x70
[   18.951842]  dw_hdmi_hardirq+0x58/0x138 [dw_hdmi]
[   18.956269]  __handle_irq_event_percpu+0xac/0x410
[   18.960712]  handle_irq_event_percpu+0x34/0x88
[   18.965176]  handle_irq_event+0x48/0x78
[   18.969612]  handle_fasteoi_irq+0xac/0x160
[   18.974058]  generic_handle_irq+0x24/0x38
[   18.978501]  __handle_domain_irq+0x60/0xb8
[   18.982938]  gic_handle_irq+0x50/0xa0
[   18.987351]  el1_irq+0xb4/0x130
[   18.991734]  debug_lockdep_rcu_enabled+0x2c/0x30
[   18.996180]  schedule+0x38/0xa0
[   19.000609]  schedule_timeout+0x3a8/0x510
[   19.005064]  wait_for_common+0x15c/0x180
[   19.009513]  wait_for_completion+0x14/0x20
[   19.013951]  mmc_wait_for_req_done+0x28/0x168
[   19.018402]  mmc_wait_for_req+0xa8/0xe8
[   19.022809]  mmc_wait_for_cmd+0x64/0x98
[   19.027177]  mmc_io_rw_direct_host+0x94/0x130
[   19.031563]  mmc_io_rw_direct+0x10/0x18
[   19.035922]  sdio_enable_func+0xe8/0x1d0
[   19.040294]  btsdio_open+0x24/0xc0 [btsdio]
[   19.044742]  hci_dev_do_open+0x64/0x598 [bluetooth]
[   19.049228]  hci_power_on+0x50/0x270 [bluetooth]
[   19.053687]  process_one_work+0x2a0/0x6e0
[   19.058143]  worker_thread+0x40/0x448
[   19.062608]  kthread+0x12c/0x130
[   19.067064]  ret_from_fork+0x10/0x1c
[   19.071513] irq event stamp: 12
[   19.075937] hardirqs last  enabled at (11): [<ffff000008a4f57c>] _raw_spin_unlock_irq+0x2c/0x60
[   19.083560] hardirqs last disabled at (12): [<ffff000008a48914>] __schedule+0xc4/0xa60
[   19.091401] softirqs last  enabled at (0): [<ffff0000080b55e0>] copy_process.isra.4.part.5+0x4d8/0x1c50
[   19.100801] softirqs last disabled at (0): [<0000000000000000>]           (null)
[   19.108135] ---[ end trace 38c4920787b88c75 ]---

So, fix this by enabling the fast_io option in our regmap config so that
regmap uses spinlocks for locking instead of mutexes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 3f68be7d8e96 ("drm/meson: Add support for HDMI encoder and DW-HDMI bridge + PHY")
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: <stable@vger.kernel.org> # v4.12+
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181124191238.28276-1-lyude@redhat.com
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/meson/meson_dw_hdmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -697,6 +697,7 @@ static const struct regmap_config meson_
 	.reg_read = meson_dw_hdmi_reg_read,
 	.reg_write = meson_dw_hdmi_reg_write,
 	.max_register = 0x10000,
+	.fast_io = true,
 };
 
 static bool meson_hdmi_connector_is_available(struct device *dev)


Patches currently in stable-queue which might be from lyude@redhat.com are

queue-4.14/drm-meson-enable-fast_io-in-meson_dw_hdmi_regmap_config.patch
queue-4.14/drm-meson-fix-oob-memory-accesses-in-meson_viu_set_osd_lut.patch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
