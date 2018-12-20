Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DF6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:10:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1E421904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RUU9rMjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1E421904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6c1DuOP8A6Y+5+mxifySMEMlAgSTm4aU5jLMWkcKQC8=; b=RUU9rMjEQ2uHK6
	u8bkR6CZhQd+ub42Fo7/GfhdEjEBr6kVbp4Bs5ow4G9TtKpENILUizsRlZ+PL5Dz7wv9a2K7r9v5V
	wxkNU6s20cHLKRQ2TEtyP0bsmKh1cTd9lv/Y6FaOpNTuFSz6SAM7p66ilJRS5Pr9mMrhbWhX4ZyMG
	X6Zbk4zY07KHr2ZL0UwELk/nTl0PDIxZvko61ugCn+N4h3FXMGP0sG42cxzykxtCJCTB43qab6IyI
	195M9p0xO9gmTtrkQCMnjNe+GkZmyg4ekMnI5McuhHobwujWnKNQwVc54FA3ilSOu9oTrpcub+iFK
	fdOuyYIe1j0XJX9YvTgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5aM-0006WS-2p; Thu, 20 Dec 2018 21:10:26 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5aI-0005lz-J0
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 21:10:24 +0000
Received: from 89-77-194-223.dynamic.chello.pl (89.77.194.223) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 90aa37423e1904d5; Thu, 20 Dec 2018 22:10:03 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Date: Thu, 20 Dec 2018 22:09:37 +0100
Message-ID: <2368540.q2jLLRDsj0@aspire.rjw.lan>
In-Reply-To: <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_131022_788420_712C0693 
X-CRM114-Status: GOOD (  11.56  )
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
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Lukas Wunner <lukas@wunner.de>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thursday, December 20, 2018 11:00:29 AM CET Hans de Goede wrote:
> Hi,
> 
> On 19-12-18 23:33, Wolfram Sang wrote:
> > Hi Lukas, Hans,
> > 
> > On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 19-12-18 18:22, Lukas Wunner wrote:
> >>> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
> >>>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
> >>>> +{
> >>>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> >>>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
> >>>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> >>>> +}
> >>>
> >>> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
> >>> Any reason why you can't use that?  If so, it would be good to document the
> >>> reason in the commit message.
> >>
> >> Oh, that is a very good point and that one only gets set on system suspend
> >> and not on resume suspend, working around the problems with the i2c-designware
> > 
> > Just to make it clear: you mean runtime suspend, not resume suspend, or?
> 
> Yes I mean runtime-suspend, sorry.

The power.is_suspended flag is about system-wide suspend, however.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
