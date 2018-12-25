Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C78C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 22:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0F42171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 22:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MlSH6Rde";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8fiLfK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0F42171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0f0OP8FAs8vC2sJTa7TrWz7GJ/HE4LBxGui3JZ8+tU4=; b=MlSH6RdeLh+vI7
	ZfYxaIV3EoEFcCKHJTHKnY76Nkx/UUKaP3O/MKVQj/Oq9vLZ3uqECb03T+oxAQHmN2e0h314Fl4Y/
	FSXDWt8szajo4a7SGZ9/3sMKKHT0y9KJwPdP3V3TNnDfN2V72vTUGp227sNxlphOdG0hqB4BfDkyL
	47e1FICRwpqhOB7DAzQMucGw1K9fNbxGGbZXG/pGmks1DWVriEnUBaLmHNiqY/6qL/oFc/EU3qnwu
	Z+vSAxO9aLO+X27rlnqnqwoe6ncklSovWRXxMAAsBignETcR8JGyfpfspO5UnEF+5suSE0BjXv60N
	w+jTZowSZqlkKO8rB6EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbuwH-0005j9-P1; Tue, 25 Dec 2018 22:12:37 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbuwC-0005h8-QR
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 22:12:34 +0000
Received: by mail-ot1-x341.google.com with SMTP id s5so12929720oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 14:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=H+F/7kpffcrmNLAFlA4wQutLgELa0cIpQ4uv5/ujSEk=;
 b=P8fiLfK03yMTM7XE6f2Ds0glYoRxzHGPBtcnafPmETZmxn2VXTEdfWJd9F2Ty5Oe8q
 p4LrWRFIrjDz1iojSp/BL072c9uq5QPStsI9F3SEjJ+E7ACN0360Qq0xpxgRfWGqbBEZ
 LQDaDkxA6qpIGyHZZieRtMfVMo2up6++yVWGnNRo56Xw662d+B7vf5dRAMwy9BNIajf1
 zocs3wv94Xj9ntP5wp+A4wrIbKyaHVVG7Y8zKcgEEjiz1audCsNhvghteIDLh2n7ukBP
 CRpWw0klrXRLCMfADzygTeD7ir4BUNs10eM7j7d4c47YnGeYy5BK/z6seNiNu4Xnc0jd
 fiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=H+F/7kpffcrmNLAFlA4wQutLgELa0cIpQ4uv5/ujSEk=;
 b=NGTYerZJZowssYdACHtleLkRevhh3Wev49cXRQ7MkyWitAOKKsb6kOd/a+v7vu2aPQ
 Y5wxCwUsgMa2sWs6IuxlyUYFev4ztjb/jGt79kx+2S4QbrjQL/0EcwVXw/F2JhTEsRdT
 1cvJLRXxIqPJz6nyrxFBJqCrptbbTJoRHI5HQPx+8lGpSNIa7Z9+Dlhg1IG1UB1A1C/7
 RjMRrUUIqr+OnfMARF1vKgwb/ke5ApGH5+KUowBCc2ysQMtFIuNqpQ0WAfkSmTz0yUlr
 1Q2JKNfLFcVqSFvym8MREP0BS8zM29yVcgrlDahRh2+kCJHFVCB5FYm18Ni7UiUzp85c
 08dQ==
X-Gm-Message-State: AJcUuke97Jljq0vk0UytTBQNdfPLNvmRZFwuW6KzswPVz3fNB6+orYAj
 rSJKtZzdhHjat8fyXANHZU3bIv4G6mZa0Pr81v8=
X-Google-Smtp-Source: ALg8bN4n4DoI/o7renZYLXiIcxQ2lByhvr3lHP4BDQo8lgAspVaSh51vTURsuGN8CRhRA0nPmv65YYMl/iKxwsNGF7M=
X-Received: by 2002:a9d:734e:: with SMTP id l14mr11308345otk.270.1545775940592; 
 Tue, 25 Dec 2018 14:12:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:6c19:0:0:0:0:0 with HTTP; Tue, 25 Dec 2018 14:12:20
 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1812232304130.2940@hadrien>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAKR_QVJefW1vxYb7-qiU8=0YdbFghYo15SK2eGjOC-dntRfyYA@mail.gmail.com>
 <alpine.DEB.2.21.1812232304130.2940@hadrien>
From: Tom Psyborg <pozega.tomislav@gmail.com>
Date: Tue, 25 Dec 2018 23:12:20 +0100
Message-ID: <CAKR_QVLeZBL43W4x1mzcfcakSZyyh9L81vgUMxfnSccKawEfdg@mail.gmail.com>
Subject: Re: [PATCH 00/20] drop useless LIST_HEAD
To: Julia Lawall <julia.lawall@lip6.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_141232_863249_BC16F07F 
X-CRM114-Status: GOOD (  13.64  )
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

there was discussion about this just some days ago. CC 4-5 lists is
more than enough

On 23/12/2018, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Sun, 23 Dec 2018, Tom Psyborg wrote:
>
>> Why do you CC this to so many lists?
>
> Because the different files are in different subsystems.  The cover letter
> goes to a list for each file, or to a person if there is no list.  The
> patches go to the people and lists associated with the affected files.
>
> julia
>
>>
>> On 23/12/2018, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>> > Drop LIST_HEAD where the variable it declares is never used.
>> >
>> > ---
>> >
>> >  drivers/dma/at_hdmac.c                                |    5 -----
>> >  drivers/dma/dw/core.c                                 |    1 -
>> >  drivers/dma/pl330.c                                   |    1 -
>> >  drivers/dma/sa11x0-dma.c                              |    2 --
>> >  drivers/dma/st_fdma.c                                 |    3 ---
>> >  drivers/infiniband/ulp/ipoib/ipoib_ib.c               |    1 -
>> >  drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    5 -----
>> >  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c       |    3 ---
>> >  drivers/net/ethernet/mellanox/mlxsw/spectrum.c        |    1 -
>> >  drivers/net/wireless/st/cw1200/queue.c                |    1 -
>> >  drivers/scsi/lpfc/lpfc_nvme.c                         |    2 --
>> >  drivers/scsi/lpfc/lpfc_scsi.c                         |    2 --
>> >  drivers/scsi/lpfc/lpfc_sli.c                          |    1 -
>> >  drivers/scsi/qla2xxx/qla_init.c                       |    1 -
>> >  drivers/xen/xenbus/xenbus_dev_frontend.c              |    2 --
>> >  fs/btrfs/relocation.c                                 |    1 -
>> >  fs/nfs/nfs4client.c                                   |    1 -
>> >  fs/nfsd/nfs4layouts.c                                 |    1 -
>> >  fs/xfs/xfs_buf.c                                      |    1 -
>> >  fs/xfs/xfs_fsops.c                                    |    1 -
>> >  20 files changed, 36 deletions(-)
>> >
>>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
