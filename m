From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 7 Dec 2011 22:44:02 +0100
Subject: [PATCH 3/3] ARM: S3C64XX: Implement basic power domain support
In-Reply-To: <20111202210706.GB15268@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4ED930B3.3020200@gmail.com>
 <20111202210706.GB15268@opensource.wolfsonmicro.com>
Message-ID: <201112072244.02299.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 02, 2011, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 09:10:27PM +0100, Sylwester Nawrocki wrote:
> 
> > > +	/* Not all domains provide power status readback */
> > > +	if (pd->pwr_stat) {
> > > +		while (retry--)
> > > +			if (__raw_readl(S3C64XX_BLK_PWR_STAT) & pd->pwr_stat)
> > > +				break;
> 
> > How about adding cpu_relax() in this busy wait loop ?
> 
> May as well, yes - I didn't actually measure how long it tends to take
> to do the spin but it's not going to hurt.

Are you going to post an updated patch?

Rafael
