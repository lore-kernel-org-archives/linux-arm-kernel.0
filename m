Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A948C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:18:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59273213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l/xYGhnd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="E6PrP6At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59273213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kGrJ3RGNRbygXvl9ZBEArLqxJtgyfGwQcCz4+uzLMic=; b=l/xYGhndJP96/c
	R2du9njgTW/CBHFSwREtPqQ5US4SOs4uGAAhQ1BdRCmeAOpCZ+7Ggy1M6cWbNesJX4X8JWlSJH/q9
	ykY9Kp+LUF/xJAoFC+zPFEcisr5HP4K/x062A0oRUlO6tfWnBmx0KiOl0j4fSf9pA85MKXu3SP3Zm
	oVeKRBTjDnoMSAFIfMQKAwEUuEBhpzXjcLL4mOt/JJEToR3IHozbWgCYIKYOblpk+nmU1jraOXrT4
	ntkKpUwRFkYumh2g7gEDNpl5g4e9ofM5w/OHUXdXgOYFjKoh6T/lPhNlhtzWxj/GCmzA18TqF1jCB
	FZG+Qb0k5vCI1virw5nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz0xz-0007iQ-OX; Wed, 27 Feb 2019 15:17:51 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz0xv-0007ht-Th
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 15:17:49 +0000
Received: by mail-pg1-x544.google.com with SMTP id m1so8105743pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 07:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ztjqP1VuN+g3iEnYapJxXdQTlGlWvjXAM/v+qMDTXuE=;
 b=E6PrP6At6RtOVPdYP8r4EqJj1VDw2BRrrfVtDGRAcZM82VlmjQXuv5vEgwPchO2BMx
 Z8DwCOkugmvOXbE27ev1lOLDGImyv4l7gf8NWLUf9bFYFifUWpF0DpcTlbtqJMicFBvk
 NnjF9aPSCmpjcoAKiIW3JmuSkSFaIzzPmFLFJLIKx4Gg5srAPi2kWi7uZrac74mquGih
 khboVw7j8SDpwaKd7bX+zhw5CbVdOMMrUYQD8eRe4SoLOWmM8qg6x9eDE+E9zw3cVVxW
 ZP5ORE2Dcx7mU05i/T1FPMn/ZxDPqYLKTuZ52uPTtP1Bf+NhNy/ojy8qEkQXttyQ+6rZ
 bcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ztjqP1VuN+g3iEnYapJxXdQTlGlWvjXAM/v+qMDTXuE=;
 b=WSIXwOPQ8ZvmdVi4KKLDpppb2BL0m0lLb5qHW0CyIVRm7yF8BPmmasDD6gQod3PauJ
 02VjMF2TpZgowjv3wjqIxYmqmenN0FrN0XS8TDkqxWlIRErqAiHhA+k/biJs2sNEfVsL
 x7uUnyClPh9UiU7z+UDjIev8yAq2wy5fIZ44ZUo3Bo3fqYrYKxryss8jtxMzx7Cu4BAY
 jiXzEIF+RErs0skmIT83UpGEN8kNF2XCatlpC5z53yt4yeU0z6Tc5eFPZDG7TpBBh4Ax
 1mDfiFdvZ++pC68Wp1W5I1Rn48p16kTHAqfHw/lT7ve76XgQsmbZ8Wa9ZnEer9BAZf3U
 4JqA==
X-Gm-Message-State: AHQUAua+NTWTv/NUUX3t3T+JI9bv5DU5tR9VqisiN/iJgCvaevTlDpKa
 c1bgeGv9fGVLV81rF2jXAQ8YGzWiVTol/Z3skzNt/w==
X-Google-Smtp-Source: AHgI3IZ++yeiGkqPRdbt1kSQM/4m7ahJgVlS2Da37s6UT53YMBDpWkaRoskS1bQp56phkFSYULA7j6yAJ9eMX4z0ENQ=
X-Received: by 2002:a65:48c1:: with SMTP id o1mr3352451pgs.94.1551280666811;
 Wed, 27 Feb 2019 07:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20190221222537.137331-1-venture@google.com>
 <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
In-Reply-To: <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
From: Patrick Venture <venture@google.com>
Date: Wed, 27 Feb 2019 07:17:35 -0800
Message-ID: <CAO=notw6Yhi5uSfHtEzSy57JPzhFHiQyPcaZGHhBhLjtmVTaFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
To: Florian Fainelli <f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_071747_983550_E7FB710B 
X-CRM114-Status: GOOD (  24.27  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 9:05 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 2/21/2019 2:25 PM, Patrick Venture wrote:
> > The ASPEED AST2400, and AST2500 in some configurations include a
> > PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> > in the BMC's memory space.  This feature is especially useful when using
> > this bridge to send large files to the BMC.
> >
> > The host may use this to send down a firmware image by staging data at a
> > specific memory address, and in a coordinated effort with the BMC's
> > software stack and kernel, transmit the bytes.
> >
> > This driver enables the BMC to unlock the PCI bridge on demand, and
> > configure it via ioctl to allow the host to write bytes to an agreed
> > upon location.  In the primary use-case, the region to use is known
> > apriori on the BMC, and the host requests this information.  Once this
> > request is received, the BMC's software stack will enable the bridge and
> > the region and then using some software flow control (possibly via IPMI
> > packets), copy the bytes down.  Once the process is complete, the BMC
> > will disable the bridge and unset any region involved.
> >
> > The default behavior of this bridge when present is: enabled and all
> > regions marked read-write.  This driver will fix the regions to be
> > read-only and then disable the bridge entirely.
>
> A complete drive by review, so I could be completely off here (most
> likely am), but have you considered using virtio and doing some sort of
> rudimentary features (regions here) negotiation over that interface?

I have not.

>
> If I get your description right in premise maybe emulating the AHB side
> on the BMC as a PCI end-point device driver, and using it as a seemingly
> regular PCI EP from the host side with BARs and stuff might make sense
> here and be less of a security hole than it currently looks like.

In this case, what I"m trying to do is control access to regions of
BMC physical address space.  The ASPEED BMC is by default, completely
open in this regard, see CVE-2019-6260.  There are two sets of
registers that control the host's ability to read or write the
physical address space.  The host needs to be able to write to the
BMC's physical address space in some use-cases -- one of which is my
firmware staging case.  It could just as easily be used as a memory
buffer region for a virtual nic.  Part of the goal here though is that
the host should not have control of what regions are on/off without
the BMC allowing it.  It's currently a security hole, and this driver
is meant to open that hole on demand for specific purposes, whereas
the default state is completely open.

> --
> Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
