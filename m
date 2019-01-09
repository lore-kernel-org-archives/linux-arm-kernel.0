Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B3CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:28:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FDE2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWIToyIO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzVk4w82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FDE2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K7ppWzuciB30c+T9ts4bsGesxLcDYLUYxDrcAobokwE=; b=CWIToyIOi0yNmz
	QAd96dR7RYc7tR1ralQDxSSW4uhBnQxBDVTE9otgaornrEjqk7Ih/pOwOKD+P/om1SZDuITe8qCRh
	Tmiga2GaFE+R4o/uSnvjBKqbADmeizvR+Tf0r7ezYfsk9kcuF/QTmhkVP72toJBcVblTGPX38gmPq
	jK9ChMdL4U1F1uqQ4hyRA8suYIkFiPsE1aKm0jTXrFXkLloZhAqO9q8PtRgB9xVTzcmmNcZ8Yhle/
	nDCoPmKdyVxy4haLCopj1AYBwPHnAvvjFC+2KYlb2D4e+iCBvyhAoDF/gQO+xJW2qqVTrOu2SmOPs
	HTp9L0FB2bO2gnUJvehw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghJWp-0000lg-PF; Wed, 09 Jan 2019 19:28:39 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJWm-0000l1-Cy
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 19:28:37 +0000
Received: by mail-wm1-x331.google.com with SMTP id b11so8909858wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 11:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JxS56qBpl3OhFSSMkg01eCan4LQUjzw+yOC5UR1STEw=;
 b=fzVk4w82G48Iq8ct6VXxs0+tRfl7VlN6iKPKaFQt+UvhFLJ8rkPm/SrdmLIceyrhg7
 niFaX8Vcubrag3T59zbZXbPqW4YDU9YZz/h0NL3ID4m/6FCNUDeC6mPKN1FOZ2wmvXtT
 nmZReYBANQh6FoD6IqiAz6xsO0vkbLEm5WYRNN2hRc1RkBxG63tPmJVMmiGrvaV3Y56y
 cqr4pX7jab5GSo7rxwUpAYow+MGECbEHrxhO40DV0C5z/0eiea8/KfIeXH0YWdxfMkPz
 tb85m8zkbdkbC1z6Sv/pBV6JjU8vi5AzYpE7eXMAxqxr6h2xZ8HPXyEjCjFBfXiqjciF
 Eakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JxS56qBpl3OhFSSMkg01eCan4LQUjzw+yOC5UR1STEw=;
 b=COYOJ/Yf7rzvsRknMPJ1S0oMBQZDWNaJ9dnOckvD2to9/Io3YQmcmFRYFVr4Y3b/ku
 1XRW9whnlFqLISI1UcZvKkPheGOYK817HWzZLU1fhN62ePebUUg4egljLGFxfhWNYkJD
 JOTW18R7Pz3Q5ecRM1X0wnVllr7WRvFUreoRbzfukFncbP+IFPmjHCjq0mJW5vhv6R9z
 z463aIS0OEq+xRzuM3vYbdwLNzURxbxgGae32s0vIu2GkeF713q3KDFcADcHiEp616/W
 f4Lt5PyU2Zp2Xk23hdyHg8GvKyyYgegZxJLT7ic4hQTXEY/v+Dm6QGZgsUlJopqaT5Z5
 z63Q==
X-Gm-Message-State: AJcUukczx4jrdLfy1zblf0V+rUn+o4IsMosKn9JQlMw/gkahqzIOqn7B
 LGxssyEYd5+oK1O6BLETq38=
X-Google-Smtp-Source: ALg8bN50/p/qBPBQ5wdOAPrjW3br2IW3kwaD9cWlnH4sFXl+Q8Q5FGG1MrGTanQTVb+Feet/ig52cg==
X-Received: by 2002:a1c:ba89:: with SMTP id k131mr6769921wmf.85.1547062113287; 
 Wed, 09 Jan 2019 11:28:33 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:30af:bb11:dc41:cedc?
 (p200300EA8BE2E40030AFBB11DC41CEDC.dip0.t-ipconnect.de.
 [2003:ea:8be2:e400:30af:bb11:dc41:cedc])
 by smtp.googlemail.com with ESMTPSA id n82sm14791353wma.42.2019.01.09.11.28.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 11:28:32 -0800 (PST)
Subject: Re: Regression in v4.20 with net phy soft reset changes
To: Tony Lindgren <tony@atomide.com>, Florian Fainelli
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>
References: <20190109190650.GT5544@atomide.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a63ca542-db96-40ed-201d-59c609f565ce@gmail.com>
Date: Wed, 9 Jan 2019 20:28:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109190650.GT5544@atomide.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_112836_461541_15925082 
X-CRM114-Status: GOOD (  15.41  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Clemens Gruber <clemens.gruber@pqgruber.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, WingMan Kwok <w-kwok2@ti.com>,
 Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Murali Karicheri <m-karicheri2@ti.com>, linux-arm-kernel@lists.infradead.org,
 Rex Chang <rchang@ti.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org,
 Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09.01.2019 20:06, Tony Lindgren wrote:
> Hi all,
> 
> Commit 6e2d85ec0559 ("net: phy: Stop with excessive soft reset") caused
> a regression where suspend resume cycle fails to bring up Ethernet on at
> least cpsw on am437x-sk-evm.
> 
What kind of PHY and which PHY driver is used with this board?
I found one schematics of am437x where a KSZ9031RN PHY is used.
Is it the same on your board?

As described in the commit message of this commit you would have
the option to implement the soft_reset callback in the PHY driver.
Can you try to add .soft_reset = genphy_soft_reset to the
KSZ9031 driver config in drivers/net/phy/micrel.c and check whether
it fixes the issue?

> Keerthy noticed this may not happen on the first resume, but usually
> happens after few suspend resume cycles. The most working suspend resume
> cycles I've seen with the commit above is three.
> 
> Any ideas what might be going wrong?
> 
> Note that unrelated to the commit above, there may be other issues too
> as the cpsw phy LED seems to come on only after about five seconds with
> about total of 10 seconds before the Ethernet is up again.
> 
> Regards,
> 
> Tony
> 
Heiner

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
