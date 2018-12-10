Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC0DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:16:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22FE20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dli03mH9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNBpfdX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22FE20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FeDkBLAYGkEmgVgI5UeBpiOjmBQ+dvyiZHvMfEDyHDk=; b=dli03mH9p64/5h
	TD1ZTlJ8ZUo98UodsbzY1aFh4bw+tsfFvwGtFVOh4jfOJ1TUYhDcdBYYEVD7+QXl8DQLnyL3JbVzw
	+ktqNBe6sxRaFSSQCHKTelSXUccLF/6U6f9e+LWjUnIASVf5oCGo6HnPoq0lQQ/hL4gw4udFMsXB6
	NumoaKavz1HZGVFcJoHZ1ACMO2bpIhYZTBVF8iv2ewVjAr27myhSKWZLkhNm6g2WWvJv8kBxQOObc
	1s1qmS6069wT6FEfP3sACMEcgOuiyEtEGX7g6lx/rgC1k1Bmm8T0SEZcW10AMKr7nM5RDK3mddyvF
	bmEKdXLNdHg+veTfTr0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGjT-000773-Im; Mon, 10 Dec 2018 08:16:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGjP-00076D-Oc
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:16:02 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EBF1B2082F;
 Mon, 10 Dec 2018 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544429747;
 bh=5y3zc/+2hkhN1mF9U7YAwTWZDQrnbdgBDNip+gKr0+M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aNBpfdX4mjxl+6UK2W1FrAKhGAx3vYd/VmOWLDiTtyR+yVlSJphsGs9WUb9jgwYE+
 efFNr1sfVQLfQ2nkaxhS6l0lnrezF5Ahg17HKjljYBsCcrXJbIyjMkF3Sp6Mrq1KJb
 iZKFr3QF3Qo5WbskeA6hx+gbx82kwXe+OncexzRw=
Date: Mon, 10 Dec 2018 16:14:56 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
Message-ID: <20181210081454.GQ3987@dragon>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
 <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154403886196.88331.15597466595875847820@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154403886196.88331.15597466595875847820@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_001600_796203_A5B627AE 
X-CRM114-Status: UNSURE (   7.23  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 11:41:01AM -0800, Stephen Boyd wrote:
> No worries, I fixed it up and merged to clk-next.

Hi Stephen,

In order to send imx7ulp device tree for 4.21, I pulled branch
clk-imx7ulp into IMX tree to resolve the dependency on clock ID
definitions.  So please keep the branch stable, thanks.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
