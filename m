From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 May 2015 12:35:03 +0100
Subject: Memory size unaligned to section boundary
In-Reply-To: <20150506105102.GB5382@e104818-lin.cambridge.arm.com>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <20150506101104.GD2067@n2100.arm.linux.org.uk>
 <20150506105102.GB5382@e104818-lin.cambridge.arm.com>
Message-ID: <20150506113503.GT2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:51:03AM +0100, Catalin Marinas wrote:
> On Wed, May 06, 2015 at 11:11:05AM +0100, Russell King - ARM Linux wrote:
> > @@ -1142,7 +1142,7 @@ void __init sanity_check_meminfo(void)
> >  	 * last full section, which should be mapped.
> >  	 */
> >  	if (memblock_limit)
> > -		memblock_limit = round_down(memblock_limit, SECTION_SIZE);
> > +		memblock_limit = round_down(memblock_limit, 2 * SECTION_SIZE);
> 
> Why not PMD_SIZE? We don't need 4MB round down with LPAE.

No reason - PMD_SIZE would be good there.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
