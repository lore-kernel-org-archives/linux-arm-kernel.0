Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62465C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:41:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343C92184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nu0yeulo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343C92184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H2F1WfQ3LyyMOoRsYFu23G+5o/SvvxfkJEL7lCNkUrA=; b=Nu0yeulo3hIPX6
	ICZDGDcTxPpHnz8JQ2uJIa4sEhVdNpPCSJIPpSCzyXDqpcfxI/ufi3nHKR4taxGH7+WUX7rQKefZl
	MvwsCclPkzNYdbq+LAnJuKGcpe8Uhzj7wPxP9crXEZpQsBimbmWwVxrebHFk3Bderrr/MN1gpInLg
	XMo7mEkmlGmcIl5xnBdzMj0hGpUFYSXdm7OGh6UkVb9ufXv/DVhnkZUU0u/JenjsLPgh2Fey/ksbS
	/QWTe8mxobIt0vn83zgpCD9vkXhvhrUw4WsCvGnjsdo+UkaX3mnbAsh+mhqy2C3YgL7xqy9kLq5+3
	mmOlakIThDNoHCd20bgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtYJN-0001xn-Fr; Tue, 12 Feb 2019 13:41:21 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtYJK-0001xM-7E
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 13:41:20 +0000
Received: from windsurf (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id B51E310000A;
 Tue, 12 Feb 2019 13:41:03 +0000 (UTC)
Date: Tue, 12 Feb 2019 14:41:02 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: Out-of-tree mwlwifi driver crashes
Message-ID: <20190212144102.412ef7e6@windsurf>
In-Reply-To: <3029c89268680e5abe4f073d8247f74d@solinno.co.uk>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
 <20190129155913.163f1e98@windsurf>
 <a56827554c95a3bcd8435d72167d35f9@solinno.co.uk>
 <20190129163117.0af2ebb3@windsurf>
 <8eb5b2981e6e60e91a3eacbb88a5ee7b@solinno.co.uk>
 <20190131164653.2599d6e7@windsurf>
 <3029c89268680e5abe4f073d8247f74d@solinno.co.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_054118_412149_A2F7E272 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: linux-pci@vger.kernel.org,
 =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Leigh,

On Thu, 31 Jan 2019 16:06:10 +0000
Leigh Brown <leigh@solinno.co.uk> wrote:

> Thanks for responding. I had to manually apply the patch, but it 
> certainly fixes the issue.

Could you check if the branch at:

  https://github.com/tpetazzoni/linux/tree/5.0/marvell/pci-mvebu-fix

also fixes the issue for you ?

I'm sorry to ask you to do all those tests, but since I don't have a
PCIe device that uses prefetchable memory BARs, I can't test :-/

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
