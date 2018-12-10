Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109FB2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V1D8BYS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109FB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dVU3lJFDFdXXBiD76kd5cZPXo4I8HVNRxNLg+sg4ds0=; b=V1D8BYS/S+P7SC
	w+Emvqqgw489b7JiANCrhUGqE+56BdmDGp/LcSaKzpsHCgAuAbUqU20FinFe5GUPa3HEy7WheRQOX
	O5AJQUP30SfRnrzmZQWTLJaCsHJ8XYHKQR0pFHUa45eCJwgCNbM/QyY40klH8Y4bdsYZuEgM8Okvm
	MCUKfWj96D+cYyE9TX8NLR7D1zEHy9LLIscKNthDpQdlM8yypF6L2FQVBkMl5KpBIs8SPU02nP3UC
	9LXV3PiXBYPU2JoF7EtZFd7miwlF2yIxsicOd5XXrD78A7YChRwIpA/ktoDYzMCm6oLeOmdx2et22
	yjhG55S2GYucEezgPqKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJnI-0006xF-V5; Mon, 10 Dec 2018 11:32:12 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJnF-0006wY-JN
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:32:11 +0000
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d4144038bcab2e97; Mon, 10 Dec 2018 12:31:53 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
Date: Mon, 10 Dec 2018 12:31:37 +0100
Message-ID: <3143453.Hr4lRPQaf4@aspire.rjw.lan>
In-Reply-To: <CAEExFWtiqTgQmMLwvMhx8UvfU9o75jsZkAjBgyHhAOwuemJdNw@mail.gmail.com>
References: <20181120161451.21149-1-tiny.windzz@gmail.com>
 <CAEExFWtiqTgQmMLwvMhx8UvfU9o75jsZkAjBgyHhAOwuemJdNw@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_033209_799836_B44D0254 
X-CRM114-Status: GOOD (  16.87  )
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
Cc: lorenzo.pieralisi@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sunday, December 9, 2018 7:20:26 AM CET Frank Lee wrote:
> On Wed, Nov 21, 2018 at 12:14 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v3:
> > -update changelog
> > ---
> >  drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> > index db2ede565f1a..650f063ef809 100644
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
> >         /*
> >          * Initialize the driver just for a compliant set of machines
> >          */
> > -       if (!of_match_node(compatible_machine_match, root))
> > +       if (!of_match_node(compatible_machine_match, root)){
> > +               of_node_put(root);
> >                 return -ENODEV;
> > +       }
> > +
> > +       of_node_put(root);
> >
> >         if (!mcpm_is_available())
> >                 return -EUNATCH;
> > --
> > 2.17.0
> >
> ping......

I've been waiting for the maintainers of this driver to speak up.

I'll pick up the patch later today or tomorrow unless there are objections.

Thanks,
Rafael


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
