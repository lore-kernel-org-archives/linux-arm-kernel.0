Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC8BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:58:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565EF21508
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J17dx6sO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4JxHa58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565EF21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C+uwalusU/611Q93MZkjjyGLixYGUsS2Rqq9b//UITA=; b=J17dx6sOHw0Qs3
	9FEE689rbG3fcFI6tOC0i5OsHumcLZYw6GVjBdg413622uqEfwmrmhmh6PR8CvYhkXXL2Dn96ix4c
	SjdxzmKD6VXCrwdyJxe2kguP/bNO2/o6/Enz6sT+WTxWhe8t2u5eu3/cvCgCHrxk9qxW4rGfaxfEx
	Wpcr3Y9e30zxWS4eM9fvs1RDwHymkhuGXSsX/XmwrLgRbTP9h3CxYfxNpucEW5Cco809oG8AwXTD0
	0DtbhMrDiW7hjpJDr+bxriNCFSKnVkZYrF9KQvKpTmJNQA5GYYbJ8T4PmfCKdDGSSklrsiYoSfjrW
	voK7dMe/+g4fjzfmNAeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUpU1-0004bC-Au; Thu, 06 Dec 2018 08:58:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUpTj-0004Nx-Ms; Thu, 06 Dec 2018 08:57:55 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C80CC214C1;
 Thu,  6 Dec 2018 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544086663;
 bh=MFLf5IJPLCb8VUeP6xlwh3RObrJQS8mmITWloiR3vN8=;
 h=Subject:To:Cc:From:Date:From;
 b=I4JxHa58zVW9JTn/i43FysEaANW71g/g9e95oqRf+yoK2wv/QZjfD9RQxVHT1ZvZ6
 xsZISHEiVszQRJ8D4/cfHAyKo8nATok1ieDeokZ+2OPJHhGp9oaErHZUl90zti0Lxs
 lazofrEDPyl5dEKg/utI6623RIAIOka5q1dnZ3H8=
Subject: Patch "drm/meson: Fix OOB memory accesses in meson_viu_set_osd_lut()"
 has been added to the 4.19-stable tree
To: 20181125012117.31915-1-lyude@redhat.com, carlo@caione.org,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 khilman@baylibre.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, lyude@redhat.com,
 maxime.ripard@bootlin.com, narmstrong@baylibre.com, seanpaul@chromium.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 06 Dec 2018 09:57:20 +0100
Message-ID: <154408664017255@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_005751_848768_360B3B4F 
X-CRM114-Status: GOOD (  11.38  )
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

    drm/meson: Fix OOB memory accesses in meson_viu_set_osd_lut()

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-meson-fix-oob-memory-accesses-in-meson_viu_set_osd_lut.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 97b2a3180a559a33852ac0cd77904166069484fd Mon Sep 17 00:00:00 2001
From: Lyude Paul <lyude@redhat.com>
Date: Sat, 24 Nov 2018 20:21:17 -0500
Subject: drm/meson: Fix OOB memory accesses in meson_viu_set_osd_lut()

From: Lyude Paul <lyude@redhat.com>

commit 97b2a3180a559a33852ac0cd77904166069484fd upstream.

Currently on driver bringup with KASAN enabled, meson triggers an OOB
memory access as shown below:

[  117.904528] ==================================================================
[  117.904560] BUG: KASAN: global-out-of-bounds in meson_viu_set_osd_lut+0x7a0/0x890
[  117.904588] Read of size 4 at addr ffff20000a63ce24 by task systemd-udevd/498
[  117.904601]
[  118.083372] CPU: 4 PID: 498 Comm: systemd-udevd Not tainted 4.20.0-rc3Lyude-Test+ #20
[  118.091143] Hardware name: amlogic khadas-vim2/khadas-vim2, BIOS 2018.07-rc2-armbian 09/11/2018
[  118.099768] Call trace:
[  118.102181]  dump_backtrace+0x0/0x3e8
[  118.105796]  show_stack+0x14/0x20
[  118.109083]  dump_stack+0x130/0x1c4
[  118.112539]  print_address_description+0x60/0x25c
[  118.117214]  kasan_report+0x1b4/0x368
[  118.120851]  __asan_report_load4_noabort+0x18/0x20
[  118.125566]  meson_viu_set_osd_lut+0x7a0/0x890
[  118.129953]  meson_viu_init+0x10c/0x290
[  118.133741]  meson_drv_bind_master+0x474/0x748
[  118.138141]  meson_drv_bind+0x10/0x18
[  118.141760]  try_to_bring_up_master+0x3d8/0x768
[  118.146249]  component_add+0x214/0x570
[  118.149978]  meson_dw_hdmi_probe+0x18/0x20 [meson_dw_hdmi]
[  118.155404]  platform_drv_probe+0x98/0x138
[  118.159455]  really_probe+0x2a0/0xa70
[  118.163070]  driver_probe_device+0x1b4/0x2d8
[  118.167299]  __driver_attach+0x200/0x280
[  118.171189]  bus_for_each_dev+0x10c/0x1a8
[  118.175144]  driver_attach+0x38/0x50
[  118.178681]  bus_add_driver+0x330/0x608
[  118.182471]  driver_register+0x140/0x388
[  118.186361]  __platform_driver_register+0xc8/0x108
[  118.191117]  meson_dw_hdmi_platform_driver_init+0x1c/0x1000 [meson_dw_hdmi]
[  118.198022]  do_one_initcall+0x12c/0x3bc
[  118.201883]  do_init_module+0x1fc/0x638
[  118.205673]  load_module+0x4b4c/0x6808
[  118.209387]  __se_sys_init_module+0x2e8/0x3c0
[  118.213699]  __arm64_sys_init_module+0x68/0x98
[  118.218100]  el0_svc_common+0x104/0x210
[  118.221893]  el0_svc_handler+0x48/0xb8
[  118.225594]  el0_svc+0x8/0xc
[  118.228429]
[  118.229887] The buggy address belongs to the variable:
[  118.235007]  eotf_33_linear_mapping+0x84/0xc0
[  118.239301]
[  118.240752] Memory state around the buggy address:
[  118.245522]  ffff20000a63cd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  118.252695]  ffff20000a63cd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  118.259850] >ffff20000a63ce00: 00 00 00 00 04 fa fa fa fa fa fa fa 00 00 00 00
[  118.267000]                                ^
[  118.271222]  ffff20000a63ce80: 00 fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
[  118.278393]  ffff20000a63cf00: 00 00 00 00 00 00 00 00 00 00 00 00 04 fa fa fa
[  118.285542] ==================================================================
[  118.292699] Disabling lock debugging due to kernel taint

