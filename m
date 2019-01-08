Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:54:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A183D20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OaU+XbSr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ALDXmzQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A183D20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OwVjDu2DZJ3efTF41By/hC30HDRrK/MNSi7C1+aj/GI=; b=OaU+XbSr2faU/5
	TwbEsQvl8lhpBXzBnpcH6uB83wgyxz6OaLHIW8ktVvTflRYATfN5VpP5/aoJOlCNUW6x4AnSl/E0M
	3MDrcoy5utZgnWtpvnWHRVjduU2TXP50d/tv3YzzvYwNNJ/Fglyc/WAsi/omQh88anMm9FHG3D5gS
	/ZSZp3bUu5r+8+5u2ql/mmw4Y9jHQy4CQFSH6bADEncEJmq/F9s3GgBeV1dJz8e8brQrkhQVngbaH
	qVVMs4TI4BkzCmRKhPrOlYVOmyKsliUdg0KxBJHYEt3HRq1yfNl3Y1jOu/QdkYr+/64vlVvSr//8V
	IY5cADdYJSsNdJA7fkPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggo5n-00036d-VQ; Tue, 08 Jan 2019 09:54:40 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggo57-00018b-2P
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j8ywhXL8zWjHLl2a7RMkFM2PP1cm5g+QOAUtTPOccWk=; b=ALDXmzQAOGb18wgk8xuzz0HCh
 C2nhv8dvFUJCFGYc9o6ALqs5DVo1SYlkPdxtnDhOhsvmVOZ+BBucKjWMw8xy+XH1QC/vC8E3uEuzT
 niTh+w2WdOLTe/Ym9/9PEjg9GhnJFtiK67j7Poc7JAOXurB/vthk26qpYNLsNz9eKTOzU=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:46015)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1ggo2x-00013m-81; Tue, 08 Jan 2019 09:51:43 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1ggo2r-00013Z-E7; Tue, 08 Jan 2019 09:51:37 +0000
Date: Tue, 8 Jan 2019 09:51:33 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>
Subject: Re: arm: dma-mapping: CPU may not see up-to-date data after DMA
 transaction
Message-ID: <20190108095133.GP11171@n2100.armlinux.org.uk>
References: <1542872133.26115.4.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122092928.GF30658@n2100.armlinux.org.uk>
 <1542889465.26115.54.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122125100.GG30658@n2100.armlinux.org.uk>
 <1542900920.26115.92.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122165759.GH30658@n2100.armlinux.org.uk>
 <1546927833.511.68.camel@atviedlbe741.rss.d3s.at.thales>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546927833.511.68.camel@atviedlbe741.rss.d3s.at.thales>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_015357_684448_FDA1440C 
X-CRM114-Status: GOOD (  12.71  )
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
Cc: Chris Cole <chris@sageembedded.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 06:10:33AM +0000, JABLONSKY Jan wrote:
> Hi again,
> 
> I saw, that there are some findings in v7_dma_inv_range
> https://patchwork.kernel.org/patch/10673097/
> 
> 
> It wouldn't be better to replace it directly with C&I ?

No.

> Otherwise still there is risk that you lost writes in->out ?
> (Exactly happens in my case)

For a region that is being used to DMA data _from_ the device, the
data we have in the cache need not be written back out except if
there are overlapping cache lines - writing it out would be a
complete waste of bus bandwidth.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
