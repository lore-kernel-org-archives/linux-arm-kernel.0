Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE50C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9719E2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s2XM+99c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a5w3L0we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9719E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HWMTLqGPkkU1vrSLcalapBUcmlLFhvwGh8jJG663+sA=; b=s2XM+99c/S8OtJ
	DCxVSaOLOGPqaQdmLMvodbILU/njFfGss5HvNPNLz2amhEjv0nLW5EsmLMgEg1FKscxuPRlQ0Dotx
	Q7g3C4GqHiP5lhRR0qmtDERE6d6XpUD3OWTUBpZn9hWvG/eCu4PVAbigOcg4WfmR2XlhCMEgDrOHS
	MzjLgCkETf93HwqETjvNtVXHUy74KAc4XztBzTOwuNsmn92BZcGe/JZpKw6KGm0XkzguBZhr5LeV4
	KCudYTFEJbepEz+XF0aACR01ASO4GYpCeBbB+Pq0PAR2sDD711xVeJTsDjxCyPI3ubrE8AG6buFHs
	6BlwlnhTgtjrc9hoZfOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf34O-0006uV-35; Thu, 03 Jan 2019 13:29:56 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf34I-0006sa-Rg
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 13:29:53 +0000
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; d="scan'208";a="22165264"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 03 Jan 2019 06:29:48 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 3 Jan 2019 06:30:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ReJdSPRLur42ChEef64TCSjKzn6BBELfoqH8OV4ZGY=;
 b=a5w3L0wewzlZdPrqHyKIuaoyDN+Zz5/gNKrm7E61ISs5gXaUCk47gLXK0VW/+V7H5H1mIMNXNnU4DhMEE8+XtLwvhPdjCwJsomwaR6/OEiBwWuYHLkauEttLwr9rYhQe3u/27HnXVd6ljePfPa0ky3/zy1Bm7mXPyo1UsAajjU0=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:29:45 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:29:45 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <corbet@lwn.net>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Topic: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Index: AQHUo2hjF9SHYVC+/UyvQjeBLKSGNw==
Date: Thu, 3 Jan 2019 13:29:44 +0000
Message-ID: <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1984;
 6:roNmuBqogtV9npHEKNXjkWKuwI8I6moAwwHXsBp0uwYK/tJ1grVXvqe2YSCya8lb+58s7D3+uiH6LOTu3+32SSuxalYt1plsnqqpDStgxU+TVMKLUKbTh+GzENwGrYqKq4jjh20b0wBjq3+7j0yBTkGUJ1auOyeltqwH4MeEvNvEOnIdHu68W7RUS8okegeo2uNy4SPy8IirMbNTYY68nRwRT0XF6JRO7FlkEH+hUJTDbRRRDKw7Ju8SobY03OuNY32bA/IW5Wl6+W3meUACOukTiiAE/4ozmpUxmBzyIafLBIScLNVPgYTUwugl7VeZiXTM2cdy/zjo16bXmjcuWDLgf6n/sjgIH05DgUJLN+a9MUsUsUubAXZOBtASKnN1UybUsqrsbA6hkF30wK6OEXNpMuMZG01wGjGdQdAydCRs9zbHqP9O2co6JXRCreAB5v04sLEitKhbG6xahlxWsQ==;
 5:q/IhCGv9jRQh3tJ3unHqwTFRWHXYmngqoRuSnz0PlBXw8G7qCIrMbYhPdWYlodFEDwViL7SOAhtkDd1n9B+R7GzQOdLpm7T9brvS6YnVpWVdTYQ8st6xa1Xk020f2Mx3g27JFsoltohWotdrc0/y676v/cW0asFFnBUXoQXHWq7jtR8+DQDkZNuPGS2wG82t4dPhxUE6TD/t9aKBwSVkVA==;
 7:deenA9spZLekTVGgh/p5phBnm+j/vBtzrgSSDzq01A3NvuXfECe4pel+eMmQj43+4KGwMtTBW54fLgD4earZ32+Typb6cj4xCRJZJ2DU0aSwwZ43eCXZzmMZeXdoGdChNyxRhAer2lg+TI2orU4Odg==
