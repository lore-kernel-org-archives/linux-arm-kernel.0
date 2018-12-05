Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:01:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847082082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CCa7jPOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847082082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=44weBfI0eEHv8ojGiO7SKsGlDwO4LJQGFNWQPMbq5sg=; b=CCa7jPOVqCjeLi
	wLqXlKe1aHU7O3Nl1+AuIc+MPZE0ZXBRKayAaTF1wNeqHe+Pc+L2hWdqYPRY5ju12hCLxN8nlAIG6
	ylSYL/Qs6NY8xvQs4JgbmFDekiTJILq5wx8+02PLggtomgREcuIZ7FQZAPURHqxaVUe0J5OzTEYcA
	yRSR3SQFI6I6ajUO/7iwzsasoJa/8S0dm/1V7AXwGdKedT9PnyJmNgSHU1Q3nMcf4TyZMdPhvskzC
	SJWgL2xpNmteXkMQUHfGbTnoMcCEqs7bOqV8ENn9GDZUQ80Dd1ISwDeHjwyuzUlODgWmKelBk7t2o
	IJHRepcpsbvDmcnMOfSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gURBB-0002n6-GP; Wed, 05 Dec 2018 07:01:05 +0000
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gURB8-0002le-8L
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 07:01:04 +0000
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so17258905lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 23:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=27B9qMspjDD1AgXG4zXqfQyvg5Itc4l3gB9owMvrM3Q=;
 b=Nbk9DWmGhOkeIxG+vtD7vub0ZQuHc7Rw3qiiSsgX5vpawr9E6JI/9ZHHCTRz/d9AHG
 vT0FTHJJqimzAIsh83Vwf7pOGS7tKiQE0rUogdOkgKJ/7EQGvGjT3KSnJ9MwAH5sjMs2
 ZPCcCWUDsS+lqifaEuyBI7H5+4g9Zto8UZo+u0CHZ+8vM7RjOApFBNJCNAce/3lwI0U/
 BMCiwfzszSWCvWVgfiXIuaSoptDBG92OG+zebaTxmau87fMCwdRzBJMAElDcthh2iC3Q
 hWWmN8PJA4o1faTaWR67Dtiob1WWHs0TrYnBydZjbGIe6ohTYuTfZd9Gj3JOL577tFxC
 0pWA==
X-Gm-Message-State: AA+aEWZVYpfCqvX/7+kJ8qUKHwlbbyq9KvGo+qYf83gUnbbxenmt4SkJ
 SFSI6Mnxr8ZbwqxpXd/wTy4=
X-Google-Smtp-Source: AFSGD/WiwQEFwql3iiSwej26/LOJHQCZfhdkkv48Wrxs4/02xOu2RhZf3qo3aFV6UA4/3LLifIZWHw==
X-Received: by 2002:a2e:449c:: with SMTP id
 b28-v6mr14439032ljf.47.1543993249678; 
 Tue, 04 Dec 2018 23:00:49 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id q127-v6sm3917951ljq.45.2018.12.04.23.00.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 23:00:49 -0800 (PST)
Date: Wed, 5 Dec 2018 09:00:46 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Message-ID: <20181205070046.GD31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_230102_294122_B50DFF94 
X-CRM114-Status: GOOD (  31.00  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, andrew.smirnov@gmail.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 mazziesaccount@gmail.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Stephen,

I copied some parts of the v4 discussion here as well. Let's continue
them under this one email thread. (and yep, this is my bad we now have
multiple email threads - I did these new patches without waiting for
the final conclusion. I should try to be more patient in the future...)

> > > I think we should use parent device's node, not the paren node in DT,        
> > > right? But I agree, we should only look "one level up in the chain".         
                                                                                 
> > Are these two things different? I'm suggesting looking at                      
> > device_node::parent and trying to find a #clock-cells property.                
                                                                                 
> I thought that MFD sub-devices may completely lack the DT node but I
> will verify this tomorrow.

So yep. It appears that the DT node for MFD sub-device is left NULL.
This is quite logical as there really is no clk sub-node in MFD (pmic)
node. The option to "hack around" this would be setting the of_node to
parent node in driver code. But this feels wrong. Drivers should not
mess with the "dt node ownership" - and it also feels a bit odd when
many devices use same DT node. I think we may hit in problems when
obtaining resources or doing reference counting. Hence I think we should
keep the of_node NULL for sub-device if the sub-device does not have own
node inside the main devie node. And I think Rob was not a fan of having
own nodes for sub-devices inside the MFD node (AFAIR my first driver
draft for this device had it but Rob and you thought that was not correct).

On Tue, Dec 04, 2018 at 11:38:17AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-12-04 03:34:53)
> > It seems to be usual for MFD devices that the created 'clock sub-device'
> > do not have own DT node. The clock provider information is usually in the
> > main device node which is owned by the MFD device. Change the devm variant
> > of clk of-provider registration to check the parent device node if given
> > device has no own node or if the node does not contain the #clock-cells
> > property. In such case use the parent node if it contains the #clock-cells.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/clk/clk.c | 27 +++++++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 78c90913f987..66dc7c1483d7 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3893,6 +3893,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
> >         of_clk_del_provider(*(struct device_node **)res);
> >  }
> >  
> > +static int of_is_clk_provider(struct device_node *np)
> > +{
> > +       return !!of_find_property(np, "#clock-cells", NULL);
> > +}
> > +
> >  /**
> >   * devm_of_clk_add_hw_provider() - Managed clk provider node registration
> >   * @dev: Device acting as the clock provider. Used for DT node and lifetime.
> > @@ -3901,8 +3906,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
> >   *
> >   * Returns 0 on success or an errno on failure.
> >   *
> > - * Registers clock provider for given device's node. Provider is automatically
> > - * released at device exit.
> > + * Registers clock provider for given device's node. If the device has no DT
> > + * node or if the device node lacks of clock provider information (#clock-cells)
> > + * then the parent device's node is scanned for this information. If parent node
> > + * has the #clock-cells then it is used in registration. Provider is
> > + * automatically released at device exit.
> >   */
> >  int devm_of_clk_add_hw_provider(struct device *dev,
> >                         struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > @@ -3912,12 +3920,17 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> >         struct device_node **ptr, *np;
> >         int ret;
> >  
> > +       np = dev->of_node;
> > +
> > +       if (!of_is_clk_provider(dev->of_node))
> > +               if (of_is_clk_provider(dev->parent->of_node))
> > +                       np = dev->parent->of_node;
> 
> As said on v5, let's just modify of_clk_add_provider() to do the parent
> search.

But that won't solve the issue if we don't do "dirty hacks" in driver.
The devm interface still only gets the device-pointer, not the DT node
as argument. And if DT node for device is NULL (like in MFD cases) -
then there is no parent node, only parent device with a node. For plain
of_clk_add_provider() the driver can just give the parent's node pointer
in cases where it knows it is the parent who has the provider data in
DT. But our original problem is in devm interfaces.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
