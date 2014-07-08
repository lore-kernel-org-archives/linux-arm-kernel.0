From: pavel@denx.de (Pavel Machek)
Date: Tue, 8 Jul 2014 13:31:09 +0200
Subject: [PATCHv7 3/3] edac: altera: Add EDAC support for Altera SoC
 SDRAM Controller.
In-Reply-To: <1403730927-16163-4-git-send-email-tthayer@altera.com>
References: <1403730927-16163-1-git-send-email-tthayer@altera.com>
 <1403730927-16163-4-git-send-email-tthayer@altera.com>
Message-ID: <20140708113109.GC8100@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	read_reg = readl(mc_vbase + DRAMADDRW);
> +
> +	width = readl(mc_vbase + DRAMIFWIDTH);
> +
> +	col = (read_reg & DRAMADDRW_COLBIT_MASK) >>
> +		DRAMADDRW_COLBIT_LSB;
> +	row = (read_reg & DRAMADDRW_ROWBIT_MASK) >>
> +		DRAMADDRW_ROWBIT_LSB;
> +	bank = (read_reg & DRAMADDRW_BANKBIT_MASK) >>
> +		DRAMADDRW_BANKBIT_LSB;
> +	cs = (read_reg & DRAMADDRW_CSBIT_MASK) >>
> +		DRAMADDRW_CSBIT_LSB;

As I said, all the defines only make this harder to read. The code is
pretty obvious if you put numbers in here...

Plus I'd like an explanation/comment of how the error injection works.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
