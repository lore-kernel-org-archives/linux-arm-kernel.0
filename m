From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 12:21:30 +0000
Subject: [PATCH 0/2] clk: ux500: Make mtu driver use apb_pclock
In-Reply-To: <CACRpkdYmPvRLcEjSNwC51sZw+g3iH3a5r7+7USEWJONmR4q4JQ@mail.gmail.com>
References: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
 <20121112183615.17970.20162@nucleus>
 <CACRpkdYmPvRLcEjSNwC51sZw+g3iH3a5r7+7USEWJONmR4q4JQ@mail.gmail.com>
Message-ID: <201211151221.30217.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Linus Walleij wrote:
> On Mon, Nov 12, 2012 at 7:36 PM, Mike Turquette <mturquette@ti.com> wrote:
> > Quoting Linus Walleij (2012-11-11 10:47:46)
> 
> >> I don't know quite how ingenious git is in detecting
> >> patches on moved files, but if it's causing trouble
> >> I think it's better if you could ACK them and we
> >> could reubmit them to ARM SoC on the multiplatform
> >> branch. i.e. this one:
> >> http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=shortlog;h=refs/heads/next/multiplatform
> >>
> >
> > Those patches have my ACK.  Do you want to wait to see if something goes
> > boom or would you rather I drop them from clk-next preemptively?
> 
> Hm that's basically a question of how smart git is when
> merging these trees together.
> 
> Arnd, Olof: what is your experience? If one tree is moving
> files and another tree is patching them, should we try to
> rebase these onto your branch in ARM SoC and submit
> them there instead?

rename vs change conflicts are usually handled, but not always.
The one thing that never works is when part of one file is moved
into another file (or two files get merged into one) and another
patch changes the same file.

If I understand the problem at hand correctly, the safe solution
should be to base the ux500 clk changes on top of c3b9d1db23c4e,
which is in the nomadik/plat-removal branch in arm-soc that got
merged into next/multiplatform. I would prefer if you use that
as a base instead of the larger next/multiplatform branch that
also contains vt8500 and other changes.

	Arnd
