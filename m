From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Feb 2014 23:28:37 +0000
Subject: [PATCH RFC 31/31] mmc: sdhci-tegra: get rid of special
 PRESENT_STATE register handling
In-Reply-To: <20140219232253.GW21483@n2100.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmKj-0006nv-Py@rmk-PC.arm.linux.org.uk> <53050E43.3030602@wwwdotorg.org>
 <20140219232253.GW21483@n2100.arm.linux.org.uk>
Message-ID: <20140219232837.GX21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 11:22:53PM +0000, Russell King - ARM Linux wrote:
> The script was a little too over-zealous.  It was just supposed to do
> the following transformation:
> 
> --- => =-DO NOT APPLY-=
> +++ => =+DO NOT APPLY+=
> 
> which would've made it reversible with a trivial sed expression - but I
> cocked up because of the utterly random nature of regexp flavours, and
> instead gave sed this:
> 
> 	sed -i 's/^---/=-DO NOT APPLY-=/;s/^\+\+\+/=+DO NOT APPLY+=/'
> 
> The escaped '+' ends up causing sed to match a single + at the beginning
> of a line.  (Other regexp flavours require you to escape the '+' otherwise
> it's interpreted as "one or more".)
> 
> I had added that mode to my script a few months ago, and I just assumed
> I'd fully tested it when I used it yesterday... clearly not so.
> 
> So... yes it was designed to stop it being _accepted_ but it should have
> also been completely reversible for those who wished to apply it via
> the obvious reversed sed expression.

Oh, and before you ask why I'm now doing it, it's through necessity.  I've
had too many instances where some maintainers will take patches sent out
as part of a RFC without being asked to do so - and I've then had to email
the maintainers asking them to drop such patches from their trees.

I wish this kind of buggeration of patches wasn't necessary, but
unfortunately - as seems to always be the case - people just can't be
trusted to pay due care and attention, and do the right thing.

That's why the intention is to (a) prevent the patch being applied without
thought while (b) allowing it to be applied with a trivial transformation.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
