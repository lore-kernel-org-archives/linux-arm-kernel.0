Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:14:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A4220821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ESVCpTMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A4220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CGIOlTcTP6devJHgFpJLWrBrOjPwhttIgfSEBgbDNrc=; b=ESVCpTMHeQnrFQ
	Vv/VWLa+Z9M0kQqiVU68tg79reR8783fQETO8DdSTUW8fv5PnoWIvyQ4B8sY7o2MO4RH2vFkvzLgu
	Hx02ks7HU7EF+/z4kafsi/2VlKjkeCCtduVo7PnHWrrZqTOZaMmvhSf1oaOaSq51ngb42H8AwZJ6x
	zbKNvZav52b5TGie86diOGsyF7GYJM3ww9ktP2bbl2O/rj/CiwE/q/Ydpg8vILH2nEacK93KI1q1p
	uGJIm0neYXsmIdIBr1R64J1pzBOMqQCBc8W4gnc9O/HAljKZBJ9RhLpFEkIiiNsU4TiOk5Exegw/P
	A3/3i9srXuK5OFbq3Rew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh3Np-0008N4-7p; Wed, 09 Jan 2019 02:14:17 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh3Nl-0008Ma-5o; Wed, 09 Jan 2019 02:14:15 +0000
X-UUID: 2fae423af8c9487b9f3ced0d8fc9ffba-20190108
X-UUID: 2fae423af8c9487b9f3ced0d8fc9ffba-20190108
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 805445769; Tue, 08 Jan 2019 18:14:07 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 18:14:05 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 10:13:57 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 9 Jan 2019 10:13:57 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Linus Walleij <linus.walleij@linaro.org>, Sean Wang <sean.wang@kernel.org>
Subject: [PATCH] pinctrl: mediatek: fix build errors for moore core when
 CONFIG_OF is not enabled
Date: Wed, 9 Jan 2019 10:13:55 +0800
Message-ID: <64a23e6f8751ee6f1387a611a9d5dba43694b0d0.1546999151.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0B646594E2FACCE12C7F3E87BC347B8C87F063D296C0553D387AFC4A4CE689622000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_181413_222506_A1B8ADB7 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

on i386 or x86_64:

Lots of build errors for drivers/pinctrl/mediatek/pinctrl-moore.c when
CONFIG_OF is not enabled (but COMPILE_TEST is).

