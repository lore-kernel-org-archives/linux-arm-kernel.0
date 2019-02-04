Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1050AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:10:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17472082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OXSLNTIr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gvkSu0ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17472082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8U5A0MWUvZnv8KdcW+TGqqNU+Gscr/TmRrg8yKMXPvs=; b=OXSLNTIrslKT9s
	kHGMXyewDH/Zj7KjH4gRtq7rvAhm07PWzwl0GCIqax0mn1F2Gt1V983pUZhKibaXPazWo+tuAhIPC
	1vxFLayfy+VsLS5quIL20XMNX13Ea+Lb5xQuL54nvqy5f5F9gIF2un0YLBcjXzNVz+ihCn8zpAPkh
	nMSuTKyKl3KebxhdcgcdxuwYuMB+FifYepOAuj4h47UJUbJHZDbXl4CHY2fEQyL/F7hT4GHgW71kR
	ViIJZT/fWbLuvaBnpcumoDNTUIq7TMc6DdZbBOWi9U19MFPZZqVtY31SBKK1UUYR4qiEgqNt+6+Rt
	1VeB4nk8a1jjacLqZ7Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqex4-0004Bd-Ey; Mon, 04 Feb 2019 14:10:22 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqex0-0004BI-Ei
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 14:10:21 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x14E8xdT027994;
 Mon, 4 Feb 2019 14:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=JPYLcAP4VkvLUtdSN+MQh/nNpzonf9onT0VM4MS/sso=;
 b=gvkSu0cihfJrrxz5V76J8jOoPChR8dGQ/3YvKyZlO0IdkCqP27xjO+RYLo5/udQUlpUR
 USN3IS32Vh/Ta1In8vOhhaOhnkOnAPJIRFDUBB68hFCerPw7sVQULSv4ZjsWw7+i+fkm
 DiHLQE4UXnpCUsrpMJX8jkXlwuNZjbBAuM9LsZ7d+IkERt5bantqoEFV1tgLCj3X+Z5i
 MlO1xmdAWBR64SnhaYlmDO4GUIJ13jOARvWUn4AlNa1HU2wpMary0zq2z6xyw90wYHrm
 AhUV2HjnOh4p/dS8IkKu+HRnoqDkXyVOgrdL7YSIiM4D1nh27y97MUVmKMQcHGSnvGFv qA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2qd97enagy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Feb 2019 14:10:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x14EAEoA025591
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Feb 2019 14:10:14 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x14EACST021055;
 Mon, 4 Feb 2019 14:10:12 GMT
Received: from kadam (/197.157.0.20) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 04 Feb 2019 14:10:12 +0000
Date: Mon, 4 Feb 2019 17:10:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Roy Pledge <Roy.Pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] soc: fsl: dpio: Use after free in dpaa2_dpio_remove()
Message-ID: <20190204141005.GA915@kadam>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9156
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=959 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902040113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_061018_847054_9ACA3281 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The dpaa2_io_down(priv->io) call frees "priv->io" so I've shifted the
code around a little bit to avoid the use after free.

Fixes: 991e873223e9 ("soc: fsl: dpio: use a cpumask to identify which cpus are unused")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 2d4af32a0dec..a28799b62d53 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -220,12 +220,12 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 	dev = &dpio_dev->dev;
 	priv = dev_get_drvdata(dev);
+	cpu = dpaa2_io_get_cpu(priv->io);
 
 	dpaa2_io_down(priv->io);
 
 	dpio_teardown_irqs(dpio_dev);
 
-	cpu = dpaa2_io_get_cpu(priv->io);
 	cpumask_set_cpu(cpu, cpus_unused_mask);
 
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
