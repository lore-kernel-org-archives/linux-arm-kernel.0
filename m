From: greg@kroah.com (Greg KH)
Date: Tue, 19 Apr 2011 16:58:12 -0700
Subject: [PATCH v2] driver core: let dev_set_drvdata return int instead
	of void as it can fail
In-Reply-To: <1302547378-14639-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <BANLkTi=MjDqawZx=+fKjaAs5SPfGQDEgVQ@mail.gmail.com>
	<1302547378-14639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110419235812.GA4619@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 08:42:58PM +0200, Uwe Kleine-K?nig wrote:
> Before commit
> 
> 	b402843 (Driver core: move dev_get/set_drvdata to drivers/base/dd.c)
> 
> calling dev_set_drvdata with dev=NULL was an unchecked error. After some
> discussion about what to return in this case removing the check (and so
> producing a null pointer exception) seems fine.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> @Viresh: as I didn't choose to return -EINVAL I didn't add your Reviewed-by:

I'm confused by this thread, care to resend all of these in a series
against the latest linux-next tree?

thanks,

greg k-h
