Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36422146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d4tuVkAS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xPU04B4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36422146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fR3B+rsSFCROv0sX9gb2SLhyW5bdV6wUimE69hC52YY=; b=d4tuVkASP9Qbap
	kuWNnmZmfp88FtcnDSkszUe0cpdUKexhE1+NovunPeIr0JsJH3FcKbRxfaJ5EZkDbf3gvDesw6Hsy
	gFJcjZ+YdK0PW5W0y0iipeXvBJeJWuAiDuXU92WyWNftY3NJx0Iglahtad8YbAvRXV/oTi7n9W21G
	tpnSaQJWKn0TS6OJc0U/ktDnkB7Apxwa2efL6ysPMpM/tRBjhw6ea2ZNH/rCYcJd/iDwcBrDbn/JE
	OKE/4eRo2+/8itZPOH+O9ZyAcfSCPsmGBxxDACk/QLRupPmgYkzn85G/cGgmI0Vls77aCwDrrO2lh
	b546PORqMZ71MfGSpf3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwYvi-0002kd-RV; Wed, 20 Feb 2019 20:57:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwYvc-0002kD-5o
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 20:57:21 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C37452146E;
 Wed, 20 Feb 2019 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550696235;
 bh=vpn7NTLU0mFoc6J6HemZvZelqXumCI5/eH1E1wTUOMU=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=xPU04B4TktydSrkKar8Gy7nm82tlMhxy6K+cKG/BXtply+htolIk5D6SxY3Yw2edh
 8HcSNRylKb6OS/pqpQlLjYR8OmSlG9M2RbHfYB5SZEqPVQDfqQjExA8/Bv/Y8Lqqkv
 1rnvmwkTAPpxz8qxJxF4zSWZl5MIMhZWw1SnnH28=
MIME-Version: 1.0
Subject: RE: [PATCH V3 5/5] clk: imx: scu: add fallback compatible string
 support
Message-ID: <155069623505.77512.17191789640283789974@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
 <1548335800-6438-6-git-send-email-aisheng.dong@nxp.com>
 <AM6PR04MB42151CA6852C4EEA0FECC93C807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM6PR04MB42151CA6852C4EEA0FECC93C807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, Stephen Boyd <sboyd@codeaurora.org>
Date: Wed, 20 Feb 2019 12:57:15 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_125719_847394_6A0222B9 
X-CRM114-Status: UNSURE (   7.44  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2019-02-19 23:09:57)
> Hi Stephen,
> 
> Can you help picked this one?
> SCU clock is likely to be common, so we add a common
> compatible string to handle it.
> 
> BTW Patch 1~2 already picked up by Shawn.
> Patch 3~4 dropped.
> 

Sure. Picked into clk-next.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
