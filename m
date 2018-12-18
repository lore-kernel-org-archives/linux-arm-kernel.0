Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3868C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:28:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92794217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="icsPEs67";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w2kYeA+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92794217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vQEQH5lHtE8w63s9IEL8JrVeinZyS5Q45EtbH+XChW4=; b=icsPEs673K7ia1
	GRSYMtG8zOY6vQYF1DBJuASwIdPUyboihrWfb2eyXGVFW6WLWaYnpQpS3dTH7xw6aqVqxzODK4+K6
	W+r1TkUIKCpsKx4HvJK9Nj+nhWkdueCILVmLv9aUWpZE95DPvds6ka3UklxSRzQwnoyGl01hQYyap
	dPlpm4z7OhKN2b7QAtm6fbmCgWoYWfnbE6udiD9wpgOjUuluX8bJ9q50IC35nKaxvW0jFWVe5xx/3
	LR9TcOPu9FwPPKaV/d4dLRK8sDbN1MeicpzIE6oL744LCWU7PiJU+7khvaeS0gLo6C3/rvPCWpu+2
	nz9PPvqkfLJgaHm/GsgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZAjn-000467-Am; Tue, 18 Dec 2018 08:28:23 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZAjk-00045L-42
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 08:28:21 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBI8S2KZ056768;
 Tue, 18 Dec 2018 08:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=cJcyZ5OFFNli2SRwLuOjdN1N0x2ksq8Cp2LyM1jA1iQ=;
 b=w2kYeA+9FKCWfqf9iqmZqcLSDFxvUwvKD6d11k4CxsdsBB6kZ6ovuUOWcYbp2AV42tI9
 Lu9YPB1h9yfBRruS0EP8iu486acQycqoj7sbHcu5BdnSm4EoCEwg60C8HRfhSQPDNqAZ
 o/PGceeWYbgkNtYVigUF42P0thtLHS1bE9IkFxroUUWYgiW71VFKPAqIEd3pwCRvynzF
 rp4QTE1FhoYdKEu41NMioh0TLLNkaizoMzgFQ5wgdOIa4kDlNa/zKfELhkDH0tNltbsC
 3Jvc6toBG1zKnpSgtq7gJqtXPoZqlpFJCNrJSgVFbzom6Pz1HKeDIMQ5IOMrsKI5UPaL kA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2pcq4dswmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Dec 2018 08:28:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8S05d012766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Dec 2018 08:28:00 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBI8RxXH007579;
 Tue, 18 Dec 2018 08:28:00 GMT
Received: from kadam (/197.157.0.59) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Dec 2018 00:27:59 -0800
Date: Tue, 18 Dec 2018 11:28:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH] bus: sunxi-rsb: Fix a small memory leak
Message-ID: <20181218082800.GC440@kadam>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_002820_249259_91A2561F 
X-CRM114-Status: GOOD (  17.54  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The problem is in __devm_regmap_init_sunxi_rsb().  If the call to
__devm_regmap_init() fails, then we leak the "ctx" allocation.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bus/sunxi-rsb.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 1b76d9585902..5ec25c8164d1 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -417,17 +417,9 @@ static int regmap_sunxi_rsb_reg_write(void *context, unsigned int reg,
 	return sunxi_rsb_write(rdev->rsb, rdev->rtaddr, reg, &val, ctx->size);
 }
 
-static void regmap_sunxi_rsb_free_ctx(void *context)
-{
-	struct sunxi_rsb_ctx *ctx = context;
-
-	kfree(ctx);
-}
-
 static struct regmap_bus regmap_sunxi_rsb = {
 	.reg_write = regmap_sunxi_rsb_reg_write,
 	.reg_read = regmap_sunxi_rsb_reg_read,
-	.free_context = regmap_sunxi_rsb_free_ctx,
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 };
@@ -446,7 +438,7 @@ static struct sunxi_rsb_ctx *regmap_sunxi_rsb_init_ctx(struct sunxi_rsb_device *
 		return ERR_PTR(-EINVAL);
 	}
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = devm_kzalloc(&rdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
