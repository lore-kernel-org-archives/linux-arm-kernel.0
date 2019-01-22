Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA29FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:23:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A459C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CGqa6/FQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTNcFmaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A459C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QmeJ73shwZGLSS9Porz3b3Rfzri0unCGuQwF1DyMO2s=; b=CGqa6/FQt5+Svk
	DV90dZCjTwPzy/YI7lgDWiwQswWi+R4EtaeKjKUQnrYNs8dfvBbGxlnxGtWYNrR6yPNcIaCEd6w5l
	UGLiPG2PJzKOGjXmFGHDQPSzdi1xvkjttsuap4AYvA95HFpo7Oov+pSTmA+wYdb4v3rlm6DNBkcnN
	wspzWpe8pQLdVpbOqHD3tZoFi/j/9bSWNtB11rUzXIs7Va4uA9dF65WB3a1IS5itih9/ygIR97epL
	N+ugaCwv3y4iLwBicOWU5FKHJcdWze4wY6qZVtqBGtDwlQiw22gT4AXq/zM/Xw1hlCS22wOi+7bIc
	BusnuqTNgAtVGITVVEhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqOi-00088Q-8G; Tue, 22 Jan 2019 07:23:00 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqOe-00087e-Eo
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 07:22:58 +0000
Received: by mail-pg1-x541.google.com with SMTP id s198so10648312pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 23:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=61HksJKYYQW7RPf7xKOmLDGtem5TrSEui+Z9SSoB304=;
 b=PTNcFmaEBEPLedFytEaDRaKKv1Q80CP86HZUyMhEXD3IyRJvy2IS+Qm1u+Ve4cQ/MZ
 +I/Ci07Oi4kN4tjHalxFytg0wkI49aGElVJVbgkOE+Dx5JaJcBDywAYqUBbF8s/zRXpI
 4eRDa/D+NtaAd0xIpsj8twcye410oRvkqzqr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=61HksJKYYQW7RPf7xKOmLDGtem5TrSEui+Z9SSoB304=;
 b=SCuEJmbj6XWw6i4yMQXdcw5V4/lJ05ex2zZBP2mBVY0HfWaB0hwCdzJww3wDakdXeK
 qBdnNOvk5kT5RbYU4joZRKr2xfEN2HtEv6YcHCfPjEOhvbiu5oYILXfY1zL1E81bHEjq
 FcUrcIKrFraeR+IOJHjN8KyCIipVjC/tx824XeXGRYL1kI09DXMdA3M0ppI16JJonyFh
 tYrTrbphIAJqv3oTWAuLIYkWlM+MrNfZPBrlC/GM5U3FOkjv6z2gJaWmDP1UC4fE1/6Y
 GMR4+08OG74DJIOWUqk0VkBodmwZrQF78SfTgcX0Rdyn6AfMSZGmR0JTCVKeXK43AeFs
 UnuA==
X-Gm-Message-State: AJcUukddG+uPpiB46a7gPbrLT4uqD4nXIwR9hkKKl9Hj4MDFE4izaVMK
 c3DjRiHXTluxzyyyvXa34ffc
X-Google-Smtp-Source: ALg8bN4cYyUT8kG0jwd8Ez/plOpjjxIWiiDxF0SaPcr4Aq+LX4tF9H0XWcoNu1cThWgqHz9SKloOwg==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr32320025pfi.44.1548141775384; 
 Mon, 21 Jan 2019 23:22:55 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:7344:8fd1:3551:e475:9265:ab6d])
 by smtp.gmail.com with ESMTPSA id 24sm56571533pfl.32.2019.01.21.23.22.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 23:22:54 -0800 (PST)
