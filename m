Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6FAC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:49:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E5A20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VQv18IpN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+xNUyXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E5A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oWtIR90iIRsGpJqs7Vgs/5zvKdwfvLC6sYw1Gu2uV8o=; b=VQv18IpNuPemXs
	sPRRJD20Ams1DT149LGvBslyYzpSEjzNvhWVz32DBpGtKBfqb1nYEvMPtiUVwZ8W82Z56ZpLLwj/k
	ul1chu3iobTUTj8TI0p/1ZKpKQ2nZN1Hv7S5hmc0/HRJ7nAiiCushzHGnHMIA51SygQM0fg/6NGv6
	V7XkiPt0OP5VDo7j7c+uevvAMqmRMhXwFRgP+Ely0v+uLITyjDnDkHohF7RB2nCcr1eGXy+y5ljr5
	EXQryr3uMkVNNMkSUm86XwVZdmwELp6gQsj6J2jXpS3eA3gfcpgBt5Y3osGK6R0aXeTAfsZQLuXS7
	bv21nCzSkYsSKo9fphow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuyD-0002Nx-Mb; Thu, 06 Dec 2018 14:49:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuyB-0002Nd-6N
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:49:40 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 64A0820661;
 Thu,  6 Dec 2018 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544107768;
 bh=YRRo4CsBKdVK6NtFcCGcN+qCS5mFG4zp1Ty5UtGw7HI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E+xNUyXAkjERBLyJJUvH9XKz2l2Ke55ju/jBmFpcz7wMjSbD6ZyWQafIGSzgBQbTH
 9C1cbeGDGbecIPI6B0klExgZoDRQDny157tzmHK2DGy1sBUENla5Q7csNuHZHtle1J
 W2sJQKj0j2GaK+Nmih4AMem39HqG5vQHJx2wfrvE=
Date: Thu, 6 Dec 2018 22:48:40 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V5 3/6] ARM: imx: add initial support for imx7ulp
Message-ID: <20181206144838.GD12929@dragon>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
 <1541862478-7839-4-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5A1R-aoDg5d9OLApArz51daaKcpfyDYJH9hWPnjKCH5=g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5A1R-aoDg5d9OLApArz51daaKcpfyDYJH9hWPnjKCH5=g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_064939_255961_CE4AE6A8 
X-CRM114-Status: GOOD (  10.08  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Dong Aisheng <dongas86@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Nov 10, 2018 at 01:51:57PM -0200, Fabio Estevam wrote:
> On Sat, Nov 10, 2018 at 1:14 PM A.s. Dong <aisheng.dong@nxp.com> wrote:
> 
> > +static void __init imx7ulp_init_machine(void)
> > +{
> > +       imx7ulp_pm_init();
> > +
> > +       mxc_set_cpu_type(MXC_CPU_IMX7ULP);
> > +       /* FIXME: so far there is still no way to retrieve SoC version */
> > +       imx_print_silicon_rev("i.MX7ULP", IMX_CHIP_REVISION_UNKNOWN);
> 
> Then maybe just do not call imx_print_silicon_rev() for now?

I'm with Fabio on this.  Applied the patch by dropping the call and
FIXME comment above.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