It seems that when looping through the OSD EOTF LUT maps, we use the
same max iterator for OETF: 20. This is wrong though, since 20*2 is 40,
which means that we'll stop out of bounds on the EOTF maps.

But, this whole thing is already confusing enough to read through as-is,
so let's just replace all of the hardcoded sizes with
OSD_(OETF/EOTF)_LUT_SIZE / 2.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: <stable@vger.kernel.org> # v4.10+
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181125012117.31915-1-lyude@redhat.com
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/meson/meson_viu.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -184,18 +184,18 @@ void meson_viu_set_osd_lut(struct meson_
 	if (lut_sel == VIU_LUT_OSD_OETF) {
 		writel(0, priv->io_base + _REG(addr_port));
 
-		for (i = 0; i < 20; i++)
+		for (i = 0; i < (OSD_OETF_LUT_SIZE / 2); i++)
 			writel(r_map[i * 2] | (r_map[i * 2 + 1] << 16),
 				priv->io_base + _REG(data_port));
 
 		writel(r_map[OSD_OETF_LUT_SIZE - 1] | (g_map[0] << 16),
 			priv->io_base + _REG(data_port));
 
-		for (i = 0; i < 20; i++)
+		for (i = 0; i < (OSD_OETF_LUT_SIZE / 2); i++)
 			writel(g_map[i * 2 + 1] | (g_map[i * 2 + 2] << 16),
 				priv->io_base + _REG(data_port));
 
-		for (i = 0; i < 20; i++)
+		for (i = 0; i < (OSD_OETF_LUT_SIZE / 2); i++)
 			writel(b_map[i * 2] | (b_map[i * 2 + 1] << 16),
 				priv->io_base + _REG(data_port));
 
@@ -211,18 +211,18 @@ void meson_viu_set_osd_lut(struct meson_
 	} else if (lut_sel == VIU_LUT_OSD_EOTF) {
 		writel(0, priv->io_base + _REG(addr_port));
 
-		for (i = 0; i < 20; i++)
+		for (i = 0; i < (OSD_EOTF_LUT_SIZE / 2); i++)
 			writel(r_map[i * 2] | (r_map[i * 2 + 1] << 16),
 				priv->io_base + _REG(data_port));
 
 		writel(r_map[OSD_EOTF_LUT_SIZE - 1] | (g_map[0] << 16),
 			priv->io_base + _REG(data_port));
 
-		for (i = 0; i < 20; i++)
+		for (i = 0; i < (OSD_EOTF_LUT_SIZE / 2); i++)
 			writel(g_map[i * 2 + 1] | (g_map[i * 2 + 2] << 16),
 				priv->io_base + _REG(data_port));
 
-		for (i = 0; i < 20; i++)
+		for (i = 0; i < (OSD_EOTF_LUT_SIZE / 2); i++)
 			writel(b_map[i * 2] | (b_map[i * 2 + 1] << 16),
 				priv->io_base + _REG(data_port));
 


Patches currently in stable-queue which might be from lyude@redhat.com are

queue-4.19/drm-meson-enable-fast_io-in-meson_dw_hdmi_regmap_config.patch
queue-4.19/drm-amd-dm-understand-why-attaching-path-tile-properties-are-needed.patch
queue-4.19/drm-amd-dm-don-t-forget-to-attach-mst-encoders.patch
queue-4.19/drm-meson-fixes-for-drm_crtc_vblank_on-off-support.patch
queue-4.19/drm-meson-fix-oob-memory-accesses-in-meson_viu_set_osd_lut.patch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
