Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3106AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:05:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E314A205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f7a75PaE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="xDwT03z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E314A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:From:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=miCOaWxSkMPDb4nDBmTZ0zsYYk6lK0oFnl801mrlT1s=; b=f7a75PaEKGjrW0
	SpJjs2cXaVUodptAufGKUDX731WrjShGjCHYbDa53g3Rx6djYu2DaBPaKFojscWBsExO2IsM2ob7k
	03GTAwLfZjuz66o4S1IDN/wt+4TX+OtG7d7rfIp1p6Xkah57DFa5Pu5b8s1AYAHZQ7whzmNlwhDKe
	3YSJCMx62p+qq+43HWqyNoDp/mCHA4XJcvEuVHkVzI/0TuGWSGskJncjkB4rO612ebih2M/HuGZ87
	xrl3ZO6Z3BK4gMPzhc5BNcpshoHkKez9sLR5AS6fscIuGKkBxCuewAi5wR4tGPY6Yg7YlP1AUkIkA
	k7HHDjeFU/GRbkDAH9Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjALo-0000M0-Mb; Mon, 14 Jan 2019 22:04:56 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjALk-0000LG-Pd
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 22:04:55 +0000
Received: by mail-wr1-x443.google.com with SMTP id j2so730839wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 14:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernelci-org.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:mime-version:content-transfer-encoding:subject:to
 :from:cc; bh=hF9qLsI3SRaBbdsdd3/RS76FOn+3KAeXTg93zaoHE0I=;
 b=xDwT03z1r7xT/Rz8HLo0gHJmB2mp5Xs/OgsBymtxYszR7c+02YxutiJJPbhK1Q41SB
 qxkBt4Q0LAY4H3oNjrw6j1UsC8DnkZzvpUJc8bUTadN7KsrKpoIjEIlD6Egd2mh9U3bd
 Ih76oCkWvMo0I3DavTz2LsWZK5QJZR2+aGv3aGC7lIUM6JA8IjD+K009d6GSs1CRgEAj
 EhzkkzpXsgLXNl+uM2ksYvz5VQIObexoYW2M1TOL6VK8mWpQOF83PBK/27428/nd6IqJ
 0DlJ1lBLbXstAYTyUP1LJ53f6uxW4TFDyX0ojUvfiNMTUZULxomGDqq17ItZVJfzR4gd
 E7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version
 :content-transfer-encoding:subject:to:from:cc;
 bh=hF9qLsI3SRaBbdsdd3/RS76FOn+3KAeXTg93zaoHE0I=;
 b=FnHaQN7A1wMe4ZtSZpoyb+y4lMeKL80E97aGeSLa4JugqfwRCYHsKWJqT3ggUY2U2B
 Wtdj7gsV45It+BqxBNOrqlQYNxQ/CTR/ZvvRglUuSoCJ4xW9iLx1zVjQY+PoNtwPzjKX
 edaTRG+mccmhqeivAdGGwJFxYIqFmdhTq+GHMNxW/FXtUVhnCg6Ns0kgCPwkW+jNV2O2
 B6S5JFNQITThQoOaTQvxCZMOX7RDaglUK4tonkYgp3j8JnAqDK94fEE8+V6B6UU0/YJy
 PBnipNEP6JCekxY5bzyI7w2SCoztCFXwNNLHbArxSL+BGi/1YkPU4GZmQILgL743Zh6r
 85EA==
X-Gm-Message-State: AJcUukdlB3xnvWPANhOCf5SizMzeEjmucA8vAoqJHyEOodHkqimHgArH
 3whTV39H+rmev6QEJpac6pjCww==
X-Google-Smtp-Source: ALg8bN6EPv9AVvOtzg6cE5TCLahT2zulAZ8rt8AdbupteD8/aR7SBPewCwPQl6C+QI/2gYC8e2qpkQ==
X-Received: by 2002:a5d:46cd:: with SMTP id g13mr458565wrs.49.1547503490659;
 Mon, 14 Jan 2019 14:04:50 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
 by smtp.gmail.com with ESMTPSA id m4sm29756527wmi.3.2019.01.14.14.04.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 14:04:49 -0800 (PST)
