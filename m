Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EE1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:22:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B413420859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bg745hgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B413420859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9KGr4jJRWKLlY7llxLyF6W95tUtCkNEm6Brhrgg2WdE=; b=Bg745hgKs2FUgD
	In2xNA+cKW5q3I3oTWXYpy3aHqmvQbqRfgxxfex+I1CfOXdMjECR51hxh3CzPIn1MbyG2q9UdiafP
	Mjn/Qs9kj7zP/x/YyPnvo4SoRGfGPs0iaBDIRrxxLSEHDTu/uISGf7szuOpUNLEgVwFBoorcH4YYJ
	f/9Qoep2mTeLXJVXGwKsl4Or69TeI0jqgZiAy2B5oum7yXSQvnfow4lDydqzg/XlYQZFWXPf0EEfY
	/ITI+u+hdJxLuxWZO9w+tXHOtHjsu3xkJZOnyZ8BMcyXi7tK+Pqz8Vc731JE1X2AD/xZvVQLMg1G5
	fbpErQBV/yWM1aeIzblg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiLC-00011k-GM; Wed, 16 Jan 2019 10:22:34 +0000
Received: from bastet.se.axis.com ([195.60.68.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiL5-00011G-J2
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:22:32 +0000
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id B82C718531;
 Wed, 16 Jan 2019 11:22:25 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id EtL5C6cAIssn; Wed, 16 Jan 2019 11:22:24 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id 121721810B;
 Wed, 16 Jan 2019 11:22:24 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 014901E08D;
 Wed, 16 Jan 2019 11:22:24 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E97321E08B;
 Wed, 16 Jan 2019 11:22:23 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
 by boulder03.se.axis.com (Postfix) with ESMTP;
 Wed, 16 Jan 2019 11:22:23 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
 by seth.se.axis.com (Postfix) with ESMTP id DD47110AD;
 Wed, 16 Jan 2019 11:22:23 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
 id D96DD801F0; Wed, 16 Jan 2019 11:22:23 +0100 (CET)
Date: Wed, 16 Jan 2019 11:22:23 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: Implement pgprot_device()
Message-ID: <20190116102223.afiok444j7fghukc@axis.com>
References: <20190114135638.13520-1-vincent.whitchurch@axis.com>
 <20190115102428.yji6viia4lfhecqz@e5254000004ec.dyn.armlinux.org.uk>
 <20190115150816.352ujzjaszj2pbch@axis.com>
 <20190115170415.hkt2kllktxseypdw@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115170415.hkt2kllktxseypdw@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_022229_311207_6C9BF0E8 
X-CRM114-Status: GOOD (  14.65  )
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

On Tue, Jan 15, 2019 at 05:04:15PM +0000, Russell King - ARM Linux admin wrote:
> Argh, soo many problems!  Okay, should be resolved, and I hope I got
> all the places where <unprintable> PHP has changed. ;)  Sorry about
> that.

Thanks, the website now works, but the mail server seems to always fail
to deliver email to patches@armlinux.org.uk.  I'm using the same setup
which I've successfully used to send patches to the patch system before.

 From: Mail Delivery System <Mailer-Daemon@armlinux.org.uk>
 Subject: Mail delivery failed: returning message to sender
 
 [-- Attachment #1 --]
 [-- Type: text/plain, Encoding: 7bit, Size: 0.3K --]
 
 This message was created automatically by mail delivery software.
 
 A message that you sent could not be delivered to one or more of its
 recipients. This is a permanent error. The following address(es) failed:
 
   patches@mail.armlinux.org.uk
     local delivery failed
 
 [-- Attachment #2 --]
 [-- Type: message/delivery-status, Encoding: 7bit, Size: 0.1K --]
 
 Reporting-MTA: dns; mail.armlinux.org.uk
 
 Action: failed
 Final-Recipient: rfc822;patches@mail.armlinux.org.uk
 Status: 5.0.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
