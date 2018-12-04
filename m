Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E363C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:45:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F207D2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kahiWWiU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9Kj3r0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F207D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ckNc2mi8mD+pVZHc+1JyyNblvi+pzq+T3Nv1ILOq8l8=; b=kahiWWiUunL94B
	5uC0vjr3rnO3AZif+oc2b7jUX+/rtkAeoWKwhFglQPXrDdTFHi6voJWACo6ruS5ObtLeMgMMa8/5L
	7iEik4VmaaVbJ77hKnu0kHNhGZ/6YUCuABKpUDmIiRcu1ZjiTWx2rVLGSTJcOyHydXyG0+NEs4ZTP
	FcoNZ2yBI44FQkvAbU/j3w0FAbUWKJPdZu9ONbRpwgBgufR2YwlwGkKW97m5oT/sNrEkMkigphqFq
	i8m9flFMtlu+DAyKf9OBnSIDi6YJReu5I4U0c/voR1THvLp5QJs8QC4YC2KzYEeAOPxk3gSRqi9Gy
	zEfH4p7xTMhVLslR9gbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBwz-0008FG-IB; Tue, 04 Dec 2018 14:45:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBwq-0006zQ-I9; Tue, 04 Dec 2018 14:45:22 +0000
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5767120834;
 Tue,  4 Dec 2018 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543934705;
 bh=hVb8TID6cd1Olg3jtzdBexIhOrCiR/d52f5IOpnmACI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=I9Kj3r0o3/KmrFHvG5GA+pHQ+dy7Ck2z0nBok1uWJCjEzruGA59yQo0y1FUoCsswk
 o1aUEqebWNFZ+Ip6QC3hVzUmt5fPdbbp1IG8/nQbMgOSbjkGWOSY/gCtPmTyidtwMS
 Yy/BeYZ28OHA5lgEi9DmgXTRG0r6SrbtOljEJnKM=
Received: by mail-qt1-f172.google.com with SMTP id n32so18228828qte.11;
 Tue, 04 Dec 2018 06:45:05 -0800 (PST)
X-Gm-Message-State: AA+aEWYV3CAiXbPtPIyLYrPlnfLQw05Fk+uL3zAFhIkAwmkwOPGP6asM
 IdpO/+LWL8Kw8t9crYMOe/L0/tOsxVLfubNLwQ==
X-Google-Smtp-Source: AFSGD/WGVWJioClsa0lvQGJtAOGi8FkeeWgHBEl1fwnzno8/vkh5RpuvYCjALLTG0ebaUzuRMqN9CWkjmLCc7SNclL4=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr19931119qtf.26.1543934704526; 
 Tue, 04 Dec 2018 06:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-15-robh@kernel.org>
 <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
In-Reply-To: <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 08:44:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
Message-ID: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
Subject: Re: [PATCH v2 14/34] dt-bindings: arm: Convert Amlogic board/soc
 bindings to json-schema
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_064516_635576_69134C50 
X-CRM114-Status: GOOD (  20.61  )
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>, Kevin Hilman <khilman@baylibre.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 2:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Rob,
>
> You forgot linux-amlogic in CC...
>
> On 03/12/2018 22:32, Rob Herring wrote:
> > Convert Amlogic SoC bindings to DT schema format using json-schema.
> >
> > Cc: Carlo Caione <carlo@caione.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---

[...]

> > +      - items:
> > +          - enum:
> > +              - amlogic,s400
> > +          - const: amlogic,a113d
> > +          - const: amlogic,meson-axg
> > +      - items:
> > +          - enum:
> > +              - amlogic,u200
> > +          - const: amlogic,g12a
>
> but all this feels wrong for me.
>
> First of all, this yaml description is not human friendly and not intuitive at all,
> and secondly with this conversion we loose all the comments about the SoC family relationship
> with the compatible strings !
>
> I really understand the point to have automated verification, but really it's a pain to read
> (I can't imagine newcomers... the actual DT bindings are already hard to read...) and
> I feel it will be a real pain to write !

What do you suggest that would be easier? Is it the YAML itself or the
json-schema vocabulary? For the former, we could use {} and [] to make
things more json style. But I imagine it is the latter.

There is some learning curve for json-schema and is certainly a
concern I have, but there would be a learning curve for anything. Our
choices are use some existing schema language or invent one. All the
previous efforts (there's been about 5 since 2013) have been inventing
one, and they've not gone far. There will be far few resources
available to train people with if we do something custom.

> Can't we mix an "humam text" with a "yaml" part on a same document ? we are in 2018 (nearly 2019),
> and it should be easy to extract a yaml description from a text document without pain and
> keep all the human description, no ?

Yes. Please go look at the annotated example in patch 2.

> What will be the case for all the bindings with ASCII art to describe the architecture of the
> HW ? will you simply drop it to replace it with cold yaml description ?

No, you can have literal blocks and/or comments with however much
description you like. In fact, there's some notion to write the
descriptions in sphinx and extract them to generate documentation, but
that's a ways off. That's just the extent of what is possible.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
