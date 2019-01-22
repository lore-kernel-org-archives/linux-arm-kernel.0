Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:49:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C7E20684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FZTa17vV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C7E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MpUpq97Pwwj9jRgM49ty+rl12AhBHB4yMndK36dIJM0=; b=FZTa17vVv29qz7
	MBTP9moo3snSCp2H0peTrEATg4mbUGIGO6Jt+HUDxDE/90NOzo961BbucrK1c+npup+uRuzffS+eU
	6PTwKTmW4wvvVjczzxR1afe311k+Kl6XqdUNZ/z+7T4mU8H14axqqsBvrgMdbNy55D6DYKVesUXHW
	UwT7TJRLRIIyCLXVFisRdHxO3hDrVUf2siJN4+eT7xQVDxhfcH1GwT+tWma7RVkP0fa0R8VCw650+
	jda2HU1dlSR0O8M12KLi/vjG8NVmIQUKIZLRpvBV6ZbZHZf1OMwYtaiF5j2aEALO+6W42lydg4ENr
	3VewEXzP3SxmP+CWRiSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwQX-00042Z-VQ; Tue, 22 Jan 2019 13:49:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwQU-00042F-Ox
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:49:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FF61EBD;
 Tue, 22 Jan 2019 05:49:14 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56B5B3F614;
 Tue, 22 Jan 2019 05:49:13 -0800 (PST)
Date: Tue, 22 Jan 2019 13:49:07 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH] ARM: dts: vexpress: use list instead of tuple for mmci
 interrupts
Message-ID: <20190122134907.GA18606@e107155-lin>
References: <20190122121850.10120-1-sudeep.holla@arm.com>
 <39d7c460-3ead-34a0-75ad-732089cd9ffc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39d7c460-3ead-34a0-75ad-732089cd9ffc@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_054914_829185_1DBCB4F7 
X-CRM114-Status: GOOD (  11.54  )
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
Cc: linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 01:36:34PM +0000, Vladimir Murzin wrote:
> On 1/22/19 12:18 PM, Sudeep Holla wrote:
> > Vexpress motherboard MMCI requires dedicated interrupts for CMD and PIO,
> > which obviously should be expressed as a list. Current form uses tuple
> > and it works fine since interrupt-cells equal to 1.
> >
> > Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
>
> FWIW
>
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
