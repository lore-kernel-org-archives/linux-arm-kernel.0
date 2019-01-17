Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3979C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:22:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D3320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kf9IJ1Zi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXjcPMfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D3320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Fft8Rd01hBDb/dTKLAkHUYJsW+wxmBvNjbRxYM91ks=; b=Kf9IJ1ZiZjl3T1
	60hExQHpon6TylSqQfYlpwrfSafLKz3sSQ0lzMjXNsXUyGv9XqQ3QVocK9Y7z0gbBFIlVUwyFjU7L
	xhNE2yMO1ljweXXHcjpQOwFIJgpaUSfvF+CVO1OlVi2TIIZpSSRayzYE7jprMD3Z5UHgDVzIT471Z
	GbfMEXlVP65nfCsl3go02w4Fz8TONWqvpxi7xwCY02zhgtlizsNrQUWi8Kpd6q9Fczgv2OAEVJ3/h
	i6UwVdFWUoBaFuqj9yRH1XcgTbsMj8DJvU3o3ISKnHMGbgh0ufKkbWMVloRN5tcB6JpyPZmpzs22O
	LEiMCg8fLsnhtZ8I1BlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk9Uv-0007R0-1C; Thu, 17 Jan 2019 15:22:25 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk9Ur-0007QC-An; Thu, 17 Jan 2019 15:22:22 +0000
Received: by mail-it1-x143.google.com with SMTP id c9so1607619itj.1;
 Thu, 17 Jan 2019 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LnLAybpdoQnr3UI674Pd3aAhNK3gQ91jeRbiR4dTUzo=;
 b=LXjcPMfRXIMWwPJyrnMqKTICp5a1OZY48w+6G2JBs8vl4QdDnuyke2az+Dtx3TKa50
 7cu5HMsSCjnWTcdjf0hMKU6WUM1jdboXfI5IBmn39UmDoOW/r4IY2uMcqvJlGTzmWX/P
 r4KwfWUZK18GUWSzpIaZzNPS/b50y5L7h5AHrP4ZayuOpikN6LIitL7b6+hyBkXJeyF8
 DmYo/JkGL1orbYpF7ecKCk8fKY7GYKF1Foz42ZN4onqL7jfICuCQLmzqdiDBCNVXFTnR
 n74fqkd9CrqapVSUUZuk0WDRg7mKC7JzscM1F7UYpmNw97WERaUttPjZbPilFnqHQS81
 opHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LnLAybpdoQnr3UI674Pd3aAhNK3gQ91jeRbiR4dTUzo=;
 b=EPzdFKzFwXYloaIzILgbgWrzZD1B3EpIzjAMFhm798CxucmtRdmormZfw2deWFREMm
 JBxcAT05GAmzlf715UnuLM7JKsmssAgge6z/se+PSkRoqvHKAKJOq+rUf5Xrz0hengPr
 fxA5kprajDI1M++/D2ffE4ZLqA4NtpmYRveUNy+hxq7NzgoSC7VzJS+jY/C4hpMj25ki
 kqdyPymcVW/EC3sugbUIU5KoF4VMHAhny45h+mCdIwb8fDjbGCz2t9b9+4jzR6+q8Ddi
 BKlVBNmuqSKoB3d1pf+BRQ54LXjDHvUw3vh+9J8Cws6KmfLfojAWrv+FLfhA4TOFStLC
 FbOw==
X-Gm-Message-State: AJcUuket6Dxg6/36VJ7XYpFJFZE5KZnMfcKOitZeFVF7wBiPrwWgaEgk
 pB9aYeSU460ahrKeVBwz06MFWaQT2Ail+Q4g2Hs=
X-Google-Smtp-Source: ALg8bN74wJXGW9IEeBLX1QxSlVn90pBMU9FqRQb0GkEfbZEjdlEV7DYozD61L4nAnmvnYse2QpcxZ8VmUj2kRQbrMX8=
X-Received: by 2002:a02:5184:: with SMTP id s126mr7945358jaa.12.1547738540125; 
 Thu, 17 Jan 2019 07:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20190116050435.11624-1-ck.hu@mediatek.com>
 <20190116050435.11624-2-ck.hu@mediatek.com>
 <CABb+yY0JfRbdVb_3wqxve1pYH0ZpFNrA2Kr6qovBruzhbeFRuw@mail.gmail.com>
 <1547712032.5318.17.camel@mtksdaap41>
In-Reply-To: <1547712032.5318.17.camel@mtksdaap41>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 17 Jan 2019 09:22:09 -0600
Message-ID: <CABb+yY3Lk7up2+mrwQGBowm0j6SEyitQkj0=q9Z+C7aHad56Qw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: Add ability for clients to abort data in
 channel
To: CK Hu <ck.hu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_072221_398389_5BADB1E8 
X-CRM114-Status: GOOD (  24.00  )
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

On Thu, Jan 17, 2019 at 2:00 AM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Jassi:
>
> On Wed, 2019-01-16 at 10:22 -0600, Jassi Brar wrote:
> > On Tue, Jan 15, 2019 at 11:07 PM CK Hu <ck.hu@mediatek.com> wrote:
> > >
> > > This patch supplies a new framework API, mbox_abort_channel(), and
> > > a new controller interface, abort_data().
> > >
> > > For some client's application, it need to clean up the data in channel
> > > but keep the channel so it could send data to channel later.
> > >
> > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > ---
> > >  drivers/mailbox/mailbox.c          | 23 +++++++++++++++++++++++
> > >  include/linux/mailbox_client.h     |  1 +
> > >  include/linux/mailbox_controller.h |  4 ++++
> > >  3 files changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > index c6a7d4582dc6..281647162c76 100644
> > > --- a/drivers/mailbox/mailbox.c
> > > +++ b/drivers/mailbox/mailbox.c
> > > @@ -428,6 +428,29 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
> > >  }
> > >  EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
> > >
> > > +/**
> > > + * mbox_abort_channel - The client abort all data in a mailbox
> > > + *                     channel by this call.
> > > + * @chan: The mailbox channel to be aborted.
> > > + */
> > > +void mbox_abort_channel(struct mbox_chan *chan)
> > > +{
> > > +       unsigned long flags;
> > > +
> > > +       if (!chan || !chan->cl)
> > > +               return;
> > > +
> > > +       if (chan->mbox->ops->abort_data)
> > > +               chan->mbox->ops->abort_data(chan);
> > > +
> > > +       /* The queued TX requests are simply aborted, no callbacks are made */
> > > +       spin_lock_irqsave(&chan->lock, flags);
> > > +       chan->cl = NULL;
> > > +       chan->active_req = NULL;
> > > +       spin_unlock_irqrestore(&chan->lock, flags);
> > > +}
> > >
> > Why not just release and then request channel again ?
> > mbox_abort_channel() is just a copy of mbox_free_channel() and if the
> > abort can sleep, that is more reason to just do that.
>
> The cursor may change position 300 times in one second, so I still
> concern the processing time. Request and free channel looks too heavy to
> do 300 times per second.
You send data 300Hz, not abort ... which is supposed to be a rare event.
And then your shutdown/startup is currently empty, while abort isn't
quite lightweight.

> Conceptually, I just want to clean up the
> channel rather than free and request it, so they are somewhat different.
> I say it may sleep because mbox_abort_channel() is a copy of
> mbox_free_channel(). I could change it to 'must not sleep' because
> Mediatek controller does not sleep in abort callback.
>
No please. Just use the shutdown/startup.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
