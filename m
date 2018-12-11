Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E4C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:35:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0972620879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RqHJVJ3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0972620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=og1AlZimzCk/UKh4hFKmRZdUNtL7HsaK/Aoe9HcAXOI=; b=RqH
	JVJ3hdWURmIyZWCdNVEA5Cja4WT7mISW20L92jiqHQGi/yquO4ckZ8J2CNB1xJ5KcZ0u0EZwYHczt
	dbP4lam/Il9ESjZpWjFvgizbAz/1Wi9cW2DeARyH/pDPG7P0IngFhWXRfDxVXqtNJF7z2NPFOe4uv
	YOR1I6lxmPqYF7U3rqd7RnwzW/DwpHMFnnxb1ZtnhEq3fUAvYFKVRxEfCTFyJzPyy+D/QfILdMFZ3
	CQWh8DNUFs7EPIvFZUBpyvVW2GEWfmiIvXokr3f4VQ1OLAV4v88cRC7qp2uClcGhvi7VvnPmj+UJh
	K1WvbHZ+R37XwSIPQBfDDgUTgqzOHGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnoo-00038c-Eo; Tue, 11 Dec 2018 19:35:46 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnnG-0000RZ-VC; Tue, 11 Dec 2018 19:34:14 +0000
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVui8-1gv5yW0MwK-00X4CI; Tue, 11
 Dec 2018 20:33:32 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH 1/7] [DSA] adding fields for holding information about
 upstream-port
Date: Tue, 11 Dec 2018 20:33:08 +0100
Message-Id: <20181211193314.10695-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:6e4Tt0QPCv1129zyq1CTat5YbKXl3QuCfFVnI8ILsXDi2GCjTem
 y9EFJSDGzeyReuMagnPqrmKiAoMyiGYotXfr4phS/lZpwyoyIAUyBi4yPn933lGaJHi5f6F
 Gh/Wq+TeMg5CUEXQkTrG2gQTJaXpRZmQTBw6vUl7kF28hC9+sxZ3tzTJ11bbce6b7gv++rE
 iF0mu9Li+V5aLIRq5G3rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:48UIIgF5caM=:3VjltdEw65ve3QkcvnWep/
 ClFtD4/7B4t2vr8i4hEXl64YPQS+GphTHMQw3WpYwWuXJMv0DBRSpM52LvUi3gsJod4xlc/EI
 bwkgmSKsfu1r1PI879zu3YkVRx/08rlOWR0qdVfVbUpu3uTI8TY7G3q5Gj1uXGlVy2yhsmbac
 gif7XbRttj+XrDxg1VUghFC/jhgdOG/cHlrQP+lcbpJBWP+F7/hWcfIKLtpywm3yKZ37BZk3+
 L+z7HlMJvufiYyxkKiI658e/xLQIT4+DNW+WSVEWEeLdjAqr/00SSm+WFIIXx2u21R3Ckfd3V
 h1Kn1ryAVYSNKVkpsobNQHY/q5ipJ0fhxjhZoUpkGQ3f79gJSKLY3mBn9TwRq4feN8XIxyNQt
 9barcXf22XmQWiVAi+4YD75hWy3FEpIGMXMnubX9fXtygtWCHIF6ZhaYWbjgcETnYicgiElps
 NiswbapRgt7ODl2b/X0RKSn898cOnX1t1ZtVu8uQklo9JqYJ5ZlRTKjsy9p75FYQY5hz24weX
 /sge15oAGS2vSHkQVp7Y/DGoqb5MrehnEdp/6v9h73oV/23G0vJDuhs8t/LS61hs+12y7thH4
 IC2nAIR4cKM71Ajp46/IHfuHilMWixHumF6WwIxhSW53Yy5RjMo2laJz2/uZ/9LACPzlPr+0i
 NeeN31TK9W9gn/ubeQCOWpWX71M+3obzH/Q0MEcg6SAcgycXLcmQ2l0rG00nwGeBWGi7LyjvZ
 EcBHa/EcSdj74cpq4W2jUq96dyq8LktYaKEK4hiI7JyTEJBhy7j1gVzNWaMZpLEIlzHsv/vcn
 mubMvup3rzG4YTj5NnFN0rn2XXGyBCvq+lJ0R9JxAH8CS3BzG4Yn7xpJkQDSOJs7KfjwVJT93
 edylQgUhYMo7VU4ebjDGXPxK5K1bnQ2trJV2v6uTiGehjvoZ5ipVauqAWx2PTS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_113411_295406_283C625F 
X-CRM114-Status: UNSURE (   9.04  )
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
Cc: Frank Wunderlich <frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0033-dsa-multi-cpu.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 include/net/dsa.h  | 4 ++++
 net/dsa/dsa_priv.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 23690c44e167..3efa81e08993 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -203,6 +203,10 @@ struct dsa_port {
 	struct net_device	*bridge_dev;
 	struct devlink_port	devlink_port;
 	struct phylink		*pl;
+
+	struct net_device	*ethernet;
+	int			upstream;
+
 	/*
 	 * Original copy of the master netdev ethtool_ops
 	 */
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 9e4fd04ab53c..cc0cd7675117 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -81,6 +81,8 @@ struct dsa_slave_priv {
 
 	/* TC context */
 	struct list_head	mall_tc_list;
+
+	struct net_device       *master;
 };
 
 /* dsa.c */
@@ -188,7 +190,10 @@ static inline struct net_device *
 dsa_slave_to_master(const struct net_device *dev)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_slave_priv *p = netdev_priv(dev);
 
+	if (p->master)
+		return p->master;
 	return dp->cpu_dp->master;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
