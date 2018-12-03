Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B344EC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:38:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887A1223C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dq6D0SCb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmfVODjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887A1223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l/EdZIITpwe2LaJLT1TG1ZzVAi2Gbg5YH21us65QSW0=; b=dq6D0SCbeijtvl
	iVRhbGVNIIMExIeMduuVvN6cGQIRVVRxSGL81CDgx5a1od4aP00Ndu9knZ8qtmRRTYj7C3lbfJR57
	pZl3PMeYebcCCfl6fz/4i8Ra31jffjCcwaRnityyEz8KxKnJk14pyrC7lpea+5RVdwrv7T2rJO6ZZ
	2oh/Gx6YHHYx5wsn0Mt56z8TJ6QjP5hDG8HC/CQH6qrJDrUFBvlpvfzfUCPs2XjHxPOfs2fH6i5RZ
	JB+Q+XkQbgj2kWL3PSGVIwvQRtNZeq+aUxdmWYeTPnnUPNNtiE9V2MMi0b6li3CqbtqMsoULPE8K1
	8O89zM7gGypdsjYaqAyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt7H-0001mD-Sl; Mon, 03 Dec 2018 18:38:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt7E-0001kZ-Kj
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:38:46 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 39E7520848;
 Mon,  3 Dec 2018 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543862314;
 bh=t0rzd98XH2a4s/L1Bz0TvjLoIgoyWJGe68VS1eBbfBE=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=jmfVODjyIbDPCfgNW5xlq/cuBFxuzZTGDU2kd/pKoDXzhu0GeQtLNLy5/JTbnTb4c
 Yv/TS2ELSG2u8Z9Ly9EMSETkG1rIjoyQeUiBj+u4qrhCLBkpXVqjKhZKH2ahLOm4lh
 oJE9KruZulWYou8UTzRJRcfa9swMXRo+EAkyCqIQ=
MIME-Version: 1.0
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB42110579601320F59219CB9E80D10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB42110579601320F59219CB9E80D10@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154386231357.88331.6991254616792618686@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH V8 0/7] clk: imx: add imx8qxp clock support
Date: Mon, 03 Dec 2018 10:38:33 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_103844_693535_4AEB8859 
X-CRM114-Status: UNSURE (   7.09  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-11-28 09:18:47)
> Gently Ping...
> 

FYI, when you ping the thread, it floats to the end of the queue for me,
and then I don't review it for some time. Sorry, this is how it mostly
works. The bigger topics come to the front queue and then I try to get
to those sooner and let the stuff churning as newest in the queue become
lower priority because "someone else is doing something". I do sweeps
over the new stuff every day or two to pick out the easy one liners and
simple things because they may be critical, etc.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
