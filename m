Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5CBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:54:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C047214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kqg4yPM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C047214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HXlv+6i/DffxwtRnARRDFz4Bxv6gAkbz8qjKOfMq/60=; b=kqg4yPM9uicVAQ
	TNBXoCcQ+5NfcxH2nh5il7ciuw2XBrZjHEm7Y3PfRazTmnyeAWhCmSLWbmUQ8qzEBjhJkUfE13jag
	B/rOmJv2Cg2W8fRw0VG3cZQ/06MS+FMI6d6oH9AGzT8vezHv1UIJAKUC9eYbbjo/9gg/mc8TnizR7
	BwHw8uwtq1ghR7ZS67GZ1XDRq8FJDQeADIpPIhbgd0eCbvNEJArpUWIYbbVNa1/fWBrjeSYshmD8e
	z9MHoUrl3wl+CstAmqshj70un1zGpu30txxVCypzo0cX9QJLkLcrxUaN9SuCjENFx0fmi4K79Yx0B
	Cm66CV+helSlg1d272ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gviRl-0000lE-5k; Mon, 18 Feb 2019 12:54:57 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gviRf-0000kS-1k
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:54:55 +0000
Received: by mail-qk1-f196.google.com with SMTP id r21so9846664qkl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 04:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c2E49QAVohFq0rOCe1RTzJv1jXR7Acf6VdRdHZMGLfk=;
 b=DNE5+xgupnTle8cGJeZudt+3P3yck+7VGg4NTOx1o6iPh0jl0ubcYtMxWkemZuQnqv
 9ZbyyntSGSu11hEpbMZlwsIjJRqmB64usLnv7Z17qzVTDRsf5s3eHTmhchKwvorwAw48
 fHHoe/nzK1i+YOg///jO0FjQp6oU6FF9K2qv3lT2PxFnmoy4eGGEVqt5oI3wuCwaLSPq
 yAnNfEdZf1az/sQeExZ4HsYnrp227d/FeaoAy+UHZXwQnXX9athzgOW8Cr0VYW8cT3gJ
 JCyCs+x74hEcFwCp54zsJwkqxz4h0U48ImlAQ6MSK3Ki2IHHFFWKk0+1s0lOkPY8U0vw
 ChVg==
X-Gm-Message-State: AHQUAuYgzbqZRgxd9O8Gf9M5WTxzt8Bs12opSmjc24BZjCNkw4aryuiX
 61++Pcbk1Pw6QlUDibfEv9ohDcTL5fvfNqiwkBs=
X-Google-Smtp-Source: AHgI3IYtUmFwOJkVcrDfgVprQYA8sHo+mTpLFIH2DovLlnErkL5jBuOV7iqqADRTsk7oZeE5VE5V/+M9VQFbceLRTHw=
X-Received: by 2002:a05:620a:12a5:: with SMTP id
 x5mr16657260qki.291.1550494489786; 
 Mon, 18 Feb 2019 04:54:49 -0800 (PST)
MIME-Version: 1.0
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
 <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
 <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com>
 <CAK8P3a0kV4-OF7JPwM9cEqxaPvNM9dFZdyZetc47t+D5izkFwQ@mail.gmail.com>
 <47a3fe9f-8adb-8f47-e7c1-342f8fc318aa@st.com>
 <01d49f11-a68e-1674-e6b7-d1b87aa973c9@st.com>
In-Reply-To: <01d49f11-a68e-1674-e6b7-d1b87aa973c9@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 13:54:32 +0100
Message-ID: <CAK8P3a01rEa3bqHuhgFbNZJrb38f5XrGnDd=W3xKVorfJXHZkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To: Fabrice Gasnier <fabrice.gasnier@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_045454_082117_A2203565 
X-CRM114-Status: GOOD (  15.67  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com, Rob Herring <robh+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Gabriel Fernandez <gabriel.fernandez@st.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 5:32 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 1/28/19 2:20 PM, Fabrice Gasnier wrote:
> > On 1/16/19 4:11 PM, Arnd Bergmann wrote:
> >> On Wed, Jan 16, 2019 at 3:10 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >>
> >> What I mean is that nodes that listed as 'compatible="syscon"' get
> >> probed by the syscon driver even when no other driver references
> >> them, and that in turn would acquire the clock, right?
> >
> > When no other driver references them, nothing happens at probe time on
> > the clock: no calls to get/prepare... the clock.
> >
> > => The clock will remain unrequested & unused until another driver calls
> > one of "of_syscon_register()" variants:
> > - syscon_node_to_regmap
> > - syscon_regmap_lookup_by_compatible
> > - syscon_regmap_lookup_by_phandle
> >
> > When another driver references them (e.g. one of the above calls), then
> > it will acquire the optional clock and use it, e.g.:
> > - clk_prepare() upon of_syscon_register() variants
> > - clk_enable & clk_disable when accessing the registers
> >
> > I hope this clarifies.
>
> I would appreciate to have your feedback.

Yes, I think that's all we need here, thanks for the clarification,
and sorry for dropping the ball on this again.

Acked-by: Arnd Bergmann <arnd@arndb.de>


      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
