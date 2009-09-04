From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Fri, 4 Sep 2009 02:15:17 -0500
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903043325.GH3917@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902161252.GD2367@trinity.fluff.org>
	<20090902231839.GC32606@prithivi.gnumonks.org>
	<2accc2ff0909022038t64c08d3dodb21dc4ff1f2915b@mail.gmail.com>
	<20090903043325.GH3917@prithivi.gnumonks.org>
Message-ID: <2accc2ff0909040015q4ba7e170j4e6e4fc345882e10@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 2, 2009 at 11:33 PM, Harald Welte<laforge@gnumonks.org> wrote:
> On Wed, Sep 02, 2009 at 10:38:30PM -0500, Nelson Castillo wrote:
>
>> If it helps I can send a simplified version of the driver that does
>> not depend on filtering.
>
> I would like to see that one and see it go forward.

Harald, I replaced the filter framework with a simple filter that is
in the same driver. It's not better than all the filters (it doesn't
mix information from X and Y) but I'm surprised with the results I'm
seeing. It filters the nasty noise most of the times in my tests.

http://nelson-patches.googlecode.com/svn/trunk/openmoko/kernel/ts-with-s3c-adc/s3c2410_ts_simple_filter.c

I tested with a GTA02 (andy-tracking branch / 2.6.29-rc3). Some
required patches I used are in the same directory.

s3c-adc-cleanup.patch and s3c-adc-control-remaining-conversions.patch
were already merged by Ben and are in the Linus tree.

I won't be able to further improve it in the next few days.... It
might be useful as a starting point.
