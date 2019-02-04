Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43779C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A9620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dnw+KnN5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxfCyna4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A9620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fW6+UgpxiaEWpCQzS1vLTAHIXybXCK2YmDWhGdm6OPY=; b=Dnw+KnN5rKuSjL
	rxeDxsAoLXCQ6Q8LZFhWdudKJfBzsNv9B1PkdLQgI6UKue7d1z4wZl6A/XzontslrOwsVjx6MD4gn
	Ql1yCvcJoNg6QqMZaaWmjXsiMoegzHePbAz2aDfqo8lkd5+wVHLa/fv8S7rJnHbnILjb/YxRdcmnu
	bAEjpCBKRvdg++TmU40w+Fw0544nDRFPmYC72iHO3xo6bY0lEp2LpAMMU0HZAWIK8EdJXYnyE3U47
	zZ+nx3V+X0KGo/oc2gLLEWpiJ5k6HB+oCX7UGW5GEuWd7jjkvsvDcU1enD37rEc9OjPNBCqzM1dW5
	iJ15pAZkmUtwsEBax5yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbu4-0002Zu-FF; Mon, 04 Feb 2019 10:55:04 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbtz-0002NX-5R
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 10:55:01 +0000
Received: by mail-ua1-x943.google.com with SMTP id d2so4314582ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 02:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QA8nYJlICZp+w3q4Mla/VGIwCYru1bzX2Zj9ox/EcUU=;
 b=JxfCyna4RSX5epW3quC7RYyh2gbraKbel12D3J1hdyJo8ga+k5f0spUFw9Sf1XfbC/
 EvgF0pXikWEQbw0XvipJ9BEnUUsTnK00/D8g4M5FO1A+mHQEePNBkCc3O5ZSHs9NHtTx
 yh5CKTJI2hR8YHk4VerTPcnPsPaBA4MQWpjKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QA8nYJlICZp+w3q4Mla/VGIwCYru1bzX2Zj9ox/EcUU=;
 b=JqaHk+jojxzSigXhsrkYA180Q9rT10chxtc5e4j+AznzDjCMC8+CAQPJ2AawD0q6+j
 iFzAKXALRNDdEbzmvvYGvQtrHTVTaarmK/p9AY/yMMfollCLiuqKZ6YOq1Bz47LddyE1
 mF4uVZo1USp5+jM8sAirUMxfRTTrbhm2+UQuIIvqb8i6SIMKA2upDQPL4SyL3M4L1M13
 KSlnT23L+iml15nxmPsDgUxZcwrSyU8yzfFCOsQDf5pvATcJFL9ytypK6/GpKxEUTaCF
 /Cu7WXrlIhzsKUfTi2pBXkw5um5rzxEWRGJ6jrMbZSlO+vxVGd3bvWNwqZH5cGBBLD59
 zrrA==
X-Gm-Message-State: AJcUukcVBPHDOJXuZtbRu22Mj8nPgRY2XH/6olo5n3k2gi555dGTuRbc
 gUiyfna4UqjuyLbpfQEl9t9elTEMYEXvBJWaoCwj2Q==
X-Google-Smtp-Source: ALg8bN7ImlsHOQDKiUXrTICByehoafvlXx2jvWb4QpAm0D5T4BYfdZ0/iu6ZopcAjTOf5eh9cHT9zJj1ntzoFbbaHiQ=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr20306603uad.119.1549277697717; 
 Mon, 04 Feb 2019 02:54:57 -0800 (PST)
MIME-Version: 1.0
References: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
 <1548985091.10251.26.camel@mhfsdcap03>
 <CAPDyKFqHJn9uVkd5z4D5JvNKOtbn3E3SwL_WSgLb1=Lw1SgyUg@mail.gmail.com>
 <0e95e1a1-843e-38ea-c4bb-e6c48432ea7c@intel.com>