first this:
WARNING: unmet direct dependencies detected for PINCTRL_MTK_MOORE
  Depends on [n]: PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && OF [=n]
  Selected by [y]:
  - PINCTRL_MT7623 [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && (MACH_MT7623 || COMPILE_TEST [=y])

and then:
../drivers/pinctrl/mediatek/pinctrl-moore.c:22:44: error: array type has incomplete element type
 static const struct pinconf_generic_params mtk_custom_bindings[] = {
                                            ^
../drivers/pinctrl/mediatek/pinctrl-moore.c: In function 'mtk_pinmux_set_mux':
../drivers/pinctrl/mediatek/pinctrl-moore.c:46:2: error: implicit declaration of function 'pinmux_generic_get_function' [-Werror=implicit-function-declaration]
  func = pinmux_generic_get_function(pctldev, selector);
  ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:46:7: warning: assignment makes pointer from integer without a cast [enabled by default]
  func = pinmux_generic_get_function(pctldev, selector);
       ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:50:2: error: implicit declaration of function 'pinctrl_generic_get_group' [-Werror=implicit-function-declaration]
  grp = pinctrl_generic_get_group(pctldev, group);
  ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:50:6: warning: assignment makes pointer from integer without a cast [enabled by default]
  grp = pinctrl_generic_get_group(pctldev, group);
      ^
In file included from ../include/linux/printk.h:331:0,
                 from ../include/linux/kernel.h:14,
                 from ../include/linux/list.h:9,
                 from ../include/linux/kobject.h:19,
                 from ../include/linux/device.h:16,
                 from ../include/linux/gpio/driver.h:5,
                 from ../drivers/pinctrl/mediatek/pinctrl-moore.c:11:
../drivers/pinctrl/mediatek/pinctrl-moore.c:55:7: error: dereferencing pointer to incomplete type
   func->name, grp->name);
       ^
../include/linux/dynamic_debug.h:136:9: note: in definition of macro 'dynamic_dev_dbg'
       ##__VA_ARGS__);  \
         ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:54:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(pctldev->dev, "enable function %s group %s\n",
  ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:55:18: error: dereferencing pointer to incomplete type
   func->name, grp->name);
                  ^
../include/linux/dynamic_debug.h:136:9: note: in definition of macro 'dynamic_dev_dbg'
       ##__VA_ARGS__);  \
         ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:54:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(pctldev->dev, "enable function %s group %s\n",
  ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:57:21: error: dereferencing pointer to incomplete type
  for (i = 0; i < grp->num_pins; i++) {
                     ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:59:23: error: dereferencing pointer to incomplete type
   int *pin_modes = grp->data;
                       ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:60:16: error: dereferencing pointer to incomplete type
   int pin = grp->pins[i];
                ^
../drivers/pinctrl/mediatek/pinctrl-moore.c: In function 'mtk_pinconf_group_get':
../drivers/pinctrl/mediatek/pinctrl-moore.c:357:2: error: implicit declaration of function 'pinctrl_generic_get_group_pins' [-Werror=implicit-function-declaration]
  ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
  ^
../drivers/pinctrl/mediatek/pinctrl-moore.c: At top level:
../drivers/pinctrl/mediatek/pinctrl-moore.c:397:22: error: 'pinctrl_generic_get_group_count' undeclared here (not in a function)
  .get_groups_count = pinctrl_generic_get_group_count,
                      ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:398:20: error: 'pinctrl_generic_get_group_name' undeclared here (not in a function)
  .get_group_name = pinctrl_generic_get_group_name,
                    ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:399:20: error: 'pinctrl_generic_get_group_pins' undeclared here (not in a function)
  .get_group_pins = pinctrl_generic_get_group_pins,
                    ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:400:20: error: 'pinconf_generic_dt_node_to_map_all' undeclared here (not in a function)
  .dt_node_to_map = pinconf_generic_dt_node_to_map_all,
                    ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:401:17: error: 'pinconf_generic_dt_free_map' undeclared here (not in a function)
  .dt_free_map = pinconf_generic_dt_free_map,
                 ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:405:25: error: 'pinmux_generic_get_function_count' undeclared here (not in a function)
  .get_functions_count = pinmux_generic_get_function_count,
                         ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:406:23: error: 'pinmux_generic_get_function_name' undeclared here (not in a function)
  .get_function_name = pinmux_generic_get_function_name,
                       ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:407:25: error: 'pinmux_generic_get_function_groups' undeclared here (not in a function)
  .get_function_groups = pinmux_generic_get_function_groups,
                         ^
../drivers/pinctrl/mediatek/pinctrl-moore.c: In function 'mtk_build_gpiochip':
../drivers/pinctrl/mediatek/pinctrl-moore.c:521:6: error: 'struct gpio_chip' has no member named 'of_node'
  chip->of_node  = np;
      ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:522:6: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'
  chip->of_gpio_n_cells = 2;
      ^
../drivers/pinctrl/mediatek/pinctrl-moore.c: In function 'mtk_build_groups':
../drivers/pinctrl/mediatek/pinctrl-moore.c:552:16: error: invalid use of undefined type 'struct group_desc'
   const struct group_desc *group = hw->soc->grps + i;
                ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:554:3: error: implicit declaration of function 'pinctrl_generic_add_group' [-Werror=implicit-function-declaration]
   err = pinctrl_generic_add_group(hw->pctrl, group->name,
   ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:554:51: error: dereferencing pointer to incomplete type
   err = pinctrl_generic_add_group(hw->pctrl, group->name,
                                                   ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:555:12: error: dereferencing pointer to incomplete type
       group->pins, group->num_pins,
            ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:555:25: error: dereferencing pointer to incomplete type
       group->pins, group->num_pins,
                         ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:556:12: error: dereferencing pointer to incomplete type
       group->data);
            ^
In file included from ../include/linux/gpio/driver.h:5:0,
                 from ../drivers/pinctrl/mediatek/pinctrl-moore.c:11:
../drivers/pinctrl/mediatek/pinctrl-moore.c:559:10: error: dereferencing pointer to incomplete type
     group->name);
          ^
../include/linux/device.h:1463:32: note: in definition of macro 'dev_err'
  _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                ^
../drivers/pinctrl/mediatek/pinctrl-moore.c: In function 'mtk_build_functions':
../drivers/pinctrl/mediatek/pinctrl-moore.c:572:16: error: invalid use of undefined type 'struct function_desc'
   const struct function_desc *func = hw->soc->funcs + i;
                ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:574:3: error: implicit declaration of function 'pinmux_generic_add_function' [-Werror=implicit-function-declaration]
   err = pinmux_generic_add_function(hw->pctrl, func->name,
   ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:574:52: error: dereferencing pointer to incomplete type
   err = pinmux_generic_add_function(hw->pctrl, func->name,
                                                    ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:575:13: error: dereferencing pointer to incomplete type
         func->group_names,
             ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:576:13: error: dereferencing pointer to incomplete type
         func->num_group_names,
             ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:577:13: error: dereferencing pointer to incomplete type
         func->data);
             ^
In file included from ../include/linux/gpio/driver.h:5:0,
                 from ../drivers/pinctrl/mediatek/pinctrl-moore.c:11:
../drivers/pinctrl/mediatek/pinctrl-moore.c:580:9: error: dereferencing pointer to incomplete type
     func->name);
         ^
../include/linux/device.h:1463:32: note: in definition of macro 'dev_err'
  _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                ^
In file included from ../include/linux/kernel.h:15:0,
                 from ../include/linux/list.h:9,
                 from ../include/linux/kobject.h:19,
                 from ../include/linux/device.h:16,
                 from ../include/linux/gpio/driver.h:5,
                 from ../drivers/pinctrl/mediatek/pinctrl-moore.c:11:
../drivers/pinctrl/mediatek/pinctrl-moore.c: In function 'mtk_moore_pinctrl_probe':
../include/linux/build_bug.h:16:45: error: bit-field '<anonymous>' width not an integer constant
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                             ^
../include/linux/compiler.h:349:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
 #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                            ^
../include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                           ^
../drivers/pinctrl/mediatek/pinctrl-moore.c:643:31: note: in expansion of macro 'ARRAY_SIZE'
  mtk_desc.num_custom_params = ARRAY_SIZE(mtk_custom_bindings);
                               ^
../drivers/pinctrl/mediatek/pinctrl-moore.c: At top level:
../drivers/pinctrl/mediatek/pinctrl-moore.c:22:44: warning: 'mtk_custom_bindings' defined but not used [-Wunused-variable]
 static const struct pinconf_generic_params mtk_custom_bindings[] = {
                                            ^
cc1: some warnings being treated as errors
../scripts/Makefile.build:276: recipe for target 'drivers/pinctrl/mediatek/pinctrl-moore.o' failed
make[4]: *** [drivers/pinctrl/mediatek/pinctrl-moore.o] Error 1

Fixes: b5af33df50e9 ("pinctrl: mediatek: improve Kconfig dependencies")
Cc: stable@vger.kernel.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 1817786..a005cbc 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -45,12 +45,14 @@ config PINCTRL_MT2701
 config PINCTRL_MT7623
 	bool "Mediatek MT7623 pin control with generic binding"
 	depends on MACH_MT7623 || COMPILE_TEST
+	depends on OF
 	default MACH_MT7623
 	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT7629
 	bool "Mediatek MT7629 pin control"
 	depends on MACH_MT7629 || COMPILE_TEST
+	depends on OF
 	default MACH_MT7629
 	select PINCTRL_MTK_MOORE
 
@@ -92,6 +94,7 @@ config PINCTRL_MT6797
 
 config PINCTRL_MT7622
 	bool "MediaTek MT7622 pin control"
+	depends on OF
 	depends on ARM64 || COMPILE_TEST
 	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK_MOORE
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
