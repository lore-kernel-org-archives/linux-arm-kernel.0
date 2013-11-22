From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 22 Nov 2013 12:34:25 +0100
Subject: [PATCH v3 2/5] extcon: max14577: Add extcon-max14577 driver to
 support MUIC device
In-Reply-To: <20131122103533.GI14725@sirena.org.uk>
References: <1385109972-28059-1-git-send-email-k.kozlowski@samsung.com>
 <1385109972-28059-3-git-send-email-k.kozlowski@samsung.com>
 <20131122103533.GI14725@sirena.org.uk>
Message-ID: <1385120065.6030.0.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-11-22 at 10:35 +0000, Mark Brown wrote:
> On Fri, Nov 22, 2013 at 09:46:09AM +0100, Krzysztof Kozlowski wrote:
> 
> > +#define	DELAY_MS_DEFAULT		17000		/* unit: millisecond */
> 
> This delay is sufficiently large that the delayed work using it probably
> ought to use the power efficient workqueues instead of just a regular
> schedule_delayed_work().  This will mean that instead of being scheduled
> on the core which scheduled it the work can run on any CPU, avoiding the
> need to power up a currently idle CPU just to run the work.

I'll fix this. Thanks for review of the patches.

Best regards,
Krzysztof
