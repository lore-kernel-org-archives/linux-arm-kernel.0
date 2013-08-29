From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 29 Aug 2013 12:28:10 +0200
Subject: 3.11-rc7 big-endian support
In-Reply-To: <521F2119.8080204@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <521D21D9.8020106@codethink.co.uk> <20130829115951.4d6df89b@skate>
 <521F2119.8080204@codethink.co.uk>
Message-ID: <20130829122810.6f4c4e7a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Thu, 29 Aug 2013 11:23:21 +0100, Ben Dooks wrote:

> > I believe your patch series would get more attention if the cover
> > letter was a bit better. It lacks a version number and a changelog. The
> > new posting you made as "re-send patch series due to mta issues" does
> > not even have a cover letter.
> 
> That was in-reply to as it seems that some of the messages never made
> it back to me due to a mta issue at my end that needed fixing.

Agreed, but even your original cover letter "3.11-rc7 big-endian
support" is far from containing the needed information: a title that
contains a version number, and proper changelog with all the changes
between all the different versions. You've been in the kernel
community for a much longer time than me, I'm sure you know perfectly
how to do this properly.

> > Also, none of the patches are Cc'ed to the relevant maintainers, so I'm
> > not sure how you expect those maintainers to look at your patches?
> 
> I actually left the machine specific ones in this series as a convenient
> place to keep them before producing a tree for submission.

Still, I believe the relevant maintainers should be Cc'ed so that you
can start collecting their Acked-by/Tested-by.

> > Regarding mvebu, the below patch is needed to get the secondary CPUs to
> > boot. Other than that, on Armada XP:
> >
> > Tested-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> 
> I will fix up the original patch, as it seems to have gotten out of sync
> with the change to add the coherency fabric code.

Yeah, the automatic merge with the coherency fabric changes did the
wrong choice. Anyway, not a big issue.

> > It doesn't work yet on Armada 370, but I'm not sure it's due to your
> > patches and anyway isn't a regression since LE continues to work fine
> > on Armada 370.
> 
> I wonder if it is due to a bootloader issue. I will push out the atags
> branch later today and you can try that.

I might try some of your earlier branches that are based on 3.10 and
have the ATAGS thing, just to see how it behaves on Armada 370. But I'm
not using ATAG_DTB_COMPAT, so normally ATAGS endianness should not be a
problem.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
