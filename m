From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 19 Jan 2015 10:38:58 +0100
Subject: [PATCH v4] ARM: mvebu: remove two selects of ARM_ERRATA_753970
In-Reply-To: <1421659937.9655.16.camel@x220>
References: <1421659937.9655.16.camel@x220>
Message-ID: <1421660338.9655.21.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy, Joe,

On Mon, 2015-01-19 at 10:32 +0100, Paul Bolle wrote:
> ARM_ERRATA_753970 was renamed to PL310_ERRATA_753970 in v3.2, through
> commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
> PL310 errata workarounds"). Still, two selects were added in v3.15 that
> used the previous name. So these selects have always been nops.
> 
> It is clear that the intention here was to select PL310_ERRATA_753970.
> But as, apparently, nothing broke for four releases we can assume
> PL310_ERRATA_753970 isn't actually needed. So let's not rename these two
> selects but just drop them instead.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Checkpatch in next-21050119 complains:
    ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for PL310 errata workarounds")'
    #7: 
    commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
    
    total: 1 errors, 0 warnings, 14 lines checked
    
    Your patch has style problems, please review.

Perhaps it doesn't notice the quote spans two lines. Can this be fixed
please?

Thanks,


Paul Bolle
