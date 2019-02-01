Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81CAC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:04:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA60218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rOHxM5VK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fX6d3sgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA60218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=6dBXNywU4OirseMkTndZ9rsx4kVMCbg6GYOPhGo1/7w=; b=rOH
	xM5VKP0hzmwzXETlHCN+XGDBHhPwi1mCUfQb+JSND4QisWZ65rAnCxnk8q9pkXIaV02QhRCyBlgha
	lGCXb53u1aTVPNccKqqGCpB9cZMvNSP1qWx/vBIzWdn7XzsCTrOA6eVEuqh9k99a8NIuKkDikUEcu
	BOb/mvugvDW5vN9lZmEyEuwQueMkzzorcAdjypDXD+j1oEcR62ttq5OmjzroChCR50GT+B0CCtpXr
	oRJxm3cSGTWzA5BntROWHdQhQNZI2bT/Gi1oUgkpBJW00sXyv1Qr8W21AgwxbaOPT7hzlgscVNacz
	RIU1Xjnxbz82e6ujSg1o26d0rOvJwYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpdBL-0001p5-AZ; Fri, 01 Feb 2019 18:04:51 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpdBH-0001oV-V6
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 18:04:49 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x11HwxWt144083;
 Fri, 1 Feb 2019 18:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=drD3YgQGMc9qJL9fvvYzJTyq8vsLPd1gLpS/tANbDzo=;
 b=fX6d3sgHdIYaUkLv0OdxC/+0cnHeGuUkMlKs8+OE1dKz9ztsvqYS6EKq9Mpk0BPs/95c
 FXog4rdFnVlG/WWpS3cMKNwnHOS9E7z3ia11R9oV8kxLEi0B94T5HF1A6oy3WsanuWUP
 qETxYec70IRcC7NatqT+6UZNl9iBATCIdnUB0XMgwzvg1PBqQ9c/wF+sc1b3pOXE/ZLV
 XyPeOM3NbvCNVOEqGoRTdkbrWhxZuF5zHzrzp2k4gjjEh8zX7GTLzpM7f8+ZiaqBhlgF
 qUETUwkF73tew92L+axSyNCUbZ3cTtk+q8BSYe+1N8GzZrFxQaDtJm5FpP8q39Y056x6 Rg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by userp2120.oracle.com with ESMTP id 2q8g6rr1wa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Feb 2019 18:04:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x11I4eXV027485
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Feb 2019 18:04:40 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x11I4ceD001522;
 Fri, 1 Feb 2019 18:04:39 GMT
Received: from aserv0021.oracle.com (/10.11.38.116)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 01 Feb 2019 10:04:38 -0800
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
To: arm@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] soc: ti: couple of non critical fixes for v5.1
Date: Fri,  1 Feb 2019 10:04:23 -0800
Message-Id: <1549044263-5862-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9154
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=608 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_100448_086222_BB44014F 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: olof@lixom.net, santosh.shilimkar@oracle.com, linux-kernel@vger.kernel.org,
 arnd@arndb.de, khilman@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.1

for you to fetch changes up to 2b13ef1f4261688c2dc5d67dbee69ed2fdddf53e:

  soc: ti: knav_dma: Use proper enum in pktdma_init_chan (2019-01-30 10:22:17 -0800)

----------------------------------------------------------------
soc: ti: couple of non critical fixes for v5.1

 - Fix the Clang warning for enum in Navigator dma
 - Simplify code in ti_sci with DEFINE_SHOW_ATTRIBUTE macro

----------------------------------------------------------------
Nathan Chancellor (1):
      soc: ti: knav_dma: Use proper enum in pktdma_init_chan

Yangtao Li (1):
      firmware: ti_sci: Change to use DEFINE_SHOW_ATTRIBUTE macro

 drivers/firmware/ti_sci.c | 21 ++-------------------
 drivers/soc/ti/knav_dma.c |  2 +-
 2 files changed, 3 insertions(+), 20 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
