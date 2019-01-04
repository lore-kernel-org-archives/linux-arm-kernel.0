Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764E4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:53:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CDF21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MALKGbFy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rNT4JLWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CDF21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=476hyQRPcpVrWie6EUsdGgs+gABTNCRopfUffNn63lY=; b=MALKGbFyoDH9Jr
	Vkf3um4vyj+25ca7Fj5blKk6uDOgfyXzRS5IzAqoJrOW2lTFC56cF3flQ6qvbfoR8qXUY0I9usy9L
	85XxxQt6peb5H/Rk2iyZ2nyQYvU6SQDoX9k5U4/0zWcWp3+1h5GEBkg2vPEGuAurKTDyIqLO+lMTH
	/FctpbUumxf/Le+/uaIXhi5BRUn2Rnjya5Q7cgR1/7gr+/2h7OPSn+dzRC/xQIniuY4vm3vkhdmW2
	j0gAgZw156iTimubsaWTpvJkP5AjPH39dPJ+4o4FOWmHuotHEE3vIefSA+YO2pvHAo57H3iDt64Y+
	QHv8gC/S9DcLz/l9NMvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfUbH-0006fF-PN; Fri, 04 Jan 2019 18:53:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfUbG-0006aW-1v
 for linux-arm-kernel@bombadil.infradead.org; Fri, 04 Jan 2019 18:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mSffHzWHQ6KibovOCh/03NAnuOBxACIgOEjPl+oHwTY=; b=rNT4JLWoUvcnKI3JZRbkpjyzOQ
 /wpkVYlFEOtl0UG/YZtbtvGi2VEmw+Afqas43uRpOkqClGftafFFYEYlQpKXQ1eyp7aOwtWK2QHxp
 QtkHM+LBZS8zr7yjs9VlMTiw3wJDPnwtAv7kL7BmHUwFUM/kv2JKtFFJQcW24SNnnnXXZSrm/v2Sa
 EFZS5kaEIq+Ggyf71q1QniVr1MLgkDivIarekqF4/3YOG4DOmmafAAreJIOXT9lwI/x1+60Bnr/oo
 c+hM2OG3RpCTejkOoFjQ9cYdClPs9bpzgaliV9qpZKolMtNDeKHrrP7druKXFCF4gyB8JAMUoj0YF
 e1ollfbg==;
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]
 helo=smtprelay.hostedemail.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfUMB-0006Gg-41
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 18:38:08 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3F1EF1802FA29;
 Fri,  4 Jan 2019 18:38:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wish49_b837086a7342
X-Filterd-Recvd-Size: 2433
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf09.hostedemail.com (Postfix) with ESMTPA;
 Fri,  4 Jan 2019 18:37:59 +0000 (UTC)
Message-ID: <ddbf72a52cd5b6c5e2cba2c6f301d12be651e220.camel@perches.com>
Subject: Re: [PATCH 07/21] PCI: designware: Make use of IS_ALIGNED()
From: Joe Perches <joe@perches.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Date: Fri, 04 Jan 2019 10:37:57 -0800
In-Reply-To: <9b275993-c511-50d3-e18e-b421010c1bba@synopsys.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
 <20181221072716.29017-8-andrew.smirnov@gmail.com>
 <9b275993-c511-50d3-e18e-b421010c1bba@synopsys.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_183807_269588_A3320A43 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, "linux-imx@nxp.com" <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-02 at 09:33 +0000, Gustavo Pimentel wrote:
> On 21/12/2018 07:27, Andrey Smirnov wrote:
> > Make the intent a bit more clear as well as get rid of explicit
> > arithmetic by using IS_ALIGNED() to determine if "addr" is aligned to
> > "size". No functional change intended.
[]
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
[]
> > @@ -22,7 +22,7 @@
> >  
> >  int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> >  {
> > -	if ((uintptr_t)addr & (size - 1)) {
> > +	if (!IS_ALIGNED((uintptr_t)addr, size)) {

The (uintptr_t) cast could probably be removed as well.

> > @@ -43,7 +43,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
> >  
> >  int dw_pcie_write(void __iomem *addr, int size, u32 val)
> >  {
> > -	if ((uintptr_t)addr & (size - 1))
> > +	if (!IS_ALIGNED((uintptr_t)addr, size))
> >  		return PCIBIOS_BAD_REGISTER_NUMBER;

here too


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
