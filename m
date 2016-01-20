From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Jan 2016 14:23:32 +0000
Subject: arm64/efi handling of persistent memory
In-Reply-To: <CAKv+Gu_KEDMdeF5zWL6EEwJyo+kt0u6HeaqrcVOEP9YHeu7uuw@mail.gmail.com>
References: <94D0CD8314A33A4D9D801C0FE68B40295BEBD864@G9W0745.americas.hpqcorp.net>
 <20151218110651.GL25034@bivouac.eciton.net>
 <20151218114546.GD29219@leverpostej>
 <CAKv+Gu_KEDMdeF5zWL6EEwJyo+kt0u6HeaqrcVOEP9YHeu7uuw@mail.gmail.com>
Message-ID: <20160120142330.GA28169@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For those newly Cc'd, the initially reported problem is that arm64 Linux
currently treats persistent memory as with any other memory (happily clobbering
it), per [1].

On Fri, Dec 18, 2015 at 02:07:10PM +0100, Ard Biesheuvel wrote:
> Before we start hacking away at this at the arm64/EFI level, do we
> have any documentation and/or consensus regarding how persistent
> memory should be treated in the first place? Should it be covered by
> memblock? Should it be covered by the linear mapping? Should it be
> memblock_reserve()'d?

I'm hoping that the lack of replies has more to do with the recent
holiday than a lack of opinion...

I think that it's sensible to say that at minimum we need to ensure that we
don't treat it as available RAM (i.e. we don't clobber it with random data) for
now.

Per [2] it's not clear to me what the consensus is on memblock, the linear
mapping, and the use of struct page, though that's months old so perhaps that's
been figured out since. I've Cc'd some of the attendees in case they can
clarify the situation.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394707.html
[2] https://lwn.net/Articles/636096/

Thanks,
Mark.