x-ms-office365-filtering-correlation-id: 696837e1-99fd-49fd-ffc6-08d6717f861b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1984; 
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB198442C0FBF537751B80C84A878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR11MB1984; BCL:0; PCL:0; RULEID:; SRVR:MWHPR11MB1984; 
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(11346002)(71190400001)(6486002)(2501003)(72206003)(14454004)(4744004)(2616005)(476003)(97736004)(446003)(5660300001)(478600001)(316002)(6636002)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(76176011)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1984;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZzJeUHOotROsYl4YdxgXKlYzHf29pnJ/jlZ31tO0RADhprufvMTjY/NHpMc4TphL6NffTT2h9rX28DBeDIbGyrkwFWuphwQvj8YS/U/qUyrwJkAjyC5POO58LPBcnnyeW3NWP4keWXTxofhwBtRzDkdb8d9E3QdlVU0HpA/TMMAfW9giIbgHlYxw1JM602WrNRn4S6zOoO24MRphZjasIXzR2wJ9jC2ZDEckKKJ2SCexfgZisX8RwPBiePNYDr0v3x17WoByDgsbGYpbZ6mQ6dMW4FJnTbaobvdDcpJ3bWj2U0E3/nZIOE2pki7g8or2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 696837e1-99fd-49fd-ffc6-08d6717f861b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:29:44.8304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_052950_953767_22C099D5 
X-CRM114-Status: GOOD (  22.52  )
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
Cc: linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add basic PWM modes: normal and complementary. These modes should
differentiate the single output PWM channels from two outputs PWM
channels. These modes could be set as follow:
1. PWM channels with one output per channel:
- normal mode
2. PWM channels with two outputs per channel:
- normal mode
- complementary mode
Since users could use a PWM channel with two output as one output PWM
channel, the PWM normal mode is allowed to be set for PWM channels with
two outputs; in fact PWM normal mode should be supported by all PWMs.

The PWM capabilities were implemented per PWM channel. Every PWM controller
will register a function to get PWM capabilities. If this is not explicitly
set by the driver a default function will be used to retrieve the PWM
capabilities (in this case the PWM capabilities will contain only PWM
normal mode). To retrieve capabilities the pwm_get_caps() function could
be used.

Every PWM channel have associated a mode in the PWM state. Proper
support was added to get/set PWM mode. Only modes supported by PWM channel
could be set.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  |  91 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pwm/sysfs.c |  61 ++++++++++++++++++++++++++++++
 include/linux/pwm.h | 104 +++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 222 insertions(+), 34 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..eb444ee8d486 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -249,6 +249,88 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
 	return false;
 }
 
