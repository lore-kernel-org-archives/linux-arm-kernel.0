Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:13:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A8320675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SQU/qBW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A8320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OZyn9Kxkf9imOnch92UPUjOE89IVQ9yWekQGHN+olaM=; b=SQU/qBW5tuCZsG
	ABrTsKeasUtu6eDRH5mMTKE+azH9udYJTRiz25ECWHaO7t0NWHRO4FzXEN6vQnKfOig0fHCP+sHsB
	Yf0QZD/MFzBMyUObjABeR1DH8R6QS89IRqtTQuGk9eeNUkeCllsjr7ej4T+wCNCI6TCMPfvrx5MBn
	yng7UbtBsND9J5C87APN0D2NyV2/+g/H6EBDNUgl/zIBB187p6LAvFJlHiUSLAGFgjITN2ZGswMFx
	nJK2vaEsfHNZhn+o0hEm3cQ8G8tXP3SCBtQGdkgitTpocPZRA7o/NRVTi9H6MbmBeI4xq4LRJ4gpK
	ZSA6mcNWH7DoAaairWMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufAw-0001pc-BA; Fri, 15 Feb 2019 15:13:14 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufAt-0001pC-7j
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:13:12 +0000
Received: by mail-qk1-f193.google.com with SMTP id r21so5843160qkl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7AymeIgZDFVEmTqbhsE26TTZT0PXkxW3IXL+4ovG8hI=;
 b=hAZM855hF7UFHB3J4t43IQVvWe90CeOdvgrn8v41I2yKG9UXXKvceKth2Bz6uLKgNe
 Z88lZp/0pCAr+7zF+YOT12RtC1+3khQgAn2g5+jIdWzOOSnsh0Ep333DvnNDO2uu8UGg
 H1Pcxdy+pwLxmyTuo9q0jDwu03DJCkKfptOjWliOHPBjlNV93D7F3ahn3hOlqOiJw5H3
 064dDLuWvzbXGGfExSjizRsQIpb5FYSD+8cLXvnHMw4h6wIMKrnBVFxqLm20QAsX/SUd
 xnq7uE5H/t5xtMOVqKoyDrrrGyC+92JPGiGWz3lzOJM4EJwCf8Zc1iW1KD6bwKxaPu1R
 tdcA==
X-Gm-Message-State: AHQUAuZdG64PD7zMU/P3NISI9WFZCp6weKhr2tr7f4cIcOE6HY3FDfO9
 FRwS57CsjsxlZ106nKm74m1pMP+yHTa/z6TQP6A/5A==
X-Google-Smtp-Source: AHgI3IYNDCAaFBSksVREkNpEdJ2oBX3giLPsEsx5MdekbEY9tNMXGbUnWVRYne+5naHhfM+iaFDSAbxWcz/oa1SpELE=
X-Received: by 2002:a37:d492:: with SMTP id s18mr7000817qks.343.1550243590397; 
 Fri, 15 Feb 2019 07:13:10 -0800 (PST)
MIME-Version: 1.0
References: <eca10cf1-d5fc-42a4-0e5c-db45407c0560@monstr.eu>
In-Reply-To: <eca10cf1-d5fc-42a4-0e5c-db45407c0560@monstr.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:12:54 +0100
Message-ID: <CAK8P3a37hLXjxd30AMbkjhAGURsV-yRoXwSL71zJjRXjhmKqBA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: Xilinx Zynq DT changes for v5.1
To: Michal Simek <monstr@monstr.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_071311_270563_849BEFDE 
X-CRM114-Status: GOOD (  12.49  )
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
Cc: arm-soc <arm@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 2:00 PM Michal Simek <monstr@monstr.eu> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the git repository at:
>
>   https://github.com/Xilinx/linux-xlnx.git tags/zynq-dt-for-v5.1
>
> for you to fetch changes up to 1241c72b6db13a1e294f9ea25577a3677733582e:
>
>   ARM: dts: zynq: replace gpio-key,wakeup with wakeup-source property
> (2019-02-12 13:53:33 +0100)
>
> ----------------------------------------------------------------
> ARM: dts: zynq: DT changes for v5.1
>
> - Use new "wakeup-source" instead of "gpio-key,wakeup" in Z-Turn


Pulled into arm/dt, thanks!

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
