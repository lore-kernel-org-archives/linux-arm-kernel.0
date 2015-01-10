From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 10 Jan 2015 17:50:30 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <20150110163001.GA5392@lunn.ch>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150109165204.3d0d3d99@free-electrons.com>
 <20150110163001.GA5392@lunn.ch>
Message-ID: <20150110175030.186ef929@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sat, 10 Jan 2015 17:30:01 +0100, Andrew Lunn wrote:

> Fixing window 13 is a big fix. It is getting late in the -rc cycle,
> which is partially my responsibility, since i was waiting for some
> tested-by:'s. But these patches are also heading towards
> stable. Stable rules state:
> 
>  - It must be obviously correct and tested.
>  - It cannot be bigger than 100 lines, with context.
>  - It must fix only one thing.
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing).
>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>    security issue, or some "oh, that's not good" issue.  In short, something
>    critical.
> 
> The first patch is over 300 lines. Because of its size, i'm also not
> able to say it is obviously correct. It does however tick some of the
> other boxes, fix only one thing, fixes a real problem.
> 
> Is there a more minimal fix? How big an impact is there in just
> disabling window 13? How much pressure do we have on windows? Can
> Michal Mazur live with one less window?
> 
> We could then pushing this proper fix into the next merge window?

I believe pushing the proposed fix for the next merge window, and
having a simpler fix that consists in simply not using window 13 for
stable is a reasonable approach.

> For the IO Coherency fixes, obviousness is an issue. This is
> especially true since your own comment is "still not working 100%
> properly, but it is apparently not worse than it was."
> 
> Maybe the correct fix for stable is to simply disable the I/O
> coherency hardware. That at least makes mainline stable.  Once we have
> a real, well tested, 100% fix, take it via the normal merge window.

However, I'm not a big fan of this idea. I'd really like to have I/O
coherency progressively improved, and made working.

The patch is actually make the code *simpler* since it removes the
custom dma_map_ops and uses a set of operations that already exists in
the kernel. The changes in the mvebu-mbus driver are minimal.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
