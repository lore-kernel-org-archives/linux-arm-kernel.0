Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA0EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:04:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D44320672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fqBHctfO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CetDD4u1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQtvVvuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D44320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1oQsUcORDZ+89tApWDzSEN23GbY/EKGKPG6LXvXI/k0=; b=fqBHctfO5glVco
	fzLNev8D5x+HgbgmQvRsr5SUiA1hNCd/RCXaKDc3pLL91peoCIwm4zoME1CViZim4dFMN19GMeTop
	/tFt9i5cgVG8gQSvK7uzrARKhh7ZuQohFJ1rIqZtAlmQbL5t1mafHMbUbsVPX91+THcU4KEBW87oe
	V2SXlMldwWdW9qlG6OqBEjilVRBLDt9CvcMESCWTVFSQWPXqniT7JLzDFhsyYX4JaJh98GDds66pj
	pxMLdgKdgpSql6x1PSWcXwtsZvhHDC1mRLuAn+/LnkYhtNFkoYxiQ8LKCt3Mkq4hrLFuXBJPQwLhw
	3tMpXi818RFU+Z1EKbkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqhV-0001Y8-L0; Mon, 03 Dec 2018 16:04:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqhT-0001Ll-3g
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 16:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yBXkX3rcczG4mv3Q9aWvY5yAS/+Z4MxAHl9QsNgwyJs=; b=CetDD4u16T2ooIhqy0EBpm4I4
 0vZfiBei4RCPp3KZmircwtaiGOeMhACII8Ir7twgaqBiRTgAlJ7h9ia3GshBXx/yRLmUcotZ6umJi
 S3GwBLkGfuIflARrhqmUDr2/UNzXVKQ6pDHd7QPCMfbNE9PfWKGBNmy930X4AMSwto5ap3MXLw/Ul
 5zbzj21ljcLfsvuo3L4enwO0/BSoL4eIKnLjKpME26D+pY7HycOY7sRe4ZCx8BueGeMnPspB7yeNT
 0zibZAsrKvXdI5logDb1nG0R6ZR/bbMMMpmiAi5dXAEbknl9mXimrKYr102JeGoukczI91Y0DSdRj
 aSv0/Ep1A==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqTr-0002Z2-1n
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:49:57 +0000
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 585FD214DE
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543852181;
 bh=pN3h6zRzeTbZdA+F+ILK+NrhH5etsg5R8T3a6yNT9J0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qQtvVvuq4G319BAMalYpRBu4O4mDIbG0mfb4ByxjvUtyC60D2GNrAeKlBRSM8dKZT
 W8B8ESfb3Cmh9g4j1/OKNCxtot5silr3tuAz5MLW1BF6iiYssaYGJW6R3f1kggDZlB
 yTNUfCxP9+lJBOVXXQOleynqI8rYP9wmUiO36dFk=
Received: by mail-qk1-f177.google.com with SMTP id m5so7572590qka.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 07:49:41 -0800 (PST)
X-Gm-Message-State: AA+aEWZY2PFK8Z+5cPwg/D37QU3wphxyZK0df0p88kBekBQYzZTZ8W56
 hzovD6h4BxfwL/4ePUD3vhJYzZPCrSFt7AziMg==
X-Google-Smtp-Source: AFSGD/WYph9gLXfZcLl1K4BXPdpETtX1EUB57VQti7f5ViXIcMxMmpiz31TH63qvElH/gTIBXMldVDgE9okz0vCwU4c=
X-Received: by 2002:a37:7682:: with SMTP id r124mr15416720qkc.79.1543852180470; 
 Mon, 03 Dec 2018 07:49:40 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
 <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
 <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com>
In-Reply-To: <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 3 Dec 2018 09:49:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+dnKht3TwCh1qB1H4pYFhQJmSN0nAayU+=PJLAvq0bbQ@mail.gmail.com>
Message-ID: <CAL_Jsq+dnKht3TwCh1qB1H4pYFhQJmSN0nAayU+=PJLAvq0bbQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
To: sugaya.taichi@socionext.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_154955_360138_58CF3B06 
X-CRM114-Status: GOOD (  34.60  )
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

On Mon, Dec 3, 2018 at 1:42 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi,
>
> On 2018/11/30 17:16, Stephen Boyd wrote:
> > Quoting Sugaya, Taichi (2018-11-29 04:24:51)
> >> On 2018/11/28 11:01, Stephen Boyd wrote:
> >>> Quoting Sugaya Taichi (2018-11-18 17:01:07)
> >>>>    create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>> new file mode 100644
> >>>> index 0000000..f5d906c
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>> @@ -0,0 +1,12 @@
> >>>> +Socionext M10V SMP trampoline driver binding
> >>>> +
> >>>> +This is a driver to wait for sub-cores while boot process.
> >>>> +
> >>>> +- compatible: should be "socionext,smp-trampoline"
> >>>> +- reg: should be <0x4C000100 0x100>
> >>>> +
> >>>> +EXAMPLE
> >>>> +       trampoline: trampoline@0x4C000100 {
> >>> Drop the 0x part of unit addresses.
> >>
> >> Okay.
> >>
> >>
> >>>> +               compatible = "socionext,smp-trampoline";
> >>>> +               reg = <0x4C000100 0x100>;
> >>> Looks like a software construct, which we wouldn't want to put into DT
> >>> this way. DT doesn't describe drivers.
> >> We would like to use this node only getting the address of the
> >> trampoline area
> >> in which sub-cores wait.  (They have finished to go to this area in previous
> >> bootloader process.)
> >
> > Is this area part of memory, or a special SRAM? If it's part of memory,
> > I would expect this node to be under the reserved-memory node and
> > pointed to by some other node that uses this region. Could even be the
> > CPU nodes.
>
> Yes, 0x4C000100 is a part of memory under the reserved-memory node. So
> we would like to use the SRAM ( allocated 0x00000000 ) area instead.
> BTW, sorry, the trampoline address of this example is simply wrong.  We
> were going to use a part of the SRAM from the beginning.
>
> >
> >>
> >> So should we embed the constant value in source codes instead of getting
> >> from
> >> DT because the address is constant at the moment? Or is there other
> >> approach?
> >>
> >
> > If it's constant then that also works. Why does it need to come from DT
> > at all then?
>
> We think it is not good to embed constant value in driver codes and do
> not have another way...
> Are there better ways?

If this is just memory, can you use the standard spin-table binding in
the DT spec? There are some requirements like 64-bit values even on
32-bit machines (though this gets violated).

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
