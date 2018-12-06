Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029C7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:37:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC1120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aElEW3A0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="07K9Nisu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC1120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o9LGzmXCXhOvVVivSCkyTpCYSA07olC6fAxSWDa5BUY=; b=aElEW3A0aoVDgm
	l8SetPoPoJJFGEt9xWY3LWLu0Ok99ztZC51nHMrLJU43PSpygG/TavyE+0jqKtd7QytikG27n/Tvf
	hwFn1PCeAZWtM6L0VEh7Xh7FmFmJWAeDboClcL6RzWIXhL/9ry7ecw+ljvZX64tE+awHB/UJV2Vsp
	ro1uygCGZsYnkyNVxqxpQBeJH/aoqvjzR2lt59xRKuP42heLuOVZ1LB2LJdISDmNmT/d9Y1/cGyrW
	lEmFcVynT4ak0Im/nU0gPn+usuqZWfFJgiXGAuKfw/z2aV6viik/GJY+C1ibLSRWTN5ERc34870t3
	WLtw9cmvLlvvrDPZPmcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoDY-0001Qe-Pi; Thu, 06 Dec 2018 07:37:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoCz-0000i5-5v
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:36:37 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E7A1120878;
 Thu,  6 Dec 2018 07:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544081778;
 bh=zwfc/xaKj2F/WN5VahWfQreYqn/sl1p0p7HNdSXHssk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=07K9NisujIYMHhro9h9Nf46h/RGfPoT5ENfCQej+F21vyajcBhYjbp48n3X3src4f
 CvFG8mAvHoKUu/m1k+dr1Bfdld69sgI/2gjQja5jPb66eYewKw0xzzT17H6e9IkhEq
 AwnzBHXlrYkXGiWevJW7dzEwB8xSzgmqFVaA9pgs=
Date: Thu, 6 Dec 2018 15:35:37 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V2] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
Message-ID: <20181206073536.GH3987@dragon>
References: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543972116-22505-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233629_948380_89412C12 
X-CRM114-Status: UNSURE (   9.21  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 01:14:25AM +0000, Anson Huang wrote:
> Add egalax touch screen support on i2c2 bus, it is connected
> to LVDS0, while the existing one on i2c3 bus is connected to
> LVDS1.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
