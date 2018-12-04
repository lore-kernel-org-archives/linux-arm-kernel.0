Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F6BC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:33:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4FD2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeKpZznJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpmubcok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4FD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vVBHiMrDxfq6RVYY2LeoBwYbR9Y9B0BQDuOQlHC5LeE=; b=BeKpZznJWPYaA9
	lNr/xUePcMoE4wVsC1o+JdOnWkkrypniNPWdMaZg78sUuw9PGnBNKRPQDjiUyHQtQxTbXKmiNKnjp
	NLgPp/GYLFp5LD8SETUsBU+a+eod2wPMI/aXP+toNpqo7o07ppSZq6kHQJKtb1HtqLG8NbjyFBkfE
	bX9xC+ca71GKihIJpCj6RXIFgmvRE8mLbpL0pgGxcAhyt2Bd3U9vZF8GJorQFGkIuL3Wm50765RYr
	cICsW1p+SjuBFGJFTyLrZ95rmDJr3UY0T67qdPhO8Hv+aRFZ+kNXzXdMw3x5050Fyoo7pXF4rQGCY
	mdOGshI9auBrUfMFqe9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUAp0-0000kD-Od; Tue, 04 Dec 2018 13:33:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUAoy-0000j5-0b
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 13:33:05 +0000
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 701C2214F1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543930373;
 bh=sBFcr+Jb62B48Hwe1h8iPAD26K2EHQzJ9SUJepkarjA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kpmubcokEvNZiAPDAgfqFP6gCoI+6KbzxfoQ4SwiZvNwM0q5aLMmDW2g0ZAq1Vt42
 6hGAnaYHK3D1zjQCtNqzm5jUsYG4amSrI30bt2jvB/9GRqXIswScvvb82o6eKPPZLt
 SvMAq4HzzlqjYXjmBOwt5FjVuxYAQrQlrBLYnWis=
Received: by mail-qk1-f176.google.com with SMTP id q1so9545953qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 05:32:53 -0800 (PST)
X-Gm-Message-State: AA+aEWZFs/3ydGUF7sk0wky/LKHRUVgyHfZ0wafLBAyeZBp700k9vqhK
 iKACLU90IK9omF0QbgYd443JmwrNEBQ5f/BOXg==
X-Google-Smtp-Source: AFSGD/VMrJg6doU0xFmV7V+hms34CTpTPhPJPLZU6kGzHVDcmsr4VzsC++J9376JDB1j2bVVFVMqPXZls0uYhEkqGcg=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr18998224qkg.147.1543930372509; 
 Tue, 04 Dec 2018 05:32:52 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
 <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
 <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com>
 <CAL_Jsq+dnKht3TwCh1qB1H4pYFhQJmSN0nAayU+=PJLAvq0bbQ@mail.gmail.com>
 <90b00858-6e9e-8f7c-f6d4-b35e5daa6eee@socionext.com>
In-Reply-To: <90b00858-6e9e-8f7c-f6d4-b35e5daa6eee@socionext.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 4 Dec 2018 07:32:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=FRfzVFiOJ0wvoV5iZV+Gx3ft9pGyhb-GoKnOAQgPtQ@mail.gmail.com>
Message-ID: <CAL_JsqJ=FRfzVFiOJ0wvoV5iZV+Gx3ft9pGyhb-GoKnOAQgPtQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
To: sugaya.taichi@socionext.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_053304_085103_B3061BCF 
X-CRM114-Status: GOOD (  28.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-clk <linux-clk@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 5:30 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi
>
> On 2018/12/04 0:49, Rob Herring wrote:
> > On Mon, Dec 3, 2018 at 1:42 AM Sugaya, Taichi
> > <sugaya.taichi@socionext.com> wrote:
> >>
> >> Hi,
> >>
> >> On 2018/11/30 17:16, Stephen Boyd wrote:
> >>> Quoting Sugaya, Taichi (2018-11-29 04:24:51)
> >>>> On 2018/11/28 11:01, Stephen Boyd wrote:
> >>>>> Quoting Sugaya Taichi (2018-11-18 17:01:07)
> >>>>>>     create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>>>> new file mode 100644
> >>>>>> index 0000000..f5d906c
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>>>> @@ -0,0 +1,12 @@
> >>>>>> +Socionext M10V SMP trampoline driver binding
> >>>>>> +
> >>>>>> +This is a driver to wait for sub-cores while boot process.
> >>>>>> +
> >>>>>> +- compatible: should be "socionext,smp-trampoline"
> >>>>>> +- reg: should be <0x4C000100 0x100>
> >>>>>> +
> >>>>>> +EXAMPLE
> >>>>>> +       trampoline: trampoline@0x4C000100 {
> >>>>> Drop the 0x part of unit addresses.
> >>>>
> >>>> Okay.
> >>>>
> >>>>
> >>>>>> +               compatible = "socionext,smp-trampoline";
> >>>>>> +               reg = <0x4C000100 0x100>;
> >>>>> Looks like a software construct, which we wouldn't want to put into DT
> >>>>> this way. DT doesn't describe drivers.
> >>>> We would like to use this node only getting the address of the
> >>>> trampoline area
> >>>> in which sub-cores wait.  (They have finished to go to this area in previous
> >>>> bootloader process.)
> >>>
> >>> Is this area part of memory, or a special SRAM? If it's part of memory,
> >>> I would expect this node to be under the reserved-memory node and
> >>> pointed to by some other node that uses this region. Could even be the
> >>> CPU nodes.
> >>
> >> Yes, 0x4C000100 is a part of memory under the reserved-memory node. So
> >> we would like to use the SRAM ( allocated 0x00000000 ) area instead.
> >> BTW, sorry, the trampoline address of this example is simply wrong.  We
> >> were going to use a part of the SRAM from the beginning.
> >>
> >>>
> >>>>
> >>>> So should we embed the constant value in source codes instead of getting
> >>>> from
> >>>> DT because the address is constant at the moment? Or is there other
> >>>> approach?
> >>>>
> >>>
> >>> If it's constant then that also works. Why does it need to come from DT
> >>> at all then?
> >>
> >> We think it is not good to embed constant value in driver codes and do
> >> not have another way...
> >> Are there better ways?
> >
> > If this is just memory, can you use the standard spin-table binding in
> > the DT spec? There are some requirements like 64-bit values even on
> > 32-bit machines (though this gets violated).
>
> The spin-table seems to be used on only 64-bit arch. Have it ever worked
> on 32-bit machine?

Yes.

> And I would like not to use it because avoid violation.

The issue now that I remember is cpu-release-addr is defined to always
be a 64-bit value while some platforms made it a 32-bit value.
'cpu-release-addr' is also used for some other enable-methods.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
