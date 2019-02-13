Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BFBC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:34:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2011121901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q0YmL/te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2011121901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b4quG9d5Hg7b/aTtQo9Pa3buTL98+oQJPMcqajgbYYs=; b=Q0YmL/te0lMlFX
	exy5eg7FKMqh/Gyg6UJU0KECm+989DYvnB6rA+W3QHN9DwSqZxQ0E8hbTZ1dQcYGoJOJwYkVxLxq7
	gxv1F4+4mACfxyETyqTT7c4l8lh6zq3GWQl4v5iSOZctqnmLGFUhjT+hs4JYEmgY5JICCDWD1zrkk
	DDltyuGj2wU7xzwv09TX4AlDmvSntTr10+p88PZt7lKIFVmDbDf+g1PaDFylb0Dj1EcuXy8Wwl4cm
	NG5rMW7iRlQlHAytNVnRUNRdgCHjoSqx6pb4a9DMgyBsXhvlL6gRNmhJQ21kL2FhyzztajNl3RyK8
	CETGdkK8dy6OJPhDIa0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqwC-0000FN-LO; Wed, 13 Feb 2019 09:34:40 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqw7-0000DU-ND; Wed, 13 Feb 2019 09:34:37 +0000
Received: by mail-lj1-f194.google.com with SMTP id z20so379257ljj.10;
 Wed, 13 Feb 2019 01:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zahirVm0TD8tFdJrSdrC51Xnvqieohwgze4d7k+/G7Q=;
 b=ozlcx+S5StilHR+/naPN8PLCLIro70v+ZvMBbqZxODpbJifG0aem+JYoPegX+4eZ8h
 3k2S6lEuiNbFKueQfqbicsWd0VZQe+oj7fYerJk+Sahb3DEt+iiSXKShR0LgiTIwWIAi
 Be8hZ4CdMZGk8wGJNnPY0Ln+1JGUFVtEpn6XowaAavwKL8VI2Dnv/7cAcZolOnBR/j16
 +bIVZWzXJKglGfeoKc14FYSaUBpKA81SbCuubuMLxeS2vz9cD2ck1bay7Z6WtVPBIIl6
 rtLFXWrdIIHij/kF73HAWYMn9WA0CXJcnCG2yq9FFXWjKXE8LGZ7nzTxgb08KE/ZQwqs
 e23Q==
X-Gm-Message-State: AHQUAuYjFbygcTWgBhf9ivpMJxTZ4qsM3CbMFKWDnXyXVGVLCf4xXmq8
 l6rTCP9vls+PClTAQyj5SoBJHQD+
X-Google-Smtp-Source: AHgI3IaRJCwj3e+LCgQoHC4dx8FrwaR9d+qs+kXoyIoYIa5MBf99ovZP7nNxWUm2hA3UFhtHXXjbrQ==
X-Received: by 2002:a2e:8446:: with SMTP id u6-v6mr5076658ljh.74.1550050472709; 
 Wed, 13 Feb 2019 01:34:32 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id q3sm3643252lfj.50.2019.02.13.01.34.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 01:34:31 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gtqvx-0007j6-8w; Wed, 13 Feb 2019 10:34:25 +0100
Date: Wed, 13 Feb 2019 10:34:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190213093425.GH28278@localhost>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
 <20190130155016.GA26536@bogus> <20190211092251.GV4686@localhost>
 <86o97iv2px.fsf@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86o97iv2px.fsf@baylibre.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_013435_749603_F05023F0 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 03:06:50PM +0100, Loys Ollivier wrote:
> 
> On Mon 11 Feb 2019 at 09:22, Johan Hovold <johan@kernel.org> wrote:
> 
> > On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
> >> On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> >> > Add binding for Mediatek-based GNSS receivers.
> >> > 
> >> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

> >> reset-gpios is the standard name.
> >> 
> >> > +- gtop,fix-gpios	: GPIO used to determine device position fix state
> >> > +			  (pin name: FIX, 3D_FIX)
> >
> > I'm thinking we might need a standard name for fix-gpios as well. This
> > isn't a feature that is globaltop (or mediatek) specific, and other
> > manufacturers provide similar functionality through pins named UI_FIX,
> > or even LCKIND (lock indicator).
> >
> > The pin is typically used to drive an indicator LED AFAIU, but the
> > characteristics of the signal varies from device to device (fw to fw),
> > for example, pulse when no lock and low otherwise, or pulse when a 2d or
> > 3d-fix is acquired, etc.
> >
> 
> Yes most GNSS recevivers provide a similar feature even if behavior of
> the line differs.
> 
> > I'm not sure how useful the pulsing would be for software, but someone
> > might find a use for it in some form.
> >
> 
> Well it is useful to know when you start acquiring "valid" positionning
> data. I'm using this as a trigger to start recording position.

Sure, but a non-pulsing signal might have been easier to deal with if it
was meant to be used by software.

> > Rob, is this something we want to keep in the binding, and if so, how
> > about using a generic name such as "gnss-fix-gpios"?
> 
> Name "gnss-fix-gpios" sounds good to me.

Let's go with that then.

Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