Message-ID: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com>
Date: Mon, 14 Jan 2019 14:04:49 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: broonie-regulator
X-Kernelci-Branch: for-next
X-Kernelci-Kernel: v5.0-rc2-20-g61b67608c6b9
Subject: broonie-regulator/for-next boot bisection: v5.0-rc2-20-g61b67608c6b9
 on meson-gxl-s905x-libretech-cc
To: Mark Brown <broonie@kernel.org>, tomeu.vizoso@collabora.com,
 guillaume.tucker@collabora.com, Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
 enric.balletbo@collabora.com
From: "kernelci.org bot" <bot@kernelci.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_140452_891734_6001B333 
X-CRM114-Status: GOOD (  23.05  )
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
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Philipp Zabel <philipp.zabel@gmail.com>,
 Paul Parsons <lost.distance@yahoo.com>, Russell King <linux@armlinux.org.uk>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

broonie-regulator/for-next boot bisection: v5.0-rc2-20-g61b67608c6b9 on meson-gxl-s905x-libretech-cc

Summary:
  Start:      61b67608c6b9 Merge branch 'regulator-5.1' into regulator-next
  Details:    https://kernelci.org/boot/id/5c3caf0459b514eca66eddf2
  Plain log:  https://storage.kernelci.org//broonie-regulator/for-next/v5.0-rc2-20-g61b67608c6b9/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/lab-baylibre/boot-meson-gxl-s905x-libretech-cc.txt
  HTML log:   https://storage.kernelci.org//broonie-regulator/for-next/v5.0-rc2-20-g61b67608c6b9/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/lab-baylibre/boot-meson-gxl-s905x-libretech-cc.html
  Result:     fe665efe6554 regulator: gpio: Convert to use descriptors

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       broonie-regulator
  URL:        http://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
  Branch:     for-next
  Target:     meson-gxl-s905x-libretech-cc
  CPU arch:   arm64
  Lab:        lab-baylibre
  Config:     defconfig+CONFIG_RANDOMIZE_BASE=y
  Test suite: boot

Breaking commit found:

-------------------------------------------------------------------------------
commit fe665efe6554eb80ff301ba9765d497f5f24abb6
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Mon Jan 7 17:27:42 2019 +0100

    regulator: gpio: Convert to use descriptors
    
    This converts the GPIO regulator driver to use decriptors only.
    
    We have to let go of the array gpio handling: the fetched descriptors
    are handled individually anyway, and the array retrieveal function
    does not make it possible to retrieve each GPIO descriptor with
    unique flags. Instead get them one by one.
    
    We request the "enable" GPIO separately as before, and make sure
    that this line is requested as nonexclusive since enable lines can
    be shared and the regulator core expects this.
    
    Most users of the GPIO regulator are using device tree.
    
    There are two boards in the kernel using the gpio regulator from a
    non-devicetree path: PXA hx4700 and magician. Make sure to switch
    these over to use descriptors as well.
    
    Cc: Philipp Zabel <p.zabel@pengutronix.de> # Magician
    Cc: Petr Cvek <petr.cvek@tul.cz> # Magician
    Cc: Robert Jarzmik <robert.jarzmik@free.fr> # PXA
    Cc: Paul Parsons <lost.distance@yahoo.com> # hx4700
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index b79b757fdd41..51d38d5e776a 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -702,9 +703,7 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies      = bq24022_consumers,
 };
 
