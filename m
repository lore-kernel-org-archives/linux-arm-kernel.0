From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 2 Aug 2014 19:08:11 +0200
Subject: [PATCHv9 1/3] mfd: altera: Add Altera SDRAM Controller
In-Reply-To: <53DC146D.1070504@opensource.altera.com>
References: <1406744573-609-1-git-send-email-tthayer@opensource.altera.com>
 <1406744573-609-2-git-send-email-tthayer@opensource.altera.com>
 <20140731082637.GH9030@lee--X1>
 <53DAA072.4010902@opensource.altera.com>
 <20140801081317.GL9030@lee--X1>
 <53DC146D.1070504@opensource.altera.com>
Message-ID: <20140802170811.GA20550@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Fri, Aug 01, 2014 at 05:27:57PM -0500, Thor Thayer wrote:
> 
> On 08/01/2014 03:13 AM, Lee Jones wrote:
> >On Thu, 31 Jul 2014, Thor Thayer wrote:
> >>On 07/31/2014 03:26 AM, Lee Jones wrote:
> >>>On Wed, 30 Jul 2014, tthayer at opensource.altera.com wrote:

[...]

> >>>>+u32 altera_sdr_readl(struct altera_sdr *sdr, u32 reg_offset)
> >>>>+{
> >>>>+	return readl(sdr->reg_base + reg_offset);
> >>>>+}
> >>>>+EXPORT_SYMBOL_GPL(altera_sdr_readl);
> >>>>+
> >>>>+void altera_sdr_writel(struct altera_sdr *sdr, u32 reg_offset, u32 value)
> >>>>+{
> >>>>+	writel(value, sdr->reg_base + reg_offset);
> >>>>+}
> >>>>+EXPORT_SYMBOL_GPL(altera_sdr_writel);
> We'd prefer to use syscon and that is what we started with. If you'd
> like to be our advocate, I will return to that because it was pretty
> clean. My primary concern is to get it upstreamed and if it is MFD
> then I'll make the changes.
> 
> Here are the threads.
> http://marc.info/?l=linux-kernel&m=140128791902800&w=2

The conclusion of this thread was syscon for offset 0x0, no ?!
And if you decide to have new writel/readl functions, I'd prefer if you don't
change the order of parameters just because. That always weirds me out, when
there are vendorname_writel functions, that only change the API of writel and
nothing else (not exactly the case here).

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
