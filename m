Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F105C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:44:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FDA20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YuoFdn6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FDA20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x2MQ2j+yezh+r9DNAPnBH4pCfre69gDd9ItI/Mm32VI=; b=YuoFdn6KuVbAMG
	sqkMlDhT5y1Ij+5EM1aTg5XPCdXa2gP6HIXct4lB2ThPPtRSHQ0UqpzeoO+i0jk2S8udYvr5Yzhab
	q9vnMLhnLBM7WWX01QUBA7bg0+IIqjy7LPIEzwrhsx1hOIWdce9MWDRtcV9anoSFu5MzIBDxBKJh1
	d0uFX/TCwV7GcGSd9lt3DmPv1UuAHkAmCLqwkUUieISy6jKrBHj2FIEbRkCfk8v9zt/bpebOkOJGg
	I6SoURrsZcNKEpRdbsvOAyqtBS2jW91kWNKv2+XBRICCGiXi5WT1QXhXxHzY4tK7H15NX6xDFOeGs
	l13zd2I5vofT51B1BnnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghmnn-0002UG-NU; Fri, 11 Jan 2019 02:44:07 +0000
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]
 helo=mail.osadl.at)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghmnj-0002TD-I6
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 02:44:05 +0000
Received: by mail.osadl.at (Postfix, from userid 1001)
 id AE90F5C033D; Fri, 11 Jan 2019 03:43:34 +0100 (CET)
Date: Fri, 11 Jan 2019 03:43:34 +0100
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Message-ID: <20190111024334.GA12140@osadl.at>
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
 <20181222075944.GA26155@osadl.at>
 <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_184403_784149_06B34AC9 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 01:43:01PM -0600, Li Yang wrote:
> On Sat, Dec 22, 2018 at 2:02 AM Nicholas Mc Guire <der.herr@hofr.at> wrot=
e:
> >
> > On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> > > On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > > > devm_kstrdup() may return NULL if internal allocation failed, but
> > > > as  machine  is from the device tree, and thus RO, devm_kstrdup_con=
st()
> > > > can be used here, which will only copy the reference.
> > >
> > > Is it really going to only copy the reference?  That would require th=
at
> > > is_kernel_rodata(machine) be true, which it shouldn't be since it's n=
ot part
> > > of the kernel image.
> > >
> > I had tried to figure out what is RO and what not but was not
> > able to determine that - from the discussion it seemed that the
> > assumption of RO is correct though I did not ask if it would
> > satisfy is_kernel_rodata() so that explains the incorrect assertion.
> > see https://lkml.org/lkml/2018/12/6/42
> > So then the only option is to check the return and cleanup
> > on allocation failure as the orriginal patch proposed.
> =

> Thanks for the good discussion. I will drop the previous patch. But
> would it also be good to just have "soc_dev_attr.machine =3D machine"
> directly?
>
I think that the intent is to switch to =

managed devm API so that the cleanup is handled properly
currently you would get "machine" from =

 of_property_read_string_index =

  -> of_property_read_string_helper
   -> of_find_property
which does not do any allocation - so there would actually
not be anything to cleanup here - don=B4t see why your solution
would not be suitable given the current API. the only advantage
of the devm_kstrdup() is that underlying APIs internal changes
would have no effect.

thx!
hofrat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
