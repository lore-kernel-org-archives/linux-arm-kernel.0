Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B65C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:21:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA3921848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t4mlLq8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA3921848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IJg4BcPv+/vaEha/6d2u5c6te3GgA4kM1TMsvrfjRP0=; b=t4mlLq8JqNXzO8
	rM3Y/VsoMOdmvduRw6l9XPeN4x04W8IWs40DquXObe/2Wrd/byeYHkthOY0rZap/4XHgSiQHW5qVK
	AZoiaXHSJ52teNJ6domDvaAAume+2ztcLTrP+VOBqYs5z5vglPvQXSgD9Vhx2svZWueGF8hI5Pdh5
	vKZn6+Mo3k1lcRxbWwk8PXvhHa+/dEaHmLQrM9qBJMUi8Zb6vW/hTz7Ln3hAIjWbHRe2CE9nhxJur
	TOwr0FMVuIokDwJwrCPmJzASVwZYc9rQwUd1beSVhyiPzIIMu8RaSJO8ya0rrARhT3DSNX+4ZeP8j
	BrJ0bLDCp+kAe0dA0v0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1ac-0002Z7-Sc; Tue, 19 Feb 2019 09:21:22 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1aa-0002Ym-53
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:21:21 +0000
Received: by mail-qt1-f194.google.com with SMTP id o6so22327887qtk.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 01:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YaRJXWMPwMF5dOfThdKY2XaRgXEOtBxAahcDGKBFIjY=;
 b=DdPkzSf3DEgeJ8UfUUkwr3aZQNnJ6pxUOEuA7YHLGDA1+x/cOywBmB5aX/fRHVP/lQ
 yUk8/OT9as2QFUscJWHP2u/SytAegLfVmTJDzBPnjXacTMcHZ6qlgoXZpmKvhOsKipqB
 bnRepbvl0x4SdLQka127Y33AkjLzu0ziaDqruCONpfMvilf0SXWTsgqILv97OGjDU/BF
 Zoxdc3X9c61985NN3FrsyCU3iDmmINs2sNGv4nE8SIahDwa5GTnIubWthcA8zL6shm3P
 qas+7cWMzm+X61PMLvWmNwSqZMhKWy7IN6TvFT+M+9R2mgdlzIx2P/rkui6ho/pB8TqO
 5Sew==
X-Gm-Message-State: AHQUAuZGPjhef2o/tFF9WTYGyk8GIVm6hsP5Md9nkcfDwa8h2IxJNXq5
 YPozsgQZXT5jwr13eP+LfUSHzT/udH7BbCRePfo=
X-Google-Smtp-Source: AHgI3IZa7a2MFIPVdfBN9ABbvVneQCmsRaOOBg/wA5iD7KfxHwGBiQJ32bmJ/wzm27PHOhJbEMrZgqQU9YhM2nQg6MI=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr7506433qtb.343.1550568077655; 
 Tue, 19 Feb 2019 01:21:17 -0800 (PST)
MIME-Version: 1.0
References: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
 <7266af3b-aeec-4c29-c96e-ee0d21d3e867@socionext.com>
In-Reply-To: <7266af3b-aeec-4c29-c96e-ee0d21d3e867@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Feb 2019 10:21:01 +0100
Message-ID: <CAK8P3a09+K7ZPBgHs45Z2e_w6DPzXDMPT+DpXBowT0SBu8oCtw@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut
 m10v SoC
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_012120_190614_173E0CF0 
X-CRM114-Status: GOOD (  15.36  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 8:12 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
> On 2019/02/18 21:15, Arnd Bergmann wrote:
> > On Fri, Feb 8, 2019 at 1:26 PM Sugaya Taichi
> > <sugaya.taichi@socionext.com> wrote:
>
> >> +static int __init m10v_pm_init(void)
> >> +{
> >> +       suspend_set_ops(&m10v_pm_ops);
> >> +
> >> +       return 0;
> >> +}
> >> +late_initcall(m10v_pm_init);
> >
> > This requires a check to ensure you are actually on the right platform,
> > otherwise you break suspend/resume in a multiplatform kernel running
> > on anything other than milbeaut.
> >
>
> OK.
> I think the solution is adding a "if statement with mlbeaut compatible"
> above suspend_set_ops(&m10v_pm_ops).

Right, you can either use a call to of_machine_is_compatible(),
or you add a machine descriptor with OF_MACHINE_START()
and use this as the init_late() callback.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
