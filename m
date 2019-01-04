Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:17:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669CD208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cfrJ9ITb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669CD208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TVXBqjVMPvo+bXjyyR5t2BOyCX5xqjbxq9yxAkmuwP8=; b=cfrJ9ITb8dPGUi
	ArCbQIVnyE+FKq/sWAby2twRha4MU8sOGJvEearsnHANy0AB982s+dRmz+z7cJYdF3wCd124bS2Bm
	kTBsIP3S6YB53HqZZWQHytttxbXEPROR4uDKB1ue5PCnG0Hv1HzNyKDVevybiGOUMjh9PC5yD8Yx7
	HtfKvyC9MfblAe3DMWImPcO0sLk2U9P044KEHdeJKQtsIZUkB1VeyzKm/MNrxSyvhuRBA290ajO9i
	C5ts3EyoEYKYHUgfpibM7JoRb+0Swjnu4JsyQeMgsC4E+WB8oQvtgAtz3Pw10tnVuHiX1kR/F78kP
	mEXFSqZwzDVLRL+nneGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfNTq-0002SL-MI; Fri, 04 Jan 2019 11:17:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfNTm-0002Qt-AR; Fri, 04 Jan 2019 11:17:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62A4D15AD;
 Fri,  4 Jan 2019 03:17:28 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06AA33F5D4;
 Fri,  4 Jan 2019 03:17:26 -0800 (PST)
Date: Fri, 4 Jan 2019 11:17:21 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: LABBE Corentin <clabbe@baylibre.com>
Subject: Re: [PATCH] PCI: amlogic: fix build failure due to missing
 linux/gpio/consumer.h header
Message-ID: <20190104111721.GA23713@e107981-ln.cambridge.arm.com>
References: <1546592917-27846-1-git-send-email-clabbe@baylibre.com>
 <20190104103015.GA3738@red-moon> <20190104103626.GA8448@Red>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104103626.GA8448@Red>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_031730_363557_0043127A 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: khilman@baylibre.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 11:36:26AM +0100, LABBE Corentin wrote:
> On Fri, Jan 04, 2019 at 10:30:25AM +0000, Lorenzo Pieralisi wrote:
> > On Fri, Jan 04, 2019 at 09:08:37AM +0000, Corentin Labbe wrote:
> > > When building on x86, I got the following build failure:
> > 
> > Hi,
> > 
> > what tree are you testing on and which config ?
> 
> I use the next-20190102 tree
> The config can be found at http://kernel.montjoie.ovh/configs/x86

Ok, right, it is a config that unfortunately the bots failed to test, I
will pick this up and send it to Bjorn for -rc2 (given that the PCI tree
is not in mainline yet).

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
