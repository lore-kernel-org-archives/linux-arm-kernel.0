Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F75C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214892083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HtrECNVC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpubHwcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214892083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vp7/P4WCOk7uT2rd6mWlaOBWyv/VyMQbt50eokDHNG0=; b=HtrECNVCp00Dz1
	miQTvdQVCCx6CKej06A/eVlotTRFePCNNX8kCpKPdahl/nJkg/rtaMS7k0z3rq4NCoQbFrmj86DYn
	NUq6nEKJJNkAm5HAQ9sJBhY0uH1GN/QG99NZiDvv82EoO5GXU0RNMuADUIWWifPCsZ7GvzMQ6KUQx
	3NYcJUxfVby77DyNkwbl3B9PZ6NQW95UOam2sQ7XrOHXuqHDCF/ALavAd2fz3NXn4ETYM+tdrMwDU
	BoBINtpwbFw/QvOitDvAn/122njfwEirCABbTFuzrwMU0rvaEDt6a7Qhie+NsExbtTxOTqoni/puK
	MMYByu7rXL6hBLI4G5Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVVnx-0003nv-Bs; Sat, 08 Dec 2018 06:09:33 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVVns-0003nG-V2
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 06:09:30 +0000
Received: by mail-it1-x144.google.com with SMTP id o19so10251177itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 22:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6Ea0jZuKNEtY1o7RxzehHX5bI1J0CG99DaFvgveuK40=;
 b=hpubHwcdkpXRZ8vmcbb7jIWX2NbuKD1fPk+EoQ9oFP+ylZjCARCnDbe/uX1Zp42LP3
 BM8YVdo+vFpFGn+pwHkzxxtNTsON9GqqZfgluJ7yH5o7B2g7ayo51aR04sKiccY4pKmr
 WpdcDuhChXGCOaV3iS/D3HYqL6dGCMUcUxkN//PlXBmP9fyAVhSHMktoP9TLpquEtIQo
 iUfYmhBCTm8DmSSD7X0fn/yymn0vZePELFGLDalHga9WdUnUBnx/0nHNo/jHmywYU928
 Apbi4XaZSY3XM8kwjRiTXkYFDO82nBPNZwbse3EFDkEhXfwRfpbt798ID+9fbLb3zvbF
 hBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Ea0jZuKNEtY1o7RxzehHX5bI1J0CG99DaFvgveuK40=;
 b=UE7qPRlX+qVXvyavce3N8aLFSgH8951CTa0EhlT5oqqliBHxLs2UkKYJef9xjx8S4O
 GgHTI3ycfjCJPDECN44F4e+aQgYFyErmNmfCixwB18Ixxdo5DXmAtp4VtEymGtEsH3jW
 jBHp6FXnrxXUflK/dwiZZ2TkGqg86mc0PfQafK1b2VUKhajZK4IXJVHFfZVepYEEmStJ
 YYDk5XEqHlEtXIfIE2h1Xu6gAc4bVQhIgP6YFzKgO+1wV48tOpATlw5PJHZIBJlPd3E0
 ZqOxa7RW95ifJBXMTxvWav42cJF0di8E7Nlq//jao56HZkbAvibnHtuyHw9fPMdt9zCu
 ziIg==
X-Gm-Message-State: AA+aEWbgx7y/DBmB1PM4sO4SfDvMYARTKHwfEvtq91l4lsSUhecUkcV3
 9aqgzyzmX+7baUCMP102zgNPxGBIwu4IvZm5KGI=
X-Google-Smtp-Source: AFSGD/UOpvlZFjaU+1z2oqSR8q79q0N56EZJf8x+hwhGKnEVFmfSA5uWAnsLyCm+HRajrQTJje/LWO67BOSjXHvEJ3o=
X-Received: by 2002:a24:8203:: with SMTP id t3mr4432109itd.151.1544249356445; 
 Fri, 07 Dec 2018 22:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <20181207113245.GA30719@ulmo>
In-Reply-To: <20181207113245.GA30719@ulmo>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 8 Dec 2018 11:39:05 +0530
Message-ID: <CABb+yY2jVmzxFR7iqSyMMyE+XZtyHrAPAxM_KMEa7c2zzpSwCA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_220929_026862_6E4B0325 
X-CRM114-Status: GOOD (  49.77  )
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
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org,
 ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 5:02 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Dec 06, 2018 at 11:56:25PM -0600, Jassi Brar wrote:
> > On Thu, Nov 29, 2018 at 9:23 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Wed, Nov 28, 2018 at 11:23:36PM -0600, Jassi Brar wrote:
> > > > On Wed, Nov 28, 2018 at 3:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > > >
> > > > >
> > > > > On 12/11/2018 15:18, Thierry Reding wrote:
> > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > >
> > > > > > The mailbox framework supports blocking transfers via completions for
> > > > > > clients that can sleep. In order to support blocking transfers in cases
> > > > > > where the transmission is not permitted to sleep, add a new ->flush()
> > > > > > callback that controller drivers can implement to busy loop until the
> > > > > > transmission has been completed. This will automatically be called when
> > > > > > available and interrupts are disabled for clients that request blocking
> > > > > > transfers.
> > > > > >
> > > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > > > ---
> > > > > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > > > > >  include/linux/mailbox_controller.h | 4 ++++
> > > > > >  2 files changed, 12 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > > > > index 674b35f402f5..0eaf21259874 100644
> > > > > > --- a/drivers/mailbox/mailbox.c
> > > > > > +++ b/drivers/mailbox/mailbox.c
> > > > > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> > > > > >               unsigned long wait;
> > > > > >               int ret;
> > > > > >
> > > > > > +             if (irqs_disabled() && chan->mbox->ops->flush) {
> > > > > > +                     ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > > > > > +                     if (ret < 0)
> > > > > > +                             tx_tick(chan, ret);
> > > > > > +
> > > > > > +                     return ret;
> > > > > > +             }
> > > > >
> > > > > It seems to me that if mbox_send_message() is called from an atomic
> > > > > context AND tx_block is true, then if 'flush' is not populated this
> > > > > should be an error condition as we do not wish to call
> > > > > wait_for_completion from an atomic context.
> > > > >
> > > > > I understand that there is some debate about adding such flush support,
> > > > > but irrespective of the above change, it seems to me that if the
> > > > > mbox_send_message() can be called from an atomic context (which it
> > > > > appears to), then it should be detecting if someone is trying to do so
> > > > > with 'tx_block' set as this should be an error.
> > > > >
> > > > Layers within kernel space have to trust each other. A badly written
> > > > client can break the consumer in so many ways, we can not catch every
> > > > possibility.
> > > >
> > > > > Furthermore, if the underlying mailbox driver can support sending a
> > > > > message from an atomic context and busy wait until it is done, surely
> > > > > the mailbox framework should provide a means to support this?
> > > > >
> > > > Being able to put the message on bus in atomic context is a feature -
> > > > which we do support. But busy-waiting in a loop is not a feature, and
> > > > we don't want to encourage that.
> > >
> > > I agree that in generally busy-waiting is a bad idea and shouldn't be
> > > encouraged. However, I also think that an exception proves the rule. If
> > > you look at the console drivers in drivers/tty/serial, all of them will
> > > busy loop prior to or after sending a character. This is pretty much
> > > part of the API and as such busy-looping is very much a feature.
> > >
> > > The reason why this is done is because on one hand we have an atomic
> > > context and on the other hand we want to make sure that all characters
> > > actually make it to the console when we print them.
> > >
> > > As an example how this can break, I've taken your suggestion to
> > > implement a producer/consumer mode in the TCU driver where the console
> > > write function will just stash characters into a circular buffer and a
> > > work queue will then use mbox_send_message() to drain the circular
> > > buffer. While this does work on the surface, I was able to concern both
> > > of the issues that I was concerned about: 1) it is easy to overflow the
> > > circular buffer by just dumping enough data at once to the console and
> > > 2) when a crash happens, everything in the kernel stops, including the
> > > consumer workqueue that is supposed to drain the circular buffer and
> > > flush messages to the TCU. The result is that, in my particular case,
> > > the boot log will just stop at a random place in the middle of messages
> > > from much earlier in the boot because the TCU hasn't caught up yet and
> > > there's a lot of characters still in the circular buffer.
> > >
> > > Now, 1) can be mitigated by increasing the circular buffer size. A value
> > > that seems to give reliably good results in 2 << CONFIG_LOG_BUF_SHIFT.
> > >
> > Yes please.
>
> As I explained elsewhere, I actually went and implemented this. But
> given the nature of buffering, this ends up making the TCU completely
> useless as a console because in case of a crash, the system will stop
> working with a large number of characters still stuck in the buffer.
> And that's especially bad in case of a crash because those last
> characters that get stuck in the buffer are the most relevant ones
> because they contain the stack dump.
>
I don't question the utility of TCU. I just wonder if mailbox api
should provide a backdoor for atomic busy-wait in order to support a
sub-optimal hw+fw design.

> > > I thought that I could also mitigate 2) by busy looping in the TCU driver,
> > > but it turns out that that doesn't work. The reason is that since we are
> > > in atomic context with all interrupts disabled, the mailbox won't ever
> > > consume any new characters, so the read pointer in the circular buffer
> > > won't increment, leaving me with no condition upon which to loop that
> > > would work.
> > >
> > So you want to be able to rely on an emulated console (running on a
> > totally different subsystem) to dump development-phase early-boot
> > logs? At the cost of legitimizing busy looping in atomic context - one
> > random driver messing up the api for ever. Maybe you could have the
> > ring buffer in some shmem and only pass the number of valid characters
> > in it, to the remote?
>
> First of all, this is not about development-phase early-boot messages.
> We're talking about the system console here. This is what everyone will
> want to be using when developing on this device. Sure at some point you
> may end up with a system that works and you can have the console on the
> network or an attached display or whatever, but even then you may still
> want to attach to the console if you ever run into issues where the
> system doesn't come up.
>
> Secondly, I don't understand why you think this is an emulated console.
>
It is emulated/virtual because Linux doesn't put characters on a
physical bus. The data is simply handed forward to a remote entity.

> Lastly, I don't understand why you think we're messing up the API here.
> The proposal in this series doesn't even change any of the API, but it
> makes it aware of the state of interrupts internally so that it can do
> the right thing depending on the call stack. The other proposal, in v3,
> is more explicit in that it adds new API to flush the mailbox. The new
> API is completely optional and I even offered to document it as being
> discouraged because it involves busy looping. At the same time it does
> solve a real problem and it doesn't impact any existing mailbox drivers
> nor any of their users (because it is completely opt-in).
>
The 'flush' api is going to have no use other than implement
busy-waits. I am afraid people are simply going to take it easy and
copy the busy-waits from the test/verification codes.
"discouraging" seldom works because the developer comes with the
failproof excuse "the h/w doesn't provide any other way". Frankly I
would like to push back on such designs.

 Anyways, let us add the new 'flush' api.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