Date: Tue, 22 Jan 2019 12:52:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: properly describe IRQ hierarchy
Message-ID: <20190122072247.GB29172@Mani-XPS-13-9360>
References: <20190115110446.19077-1-l.stach@pengutronix.de>
 <VI1PR0402MB3357FAB48888D99A809F41AEF99F0@VI1PR0402MB3357.eurprd04.prod.outlook.com>
 <AM6PR04MB51581FBD4D21FEFDCAC2B27FE39F0@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <7f92c150219832eb9fb54e72021116ad78ae71c3.camel@nxp.com>
 <CAOMZO5BFZVUT8x8o57TkYfwfT9OF1a=g5pNo48bW1qwfYXUrRg@mail.gmail.com>
 <1548091897.2465.10.camel@pengutronix.de>
 <601e00d6dd1300737551c2ad82cbec8ab79c67f0.camel@nxp.com>
 <20190122034129.GA3205@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122034129.GA3205@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_232256_504162_6F586F28 
X-CRM114-Status: GOOD (  23.47  )
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
Cc: "festevam@gmail.com" <festevam@gmail.com>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On Tue, Jan 22, 2019 at 09:11:29AM +0530, Manivannan Sadhasivam wrote:
> Hi Daniel,
> 
> On Mon, Jan 21, 2019 at 05:59:42PM +0000, Daniel Baluta wrote:
> > On Mon, 2019-01-21 at 18:31 +0100, Lucas Stach wrote:
> > > Am Montag, den 21.01.2019, 15:30 -0200 schrieb Fabio Estevam:
> > > > Hi Daniel,
> > > > 
> > > > > On Mon, Jan 21, 2019 at 3:25 PM Daniel Baluta <
> > > > > daniel.baluta@nxp.com> wrote:
> > > > > Hi Fabio,
> > > > > 
> > > > > Your patch helps.
> > > > 
> > > > Thanks for testing. I will send it as a formal patch.
> > > 
> > > If you look closely that's exactly the patch 2/2 from this series.
> > > 
> > > Regards,
> > > Lucas
> > > 
> > > > 
> > > > > Now the console works. Anyhow, it seems that now there
> > > > > is a problem with the network card.
> > > > > 
> > > > > [    0.831454] mdio_bus 30be0000.ethernet-1:00: error -2 loading
> > > > > PHY driver module for ID 0x004dd074
> > > > > [    0.840796] fec 30be0000.ethernet: Dropping the link to
> > > > > regulator.0
> > > > > [    0.847212] fec: probe of 30be0000.ethernet failed with error
> > > > > -2
> > > > > 
> > > > > Booting fails now because kernel isn't able to mount to nfs
> > > > > rootfs.
> > > > > 
> > > > > [  111.652134] VFS: Unable to mount root fs via NFS, trying
> > > > > floppy.
> > > > > [  111.658510] VFS: Cannot open root device "nfs" or unknown-
> > > > > block(2,0): error -6
> > > > > 
> > > > > This problem is similar with the one met on i.MX 8QXP.
> > > > 
> > > > Does this patch help?
> > > > 
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fnetdev%2Fmsg545573.html&amp;data=02%7C01%7Cdaniel.baluta%40nxp.com%7Cb3055410508f4333003b08d67fc64cc8%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636836887005112836&amp;sdata=7qSMs76%2B%2Fjdgeu0VWvrj36gTx%2B1tXPLwN8ZoYYmAeLE%3D&amp;reserved=0
> > 
> > Yes, with this patch and 2/2 i.mx8m boots fine.
> > 
> 
> Thanks for sharing the patches!
> 
> > So, Mani I think this should also fix the problem on i.MX8 QXP.
> > 
> > Can you give it a try?
> > 
> > To sum up you need these two patches:
> > 
> > 1) https://www.spinics.net/lists/netdev/msg545573.html
> > 

Just tested the above patch and it fixes the PHY driver issue on my
IMX8QXP board.

Thanks,
Mani

> > 2) https://patchwork.codeaurora.org/patch/700169/
> > 
> 
> My issue was not related to above mentioned patches but anyhow I solved
> it using the kernel command line parameters you gave. Regarding NFS, I'm
> not close yet to have network support on my board. Will give it a shot
> once I add onboard Ethernet/WiFi support.
> 
> Thanks once again!
> 
> Regards,
> Mani
> 
> > thanks,
> > Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
