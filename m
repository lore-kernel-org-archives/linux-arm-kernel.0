Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:08:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1A020645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fdHu91Se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1A020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MIglP2KQZREbl/CqKICT0GCOE6Ud7PheZ2F/F3Apyc8=; b=fdHu91SeEMzgsa
	zZUskDJmIl56HQznmQNpAdROdwj+Y/5tb8m8c9Hmp3LoZ3Az6oHFg5hfuvNMEq31EcKmdoPrxsfjF
	eHSPj0Gi0BkoVJcGpjchsdiG29G1FykgUfxYiLIxeFGTKQLFPTsrGG8/9HwzAbdXr57yfx5OIIrGO
	ZiQLPo4/u5PbJ4yqUBAXx7zYT3zBsqGIzrlSJuvVJGnfmZp9jn+gcd3uWfU95Pu7ZA/YcV6mhDUFw
	ZROJHcg6dmLG4VopbBHrxft63HIELUeclj2S5w5QI2pnCUr0d1Oa9kW3/Z0O7KODVaoSAKcVxSVY2
	SNtBMi7b0SZZVZQfsspA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQKK-0006uy-J0; Tue, 15 Jan 2019 15:08:28 +0000
Received: from bastet.se.axis.com ([195.60.68.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQKH-0006uT-FN
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:08:27 +0000
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 91811184DB;
 Tue, 15 Jan 2019 16:08:18 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id DUICAMiahSiT; Tue, 15 Jan 2019 16:08:17 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id 19F76184CA;
 Tue, 15 Jan 2019 16:08:17 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9D701E06C;
 Tue, 15 Jan 2019 16:08:16 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE3741E066;
 Tue, 15 Jan 2019 16:08:16 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder03.se.axis.com (Postfix) with ESMTP;
 Tue, 15 Jan 2019 16:08:16 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
 by thoth.se.axis.com (Postfix) with ESMTP id C1C06183A;
 Tue, 15 Jan 2019 16:08:16 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
 id BA11D80AC4; Tue, 15 Jan 2019 16:08:16 +0100 (CET)
Date: Tue, 15 Jan 2019 16:08:16 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: Implement pgprot_device()
Message-ID: <20190115150816.352ujzjaszj2pbch@axis.com>
References: <20190114135638.13520-1-vincent.whitchurch@axis.com>
 <20190115102428.yji6viia4lfhecqz@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115102428.yji6viia4lfhecqz@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_070825_674074_79E68FBC 
X-CRM114-Status: GOOD (  14.74  )
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

On Tue, Jan 15, 2019 at 10:24:29AM +0000, Russell King - ARM Linux admin wrote:
> Please drop this into the patch system, thanks.
> 
> (Please also note that stuff here has been undergoing a progressive
> major reorganisation and renovation, so I hope that still works!  Note
> that the website now supports https as of last night!)

The login page in the patch system doesn't seem to work if I go to it
from the https://www.armlinux.org.uk/developer/ page.  I always get the
"Error: The server detected that the session cookie was not retained by
your browser, or returned to the server..." message.  It only works if I
go to the login page
(https://www.armlinux.org.uk/utils/login.php?url=/developer/) directly
in a new incognito browser session.

I've tried several different browsers from two different networks so it
seems unlikely that the problem is on the client side.

Attempting to log in (from the incognito session) results in:

 Could not get user id: SQLSTATE[42000]: Syntax error or access
 violation: 1064 You have an error in your SQL syntax; check the manual
 that corresponds to your MySQL server version for the right syntax to
 use near 'foo@bar.com'' and password=PASSWORD(''foo'')' at line 1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
