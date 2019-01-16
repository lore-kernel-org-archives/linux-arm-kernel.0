Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:23:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F8F20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pobZ2K+/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIoT07Qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F8F20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Os+9vkhbKh/rOiBL0q2KtTIRdPjypjZKxi9SqzThias=; b=pobZ2K+/jWF/q1
	1m8u81OGL8yAmqhOhWEpm+ZM74ObmeQ9tQszLC8m7+AEH5l8Ap8S+ToKFHDCv1HlEE/FWFA0m0z6e
	Hv084QZa26Tgyke0Gr5bC/MqV8n7UAsaXdRpZlAlcR8VaZkNYQJnFofoz1YokG82BKpYLSzRQW5Ul
	pvtkElKNFrB1WBm7WMUYf6FjET9gRFSOD6F7FK9m0zocyOmxudxqua6r9akdZPP5Ii2yEYLMdpHKm
	zBY/I1j0Jqcb2FsLiawU7/eNsas3X1gBh4Hd3CC8EQxh3yGhpMtYqXOiIny7dIgDHgCZMAuqyOKc7
	zHkRzGY1i06zYE1FHpaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjny0-0005CS-CA; Wed, 16 Jan 2019 16:23:00 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjnxq-0005BQ-Gj; Wed, 16 Jan 2019 16:22:57 +0000
Received: by mail-it1-x141.google.com with SMTP id p197so3499757itp.0;
 Wed, 16 Jan 2019 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=odzEPFh2R4153nbmby6d3fB0YZ9yrH7zNan7H4T23Zs=;
 b=vIoT07Qf/LQMlj7FzoIe5zbGbERviN40guiKKeko66HZ9iEd7VjHxOipK1gh8d1YLr
 GxEoq7CdrNAQa1njO2cATW8sbRr97IYd5SpVb9DwWbEyJPvFXmMkqPtxoN0lPptY97jS
 BJE7VNRWb05cQyjvoqYpEgm96YU0xcAwFunt/UD7gKQt/DEG2h59H6spkGoVpO9qHnA5
 poRUeGNeVy841Jd6ABC9LP9nCBQknYxyAoaDaXqPlF3tLRKDHCoAw5e0ojk+zeRjSF6y
 XHYqoByrH5aw3kS9XXTAvhBQYdfzGFB3Mp5L8ZnIyu9Eamv7/oC+2663ELKp4s9fHFov
 7e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=odzEPFh2R4153nbmby6d3fB0YZ9yrH7zNan7H4T23Zs=;
 b=d/jF25rbLVclwUFif7KRYGKp8kqV6eA5joOENk9T0GcKyT2NwCm+usNFB7HdPjkRGT
 kxQwvaN0YYNQaKDkJcf87AX+fkPm49sfVO9rknIoSAbeAnPEddAx8rP4T7/6/IVVqy1Y
 sng9pq4wz92AZJivtJhfUAkoUEKg83WpAcLhUZYHQClGq4HOo0kOxNKQVY5EsecCNew6
 RketXBy4RvMBsy3xMXfkwJFE7GWhmj3AGeczdcfvNUl5paunEFMfLYUJB8zLKdQ5f8dV
 6yWTe1TQ3UQd7LsOtC93zcZORKlCf/UTZZnOewO/hvpLTIviZ2Kwb73evSaH7mGLTYPP
 uSVQ==
X-Gm-Message-State: AJcUukfi2iqzJQ2pRIpDy/qtV62UDKLa8zjPuLfRhZiQqpNFsmqMP1sa
 i3RA2ON1HEM7myxovzoXwwbySidu0403PJyKhoA=
X-Google-Smtp-Source: ALg8bN56eZG90BjU47A9+yzw4uSiaytI2qC2ek9t8fGu1Nj0K8Y/HzrR00wzH4IjGxw63UsFf3E/BYLwGkBrg7V/aJc=
X-Received: by 2002:a02:13c6:: with SMTP id 189mr5635699jaz.117.1547655769320; 
 Wed, 16 Jan 2019 08:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20190116050435.11624-1-ck.hu@mediatek.com>
 <20190116050435.11624-2-ck.hu@mediatek.com>
In-Reply-To: <20190116050435.11624-2-ck.hu@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 16 Jan 2019 10:22:38 -0600
Message-ID: <CABb+yY0JfRbdVb_3wqxve1pYH0ZpFNrA2Kr6qovBruzhbeFRuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: Add ability for clients to abort data in
 channel
To: CK Hu <ck.hu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_082250_586295_955E617E 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: srv_heupstream@mediatek.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Houlong Wei <houlong.wei@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 11:07 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> This patch supplies a new framework API, mbox_abort_channel(), and
> a new controller interface, abort_data().
>
> For some client's application, it need to clean up the data in channel
> but keep the channel so it could send data to channel later.
>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/mailbox/mailbox.c          | 23 +++++++++++++++++++++++
>  include/linux/mailbox_client.h     |  1 +
>  include/linux/mailbox_controller.h |  4 ++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index c6a7d4582dc6..281647162c76 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -428,6 +428,29 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
>  }
>  EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
>
> +/**
> + * mbox_abort_channel - The client abort all data in a mailbox
> + *                     channel by this call.
> + * @chan: The mailbox channel to be aborted.
> + */
> +void mbox_abort_channel(struct mbox_chan *chan)
> +{
> +       unsigned long flags;
> +
> +       if (!chan || !chan->cl)
> +               return;
> +
> +       if (chan->mbox->ops->abort_data)
> +               chan->mbox->ops->abort_data(chan);
> +
> +       /* The queued TX requests are simply aborted, no callbacks are made */
> +       spin_lock_irqsave(&chan->lock, flags);
> +       chan->cl = NULL;
> +       chan->active_req = NULL;
> +       spin_unlock_irqrestore(&chan->lock, flags);
> +}
>
Why not just release and then request channel again ?
mbox_abort_channel() is just a copy of mbox_free_channel() and if the
abort can sleep, that is more reason to just do that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
