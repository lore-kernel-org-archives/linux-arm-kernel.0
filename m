Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C6DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:07:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFE32086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NvKWcnxb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWKkeAM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFE32086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hO/j+OBxc8/S33UEH5/dEFzOa29+2lyUI7cmVFtfr7c=; b=NvKWcnxbPNzH+b
	31vHKoTpg3F4sradu4pViJQCJvX/ZRADeEj8G+Aal+odNB4x9zPmL06JjfxejPnGePNQ4a9kuk/tH
	7phPmOlotkE8wygDgAEr3P8BGMXbpCdhPxHxmln6DbnEn7cEZTnOa1N2mNY5wPXLFOhFKz/jMkgdZ
	W6+48fPLx3kB9X5xp/qqFDP5GLAp4kzVlF91x38KWse+TP4WIpYc9LWGSnzEnCcYyScprjd2BrSXT
	nta9DT2nq7YESRlfQBMOD5tvuTXCSZOj3+CSfilsO9lhh1mkJ7wU7FvGXPNDdD/nQLqcNKy1Wzz4V
	8CSVJ7gtcALKN/yQYakQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugxP-0001G3-Ra; Fri, 15 Feb 2019 17:07:23 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugx7-0001C0-Jv
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:07:14 +0000
Received: by mail-pl1-x644.google.com with SMTP id b5so5244572plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nsuKSarvFmTRgzRn0wrMUiXmsy6o7639DMZi3FrBXTw=;
 b=PWKkeAM6+tST/+Wz7EGZL+GL96GQnV6i82wcLb/xcfzGe2Dk9ZXJyk/BTNS3u74MT3
 bafuDZ2HyNehYs0gDzcKkXueQStUS1VqDp8PnHIyXWmyn89FOY+eASTMEYOdEHeEhlpg
 6z3z048VLPB/19qaN1zQZ205nDWNDQOHrEin0xc1o++8uyR5SdCpj58MUl47zo4y6zfO
 l8O94XKuYrY4jKRbfYJrQQUKFXDObWAQ58jFmWLih3BYaNkCLcRZ3vqSIuuOxT38o5sc
 9weU39rK+/cA2/kEDp/BHejJe2LJjfwhY52dXoU1Cy7SAISMoE78R719xL1PttbrMtIL
 VC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nsuKSarvFmTRgzRn0wrMUiXmsy6o7639DMZi3FrBXTw=;
 b=OfrI9o7hBWf94kmejnOOCsaqrn1RnYcRsNzX7wuDu+cak08beW3BwUxjZzM29ciUSt
 M/VK4s/C9SbfadDXXT1TJ0+FCnvJEiLyX7pH8og0TWDwBMec/kcCDDJxRgcKWPOOahJE
 p4z2AYax7xceV4HL90r5d3u+EPBwiS8ZnbiCokFqnaMf22Z+j41fyRNVIvyeUBD4JL+6
 ViXb2ik5M423+njX1A/xEpbh2Mn6Hs1jrK1szwehZK1ABZjBX1+ihaCvCBYt0YU8wW0N
 zQl2d6xWh5xJASlJLEBNS14Iz0lHyF/xAHROGQ7r2XgMhJtQ7a6m3dbICZbguQDZ1934
 o7oQ==
X-Gm-Message-State: AHQUAuYdWOnrjVLnpHK4KtHiO0f22GXA2TcVYB7qTBI8GvTL+mQ0sbko
 IUR2RGhA/OUsfEaJd67tXa8GtTsI4O4QLFRvQV4=
X-Google-Smtp-Source: AHgI3IZK0dX5j5DHuWk3Qm3ryGTko+wu7CxVUwzn8kuYhBRd8DxD3FHrwj9aXThrhQtg+NtzesjP00FyqU6EQuK3wIE=
X-Received: by 2002:a17:902:2aaa:: with SMTP id
 j39mr11380165plb.335.1550250424686; 
 Fri, 15 Feb 2019 09:07:04 -0800 (PST)
