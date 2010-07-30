From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jul 2010 08:18:05 +0100
Subject: [GIT PULL] debug macro changes for 2.6.36
In-Reply-To: <1280465905.11181.41.camel@pororo.lan>
References: <1280465905.11181.41.camel@pororo.lan>
Message-ID: <20100730071805.GB29746@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 12:58:25PM +0800, Jeremy Kerr wrote:
> Hi Russell,
> 
> Please pull the following debug macro changes for 2.6.36.
> 
> For patch 3/4 (arm: use addruart macro to establish debug mappings),
> I've made the mapping establishment dependent on !DEBUG_ICEDCC.

No.  This change is far too big to come via git and will cause lots of
conflicts.  I'm not fixing those conflicts when there's a better way
of handling this kind of change.  There's also the matter of new platform
support which your patch based approach will miss.

What I said about a week ago is that I wanted to do the removal of
.phys_io/.io_pg_offst via a script, which'll ensure that we hit
everything that's been merged for the next merge window.
