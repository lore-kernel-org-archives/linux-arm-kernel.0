From: laforge@gnumonks.org (Harald Welte)
Date: Fri, 28 Aug 2009 17:24:51 +0900
Subject: New Samsung ARM git tree branches / moving forward
Message-ID: <20090828082451.GG9822@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, Aug 28, 2009 at 12:19:49PM +0900, Harald Welte wrote:

> I hope later today we can push that tree to git.kernel.org.  Anyone who's
> interested can then look at it and see that it is far from being optimal.

This has been done now.  The public git tree at 
git://git.kernel.org/pub/scm/linux/kernel/git/kki_ap/linux-2.6-samsung.git
contains the latest sources from the Samsung LSI Linux kernel team.  The tree
will be updated once per day to reflect the development inside the Samsung
team.

We know that the code in this tree is not 100% fit for mainline, but I think
it is already a good start and massive change that the community can look
at all of Samsungs current (and continuously updated) code.

It contains right now three branches:

2.6.28-samsung
	A tree with support for s3c6410, s3c6440 and s5pc100.  No new
	development will happen here, only backports/fixes as required.

2.6.29-samsung
	A tree with support for s5pc100, s5pc110 and s5p6442.  No new
	development will happen here, only backports/fixes as required.

master	
	Current development head, this is where code for s5pc110 is being
	developed.  
	  It is a rebase of the 2.6.29-samsung tree on top of
	v2.6.31-rc7.  It will regularly pull from mainline, even after 2.6.31
	is released it will follow 2.6.32-rcX, 2.6.33-rcX, etc.
	  With lower priority, the s5p6440 and s5pc100 code will be
	tested/completed, and the s5p6442 code from 2.6.29-samsung imported.
	  Since it regularly pulls from mainline master, the missing 6410 code
	(see below) will automatically end up here, too - resulting in one
	tree with support for all Samsung SoC's.  Of course this code should
	also go mainline eventually, step by step.

Coming Soon (next week):

6410-arch
	A new 6410-arch branch based on 2.6.31-rc7 where Samsung will
	add/import any missing 6410-arch stuff from the 'discontinued'
	2.6.28-samsung branch. The 6410 branch will regularly pull from
	mainline.  Any code in here is intended to be submitted to mainline
	soon.

6410-topic-*
	We will also create per-driver topic branches starting from the
	6410-arch branch.  The topic branches will be regularly rebased on top
	of 6410-arch.  At some final point, we will likely rebase them on a
	subsystem tree before submiting them mainline.  Once a driver is mainline,
	the topic branch will be deleted.

6410-all
	Is a 6410-arch tree that merges in all the 6410-topic-* branches to
	have something that people can actually test and run on their hardware.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
