Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405ACC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:24:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1049821736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FLoc0hKc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vh4EG9mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1049821736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WnPkJuvd7PaGv8+0iN7R5WrjAA4qNlwgr2AcNJ1DfBQ=; b=FLoc0hKcPC0DOz
	wFt0A/I18d442TtF2mA/DhBC1YDpt+XVeL6p98B0rBhDfEdWHWoJdvQN48nXA/SIXIf12QrxU0ERo
	4CgW7lRXko+mCinYrGqDcm2zD80OfKV6Lp5l4b+PmW2lFQgiTTpyEp8P5ZDvG4CD9/p4t+b2SM3R1
	UVNc5MY0EPYlxp4q48jKs3v6MFQZovcYSlvEInV/omlptA4DnCNRITJyOqabT9WExtqLh9jQoWznJ
	0Aegu0SMQ3ZrsX9q5MESswKVFBkCQNuPLlpl1+VUKLc1tM2LmiVXKsEJcIzGB8lA9L3src00R1gaK
	gC96xxpxOy8gOBTvztIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggUtY-0007Pf-HC; Mon, 07 Jan 2019 13:24:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggUtQ-0007MT-HK
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 13:24:42 +0000
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 816C421736;
 Mon,  7 Jan 2019 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546867475;
 bh=fZX/Ea7Mjkw2SS6Dj9Ri0jUuqrc9UJGeuII7pD0YV+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vh4EG9mLn1VzVQSIbPRoUtTZ/hZjFYOHyyHtOKZJDutQdx4GB74PlVlkI9Yilb+UA
 BFtNwFYRzh6ealnndcOeZKTpG5P65BVs3SSutP4BMZYWKBBF4BUsHqFKTb9mJtC2kM
 u8AyeOeblb5oL8fnb84taWX0rLIv5I0K8sfAjl5o=
Date: Mon, 7 Jan 2019 07:24:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
Message-ID: <20190107132434.GA113458@google.com>
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
 <20181230010625.GC159477@google.com> <m336qegfzv.fsf@t19.piap.pl>
 <20181231152918.GE159477@google.com>
 <a7531ef2-d6d0-0a48-1558-23474c97b838@ncentric.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a7531ef2-d6d0-0a48-1558-23474c97b838@ncentric.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_052436_901005_14C2C143 
X-CRM114-Status: GOOD (  12.17  )
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
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
 Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
 Robin Leblon <robin.leblon@ncentric.com>,
 Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 09:58:42AM +0100, Koen Vandeputte wrote:
> On 31.12.18 16:29, Bjorn Helgaas wrote:
> >    1) The current one that corrects the address alignment error, and
> Is it required to resend this specific patch?

It's easier if you resend this patch along with the other.  When I
suggest changes to a patch, I mark it (and the whole series if it's
part of a series) as "changes requested" in the patchwork patch
tracker.  That means it falls off my to-do list until the resend
happens.

> >    2) A new one that converts cns3xxx_pci_read_config() to use
> >       pci_generic_config_read() instead of pci_generic_config_read32().
> I'll first extensively test non-32b reads later today and will send a patch
> for it

Perfect, thanks!

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
