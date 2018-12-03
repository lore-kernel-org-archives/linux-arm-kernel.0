Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07A2C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:53:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B312082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rt9CK54I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SwYI1/AT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B312082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kZsvtugenR2y7Tp9hTh2/lI4/u1Ju0sF5qxmC1STfN4=; b=Rt9CK54I4TwHVe
	wtWlFpO4DwhH3FgqAj4gB/R8jju2PSZrv+bNJ5L0GHgo6+RC6Us+1il9avWVV8StBt67mwui1XVqr
	KR2/z7cHOkVI9j7AXCRYfBE11Y5j4Aytqob6+MJ9iovMmvJOhhfxiPnOS+UClrPqMBGH0ZoYqRKM5
	B9tUOpb70F4BGuH8TRXOLoTwfatJTiX67UrOpGvN0WHwCAdyNvAy0mRGOmMAa85GWD1Ieh1+9x8V/
	OvNSaoz5UyEqEqoorllSulJNg5Re5a5VWlbRpZONlNj7ViFLSQf5+IbjPLhUJAMBhvNqFGzdO7AZl
	mrZHA13/Hi6Ou3iFKHXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpak-00039X-GW; Mon, 03 Dec 2018 14:52:58 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpag-00038w-WA
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:52:56 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3Emrlb009898;
 Mon, 3 Dec 2018 14:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=3zHu2TS7q888PMagnnYuV5kIkL42s5TP4A1hxO+3J28=;
 b=SwYI1/AT87hS7QtyHQZMZHpby5X78CIyWeaIHjzX2VJ0w05VyM+9/xNq+VHqTsdFrGhe
 YGYsc5HxD3Cu5tRJtC5ipEmnviq/gSwkCcEOr40/JXaeHkPr8SZg6M/DyRrXIsvZg793
 vPwRtFVaV1/Oti2RlL96/5mY9RPZdiD7iPjPNLpHofkR49bgoYyWPu5n9LsWf9onzXza
 jNhoQgLwXsTTVtFolDRe6AZnDLI3xpbK/iLQh2Oe+sE00DWyRpoWWd5oZoCsGqq7KH7j
 88mAZwlHg2HxrXv4TrBBJ2l6Fj9oGLHoexKfZ0L/YCuxp5BT7m65UUK6PTrUQZXqUq9i 6w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by aserp2120.oracle.com with ESMTP id 2p3j8q6t92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Dec 2018 14:52:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3EqWTc023471
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Dec 2018 14:52:32 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB3EqVSW027249;
 Mon, 3 Dec 2018 14:52:32 GMT
Received: from kili.mountain (/197.157.0.63)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 03 Dec 2018 06:52:31 -0800
Date: Mon, 3 Dec 2018 17:52:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH] misc: vexpress: Off by one in vexpress_syscfg_exec()
Message-ID: <20181203145219.brmtuv26dj3vnc5y@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_065255_127359_9B7B6863 
X-CRM114-Status: GOOD (  18.99  )
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
Cc: kernel-janitors@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The > comparison should be >= to prevent reading beyond the end of the
func->template[] array.

(The func->template array is allocated in vexpress_syscfg_regmap_init()
and it has func->num_templates elements.)

Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/vexpress-syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vexpress-syscfg.c b/drivers/misc/vexpress-syscfg.c
index 6c3591cdf855..a3c6c773d9dc 100644
--- a/drivers/misc/vexpress-syscfg.c
+++ b/drivers/misc/vexpress-syscfg.c
@@ -61,7 +61,7 @@ static int vexpress_syscfg_exec(struct vexpress_syscfg_func *func,
 	int tries;
 	long timeout;
 
-	if (WARN_ON(index > func->num_templates))
+	if (WARN_ON(index >= func->num_templates))
 		return -EINVAL;
 
 	command = readl(syscfg->base + SYS_CFGCTRL);
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
