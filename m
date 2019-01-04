Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5C4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:47:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E74D2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J/+Fi6VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E74D2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Nu9Exc7Q54oFIC9J3M3FeZI8aCM5MpWB33WmlVXeLiU=; b=J/+Fi6VEvpps1C
	AKYPYmgpqrooWEqHAGI37p6nQV8bVj/KCj1raf27QgzHg3URUmAz2fyY6rbMcEDbq2yV3/y2Z6aao
	H+8sihqEe7OeLLZe5kNJnVgaq0HVArz3giHrmcu2RI68bSu45XPAze/zdD9AgH2uHJaop5L+qjyb7
	UxXLEHPH69J4/XUJzdzYCkSAxWS7xHrm/2Z/FucfzVM8LA+B1ybyC9lc9MRmcDcQoIBMxIkQvfUrE
	QoW6BbXJ4CEieIzRxWGAUbuboQcmdpHzgsHr65D12OL4eqAEKYZrmxYdpzCvLBs9gFujI9ShMrgrS
	trq2n/k3qEAEFhvGuYnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPpK-0004gD-4w; Fri, 04 Jan 2019 13:47:54 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPp7-0004XC-T7
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:47:43 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x04DfW9t004402; Fri, 4 Jan 2019 14:47:32 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2pp0pm8m79-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 04 Jan 2019 14:47:32 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E445A34;
 Fri,  4 Jan 2019 13:47:31 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C3BE9530D;
 Fri,  4 Jan 2019 13:47:31 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 4 Jan 2019
 14:47:31 +0100
Received: from localhost (10.129.4.161) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 4 Jan 2019 14:47:31
 +0100
From: Fabien Dessenne <fabien.dessenne@st.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>,
 <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] mailbox: mailbox-test: fix debugfs in multi-instances
Date: Fri, 4 Jan 2019 14:47:15 +0100
Message-ID: <1546609637-6411-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.129.4.161]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-04_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_054742_257174_D1CC84F4 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Benjamin Gaignard <benjamin.gaignard@st.com>,
 Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Create one debug entry directory per instance to support the multi
instantiation.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/mailbox/mailbox-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 58bfafc..4e2bfba 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -31,7 +31,6 @@
 				 (MBOX_MAX_MSG_LEN / MBOX_BYTES_PER_LINE))
 
 static bool mbox_data_ready;
-static struct dentry *root_debugfs_dir;
 
 struct mbox_test_device {
 	struct device		*dev;
@@ -45,6 +44,7 @@ struct mbox_test_device {
 	spinlock_t		lock;
 	wait_queue_head_t	waitq;
 	struct fasync_struct	*async_queue;
+	struct dentry		*root_debugfs_dir;
 };
 
 static ssize_t mbox_test_signal_write(struct file *filp,
@@ -262,16 +262,16 @@ static int mbox_test_add_debugfs(struct platform_device *pdev,
 	if (!debugfs_initialized())
 		return 0;
 
-	root_debugfs_dir = debugfs_create_dir("mailbox", NULL);
-	if (!root_debugfs_dir) {
+	tdev->root_debugfs_dir = debugfs_create_dir(dev_name(&pdev->dev), NULL);
+	if (!tdev->root_debugfs_dir) {
 		dev_err(&pdev->dev, "Failed to create Mailbox debugfs\n");
 		return -EINVAL;
 	}
 
-	debugfs_create_file("message", 0600, root_debugfs_dir,
+	debugfs_create_file("message", 0600, tdev->root_debugfs_dir,
 			    tdev, &mbox_test_message_ops);
 
-	debugfs_create_file("signal", 0200, root_debugfs_dir,
+	debugfs_create_file("signal", 0200, tdev->root_debugfs_dir,
 			    tdev, &mbox_test_signal_ops);
 
 	return 0;
@@ -416,7 +416,7 @@ static int mbox_test_remove(struct platform_device *pdev)
 {
 	struct mbox_test_device *tdev = platform_get_drvdata(pdev);
 
-	debugfs_remove_recursive(root_debugfs_dir);
+	debugfs_remove_recursive(tdev->root_debugfs_dir);
 
 	if (tdev->tx_channel)
 		mbox_free_channel(tdev->tx_channel);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
