Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A47C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:04:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0F22133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QKuyCVhA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qznG7HxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0F22133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yv+nVZERql8+baExA2Kut8xC8BD2U3uUjOkpk1KDuNA=; b=QKuyCVhAyo6onq
	odB/IVyYqYlFmPXjJad1S0OMNfmmDqDTQY1akJX5IYaJjplgUeJs9iF9q6DSKnw9RhwDvEu2MFHZo
	hOazkb2bldup2r0aBbgCwBDOCN/C3v3342CB+8XzadaazxXfTHbdUCE1RLfHu06MkjGpb1wM4hTMt
	NZpJM6urjrsqZpIZT0oHwU0//if+Rzvrp3T3ohxD3xOkXShfg7eVQmFcSYuDF6JmwLrXiX4/fHB07
	HNtHV7oJLIUROjH6hWfBzyayVeFP8pWSLYwccR/wJGm+5f+WurZfzaNAjd8ZbbaUIbGH5bH4aIw9C
	l/NalQwh+wS0NPXG4d1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtV5-0001mz-Jh; Mon, 17 Dec 2018 14:04:03 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtUU-000194-GA
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:03:38 +0000
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; d="scan'208";a="25348228"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 17 Dec 2018 07:03:13 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 17 Dec 2018 07:03:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BMkSmX/0HT0VNAH+rqVTriEboRLGFCp1YYtHWxHBGw=;
 b=qznG7HxO5g4n3M7sQV4Y6WpRke+KRQxVYgk6+tDF44F/Q2EHqUQsemL1x31HA6hjbJlJDB/Mh1MSSFoeBkUl9V4ZN9Vik7Ow/2maCsKYjVZk4D9DKcSOmsjyKhu4MpC3r8msbMd4PEA+TlvWuBZx69IWQgyfa8rSFkL77U8/ygc=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0504.namprd11.prod.outlook.com (10.163.158.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:03:10 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:03:10 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <corbet@lwn.net>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <robh@kernel.org>
Subject: [PATCH v6 1/6] pwm: extend PWM framework with PWM modes
Thread-Topic: [PATCH v6 1/6] pwm: extend PWM framework with PWM modes
Thread-Index: AQHUlhE+GrlwQCMgUU2o1NRWZN9iBA==
Date: Mon, 17 Dec 2018 14:03:10 +0000
Message-ID: <1545055368-23338-2-git-send-email-claudiu.beznea@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::34) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0504;
 6:PmI476miHhZIZyCgVQAGQdaQHi8tCF8irHmIfqurGjFRHKPrFU8uzAUXbI/tah1h7SQeybQvv6/Iwt1jhL8dFo47RQEYdlQx2gkNsyK8sF0d3u98/Ii4MaTLv0FhJUH9T+vIE61m9mIVGf0W3MBdTq7nh15BFkJf1BaF/wakV4srditsG0s2Q+QgTCzsz2z+UIQ85V0Ks1L8dO8JwBYQcqK/X/Q06z3kqUuUsJ6h+BWsJXdUVhhAFL3Zg2t1fYcvnImo1Fx4K80dZlQPrG9fNWaJrMFfqmLoDVH/bIZ/3se60KxJKc9H+z5+u5/j1uyBi2/VMG4Jxyt/WpqUUagEdQ+vRr/HP9n60LUJSbdAdsx4I18dMSdhVDrVvCr0FgB0/n0Jpc3mjwL0ZJPxPFa8h/QciSrIJDpHMhsdkYTSUjSqFYGMaijHFuxrr4Lhq77n1Imkbv3O/j4gfyRRYf2xlA==;
 5:VD/gBq9dnSoEAnOI1zUElBuLPfhFuO81EqD44GUm+iyZ8v9Np3DCkn717l7H71k/UbOezYtyX3SF1e5GX5irRisqFQuf6C6ifLOxDnTDTOI3Ct2aMtGOFdJBXxog4omh6voyKkQznyogoul0SoB/pbI4ppscFElR2xWb3l91YK0=;
 7:aQxhqNjKABBAftbFphjruCuVH1LFlYcBzplVcDD9ka1+TBRzc0OTXGvdjlTEnBwqylislQajL+pF2uj5iCWwNn66bnHN7zrfCE55kvOAWhtE7vPFDHj3jNW+5Ehllunr0LSUAKmrGld8kFgC/YjTAg==
x-ms-office365-filtering-correlation-id: 17428bbd-cee4-4631-20de-08d66428608a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0504; 
x-ms-traffictypediagnostic: BY2PR11MB0504:
x-microsoft-antispam-prvs: <BY2PR11MB050406FAD123C428B3505AC187BC0@BY2PR11MB0504.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0504; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0504; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(4744004)(52116002)(476003)(186003)(106356001)(14454004)(5660300001)(2906002)(97736004)(99286004)(25786009)(86362001)(11346002)(2616005)(71200400001)(71190400001)(6436002)(6486002)(3846002)(6116002)(316002)(110136005)(54906003)(66066001)(486006)(26005)(6512007)(8936002)(81166006)(8676002)(446003)(36756003)(105586002)(102836004)(53936002)(72206003)(81156014)(305945005)(6506007)(76176011)(386003)(68736007)(39060400002)(478600001)(107886003)(7736002)(14444005)(256004)(4326008)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0504;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p1sx3MR5qCHcTZIYqtfqvIJQnJXNDfXdu+9XCqq4NISFXeBTsdF/mJK7ZQPtJ0xdSxSYM2nJcm/8OyKDg5RjX6UD8PkB4YrXL54XN2DgCosHjLws0v2WEXiOaNQSqyB3/iPqJ4GEedFch1gshRa1G/k+ZtDhM+4oPxdaBWrg1Tzoqkhp/BroFcdWEaW+OW5dJnV5xWxsmCfD1XgS9/XE4hNnj/qsCXqaAlk92XnT8GnK6ZULaTDszXVrOWGa15HaLlNq8UM83/MNqOm9CWQBl1A3/r7LNUCfCTGt46yCtA3grWbrZhqkU5YqS3OArl5n
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17428bbd-cee4-4631-20de-08d66428608a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:03:10.7474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0504
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_060326_767647_E8DD0473 
X-CRM114-Status: GOOD (  22.04  )
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
 drivers/pwm/core.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pwm/sysfs.c | 61 +++++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 35 +++++++++++++++++++++
 3 files changed, 186 insertions(+), 1 deletion(-)

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
index 56518adc31dd..abe189d891af 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -10,6 +10,9 @@ struct pwm_capture;
 struct seq_file;
 
 struct pwm_chip;
+struct pwm_device;
+
+unsigned long pwm_get_default_modebit(const struct pwm_device *pwm);
 
 /**
  * enum pwm_polarity - polarity of a PWM signal
@@ -26,6 +29,28 @@ enum pwm_polarity {
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
@@ -53,12 +78,14 @@ enum {
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
 
@@ -181,6 +208,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	state->period = args.period;
 	state->polarity = args.polarity;
 	state->duty_cycle = 0;
+	state->modebit = pwm_get_default_modebit(pwm);
 }
 
 /**
@@ -254,6 +282,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
+ * @get_caps: get PWM capabilities.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -272,6 +301,8 @@ struct pwm_ops {
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
+	int (*get_caps)(const struct pwm_chip *chip,
+			const struct pwm_device *pwm, struct pwm_caps *caps);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
 #endif
@@ -438,6 +469,9 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
 
+int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps);
+bool pwm_supports_mode(const struct pwm_device *pwm, unsigned long modebit);
+const char *pwm_get_mode_name(unsigned long modebit);
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
@@ -592,6 +626,7 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
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