-static struct gpio bq24022_gpios[] = {
-	{ GPIO96_HX4700_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+static enum gpiod_flags bq24022_gpiod_gflags[] = { GPIOD_OUT_LOW };
 
 static struct gpio_regulator_state bq24022_states[] = {
 	{ .value = 100000, .gpios = (0 << 0) },
@@ -714,12 +713,10 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name = "bq24022",
 
-	.enable_gpio = GPIO72_HX4700_BQ24022_nCHARGE_EN,
-	.enable_high = 0,
 	.enabled_at_boot = 0,
 
-	.gpios = bq24022_gpios,
-	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
+	.gflags = bq24022_gpiod_gflags,
+	.ngpios = ARRAY_SIZE(bq24022_gpiod_gflags),
 
 	.states = bq24022_states,
 	.nr_states = ARRAY_SIZE(bq24022_states),
@@ -736,6 +733,17 @@ static struct platform_device bq24022 = {
 	},
 };
 
+static struct gpiod_lookup_table bq24022_gpiod_table = {
+	.dev_id = "gpio-regulator",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO96_HX4700_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO72_HX4700_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * StrataFlash
  */
@@ -878,6 +886,7 @@ static void __init hx4700_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
 
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 08b079653c3f..6538a7c0e504 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -645,9 +645,8 @@ static struct regulator_init_data bq24022_init_data = {
 	.consumer_supplies	= bq24022_consumers,
 };
 
-static struct gpio bq24022_gpios[] = {
-	{ EGPIO_MAGICIAN_BQ24022_ISET2, GPIOF_OUT_INIT_LOW, "bq24022_iset2" },
-};
+
+static enum gpiod_flags bq24022_gpiod_gflags[] = { GPIOD_OUT_LOW };
 
 static struct gpio_regulator_state bq24022_states[] = {
 	{ .value = 100000, .gpios = (0 << 0) },
@@ -657,12 +656,10 @@ static struct gpio_regulator_state bq24022_states[] = {
 static struct gpio_regulator_config bq24022_info = {
 	.supply_name		= "bq24022",
 
-	.enable_gpio		= GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
-	.enable_high		= 0,
 	.enabled_at_boot	= 1,
 
-	.gpios			= bq24022_gpios,
-	.nr_gpios		= ARRAY_SIZE(bq24022_gpios),
+	.gflags = bq24022_gpiod_gflags,
+	.ngpios = ARRAY_SIZE(bq24022_gpiod_gflags),
 
 	.states			= bq24022_states,
 	.nr_states		= ARRAY_SIZE(bq24022_states),
@@ -679,6 +676,17 @@ static struct platform_device bq24022 = {
 	},
 };
 
+static struct gpiod_lookup_table bq24022_gpiod_table = {
+	.dev_id = "gpio-regulator",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", EGPIO_MAGICIAN_BQ24022_ISET2,
+			    NULL, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
+			    "enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /*
  * fixed regulator for ads7846
  */
@@ -1027,6 +1035,7 @@ static void __init magician_init(void)
 	regulator_register_always_on(0, "power", pwm_backlight_supply,
 		ARRAY_SIZE(pwm_backlight_supply), 5000000);
 
+	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 }
 
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index b2f5ec4f658a..0cec163200c8 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -30,16 +30,15 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/gpio-regulator.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 struct gpio_regulator_data {
 	struct regulator_desc desc;
 	struct regulator_dev *dev;
 
-	struct gpio *gpios;
+	struct gpio_desc **gpiods;
 	int nr_gpios;
 
 	struct gpio_regulator_state *states;
@@ -82,7 +81,7 @@ static int gpio_regulator_set_voltage(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state = target;
 
@@ -119,7 +118,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 
 	for (ptr = 0; ptr < data->nr_gpios; ptr++) {
 		state = (target & (1 << ptr)) >> ptr;
-		gpio_set_value_cansleep(data->gpios[ptr].gpio, state);
+		gpiod_set_value_cansleep(data->gpiods[ptr], state);
 	}
 	data->state = target;
 
@@ -138,7 +137,8 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 {
 	struct gpio_regulator_config *config;
 	const char *regtype;
-	int proplen, gpio, i;
+	int proplen, i;
+	int ngpios;
 	int ret;
 
 	config = devm_kzalloc(dev,
@@ -153,59 +153,36 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	config->supply_name = config->init_data->constraints.name;
 
-	if (of_property_read_bool(np, "enable-active-high"))
-		config->enable_high = true;
-
 	if (of_property_read_bool(np, "enable-at-boot"))
 		config->enabled_at_boot = true;
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	config->enable_gpio = of_get_named_gpio(np, "enable-gpio", 0);
-	if (config->enable_gpio < 0 && config->enable_gpio != -ENOENT)
-		return ERR_PTR(config->enable_gpio);
-
-	/* Fetch GPIOs. - optional property*/
-	ret = of_gpio_count(np);
-	if ((ret < 0) && (ret != -ENOENT))
-		return ERR_PTR(ret);
-
-	if (ret > 0) {
-		config->nr_gpios = ret;
-		config->gpios = devm_kcalloc(dev,
-					config->nr_gpios, sizeof(struct gpio),
-					GFP_KERNEL);
-		if (!config->gpios)
+	/* Fetch GPIO init levels */
+	ngpios = gpiod_count(dev, NULL);
+	if (ngpios > 0) {
+		config->gflags = devm_kzalloc(dev,
+					      sizeof(enum gpiod_flags)
+					      * ngpios,
+					      GFP_KERNEL);
+		if (!config->gflags)
 			return ERR_PTR(-ENOMEM);
 
-		proplen = of_property_count_u32_elems(np, "gpios-states");
-		/* optional property */
-		if (proplen < 0)
-			proplen = 0;
+		for (i = 0; i < ngpios; i++) {
+			u32 val;
 
-		if (proplen > 0 && proplen != config->nr_gpios) {
-			dev_warn(dev, "gpios <-> gpios-states mismatch\n");
-			proplen = 0;
-		}
+			ret = of_property_read_u32_index(np, "gpios-states", i,
+							 &val);
 
-		for (i = 0; i < config->nr_gpios; i++) {
-			gpio = of_get_named_gpio(np, "gpios", i);
-			if (gpio < 0) {
-				if (gpio != -ENOENT)
-					return ERR_PTR(gpio);
-				break;
-			}
-			config->gpios[i].gpio = gpio;
-			config->gpios[i].label = config->supply_name;
-			if (proplen > 0) {
-				of_property_read_u32_index(np, "gpios-states",
-							   i, &ret);
-				if (ret)
-					config->gpios[i].flags =
-							   GPIOF_OUT_INIT_HIGH;
-			}
+			/* Default to high per specification */
+			if (ret)
+				config->gflags[i] = GPIOD_OUT_HIGH;
+			else
+				config->gflags[i] =
+					val ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 		}
 	}
+	config->ngpios = ngpios;
 
 	/* Fetch states. */
 	proplen = of_property_count_u32_elems(np, "states");
@@ -255,7 +232,8 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg = { };
-	int ptr, ret, state;
+	enum gpiod_flags gflags;
+	int ptr, ret, state, i;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gpio_regulator_data),
 			       GFP_KERNEL);
@@ -275,26 +253,17 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (config->nr_gpios != 0) {
-		drvdata->gpios = kmemdup(config->gpios,
-					 config->nr_gpios * sizeof(struct gpio),
-					 GFP_KERNEL);
-		if (drvdata->gpios == NULL) {
-			dev_err(&pdev->dev, "Failed to allocate gpio data\n");
-			ret = -ENOMEM;
-			goto err_name;
-		}
-
-		drvdata->nr_gpios = config->nr_gpios;
-		ret = gpio_request_array(drvdata->gpios, drvdata->nr_gpios);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"Could not obtain regulator setting GPIOs: %d\n",
-					ret);
-			goto err_memgpio;
-		}
+	for (i = 0; i < config->ngpios; i++) {
+		drvdata->gpiods[i] = devm_gpiod_get_index(&pdev->dev,
+							  NULL,
+							  i,
+							  config->gflags[i]);
+		if (IS_ERR(drvdata->gpiods[i]))
+			return PTR_ERR(drvdata->gpiods[i]);
+		/* This is good to know */
+		gpiod_set_consumer_name(drvdata->gpiods[i], drvdata->desc.name);
 	}
+	drvdata->nr_gpios = config->ngpios;
 
 	drvdata->states = kmemdup(config->states,
 				  config->nr_states *
@@ -303,7 +272,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	if (drvdata->states == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate state data\n");
 		ret = -ENOMEM;
-		goto err_stategpio;
+		goto err_name;
 	}
 	drvdata->nr_states = config->nr_states;
 
@@ -330,7 +299,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	/* build initial state from gpio init data. */
 	state = 0;
 	for (ptr = 0; ptr < drvdata->nr_gpios; ptr++) {
-		if (config->gpios[ptr].flags & GPIOF_OUT_INIT_HIGH)
+		if (config->gflags[ptr] == GPIOD_OUT_HIGH)
 			state |= (1 << ptr);
 	}
 	drvdata->state = state;
@@ -340,21 +309,19 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
 
-	if (gpio_is_valid(config->enable_gpio)) {
-		cfg.ena_gpio = config->enable_gpio;
-		cfg.ena_gpio_initialized = true;
-	}
-	cfg.ena_gpio_invert = !config->enable_high;
-	if (config->enabled_at_boot) {
-		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
-		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
-	} else {
-		if (config->enable_high)
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_LOW;
-		else
-			cfg.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
+	/*
+	 * The signal will be inverted by the GPIO core if flagged so in the
+	 * decriptor.
+	 */
+	if (config->enabled_at_boot)
+		gflags = GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+	else
+		gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
+
+	cfg.ena_gpiod = gpiod_get_optional(&pdev->dev, "enable", gflags);
+	if (IS_ERR(cfg.ena_gpiod)) {
+		ret = PTR_ERR(cfg.ena_gpiod);
+		goto err_memstate;
 	}
 
 	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
@@ -370,10 +337,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 
 err_memstate:
 	kfree(drvdata->states);
-err_stategpio:
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-err_memgpio:
-	kfree(drvdata->gpios);
 err_name:
 	kfree(drvdata->desc.name);
 	return ret;
@@ -384,12 +347,7 @@ static int gpio_regulator_remove(struct platform_device *pdev)
 	struct gpio_regulator_data *drvdata = platform_get_drvdata(pdev);
 
 	regulator_unregister(drvdata->dev);
-
-	gpio_free_array(drvdata->gpios, drvdata->nr_gpios);
-
 	kfree(drvdata->states);
-	kfree(drvdata->gpios);
-
 	kfree(drvdata->desc.name);
 
 	return 0;
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regulator/gpio-regulator.h
index 19fbd267406d..49c407afb944 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -21,6 +21,8 @@
 #ifndef __REGULATOR_GPIO_H
 #define __REGULATOR_GPIO_H
 
+#include <linux/gpio/consumer.h>
+
 struct regulator_init_data;
 
 enum regulator_type;
@@ -53,9 +55,9 @@ struct gpio_regulator_state {
  *			This is used to keep the regulator at
  *			the default state
  * @startup_delay:	Start-up time in microseconds
- * @gpios:		Array containing the gpios needed to control
- *			the setting of the regulator
- * @nr_gpios:		Number of gpios
+ * @gflags:		Array of GPIO configuration flags for initial
+ *			states
+ * @ngpios:		Number of GPIOs and configurations available
  * @states:		Array of gpio_regulator_state entries describing
  *			the gpio state for specific voltages
  * @nr_states:		Number of states available
@@ -74,8 +76,8 @@ struct gpio_regulator_config {
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
 
-	struct gpio *gpios;
-	int nr_gpios;
+	enum gpiod_flags *gflags;
+	int ngpios;
 
 	struct gpio_regulator_state *states;
 	int nr_states;
-------------------------------------------------------------------------------


Git bisection log:

-------------------------------------------------------------------------------
git bisect start
# good: [1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8] Linux 5.0-rc2
git bisect good 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8
# bad: [61b67608c6b90e8a2abde5be31bb181f56849927] Merge branch 'regulator-5.1' into regulator-next
git bisect bad 61b67608c6b90e8a2abde5be31bb181f56849927
# bad: [fe665efe6554eb80ff301ba9765d497f5f24abb6] regulator: gpio: Convert to use descriptors
git bisect bad fe665efe6554eb80ff301ba9765d497f5f24abb6
# good: [08f0b14adc7c4fd5ef7ab2f4b7a62ed1b8216bbb] regulator: hi655x: Removed unused ctrl_regs field from struct hi655x_regulator
git bisect good 08f0b14adc7c4fd5ef7ab2f4b7a62ed1b8216bbb
# good: [67cc7ca316c4167cc5aca54b7f63a55de356d976] regulator: max14577: Remove redundant MODULE_ALIAS
git bisect good 67cc7ca316c4167cc5aca54b7f63a55de356d976
# good: [f01a7beb6791f1c419424c1a6958b7d0a289c974] regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting
git bisect good f01a7beb6791f1c419424c1a6958b7d0a289c974
# first bad commit: [fe665efe6554eb80ff301ba9765d497f5f24abb6] regulator: gpio: Convert to use descriptors
-------------------------------------------------------------------------------

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
