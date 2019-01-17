Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:01:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA06020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QZzDDD7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA06020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oju99TD4kEkfOoXUqeWLj4GkzQ2hs0xlRc+lwB66hvI=; b=QZzDDD7uKrGXRl
	N97yRC3zL5D34VaLzo/l0GfxKKjAaT5rVlUVb5ZKn1KaV4JJc7/t0U3O6Y0GZ/JvwtKCKx1sKIQeo
	uPe/A7UroQ7PSPLHSRFtba/luq6dpSXnWEVSIQ48mX+1e3PIOX5JkIiObUiscZoc4eJJkMwhZ+RBp
	xXBhluGN2eiIhu6/xXeWcOWh4CBrDtYkpcz1fa6L1D2FtI8qQjilACij8hlm/QuQdT5WRRgZqZLoN
	u09ccemfL+XHdPMC8G1JZSL2qfrpQyZNjD+eKhmgPJMKGKnqllZKr4JOF2u+tVclMAcPxF9D/Defs
	ApQFE+A9H/Fq1PiWNW1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk2bj-0001rJ-Rw; Thu, 17 Jan 2019 08:00:59 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk2bg-0001q5-A4; Thu, 17 Jan 2019 08:00:57 +0000
X-UUID: 1a46da721cf8472c98f520f24f95c928-20190117
X-UUID: 1a46da721cf8472c98f520f24f95c928-20190117
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 301534704; Thu, 17 Jan 2019 00:00:36 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 00:00:34 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 16:00:32 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 16:00:32 +0800
Message-ID: <1547712032.5318.17.camel@mtksdaap41>
Subject: Re: [PATCH 1/3] mailbox: Add ability for clients to abort data in
 channel
From: CK Hu <ck.hu@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 17 Jan 2019 16:00:32 +0800
In-Reply-To: <CABb+yY0JfRbdVb_3wqxve1pYH0ZpFNrA2Kr6qovBruzhbeFRuw@mail.gmail.com>
References: <20190116050435.11624-1-ck.hu@mediatek.com>
 <20190116050435.11624-2-ck.hu@mediatek.com>
 <CABb+yY0JfRbdVb_3wqxve1pYH0ZpFNrA2Kr6qovBruzhbeFRuw@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0AE1DE8F454E571EC2C12497B1F87F8F86732474482BE7D983F49524CDF2F1912000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_000056_359546_24AF9069 
X-CRM114-Status: GOOD (  19.95  )
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

Hi, Jassi:

On Wed, 2019-01-16 at 10:22 -0600, Jassi Brar wrote:
> On Tue, Jan 15, 2019 at 11:07 PM CK Hu <ck.hu@mediatek.com> wrote:
> >
> > This patch supplies a new framework API, mbox_abort_channel(), and
> > a new controller interface, abort_data().
> >
> > For some client's application, it need to clean up the data in channel
> > but keep the channel so it could send data to channel later.
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > ---
> >  drivers/mailbox/mailbox.c          | 23 +++++++++++++++++++++++
> >  include/linux/mailbox_client.h     |  1 +
> >  include/linux/mailbox_controller.h |  4 ++++
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index c6a7d4582dc6..281647162c76 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -428,6 +428,29 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
> >  }
> >  EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
> >
> > +/**
> > + * mbox_abort_channel - The client abort all data in a mailbox
> > + *                     channel by this call.
> > + * @chan: The mailbox channel to be aborted.
> > + */
> > +void mbox_abort_channel(struct mbox_chan *chan)
> > +{
> > +       unsigned long flags;
> > +
> > +       if (!chan || !chan->cl)
> > +               return;
> > +
> > +       if (chan->mbox->ops->abort_data)
> > +               chan->mbox->ops->abort_data(chan);
> > +
> > +       /* The queued TX requests are simply aborted, no callbacks are made */
> > +       spin_lock_irqsave(&chan->lock, flags);
> > +       chan->cl = NULL;
> > +       chan->active_req = NULL;
> > +       spin_unlock_irqrestore(&chan->lock, flags);
> > +}
> >
> Why not just release and then request channel again ?
> mbox_abort_channel() is just a copy of mbox_free_channel() and if the
> abort can sleep, that is more reason to just do that.

The cursor may change position 300 times in one second, so I still
concern the processing time. Request and free channel looks too heavy to
do 300 times per second. Conceptually, I just want to clean up the
channel rather than free and request it, so they are somewhat different.
I say it may sleep because mbox_abort_channel() is a copy of
mbox_free_channel(). I could change it to 'must not sleep' because
Mediatek controller does not sleep in abort callback.

Regards,
CK


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
