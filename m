From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Mar 2016 15:16:47 +0000
Subject: dmaengine: ARM pl080 misidentified as Samsung pl080s
In-Reply-To: <20160324105651.GA20489@sig21.net>
References: <20160324105651.GA20489@sig21.net>
Message-ID: <20160324151647.GS19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 11:56:51AM +0100, Johannes Stezenbach wrote:
> Hi,
> 
> commit da1b6c05b8b5bd ("dmaengine: PL08x: Add support for PL080S variant")
> added this hunk:
> 
>  static struct amba_id pl08x_ids[] = {
> +       /* Samsung PL080S variant */
> +       {
> +               .id     = 0x0a141080,
> +               .mask   = 0xffffffff,
> +               .data   = &vendor_pl080s,
> +       },
>         /* PL080 */
> 
> However, 0x0a141080 happens to be the ID of the
> ARM PL080, too:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0196g/I54627.html
> 
> Since the PL080S has the configuration register at a different
> address the driver doesn't work for ARM PL080 anymore.

Vendors have got into serious trouble in the past over IDs claiming that
some other legal entity being the vendor.  A certain buggy ARM926 clone
comes to mind, and they were forced to respin their silicon as a result.
It sounds like Samsung have made the same idiotic mistake.  I suggest
reverting the offending commit.  This behaviour really isn't on.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