MIME-Version: 1.0
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
 <20190215142241.GB55505@lakrids.cambridge.arm.com>
 <CAHrpEqT9sS2gmvB9iSH6V2-B3iza05qMGGLYRwR2sR3ZjO4wqA@mail.gmail.com>
 <20190215170238.GB10859@lakrids.cambridge.arm.com>
In-Reply-To: <20190215170238.GB10859@lakrids.cambridge.arm.com>
From: Zhi Li <lznuaa@gmail.com>
Date: Fri, 15 Feb 2019 11:06:53 -0600
Message-ID: <CAHrpEqQ3Lv3K+k1rFPB_hdMwLgq2zBDk5Bx=qc-Y4R+1kvTgoQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] drivers/perf: imx_ddr: Add ddr performance counter
 support
To: Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090705_750428_4E70F048 
X-CRM114-Status: GOOD (  22.66  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 11:02 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 15, 2019 at 10:04:10AM -0600, Zhi Li wrote:
> > On Fri, Feb 15, 2019 at 8:22 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Wed, Feb 13, 2019 at 06:12:27PM +0000, Frank Li wrote:
> > > > +struct fsl_ddr_devtype_data {
> > > > +     unsigned int flags;
> > > > +};
> > > > +
> > > > +static const struct fsl_ddr_devtype_data imx8_data;
> > > > +static const struct fsl_ddr_devtype_data imx8m_data = {
> > > > +     .flags = DDR_CAP_AXI_ID,
> > > > +};
> > > > +
> > > > +static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> > > > +     { .compatible = "fsl,imx8-ddr-pmu", .data = (void *)&imx8_data},
> > > > +     { .compatible = "fsl,imx8m-ddr-pmu", .data = (void *)&imx8m_data},
> > > > +     { /* sentinel */ }
> > > > +};
> > >
> > > You could encode the flags directly in of_device_id::data, and avoid the
> > > need for this structure entirely.
> >
> > I plan use fsl_ddr_devtype to save some friendly AXI ID name in future, such as
> > GPU  0x111122222
> > VPU  0x333344444
> >
> > so user can use bus master name instead of to look ref manual to get hex number.
> >
> > perf stat -e ddr0/axid_read, axid=GPU
> >
> > But perf application can't pass string by config.
> >
> > Any suggestion here ?
>
> Remove it for now, and we can consider it if/when you add that
> functionality.
>
> However, I will say that in general I am not a fan of coding SoC-level
> details into individual drivers, and I would prefer to avoid hard coding
> the AXI IDs here regardless.
>
> > > > +static u32 ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event)
> > > > +{
> > > > +     int i;
> > > > +
> > > > +     /* Always map cycle event to counter 0 */
> > > > +     if (event == EVENT_CYCLES_ID)
> > > > +             return EVENT_CYCLES_COUNTER;
> > >
> > > What if the cycle counter is already in use?
> >
> > cycles counter is dedicated to cycles events.
> > Can't use for other event.
>
> What I meant was if you have two cycles events, they'll both try to
> configure the cycle counter (e.g. when it overflows), which may not
> behave as you expect.
>
> I think that you should only allow one event to use the cycle counter at
> a time.

Yes, one \only one cycle event can use cycle counter.

best regards
Frank Li

>
> > > > +static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
> > > > +{
> > > > +     int i;
> > > > +     u8 reg;
> > > > +     int val;
> > > > +     int counter;
> > > > +     struct ddr_pmu *pmu = (struct ddr_pmu *) p;
> > > > +     struct perf_event *event;
> > > > +
> > > > +     /* Only cycles counter overflowed can issue irq. all counters will
> > > > +      * be stopped when cycles counter overflow. but other counter don't stop
> > > > +      * when overflow happen. Update all of the local counter values,
> > > > +      * then reset the cycles counter, so the others can continue
> > > > +      * counting.
> > > > +      */
> > >
> > > That is a rather unfortunate design decision.
> > >
> > > Can any of the counters count multiple events per cycle?
> >
> > No,  other events always much less than cycle counters.
>
> Ok. Please describe that in the comment.
>
> Thanks,
> Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
