From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 22 May 2013 22:47:52 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522191420.1ef08f8d@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164928.GD27348@1wt.eu> <20130522190004.67880320@skate>
 <20130522170807.GE27348@1wt.eu> <20130522191420.1ef08f8d@skate>
Message-ID: <519D2EF8.7040804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 07:14 PM, Thomas Petazzoni wrote:
> On Wed, 22 May 2013 19:08:07 +0200, Willy Tarreau wrote:
>> On Wed, May 22, 2013 at 07:00:04PM +0200, Thomas Petazzoni wrote:
>>> Of course, one option is simply to have a kconfig option "I am booting
>>> from an old bootloader", but with the CP15 trick, we've tried to make
>>> this automatic so that users don't have to understand the kind of gory
>>> details we are discussing right now.
>>
>> Same as for ATAGS right now which are not necessarily the most obvious
>> setting for end users. Better keep the trick on by default if it's safe
>> enough. In fact I'm mostly concerned about the risk that it later breaks
>> for even newer boot loaders. But then we'll have more feedback to decide.
>
> As I suggested earlier, we can print a warning when people boot from an
> old bootloader, and then down the road get rid of the trick. Or move it
> under a conditional compilation so that the minority of remaining users
> will have to enable this particular option. This will anyway be needed
> if we want to go multiplatform with Dove, for example.

I am not so sure Kconfig for Dove is really required, if it moves to
mach-mvebu. As I already stated before, Dove is happily accessing
0xd0000000 even if internal registers mapped on 0xf1000000. So maybe
the enforced remap will do no harm and at max write in some RAM mapped
there.

Although, I doubt that there will ever be a Dove board with RAM at 3GB
addresses with only two DDR CS available. Currently, for DDR3 DRAMs
8Gbit is the largest you can get, DDR2 ends at 4Gbit but >3GB RAM would 
require 16Gbit DRAMs.

Also I guess Dove is about to be replaced by Armada 1000/1500 for new
products.

Sebastian
