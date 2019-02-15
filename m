Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD86C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:28:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6C920643
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C0rFro1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6C920643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=COevmw45q4EnskHmp3Mg5buWThftCnjUi5f+y/X/Lcs=; b=C0rFro1zxf16Dg
	/wBYVgQFpyylSWS85hzhjoiwsrTUhztA/4f/wPCPCC7h9WSFTVHylHEyXV9RngWMugDdbemrKjaqt
	rz2qHXD6oZfRB1iiu8iy4rxqK0jpePHW/dP/x3mb27n2R8mwl3ullz1qqPgUKIR5yqM+cvpwY66wy
	0iTADThaiBm54lFSX1eDa+Q4u9WYmOPCyZzMnS2e8WxE21hQpSAcLBZgMlR9Ui8IhMYyyhBpwwC/s
	YGZzBTTmMU+i1mFXgV96AHygDWAIK1qgFjkQ2X+bDbIksoQ4D55TChOnCIP08y7toAhxct8MjJ5l1
	JuG/JwQG7KzrJF6CqUOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugLy-0001AK-7x; Fri, 15 Feb 2019 16:28:42 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugLv-00019v-C4
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:28:40 +0000
Received: by mail-qt1-f196.google.com with SMTP id p25so11226579qtb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y7k2/so7kSaJ6lzIZPeGqCFAR42XPj+R6a2hD8Y+QFw=;
 b=AbsugxZjwSCL6UmwfatQ4RGXuu3XhJOmWLXVUIYtLmzgA88efoIQeBNztppScrJGao
 iE0fwIKPY3TWlKz//f03svoXD46s5SlBEQTm/en0PRitXljtEeV9agKnvY2D7Sfga/Ik
 QpU3cISXK6KBzGqP4iiBLmxZxqb9hd5l+AZ46vIzdHNJEz0RalHsWb5e/igWPu9ddgK0
 fYomqcUQn3zaxvdR1vVThapaScM3VTEcApQavNjEy2E6F1dwrITShwkFLgZPe6NxjmzN
 TCEn20M/6cO8pv6HQnTSyEXNYRM0H6UkI73t8a7zOvfpTFf0MLwxy5G61P35YPZLM00z
 VDPQ==
X-Gm-Message-State: AHQUAuaT7LCzZaDDVhBn0QaJWaF3R5LAC+dOXgVNtElr3AeE+TQTDJ6o
 0m1MDSNXVxWdwGitmfP6SB1zl4QRKqElQXP8j0U=
X-Google-Smtp-Source: AHgI3IZVaPy3RMqNCVAKpEbBcXOSD+85gngxO5E8JBxIPOnWz1K2oJ36RGjiC/61XuHTlWHWPFOV2CdYt2tsxfDV+BA=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr8096577qtl.343.1550248118508; 
 Fri, 15 Feb 2019 08:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20190208150935.32108-1-thierry.reding@gmail.com>
 <20190208150935.32108-3-thierry.reding@gmail.com>
In-Reply-To: <20190208150935.32108-3-thierry.reding@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:28:22 +0100
Message-ID: <CAK8P3a0zEQ3oY8vYBxpnq3wg0pDfag66Y7FxZ1muvxHh+SwHyg@mail.gmail.com>
Subject: Re: [GIT PULL 2/9] cpufreq: tegra: Add support for Tegra210
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_082839_406773_22264EA7 
X-CRM114-Status: GOOD (  12.75  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> Hi ARM SoC maintainers,
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-cpufreq
>
> for you to fetch changes up to 43c36002b86d6027b48f7c68ac32245f73f29f6b:
>
>   cpufreq: dt-platdev: add Tegra210 to blacklist (2019-02-06 14:31:19 +0100)
>
> Thanks,
> Thierry
>
> ----------------------------------------------------------------
> cpufreq: tegra: Add support for Tegra210
>
> This uses the DFLL clock support to enable CPU frequency scaling on
> Tegra210.

I see the Ack from Viresh, but I don't see why you'd like to have them
merged through the soc tree rather than the cpufreq tree.

Could you clarify? It's no problem to do it, I just want to make sure
there is a good reason for it.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