+static int pwm_get_default_caps(struct pwm_caps *caps)
+{
+	static const struct pwm_caps default_caps = {
+		.modes_msk = PWM_MODE_BIT(NORMAL),
+	};
+
+	if (!caps)
+		return -EINVAL;
+
+	*caps = default_caps;
+
+	return 0;
+}
+
+/**
+ * pwm_get_caps() - get PWM capabilities of a PWM device
+ * @pwm: PWM device to get the capabilities for
+ * @caps: returned capabilities
+ *
+ * Returns: 0 on success or a negative error code on failure
+ */
+int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps)
+{
+	if (!pwm || !caps)
+		return -EINVAL;
+
+	if (pwm->chip->ops->get_caps)
+		return pwm->chip->ops->get_caps(pwm->chip, pwm, caps);
+
+	return pwm_get_default_caps(caps);
+}
+EXPORT_SYMBOL_GPL(pwm_get_caps);
+
+/**
+ * pwm_get_default_modebit() - get the default mode for PWM (as a bit mask)
+ * @pwm: PWM device to get the default mode for
+ *
+ * Returns: the default PWM mode (as a bit mask) for PWM device
+ */
+unsigned long pwm_get_default_modebit(const struct pwm_device *pwm)
+{
+	struct pwm_caps caps;
+
+	if (pwm_get_caps(pwm, &caps))
+		return PWM_MODE_BIT(NORMAL);
+
+	return BIT(ffs(caps.modes_msk) - 1);
+}
+EXPORT_SYMBOL_GPL(pwm_get_default_modebit);
+
+/**
+ * pwm_supports_mode() - check if PWM mode is supported by PWM device
+ * @pwm: PWM device
+ * @modebit: PWM mode bit mask to be checked (see PWM_MODE_BIT())
+ *
+ * Returns: true if PWM mode is supported, false otherwise
+ */
+bool pwm_supports_mode(const struct pwm_device *pwm, unsigned long modebit)
+{
+	struct pwm_caps caps;
+
+	if (!pwm || !modebit)
+		return false;
+
+	if (hweight_long(modebit) != 1 || ffs(modebit) - 1 >= PWM_MODE_CNT)
+		return false;
+
+	if (pwm_get_caps(pwm, &caps))
+		return false;
+
+	return !!(caps.modes_msk & modebit);
+}
+EXPORT_SYMBOL_GPL(pwm_supports_mode);
+
+const char *pwm_get_mode_name(unsigned long modebit)
+{
+	if (modebit == PWM_MODE_BIT(COMPLEMENTARY))
+		return "complementary";
+
+	return "normal";
+}
+
 /**
  * pwmchip_add_with_polarity() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -294,6 +376,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
+		pwm->state.modebit = pwm_get_default_modebit(pwm);
 
 		if (chip->ops->get_state)
 			chip->ops->get_state(chip, pwm, &pwm->state);
@@ -469,7 +552,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	int err;
 
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_cycle > state->period ||
+	    !pwm_supports_mode(pwm, state->modebit))
 		return -EINVAL;
 
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
@@ -530,6 +614,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 
 			pwm->state.enabled = state->enabled;
 		}
+
+		pwm->state.modebit = state->modebit;
 	}
 
 	return 0;
@@ -579,6 +665,8 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	pwm_get_args(pwm, &pargs);
 	pwm_get_state(pwm, &state);
 
+	state.modebit = pwm_get_default_modebit(pwm);
+
 	/*
 	 * If the current period is zero it means that either the PWM driver
 	 * does not support initial state retrieval or the PWM has not yet
@@ -999,6 +1087,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		seq_printf(s, " duty: %u ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
+		seq_printf(s, " mode: %s", pwm_get_mode_name(state.modebit));
 
 		seq_puts(s, "\n");
 	}
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index ceb233dd6048..7865fbafbeb4 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -223,11 +223,71 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t mode_show(struct device *child,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_state state;
+	unsigned long modebit;
+	enum pwm_mode mode;
+	int len = 0;
+
+	pwm_get_state(pwm, &state);
+
+	for (mode = PWM_MODE_NORMAL; mode < PWM_MODE_CNT; mode++) {
+		modebit = BIT(mode);
+		if (pwm_supports_mode(pwm, modebit)) {
+			if (state.modebit == modebit)
+				len += scnprintf(buf + len,
+						 PAGE_SIZE - len, "[%s] ",
+						 pwm_get_mode_name(modebit));
+			else
+				len += scnprintf(buf + len,
+						 PAGE_SIZE - len, "%s ",
+						 pwm_get_mode_name(modebit));
+		}
+	}
+
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	return len;
+}
+
+static ssize_t mode_store(struct device *child,
+			  struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	unsigned long modebit;
+	enum pwm_mode mode;
+	int ret;
+
+	for (mode = PWM_MODE_NORMAL; mode < PWM_MODE_CNT; mode++) {
+		modebit = BIT(mode);
+		if (sysfs_streq(buf, pwm_get_mode_name(modebit)))
+			break;
+	}
+
+	if (mode == PWM_MODE_CNT)
+		return -EINVAL;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.modebit = modebit;
+	ret = pwm_apply_state(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
+static DEVICE_ATTR_RW(mode);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
@@ -235,6 +295,7 @@ static struct attribute *pwm_attrs[] = {
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_mode.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d5199b507d79..3d89343bc405 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -26,6 +26,28 @@ enum pwm_polarity {
 };
 
 /**
+ * PWM modes capabilities
+ * @PWM_MODE_NORMAL: PWM has one output
+ * @PWM_MODE_COMPLEMENTARY: PWM has 2 outputs with opposite polarities
+ * @PWM_MODE_CNT: PWM modes count
+ */
+enum pwm_mode {
+	PWM_MODE_NORMAL,
+	PWM_MODE_COMPLEMENTARY,
+	PWM_MODE_CNT,
+};
+
+#define PWM_MODE_BIT(name)		BIT(PWM_MODE_##name)
+
+/**
+ * struct pwm_caps - PWM capabilities
+ * @modes_msk: bitmask of supported modes (see PWM_MODE_*)
+ */
+struct pwm_caps {
+	unsigned long modes_msk;
+};
+
+/**
  * struct pwm_args - board-dependent PWM arguments
  * @period: reference period
  * @polarity: reference polarity
@@ -53,12 +75,14 @@ enum {
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
+ * @modebit: PWM mode bit
  * @enabled: PWM enabled status
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	unsigned long modebit;
 	bool enabled;
 };
 
@@ -151,39 +175,6 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
 }
 
 /**
- * pwm_init_state() - prepare a new state to be applied with pwm_apply_state()
- * @pwm: PWM device
- * @state: state to fill with the prepared PWM state
- *
- * This functions prepares a state that can later be tweaked and applied
- * to the PWM device with pwm_apply_state(). This is a convenient function
- * that first retrieves the current PWM state and the replaces the period
- * and polarity fields with the reference values defined in pwm->args.
- * Once the function returns, you can adjust the ->enabled and ->duty_cycle
- * fields according to your needs before calling pwm_apply_state().
- *
- * ->duty_cycle is initially set to zero to avoid cases where the current
- * ->duty_cycle value exceed the pwm_args->period one, which would trigger
- * an error if the user calls pwm_apply_state() without adjusting ->duty_cycle
- * first.
- */
-static inline void pwm_init_state(const struct pwm_device *pwm,
-				  struct pwm_state *state)
-{
-	struct pwm_args args;
-
-	/* First get the current state. */
-	pwm_get_state(pwm, state);
-
-	/* Then fill it with the reference config */
-	pwm_get_args(pwm, &args);
-
-	state->period = args.period;
-	state->polarity = args.polarity;
-	state->duty_cycle = 0;
-}
-
-/**
  * pwm_get_relative_duty_cycle() - Get a relative duty cycle value
  * @state: PWM state to extract the duty cycle from
  * @scale: target scale of the relative duty cycle
@@ -254,6 +245,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
+ * @get_caps: get PWM capabilities.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -272,6 +264,8 @@ struct pwm_ops {
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
+	int (*get_caps)(const struct pwm_chip *chip,
+			const struct pwm_device *pwm, struct pwm_caps *caps);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
 #endif
@@ -402,6 +396,10 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
 
+int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps);
+bool pwm_supports_mode(const struct pwm_device *pwm, unsigned long modebit);
+unsigned long pwm_get_default_modebit(const struct pwm_device *pwm);
+const char *pwm_get_mode_name(unsigned long modebit);
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
@@ -488,6 +486,11 @@ static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline unsigned long pwm_get_default_modebit(const struct pwm_device *pwm)
+{
+	return 0;
+}
+
 static inline struct pwm_device *pwm_get(struct device *dev,
 					 const char *consumer)
 {
@@ -522,6 +525,40 @@ static inline void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
 }
 #endif
 
+/**
+ * pwm_init_state() - prepare a new state to be applied with pwm_apply_state()
+ * @pwm: PWM device
+ * @state: state to fill with the prepared PWM state
+ *
+ * This functions prepares a state that can later be tweaked and applied
+ * to the PWM device with pwm_apply_state(). This is a convenient function
+ * that first retrieves the current PWM state and the replaces the period
+ * and polarity fields with the reference values defined in pwm->args.
+ * Once the function returns, you can adjust the ->enabled and ->duty_cycle
+ * fields according to your needs before calling pwm_apply_state().
+ *
+ * ->duty_cycle is initially set to zero to avoid cases where the current
+ * ->duty_cycle value exceed the pwm_args->period one, which would trigger
+ * an error if the user calls pwm_apply_state() without adjusting ->duty_cycle
+ * first.
+ */
+static inline void pwm_init_state(const struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pwm_args args;
+
+	/* First get the current state. */
+	pwm_get_state(pwm, state);
+
+	/* Then fill it with the reference config */
+	pwm_get_args(pwm, &args);
+
+	state->period = args.period;
+	state->polarity = args.polarity;
+	state->duty_cycle = 0;
+	state->modebit = pwm_get_default_modebit(pwm);
+}
+
 static inline void pwm_apply_args(struct pwm_device *pwm)
 {
 	struct pwm_state state = { };
@@ -550,6 +587,7 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	state.enabled = false;
 	state.polarity = pwm->args.polarity;
 	state.period = pwm->args.period;
+	state.modebit = pwm_get_default_modebit(pwm);
 
 	pwm_apply_state(pwm, &state);
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
