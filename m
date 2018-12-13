Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ED1C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:50:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB79D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+GvvdPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB79D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gpdT1AdKlvZPSDtjzKZkLa9xxLzSs/rnFpedKuN8nE4=; b=H+GvvdPWKYwaxe
	QXnhhOjKsmBGMI1lNdGNuBrSvRhvSwA29fCX5CFvHnGOSdKCytgcdS0fJWwR4awTJpuyfdztqt4Ih
	K04K/qo93nFKHv3yC/gDTE3+9B98BMs99bLFBmMWtyOlDZCENKGl5BqXnzyBQwoAS2z8BMrk+EKja
	5lWwr8YRaSv+zlF6EuYhlGaRrw34wtez9YOEgTjrVQ/wqveolT5O43wYVbLgSM0tq/fvCQV+ha7U/
	4kd77N6pTTugaVXA59lt4ORQA3Rse9CV+ATpXJ0cyI0F5llqszWr0oVNHbWEAirUwuac2cUF0nGd0
	qwjYzLhcJXskaiyAfMRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOZD-000494-87; Thu, 13 Dec 2018 10:50:07 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOZA-0003HK-RJ
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:50:06 +0000
Received: by mail-oi1-f196.google.com with SMTP id m6so1231673oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 02:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KfThjzzExAxPJ8Efasm9oMAf36zII4AZuo9FWhrjAG8=;
 b=A4F+ikSTe8YKo3a9AAXi03VouuKlLBkRgKBsNZB8gjacVjNamPjmGXh3in1DC16g8y
 5XnIivo5N5OdyaCLUx3C4f4sAEx/HQ2Ng2qv3Hi/1jtHgoVgBjonzZ9h7bfDCVmZ+wPV
 UIHL0CMohh3yD0BGAgzjQNZrZ8ey0WOPJLSsdoSv7cHlYpyhmDwxXlvu7iu47s13cgzU
 knUwWKevJd+h+Fd56QBBlHB3Bk8JNm+DMqPtIgOFBz6cm3j80vGEvOvKUJlPYVDUwFQe
 O9Ft2dKf5xANOBaSDvIRLFIwkJSf0vM9nXlOo/sPwTkJamb3zHgKw8Q6QctJK+DGmIZ9
 SreA==
X-Gm-Message-State: AA+aEWYN0ImOFVpGlCWfzJjv1Y31rROJdRld64+YTdkkrlygSGm3ITFz
 eu/c9R8Pb+AuaqDP6ZUb7fE1xw5AAkleW/vbSnk=
X-Google-Smtp-Source: AFSGD/XWQp2Ugee3yUoeTKs3fpTVNw+E/X9JsPd2mCw71dqI0reQgLwWAWeJeWbDXbAi9IyKMrJemmEkV/htHz1iixI=
X-Received: by 2002:aca:b642:: with SMTP id g63mr2429127oif.195.1544698192914; 
 Thu, 13 Dec 2018 02:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-13-josephl@nvidia.com>
In-Reply-To: <20181213093438.29621-13-josephl@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Dec 2018 11:49:41 +0100
Message-ID: <CAJZ5v0jVFGe6UXsqFEwRL58jAaAp-_FHrkjYkLwtSkSLLOKetg@mail.gmail.com>
Subject: Re: [PATCH V2 12/21] cpufreq: tegra124: do not handle the CPU rail
To: josephl@nvidia.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_025004_886762_9625B40B 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 10:35 AM Joseph Lo <josephl@nvidia.com> wrote:
>
> The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
> rail. So this driver shouldn't handle for the CPU clock switching from
> DFLL to other PLL clocks. It was designed to work on DFLL clock only,
> which handle the frequency/voltage scaling in the background.
>
> This patch removes the driver dependency of the CPU rail, as well as not
> allow it to be built as a module and remove the removal function. So it
> can keep working on DFLL clock.

I assume this entire series to go in via arm-soc, so I won't be
picking up cpufreq changes from it.

Thanks,
Rafael

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
