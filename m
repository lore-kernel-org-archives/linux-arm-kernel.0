Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EADDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:12:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE9320700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YrToIG5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE9320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LTrbAwcZ/k4MhNpCyarPD9rgib9KvuU0YmDK4+K0izU=; b=YrToIG5RsQoz+Y
	TAhNohVUNUVsi/pYLmhNSf6zta2wisoDGLdAzI2PvQdL0kj7VP9rNbdmChKKJZ47TpZSxdw5xxQB8
	nCKSeZCbPvNGM4SdneB7Wij3qfZx5P8iEoNAvko6lRXwNWCwywJ7df4vP2JrHtnqarHzKMsnpNyXW
	nzA3BPe4PGO/JxzgAMlevBtzRH2kMCvmXH/UM7QakByPFswE0sA60SflrK+nZxsFwlbEIpG9CQ9Y4
	YvN3DzsejUOWHu1QkBYXLH40EhuNaJf03K9y0dJUQS7eSUsa8y1lwjTomUJjUlMipBe3fN8sVQaYJ
	HAPEMcnPoMfdETF7jScA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxI74-0007Qf-MH; Fri, 22 Feb 2019 21:12:06 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxI71-0007QA-Fc
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 21:12:04 +0000
Received: by mail-qt1-f193.google.com with SMTP id z25so4106535qti.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 13:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5/6WlXmAARviJU8XOK06632xu6cL2IPHrNlhVuJZCX0=;
 b=siYs8oS7CuolYM+tbZmcWvTI6uggr5g3FIs84Lb8gBY/g1iiJjcNmYxFDeIh10yJie
 KCI6TC2AhqPU2sJuOIpGcO3P3PIwy16kWTj4KbaoY4aZoEM9NxKHDvgDeCfNRRtF6Tv9
 ME2oiDE+Bs+y93CqAF4SE7n4DvrADh+Tnzl1uVmVENZuCFnJ3p8t6NtGLA8KXMMIwFLY
 iByK+LjqbAa9pBq/0T0bbXuoWDS55+VEviZxxY/5PgcQMZjc5XRmZnqHHkLTvn16psyi
 CTAA2gi3bw1PIjB0mpJcdSb8yHFaEPVsImlGzN42SyQXDVd4xFy2V22ICp1dxsCBXiDM
 P/AQ==
X-Gm-Message-State: AHQUAuayGjp3gJjTi5Ixei71QIyrc1qqKPuU9FnSmYBAEvSG3uXJjmYj
 Rjj1hITtWDI77mAI3DPkDRfWLkzhZAZBRrxVFAz1BA==
X-Google-Smtp-Source: AHgI3IYsWHxzNHqHuXX04hE05vUeCiZ1YyC64SaluDcId4DzW8PIKnHMP8MtvkdXtbVi9RFa3L4DYsuj5FbkC6xyBv8=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr4716031qtb.343.1550869922656; 
 Fri, 22 Feb 2019 13:12:02 -0800 (PST)
MIME-Version: 1.0
References: <pull-1550848332-146231@atomide.com>
In-Reply-To: <pull-1550848332-146231@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 22:11:46 +0100
Message-ID: <CAK8P3a24M=ACfyLWfOHQ8qfen=L+xAAGb0JsPf-Q9sXmyS7APA@mail.gmail.com>
Subject: Re: [GIT PULL] deprecate old cpsw driver phy mode for v5.1
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_131203_521468_74E4FD57 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
 linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 4:15 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit bae2bf97939aebd74dfd8f0b76b4902a19e63eef:
>
>   dt-bindings: net: ti: deprecate cpsw-phy-sel bindings (2019-02-20 08:14:04 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/cpsw-signed
>
> for you to fetch changes up to dba235fa70cbedf7dd64d5763299451be4b9de16:
>
>   net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver (2019-02-21 07:33:51 -0800)
>
> ----------------------------------------------------------------
> One change to deprecate old CPSW Ethernet PHY mode selection driver
>
> With the device tree changes configuring CPSW with a proper PHY driver,
> we want to deprecate the old driver to avoid new users for it.
>
> Note that this driver is based on the related dts changes.
>

I've added this to the arm/late branch, which seems to be the best
way to deal with the dependency on the DT changes. I expect that
we can send this in the second week after the merge window, together
with any fixes that have come in until then.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
