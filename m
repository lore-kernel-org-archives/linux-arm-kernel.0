Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3A7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:33:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF93F2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SahFnTdk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXOrIV/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF93F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NtbNO09P/V8l0CaPVfXYYkGbSDv45t7pbdsNiDWY6lo=; b=SahFnTdk4HjynO
	Tzmn+zGXehE+30UP2lcHeYWlwpSEqZImX9YMR4X+u3klAUaX0xwun/v6OYSe++hnHhsRnssCAw7r5
	atT4n397gizkOpAfaOFVhk2LtMh/7z6s06RotStCmwPju4509KtdraPl+TcZQ+XknEuH1uFTFnlal
	QKTmlYJUGa8rJ0NQ96DgE0aUWkFyYww1rrHZg6FKfAZL6eylZH3145lFOMrLAXUBZJptpnfuF6Cv1
	glxaD9VfmJDtCgBQWawlpHaSDcr2EXHuCxAjEYIdNethwQW8ZWHVIIhqnKx6ytk2dx1Q3q2Obmzso
	dsm773dgTiEsuEg2R3+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtyM-0001x0-S8; Mon, 03 Dec 2018 19:33:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtxJ-0000hb-1A
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:33:15 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C98B6214C1;
 Mon,  3 Dec 2018 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543865544;
 bh=TJnHsdIRP++NUf3MT6qQN3f8YkL7yQXLZpezHeM5/Vc=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=oXOrIV/E/MByRpFafWS4f46HyGWGMef+grKe/zQlxFLhT4VG0irl5DSCX2o6d3PaG
 0AWNECH4Pq78zzQrRFq5D1SNPYfh7/GTDfoJCB/oSeEQNEBJNgR7Ljiq2qvSvT/Yo9
 WR1wTOsU3JNjFz62/Vd1GEsVyEp4FM9HW/CZ48Zs=
MIME-Version: 1.0
To: "A.s. Dong" <aisheng.dong@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-9-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-9-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386554424.88331.5358384242097908533@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 8/9] clk: imx: implement new clk_hw based APIs
Date: Mon, 03 Dec 2018 11:32:24 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113234_350876_70BC2E4B 
X-CRM114-Status: UNSURE (   6.10  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting A.s. Dong (2018-11-14 05:02:04)
> Clock providers are recommended to use the new struct clk_hw based API,
> so implement IMX clk_hw based provider helpers functions to the new
> approach.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
