Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:03:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CD9206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 11:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JPd2Nzfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CD9206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lX9JI3MAWbxyrfepi90cg4eLFxvOaIGKkuinxZtplyI=; b=JPd2NzfhGKR3C+
	6owpvCv/ZsG3E7VgJpP7YbQfo5w+GmvZ9RmYu3CthyoibaGIikM9TIu57pb08iU5bjBGThHLQ1aP8
	JTD3g3smi9NtV5PKPYr5hS9rgzaS7CV/i+ZzJ9XVnCqYn4e5m6D5lVlYBxMonXhL/g7l3JT/DUY9X
	/cNvBffEBgw7JNtyGyqh3fy9lD5n2VCD++Ya4BnhTcJGavMBuuPqzvP061N7mYDiVgg8vlHqBPgpw
	H0DcPK93nCzgaOhbjkMbyxJ9NRi6b0gOp7q+XWajdfNx070708fzA2JS3jTLlM3MWo1Vus32zUgVi
	zie+Yx1eSoEcWwuIi9YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxrZY-0006sP-OL; Sun, 24 Feb 2019 11:03:52 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxrZU-0006rQ-4v; Sun, 24 Feb 2019 11:03:50 +0000
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757554; Sun, 24 Feb 2019 11:03:28 +0000
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/5] spi: core: allow defining time that cs is deasserted
 as a multiple of SCK
From: kernel@martin.sperl.org
In-Reply-To: <20190224103913.bjw7g6ievr75iawz@wunner.de>
Date: Sun, 24 Feb 2019 12:03:33 +0100
Message-Id: <0CA42E9E-3297-41EC-8E90-FAE937E892DE@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
 <20190223084952.14758-4-kernel@martin.sperl.org>
 <20190223124010.y7lsncknnxoblvgz@wunner.de>
 <CCC6392E-3189-49BE-B04D-3997434184D0@martin.sperl.org>
 <20190224103913.bjw7g6ievr75iawz@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
X-Mailer: Apple Mail (2.3124)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_030348_535034_D186BE83 
X-CRM114-Status: GOOD (  18.67  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 linux-spi <linux-spi@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> On 24.02.2019, at 11:39, Lukas Wunner <lukas@wunner.de> wrote:
> 
> On Sat, Feb 23, 2019 at 02:15:13PM +0100, kernel@martin.sperl.org wrote:
>> On 23.02.2019, at 13:40, Lukas Wunner <lukas@wunner.de> wrote:
>>> On Sat, Feb 23, 2019 at 08:49:50AM +0000, kernel@martin.sperl.org wrote:
>>>> Support setting a delay between cs assert and deassert as
>>>> a multiple of spi clock length.
>>> 
>>> The ability to define a unit seems somewhat over-engineered to me.
>>> You're introducing lots of branching and integer divisions (both
>>> comparatively expensive operations) which are executed for every
>>> single transfer (i.e. in a hot path).  I'd recommend standardizing
>>> on a single unit.  If 1 usec is too coarse-grained for your use case,
>>> convert everything to nsec.
>> 
>> Well - a spi_device driver does not actually know what is the
>> actual spi clock configured/used by the spi-bus-driver.
> 
> Which slave device and driver are we talking about anyway?
> Is the driver actually making use of the ability to change the
> speed per-transfer?  Most slaves I've dealt with so far use a
> constant speed.  In that case the master driver could set the
> slave's ->speed_hz member to the effective speed on ->setup()
> and the slave's driver could then calculate the delay in nsec
> or usec based on that speed.

Unfortunately this is not always the case...

Some devices - like the mcp2517fd -  have for example an internal PLL
based on an external clock. So during setup you have to use speed_hz 
of <clock_hz> / 2 (or 4MHz at most) and only when PLL is in sync we 
may be using speed_hz from the dt (or less if a module parameter is
used to limit ourselves further)

So the initial setup would not be able to help here - and every
bus controller would now be required to implement setup.

It also means open coding the calculations in each driver that 
needs something like this.

Thus it is - imo - in the right location to support it in spi core.

This is also the reason why I was asking if the same argument
for a multiple of SCKs may apply also to delay_us.

An ADC spi-slave would be an example where this could be needed
to keep the spi bus quiet during sampling - I remember having
seen one datasheet where cs was required to remain asserted
during sampling and after X SCK cycles the conversion could get read.

> 
>> All it knows is that the device requires X clock cycles of cs high.
> 
> That's what I was driving at with my "to what end?" question.  You've
> apparently got a slave device that requires a delay of a specific number
> of clock cycles.  You should make that explicit in the commit messages,
> ideally by naming the slave that requires it.  Right now your commit
> messages only explain the "what", not the "why".  For an uninitiated
> reader it's helpful to understand the specific motivation of your code
> changes.

I will make that commit message clearer in case a new version of 
the patchset is needed for other reasons.

Thanks,
	Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
