Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F17C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451CA21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tSo4cEMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451CA21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ibQh/WGlIqRS5ESFd3YRgmy811aIhzbwvdDlN2p8E0A=; b=tSo4cEMRHonAy1
	O/D/DVFs+7oLrLnFSAs2JRSs+vl9paKKVT5mDbVpC9o72AL0LAE39bwZeKG4MTTWzLr11AAl/9JYX
	Cz6sE5TByH2QeTGEoap5X+Caqa0PffGQzvXTcVjZkWed+9nbgRJdFuNbMht4OKDO464LCa9SXa+Ks
	7nLs3D2qBjcNXuEJ8Z/Y27PKX3uQ2OOfXXSIiBCLjfR9GQ9KHUQmFdtDuJMkc2WgH/BoIA5w6rqjO
	0IdT14i1YUJ1Hq6Nv8bIm8DcOpGCOMZWDGO6R5QYCWL1gX576YQsyZxVX7txFXwNc3irtRdtAIzGp
	mIVUOKinc867L06tFsZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugsx-0003b2-6e; Fri, 15 Feb 2019 17:02:47 +0000
Received: from mail-qk1-f177.google.com ([209.85.222.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugss-0003Vn-4K
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:02:43 +0000
Received: by mail-qk1-f177.google.com with SMTP id m9so6099431qkl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/9zAIeq2Ol4m9ysnOUmt4bHtlKlrrmIDX6JCSKz/pRE=;
 b=XcL+NMq28RuY0ErL0luISKhMNV7UQgqx9g9Wqv69SqFofsNpx3MwlTMh981jT4cANu
 o8y3hTgXcg+4WEFnnjYpw63mWVB2pRgCyrbVb+q5fsJb6NWZqq7Y/3m4jRlaiT7932tf
 aDRSaSIFDfk1o8t5DcRT8axMSuDhAO5mU7c0S/O1e8At4FkQFDHQkAtJ+2B+OTOsIL7Q
 7B2QRKQhDZgOyB1dDx15NHqLwNcURzxN1jfmFBY2h4xR05bcULSVLeLUQkOUb5ETCLgc
 mSs8uLji179K2AsfdFxmvh8DWlsMdb97AwcUc/OR1XIVLnRMRl7oqR5Wzx3ZqUoYmdkv
 HcNA==
X-Gm-Message-State: AHQUAuajj/V0MugrEHAZZV0QY8rCTYoveJhntWA4XJuCOJYGQsfe3SUg
 T5v88jI4itoK80STXwnxG2HodvvsUGRJJatKdH0=
X-Google-Smtp-Source: AHgI3IbwmLqV3Zax5Lup19d5xghzKvGL2sRDkktZ1FER3kEV3EJDqpUp3luGQUbDVjbSOgqn9rAqzP8y+ECUxSWoBTw=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7767513qkh.173.1550250161012; 
 Fri, 15 Feb 2019 09:02:41 -0800 (PST)
MIME-Version: 1.0
References: <1549044263-5862-1-git-send-email-santosh.shilimkar@oracle.com>
In-Reply-To: <1549044263-5862-1-git-send-email-santosh.shilimkar@oracle.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 18:02:24 +0100
Message-ID: <CAK8P3a3pspTHpVNDxwLG-GyajyjLN4nRz4k-3uUqwOP3xJzP3w@mail.gmail.com>
Subject: Re: [GIT PULL] soc: ti: couple of non critical fixes for v5.1
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090242_371681_C232654E 
X-CRM114-Status: UNSURE (   8.70  )
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
Cc: Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 7:04 PM Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:
> soc: ti: couple of non critical fixes for v5.1
>
>  - Fix the Clang warning for enum in Navigator dma
>  - Simplify code in ti_sci with DEFINE_SHOW_ATTRIBUTE macro

Pulled into arm/drivers, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
