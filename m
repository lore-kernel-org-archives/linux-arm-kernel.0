Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:16:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FC6218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E7Fv2tXq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BZxyzHXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FC6218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DlZpkgs9fCByEA1xH+UhuR4Gf702pd3p8duLY1238O4=; b=E7Fv2tXqzfWT3n
	Trcj3D/Ue5d0/5FwDFXwib+atUDQ+VEqcNB/EH2lmnd9xEa29S8mggHVRdeDzzLDQJ0aghHXDPMJf
	D3BjCzYWyeyK8Bm+gbasDvtfxzxAhfa6u4Z1FeXPfhPSZM3NoWD2FdwsDcsT6KAgImg4CpX2xRvZ8
	DAPxdZR+DqDjutL/OG96PIqMgJmB3WAkTXrb4fFKVsKBuXciuQcS+LGmRzRNiW18FN4xBEvFNK8RF
	ey4t2R/D2+XxlcnI8FB08VJ8gI4EUGTJYLcgrdkWBA2C4ZhxUrLJCKdALjFlPE9XC6XsPjPMqJNLB
	HwhZdzTEdkqu5WhFQMJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvbIJ-0001eW-9y; Mon, 18 Feb 2019 05:16:43 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvbHY-0000fG-6T
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 05:15:59 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1I5Fhio122105;
 Sun, 17 Feb 2019 23:15:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550466943;
 bh=0aUHHaApbR+3xDaySxtegSDe8EZV9AyWVV4IazcrAmY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BZxyzHXZdN2X8olkURFFxX6o4daY0mCGYck6JL2D6i4/RAWPHWY9MKNGiEdD4iPkC
 XJUln05iNy98sz8rJoAGMJLCN8mMBqBunuDARRYyLO7Tr64oWqDYj1doazhI3MeE9i
 jVnKZ/IbrbftLBzkV1wxh9PWdAkiYbCWZUBZ8hQo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1I5FhiS058194
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 17 Feb 2019 23:15:43 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 17
 Feb 2019 23:15:42 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 17 Feb 2019 23:15:42 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1I5FbKh029067;
 Sun, 17 Feb 2019 23:15:40 -0600
From: Lokesh Vutla <lokeshvutla@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/4] firmware: ti_sci: (Dis)Allow for device exclusive
 permissions
Date: Mon, 18 Feb 2019 10:45:14 +0530
Message-ID: <20190218051517.9218-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190218051517.9218-1-lokeshvutla@ti.com>
References: <20190218051517.9218-1-lokeshvutla@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_211556_556032_F09E691D 
X-CRM114-Status: GOOD (  19.74  )
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
Cc: Lokesh Vutla <lokeshvutla@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sysfw provides an option for requesting exclusive access for a
device using the flags MSG_FLAG_DEVICE_EXCLUSIVE. Once a device
is requested from a host with this flag set, any request to this
device from a different host will be nacked by sysfw. Current tisci
driver enables this flag for every device requests. But this may not
be true for all the devices. So provide a separate command in driver
for exclusive and non-exclusive device requests.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/firmware/ti_sci.c              | 45 ++++++++++++++++++++++++--
 include/linux/soc/ti/ti_sci_protocol.h |  3 ++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 69ed1464175c..8c6f21ceb6f2 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -634,6 +634,7 @@ static int ti_sci_get_device_state(const struct ti_sci_handle *handle,
 
 /**
  * ti_sci_cmd_get_device() - command to request for device managed by TISCI
+ *			     that can be shared with other hosts.
  * @handle:	Pointer to TISCI handle as retrieved by *ti_sci_get_handle
  * @id:		Device Identifier
  *
@@ -641,11 +642,29 @@ static int ti_sci_get_device_state(const struct ti_sci_handle *handle,
  * usage count by balancing get_device with put_device. No refcounting is
  * managed by driver for that purpose.
  *
- * NOTE: The request is for exclusive access for the processor.
- *
  * Return: 0 if all went fine, else return appropriate error.
  */
 static int ti_sci_cmd_get_device(const struct ti_sci_handle *handle, u32 id)
+{
+	return ti_sci_set_device_state(handle, id, 0,
+				       MSG_DEVICE_SW_STATE_ON);
+}
+
+/**
+ * ti_sci_cmd_get_device_exclusive() - command to request for device managed by
+ *				       TISCI that is exclusively owned by the
+ *				       requesting host.
+ * @handle:	Pointer to TISCI handle as retrieved by *ti_sci_get_handle
+ * @id:		Device Identifier
+ *
+ * Request for the device - NOTE: the client MUST maintain integrity of
+ * usage count by balancing get_device with put_device. No refcounting is
+ * managed by driver for that purpose.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_get_device_exclusive(const struct ti_sci_handle *handle,
+					   u32 id)
 {
 	return ti_sci_set_device_state(handle, id,
 				       MSG_FLAG_DEVICE_EXCLUSIVE,
@@ -664,6 +683,26 @@ static int ti_sci_cmd_get_device(const struct ti_sci_handle *handle, u32 id)
  * Return: 0 if all went fine, else return appropriate error.
  */
 static int ti_sci_cmd_idle_device(const struct ti_sci_handle *handle, u32 id)
+{
+	return ti_sci_set_device_state(handle, id, 0,
+				       MSG_DEVICE_SW_STATE_RETENTION);
+}
+
+/**
+ * ti_sci_cmd_idle_device_exclusive() - Command to idle a device managed by
+ *					TISCI that is exclusively owned by
+ *					requesting host.
+ * @handle:	Pointer to TISCI handle as retrieved by *ti_sci_get_handle
+ * @id:		Device Identifier
+ *
+ * Request for the device - NOTE: the client MUST maintain integrity of
+ * usage count by balancing get_device with put_device. No refcounting is
+ * managed by driver for that purpose.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+static int ti_sci_cmd_idle_device_exclusive(const struct ti_sci_handle *handle,
+					    u32 id)
 {
 	return ti_sci_set_device_state(handle, id,
 				       MSG_FLAG_DEVICE_EXCLUSIVE,
@@ -1631,7 +1670,9 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	core_ops->reboot_device = ti_sci_cmd_core_reboot;
 
 	dops->get_device = ti_sci_cmd_get_device;
+	dops->get_device_exclusive = ti_sci_cmd_get_device_exclusive;
 	dops->idle_device = ti_sci_cmd_idle_device;
+	dops->idle_device_exclusive = ti_sci_cmd_idle_device_exclusive;
 	dops->put_device = ti_sci_cmd_put_device;
 
 	dops->is_valid = ti_sci_cmd_dev_is_valid;
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 18435e5c6364..5d704bb33989 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -97,7 +97,10 @@ struct ti_sci_core_ops {
  */
 struct ti_sci_dev_ops {
 	int (*get_device)(const struct ti_sci_handle *handle, u32 id);
+	int (*get_device_exclusive)(const struct ti_sci_handle *handle, u32 id);
 	int (*idle_device)(const struct ti_sci_handle *handle, u32 id);
+	int (*idle_device_exclusive)(const struct ti_sci_handle *handle,
+				     u32 id);
 	int (*put_device)(const struct ti_sci_handle *handle, u32 id);
 	int (*is_valid)(const struct ti_sci_handle *handle, u32 id);
 	int (*get_context_loss_count)(const struct ti_sci_handle *handle,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
