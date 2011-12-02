From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Dec 2011 21:07:06 +0000
Subject: [PATCH 3/3] ARM: S3C64XX: Implement basic power domain support
In-Reply-To: <4ED930B3.3020200@gmail.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1322765339-29879-3-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4ED930B3.3020200@gmail.com>
Message-ID: <20111202210706.GB15268@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 09:10:27PM +0100, Sylwester Nawrocki wrote:

> > +	/* Not all domains provide power status readback */
> > +	if (pd->pwr_stat) {
> > +		while (retry--)
> > +			if (__raw_readl(S3C64XX_BLK_PWR_STAT) & pd->pwr_stat)
> > +				break;

> How about adding cpu_relax() in this busy wait loop ?

May as well, yes - I didn't actually measure how long it tends to take
to do the spin but it's not going to hurt.
