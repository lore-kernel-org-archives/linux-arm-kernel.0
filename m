Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44B3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:31:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE17821473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WP00SoWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE17821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rg0IabOL1MJVaLoIQcwUb9tqXEj1TTAFJfweUA0d6HE=; b=WP00SoWJ6EuXju
	7Xy1xn9UL/gFvRxjQHCeppVI+vlyMgSYVFAloPXDScU6n9bwqp4cPBz6LlMzbwguOsSn5rDEGMNwS
	r9nhbjLDuVz0gycGCP87zyITnfE13nmeCZEJgbbUNQlYhXet6wLlQgC4LgzpgpBKWBJm1rVDu/qy2
	PtPsQiCHeBRlZsJiyCWb2h7L1LJfinr/b2F9re7jt6VMcEtnX0RbtDkmLf39l1BXOAjLuV2ZdD6KG
	WKOWkEi9hwC4msl10CpqtGVlunU7X+delF7lWFB4e8esuxjF8xinlUrRxNSM3Julilc4bbFZOFAyR
	RzCQ4P/TKHUhTF8OwEcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVMM-0001Gp-28; Tue, 29 Jan 2019 15:31:34 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVMI-0001GQ-OW
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:31:32 +0000
X-Originating-IP: 90.88.147.226
Received: from windsurf (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C39A2FF803;
 Tue, 29 Jan 2019 15:31:18 +0000 (UTC)
Date: Tue, 29 Jan 2019 16:31:17 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: Out-of-tree mwlwifi driver crashes
Message-ID: <20190129163117.0af2ebb3@windsurf>
In-Reply-To: <a56827554c95a3bcd8435d72167d35f9@solinno.co.uk>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
 <20190129155913.163f1e98@windsurf>
 <a56827554c95a3bcd8435d72167d35f9@solinno.co.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_073130_951571_21AA43F0 
X-CRM114-Status: UNSURE (   6.48  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 29 Jan 2019 15:25:05 +0000
Leigh Brown <leigh@solinno.co.uk> wrote:

> With commit in place (crashing):

Thanks. Could you tell your e-mail client to not wrap long lines when
you share logs, or alternatively shared them as attached files? Right
now your logs are badly line wrapped, it is not very practical to
read/use.

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
