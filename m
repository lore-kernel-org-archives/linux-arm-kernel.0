Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B19C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:34:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A022146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJiNu/up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A022146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qFr1N8tWJDq5oNqHsPzFJ/4xDJ9pUJ/LNBcTrDM/mVA=; b=XJiNu/upRLePRH
	zvDkcqwU/lpDT4zh3lJ9my6EauJTNzPLgbrrVpoxYmbMzEr5RAnmGJekUKl//eqbW0yA/9okWq3Py
	XFObZa6tSXvG30wyDgyqhBkmbWrSC3DTMFUV/zdWcwF0LpXZmivMHFRNESKQ/4EQIXpc0V0mYH28h
	9B4xpvuZDhMs5J9LKcIixELyq0smva0upfgbDF76vdrdQC7/w6OP2aQHLo4PNSAdg/s9ojZ3C2a2A
	OgUEaQyCqF3vlB9e4N1USAnhU2xsYZDnoYuxGTp4oOKgpwbWQ5b/VudQi1hs7tfiFKTDnsUco0AK2
	andBzdX8ps+qwvqWm3Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUnEU-0001Mz-QC; Thu, 06 Dec 2018 06:33:58 +0000
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]
 helo=mail.osadl.at)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUnEO-0001MD-8U
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 06:33:56 +0000
Received: by mail.osadl.at (Postfix, from userid 1001)
 id 768FD5C0F63; Thu,  6 Dec 2018 06:32:57 +0000 (UTC)
Date: Thu, 6 Dec 2018 07:32:57 +0100
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Li Yang <leoyang.li@nxp.com>
Subject: Re: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
Message-ID: <20181206063257.GA30835@osadl.at>
References: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
 <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_223352_498276_D6625876 
X-CRM114-Status: GOOD (  24.07  )
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, hofrat@osadl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 02:42:55PM -0600, Li Yang wrote:
> On Sun, Dec 2, 2018 at 3:07 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > devm_kstrdup() may return NULL if internal allocation failed.
> > soc_dev_attr.machine  should be checked (although its only use
> > in pr_info() would be safe even with a NULL). Therefor
> > in the unlikely case of allocation failure, fsl_guts_probe() returns
> > -ENOMEM as this allocating failing is an indication of something
> > more serious going wrong at system level.
> >
> > As  machine  is from the device tree which I assume to be RO - if
> > that assumption is always correct - a better alternative would be
> > to use devm_kstrdup_const() here. That would then simply copy the
> > reference to the RO data and not perform any allocation at all.
> 
> I think your assumption is correct.  Do you want to send a new and
> better version?  :)

The issue was actually more general that I did not find a reliable
method to assure that some object is *always* RO. Even for device
tree data it was not clear to me if there could be systems where
it is not RO.
Anyway - will send the version using devm_kstrdup_const() then.

thx!
hofrat

> 
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
> > ---
> >
> > Problem located by experimental coccinelle script
> >
> > Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)
> >
> > Patch is against 4.20-rc4 (localversion-next is next-20181130)
> >
> >  drivers/soc/fsl/guts.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> > index 302e0c8..a0c751b 100644
> > --- a/drivers/soc/fsl/guts.c
> > +++ b/drivers/soc/fsl/guts.c
> > @@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
> >         if (of_property_read_string(root, "model", &machine))
> >                 of_property_read_string_index(root, "compatible", 0, &machine);
> >         of_node_put(root);
> > -       if (machine)
> > +       if (machine) {
> >                 soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
> > +               if (!soc_dev_attr.machine)
> > +                       return -ENOMEM;
> > +       }
> >
> >         svr = fsl_guts_get_svr();
> >         soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> > --
> > 2.1.4
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
