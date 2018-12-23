Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3098AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:49:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB112184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rBSV7SkE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqmG7zha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB112184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OvRm0wyTgfrxLbkCaTMS8yrTMDZ5I9qTRPxqvk6DdIo=; b=rBSV7SkE4WjrH9
	KuNFCV4RmvW2TuwoT6A6sHDV1SIjVtvnGdQxIC7sSFQ8vGeY1QPpMUR2sSP1dedgPBAui1fml1V0H
	Kb32mJthOn/f4tav3OkSvrvo9s2+1zLS/gLGj3OJx1uRwiQGSbOwoC8OeONoFwYWprnLRh9rW1klT
	SgPMQN3F9Lo8Eu1y6UUr9ur6ZgaoP0M1iFgSBW9BE8ztmk6Akz6HusmlXmU1l1c247kYNU3HOXxWo
	vdlTA7H63pSFqGHfWS5jcTYGPRaxCbdfX0SBn1J9gdhWpkIt/z39xRFluZq/xiim9bkHlUgprdugF
	7kUQZDrcOpJYi1VSuu1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbBcq-0003tM-Ok; Sun, 23 Dec 2018 21:49:32 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbBcn-0003qy-Ae
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 21:49:30 +0000
Received: by mail-oi1-x244.google.com with SMTP id t204so8876089oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 23 Dec 2018 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=5nekOVn8E/3y11Wo6lTFqhZbWWcKF/FGPvFqNszBb1k=;
 b=sqmG7zha9a8arZm/X7CV2fl+4oV0LbyPT8EBSQbBxKB0whPF8XlxdZM0oSqMLQJXyn
 joMCDNL5WrXT8/OfMgNNHApIlNCCPG7WWzwyE0HrzwNMkm3KdON3LM6/d6KmEKcXudmt
 kT31BC8Y/50ZRKMOshvjsw7ArHAIQoDmRG86OXG9N6YATRlfOZxIEdj8bUVizSS4XqLJ
 3+GXl271HxkkDYqkRuaV6d1ylrX3aTFr7rfYgGdsP5Q21gkDa0GEY/qAhBK9CczfbomS
 soDZP1VtzZGGAlnFz9TTnW9dx6kxFBdDTUZ3AcgVbsEtiCz0xKpS00QNUbOIvIsU9yTB
 W51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=5nekOVn8E/3y11Wo6lTFqhZbWWcKF/FGPvFqNszBb1k=;
 b=PIPAq3XZuKxfmgwzPKnFuSOsQZzGUe9DhjYuTn+jF0lQGLlLrQfLKPKsc9XdGOoexj
 kyFEKxG/Fv3Xeu+xsHJxR973Ne+h0dyiCOa3ajQ1Yz7bStZ+ab9g3nXGcBu1C9QjOVyi
 1lY9SzNU6BXm6rIGMgjGeU0lxis3nJ4yLrxAZgZSAfb5re+HEdrT9ixWGbe5Yg24uuMR
 9BZA1l6PcN4A/N3jZmxk+INtN3gHEyFEla7b4tcj+ZOVHrRS9mPsumyYOPu5JS08JqiZ
 v89CDEUq02BE2rQs4IaNK34KyD4Zlz/gft8l+1deed0voybZpYSJmCbuFXNJncDg7sCP
 Tibw==
X-Gm-Message-State: AA+aEWYQyoRhIKnlli4ajXZ38tU1rF3/OGoux7kaXJqoPo6Izpwtj0lc
 +K8R4bShCNcBSltvJrdMP7d9Z80uTRu1JIADj0A=
X-Google-Smtp-Source: AFSGD/UqXb98WoWfMxLkqUQYnQn7mtTCDKGW00IBAS1v8MbnRQJr1YDat9XwmyF+K2O+jIuVsXUH7mfx8rGd9U04T3I=
X-Received: by 2002:aca:4709:: with SMTP id u9mr6355601oia.212.1545601755567; 
 Sun, 23 Dec 2018 13:49:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:6c19:0:0:0:0:0 with HTTP; Sun, 23 Dec 2018 13:49:15
 -0800 (PST)
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
From: Tom Psyborg <pozega.tomislav@gmail.com>
Date: Sun, 23 Dec 2018 22:49:15 +0100
Message-ID: <CAKR_QVJefW1vxYb7-qiU8=0YdbFghYo15SK2eGjOC-dntRfyYA@mail.gmail.com>
Subject: Re: [PATCH 00/20] drop useless LIST_HEAD
To: Julia Lawall <Julia.Lawall@lip6.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_134929_371504_292D1C81 
X-CRM114-Status: UNSURE (   8.65  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-wireless@vger.kernel.org, linux-nfs@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 dmaengine@vger.kernel.org, xen-devel@lists.xenproject.org,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Why do you CC this to so many lists?

On 23/12/2018, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> Drop LIST_HEAD where the variable it declares is never used.
>
> ---
>
>  drivers/dma/at_hdmac.c                                |    5 -----
>  drivers/dma/dw/core.c                                 |    1 -
>  drivers/dma/pl330.c                                   |    1 -
>  drivers/dma/sa11x0-dma.c                              |    2 --
>  drivers/dma/st_fdma.c                                 |    3 ---
>  drivers/infiniband/ulp/ipoib/ipoib_ib.c               |    1 -
>  drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    5 -----
>  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c       |    3 ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.c        |    1 -
>  drivers/net/wireless/st/cw1200/queue.c                |    1 -
>  drivers/scsi/lpfc/lpfc_nvme.c                         |    2 --
>  drivers/scsi/lpfc/lpfc_scsi.c                         |    2 --
>  drivers/scsi/lpfc/lpfc_sli.c                          |    1 -
>  drivers/scsi/qla2xxx/qla_init.c                       |    1 -
>  drivers/xen/xenbus/xenbus_dev_frontend.c              |    2 --
>  fs/btrfs/relocation.c                                 |    1 -
>  fs/nfs/nfs4client.c                                   |    1 -
>  fs/nfsd/nfs4layouts.c                                 |    1 -
>  fs/xfs/xfs_buf.c                                      |    1 -
>  fs/xfs/xfs_fsops.c                                    |    1 -
>  20 files changed, 36 deletions(-)
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
