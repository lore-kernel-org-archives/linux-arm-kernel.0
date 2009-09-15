From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 13:21:14 +0100
Subject: [PATCH 05/10] S3C I2S: lrsync function made to work with IRQs
	disabled.
In-Reply-To: <1253008957-10569-1-git-send-email-jassi.brar@samsung.com>
References: <1253008957-10569-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915122114.GP22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:37PM +0900, Jassi wrote:
> s3c2412_snd_lrsync() maybe reached with IRQs disabled and if LRCLK
> is dead due to improper initialization of CPU or CODEC, the system
> gets stuck in the loop because jiffies may never get updated.
> Implemented counter based wait mechanism for atleast the same
> timeout period.

I'll apply this but...

> +#define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)

...this really should be moved into a standard header since it's a bit
of a namespace violation.  Also, there's a jiffies_to_msecs function.
