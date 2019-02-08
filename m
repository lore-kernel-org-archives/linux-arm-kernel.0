Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B763C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:11:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4F82147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XY4MKxIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4F82147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QEjQ5dmt9pBdGrfhnDC2JYvYRR6ePqPumF7PJ1DAbMQ=; b=XY4MKxILbB7r49
	OVmCqKfH1NAZwk4eA88Izl3aoOKflM64cyXyyt8Inegwdbfm39DQioLju69EYGrICvl5k5JJgBzz+
	KVa5WEigw4aKczeH9GPUk/5TsNfwWqZwILhBm7y4VvdQ+1jTQMc6rJUam62wbBm/53sJgNpM35u5j
	FFg33raDmZJFTXH5qUGur78lOx/nE9tshHYVj8J4+bV+mDIHHAarRa5+fzmVV61eEv+EKUIkEcmnO
	EmmXKCAww2T7CGwnBwGSxnsx+ub5Ju+3ZMM9irss7uStT8k/3fr4EGexAywNXvGGDbkfnCRiY7RUI
	v8tpnKTOt7NjnYqTFizA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grvd3-0008R9-W6; Fri, 08 Feb 2019 02:10:57 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grvd1-0008Qi-Bh
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 02:10:56 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 9BC38108B872F;
 Thu,  7 Feb 2019 18:10:49 -0800 (PST)
Date: Thu, 07 Feb 2019 18:10:49 -0800 (PST)
Message-Id: <20190207.181049.1229639710283404215.davem@davemloft.net>
To: linux@armlinux.org.uk
Subject: Re: [PATCH net-next v2 0/6] Add comphy support for Armada 38x
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
References: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Thu, 07 Feb 2019 18:10:50 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_181055_403868_FEE88805 
X-CRM114-Status: UNSURE (   8.58  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, jason@lakedaemon.net,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, kishon@ti.com, robh+dt@kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 sebastian.hesselbarth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Date: Thu, 7 Feb 2019 16:18:25 +0000

> This series adds support for the comphy for Armada 38x, which allows
> these SoCs to use 2500BASE-X mode with appropriate SFP modules.
> 
> Tested on SolidRun Clearfog after updating for the 5.0 merge window
> changes.

Series applied, thanks Russell.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
