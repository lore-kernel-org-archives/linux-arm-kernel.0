Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:56:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EC420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tfKcNH67";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uRJX5DBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EC420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B3ncsrjpomjKdOtcUasTIcTgddRiDYCYqZL215cjctw=; b=tfKcNH67N6V/fK
	C5DbjiIuJZVEk86PyP0xGsWoecbA2VzWFecTq7dRpZz5Nmf8tceLZA7aKGqOgHEahOG4jdoOK9PsN
	R/27Ytmpp6m6srli4oJ1tyw5rDSiDil/HbZvPt0Izey/ULwhjkO8+yjpEHgCAAA3xuKICRzmnjsR3
	PZRWlA29cmxWLmLB3vSkOc2awDQDgcGierl04WBKFBr4POFijQrfz9pRYAhWMyUaXWvRTdtBNHTnz
	tC7ni+ZwNcF+dA0c+nWhTHc3ZfK52pMaSSJ1HBqe+1ibFO05sFCMMeAFsQOYEQfwAXEsNVENrziJ6
	q22pYP4scKLpHMBvyd8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxIk-0001fw-91; Fri, 11 Jan 2019 13:56:46 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxIf-0001eg-So
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=kMAKAE1n6w0jiweeK7Ui6ZhFN+TRzH4vfpyEDeal7QY=; 
 b=uRJX5DBsVuGkpmCWHZAnwbGPL8eAyGl0/nwPLAMk/ZzpTj7P31VUGmHjI3cQgvg25uIjNbC/0yLLHKD6zTGVuFAru0pW4dpnsBeBk9XmUXLKR9V/5O5tGDNv9/xiFE42ACpN7n+T6E5aSqp0J258cRCKOHNOwOoIiEkSySjb6xI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1ghxDZ-0000w2-C2; Fri, 11 Jan 2019 14:51:25 +0100
Date: Fri, 11 Jan 2019 14:51:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: Re: [PATCH 2/3] drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
Message-ID: <20190111135125.GC1895@lunn.ch>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547184076-20521-3-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_055642_076265_2D5080B5 
X-CRM114-Status: GOOD (  19.38  )
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
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 10:51:15AM +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> 
> Add support for new version of pwm-kona.
> Add support to make PWM changes configured and stable.
> 
> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c | 128 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 98 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> index 09a95ae..2b44ad8 100644
> --- a/drivers/pwm/pwm-bcm-kona.c
> +++ b/drivers/pwm/pwm-bcm-kona.c
> @@ -45,30 +45,39 @@
>   *    high or low depending on its state at that exact instant.
>   */
>  
> -#define PWM_CONTROL_OFFSET			(0x00000000)
> +#define PWM_CONTROL_OFFSET			0x00000000
>  #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
>  #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
>  #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
>  #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
>  
> -#define PRESCALE_OFFSET				(0x00000004)
> +#define PRESCALE_OFFSET				0x00000004
>  #define PRESCALE_SHIFT(chan)			((chan) << 2)
>  #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
> -#define PRESCALE_MIN				(0x00000000)
> -#define PRESCALE_MAX				(0x00000007)
> +#define PRESCALE_MIN				0x00000000
> +#define PRESCALE_MAX				0x00000007

Hi Praveen

These changes are unrelated to adding support for a new PWM. So
ideally they should be in a separate patch.

> +static int kona_pwmc_wait_stable(struct pwm_chip *chip, unsigned int chan,
> +				 unsigned int kona_ver)
> +{
> +	struct kona_pwmc *kp = to_kona_pwmc(chip);
> +	unsigned int value;
> +	unsigned int count = PWM_MONITOR_TIMEOUT_US * 1000;
> +
> +	switch (kona_ver) {
> +	case KONA_PWM_V1:
> +		/*
> +		 * There must be a min 400ns delay between clearing trigger and
> +		 * settingit. Failing to do this may result in no PWM signal.
> +		 */
> +		ndelay(400);
> +		return 0;
> +	case KONA_PWM_V2:
> +		do {
> +			value = readl(kp->base + PWM_MONITOR_OFFSET);
> +			if (!(value & (BIT(chan))))
> +				return 0;
> +			ndelay(1);
> +		} while (count--);

You can probably use readl_poll_timeout() here.

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
