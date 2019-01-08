Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B73C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00DE20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S4b8kaaA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qJ3VUWZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00DE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LEFScH/0mYw17t/gQ7FriUtQGuwKx1Go4k2oLTrCNn8=; b=S4b8kaaA5Kdq+5
	6tvpJQP/eyBNPA6MhFBSWebKyUtwWmLQik+8rywVrG6sPViTuXJpAO1VkCqLbo60a3Mde9m6Qmeaf
	iyA0vRaTJSi0W1UTo3cbyOseQ4VHyqEZCnHeRUsyNxanYcoEXbezHZWtaxtyt8aWPWSvAvJp9sdhd
	6ibJjG4p/hxHHKPfZ5s/J96n4tglCb77x56eAGYm/EXyKU5+1lFhaj3Jex2pxxXPuljSv5bs12gBo
	7/XZgSCikPf4dToyqfjfWhYA8vZeR+zSfx4HvyI6WN31qHEWQLYdanlv2RdAt3OtDRAdcsdKG37w1
	LPoH1ZN+qToSUixD8Czw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggrTt-0007uS-U9; Tue, 08 Jan 2019 13:31:45 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggrTj-0007jV-Cy
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 13:31:38 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x08DVQAb075118;
 Tue, 8 Jan 2019 07:31:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1546954286;
 bh=+wg76Pqo+Bo8l3yM3CQNB0mIE8I40rfxxv6nykYX4ZQ=;
 h=From:To:Subject:Date;
 b=qJ3VUWZsgw9hWVOKKifu3XUtcnHXdv0S5lU0LOvp2cooODlt/fY3Z80mphwFT5t29
 hyZgYK0g8/9nj7zB5RuJCwtZuL0Aex2mRNd79eJJ04Dki/rh6lWqtp8JwT2AMSMfyg
 6ia0H3Jx4mVHXjh+OUIEsVIUHtymgGkJqJof1Sfw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x08DVQJp074701
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Jan 2019 07:31:26 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 8
 Jan 2019 07:31:25 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 8 Jan 2019 07:31:25 -0600
Received: from gomoku.home (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x08DVMue011668;
 Tue, 8 Jan 2019 07:31:23 -0600
From: Tero Kristo <t-kristo@ti.com>
To: <sboyd@kernel.org>, <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
 <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] clk: keystone: a few TI sci-clk improvements
Date: Tue, 8 Jan 2019 15:30:20 +0200
Message-ID: <1546954223-9738-1-git-send-email-t-kristo@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_053135_780978_7F6EC4BD 
X-CRM114-Status: GOOD (  11.64  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Patch 1 & 2 introduce a new DT flag for parsing the clock data from devicetree
instead of querying everything from firmware. The purpose of this change
is to improve boot time, it can be seen to give ~2s improvement in certain
setups. If adding a new DT flag for this is not acceptable, a kernel command
line parameter could be introduced instead, or even a new Kconfig option.
I voted for the DT flag for now as that seems to be the most versatile
solution.

Patch 3 shortens the kernel registered clock names, currently for am65x
they are of the form:

interconnect@100000:interconnect@28380000:interconnect@42040000:dmsc:clocks:11:1
0

After this patch the same clock name is cut down to:

clocks:11:10

This makes the debugfs interface much more readable in addition to some
memory savings.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