In-Reply-To: <0e95e1a1-843e-38ea-c4bb-e6c48432ea7c@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 4 Feb 2019 11:54:21 +0100
Message-ID: <CAPDyKFrvSgK0Om7GUJ143j=U2xDG4n6z6Ym-1znbtMbaw==HkQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To: Adrian Hunter <adrian.hunter@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_025459_356286_BC04E1CA 
X-CRM114-Status: GOOD (  36.32  )
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
Cc: srv_heupstream <srv_heupstream@mediatek.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mediatek@lists.infradead.org,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Hongjie Fang <hongjiefang@asrmicro.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 Kyle Roeschley <kyle.roeschley@ni.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 4 Feb 2019 at 10:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 1/02/19 10:10 AM, Ulf Hansson wrote:
> > On Fri, 1 Feb 2019 at 02:38, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >>
> >> On Thu, 2019-01-31 at 16:58 +0100, Ulf Hansson wrote:
> >>> On Thu, 31 Jan 2019 at 08:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >>>>
> >>>> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> >>>> Therefore, any commands sent to the card should use HS400 timing.
> >>>> It is incorrect to reduce frequency to 50Mhz before sending the switch
> >>>> command, in this case, only reduce clock frequency to 50Mhz but without
> >>>> host timming change, host is still in hs400 mode but clock changed from
> >>>> 200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
> >>>> the switch command gets response CRC error.
> >>>
> >>> According the eMMC spec there is no violation by decreasing the clock
> >>> frequency like this. We can use whatever value <=200MHz.
> >>>
> >>> However, perhaps in practice this becomes an issue, due to the tuning
> >>> for HS400 has been done on the "current" frequency.
> >>>
> >>> As as start, I think you need to clarify this in the changelog.
> >>>
> >> Yes, reduce clock frequency to 50Mhz is no Spec violation, but it may
> >> cause __mmc_switch() gets response CRC error, decreasing the clock but
> >> without HOST mode change, on the host side, host driver do not know
> >> what's operation the core layer want to do and can only set current bus
> >> clock to 50Mhz, without tuning parameter change, it has a chance lead to
> >> response CRC error. even lower clock frequency, but with the wrong
> >> tuning parameter setting(the setting is of hs400 tuning @200Mhz).
> >
> > Right, makes sense.
> >
> >>>>
> >>>> this patch refers to mmc_select_hs400(), make the reduce clock frequency
> >>>> after card timing change.
> >>>>
> >>>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> >>>> ---
> >>>>  drivers/mmc/core/mmc.c | 8 ++++----
> >>>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>>> index da892a5..21b811e 100644
> >>>> --- a/drivers/mmc/core/mmc.c
> >>>> +++ b/drivers/mmc/core/mmc.c
> >>>> @@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >>>>         int err;
> >>>>         u8 val;
> >>>>
> >>>> -       /* Reduce frequency to HS */
> >>>> -       max_dtr = card->ext_csd.hs_max_dtr;
> >>>> -       mmc_set_clock(host, max_dtr);
> >>>> -
> >>>
> >>> As far as I can tell, the reason to why we change the clock frequency
> >>> *before* the call to __mmc_switch() below, is probably to try to be on
> >>> the safe side and conform to the spec.
> >>>
> >> Agree, it Must be more safe with lower clock frequency, but the
> >> precondition is to make the host side recognize current timing is not
> >> HS400 mode. it has no method to find a safe setting to ensure no
> >> response CRC error when reduce clock from 200Mhz to 50Mhz.
> >>> However, I think you have a point, as the call to __mmc_switch(),
> >>> passes the "send_status" parameter as false, no other command than the
> >>> CMD6 is sent to the card.
> >>>
> >> yes, the send status command was sent only after __mmc_switch() done.
> >>>>         /* Switch HS400 to HS DDR */
> >>>>         val = EXT_CSD_TIMING_HS;
> >>>>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> >>>> @@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >>>>
> >>>>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> >>>>
> >>>> +       /* Reduce frequency to HS */
> >>>> +       max_dtr = card->ext_csd.hs_max_dtr;
> >>>> +       mmc_set_clock(host, max_dtr);
> >>>> +
> >>>
> >>> Perhaps it's even more correct to change the clock frequency before
> >>> the call to mmc_set_timing(host, MMC_TIMING_MMC_DDR52). Otherwise you
> >>> will be using the DDR52 timing in the controller, but with a too high
> >>> frequency.
> >>>
> >> for Our host, it has no impact to change the clock before or after
> >> change timing, as the mmc_set_timing() is only for host side, not
> >> related to MMC card side and no commands sent do card before the
> >> timing/clock change completed.
> >
> > Alright. After a second thought, it actually looks more consistent
> > with mmc_select_hs400() to do it after, as what you propose in
> > $subject patch.
> >
> > So, let's keep it as is.
> >
> >>>>         err = mmc_switch_status(card);
> >>>>         if (err)
> >>>>                 goto out_err;
> >>>> --
> >>>> 1.8.1.1.dirty
> >>>>
> >>>
> >>> Finally, it sounds like you are trying to fix a real problem, can you
> >>> please provide some more information what is happening when the
> >>> problem occurs at your side?
> >>>
> >> Yes, I got a problem with new kernel version. with
> >> commit:57da0c042f4af52614f4bd1a148155a299ae5cd8, this commit makes
> >> re-tuning every time when access RPMB partition.
> >
> > Okay, could you please add this as fixes tag for the next version of the patch.
> >
> >>
> >> in fact, our host tuning result of hs400 is very stable and almost never
> >> get response CRC error with clock frequency at 200Mhz. but cannot ensure
> >> this tuning result also suitable when running at HS400 mode @50Mhz. as I
> >> mentioned before, the host side does not know the reason of reduce clock
> >> frequency to 50Mhz at HS400 mode, so what's the host side can do is only
> >> reduce the bus clock to 50Mhz, even it can just only set the tuning
> >> setting to default when clock frequency lower than 50Mhz, but both card
> >> & host side are still at HS400 mode, still cannot ensure this setting is
> >> suitable.
> >
> > Right, thanks for clarifying.
> >
> > So I am expecting a new version with a fixes tag and some
> > clarification of the changelog, then I am ready to apply this to give
> > it some test.
>
> The switch from HS400 mode is done for tuning at times when CRC errors are a
> possibility e.g. after a CRC error during transfer.  So if the frequency is
> not to be reduced, then some mitigation is needed for the possibility that
> the CMD6 response itself will have a CRC error.

That's a good point!

However, how can we know that a CMD6 command is successfully
completed, if there is CRC errors detected during the transmission? I
guess we can't!?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
