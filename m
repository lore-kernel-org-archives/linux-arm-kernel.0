From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 5 Jul 2013 17:32:40 +0900
Subject: Appended DTB files for multi-machine kernels
In-Reply-To: <201307042334.37161.arnd@arndb.de>
References: <51D5A938.30607@gmail.com> <20130704171148.GJ27646@sirena.org.uk>
 <201307042334.37161.arnd@arndb.de>
Message-ID: <CANqRtoT+=CJrU2AjFwN67vrypQ1WR-8JeMyn1-mzb+tXWeAp2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Jul 5, 2013 at 6:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 July 2013, Mark Brown wrote:
>> On Thu, Jul 04, 2013 at 06:56:24PM +0200, Daniel Mack wrote:
>>
>> > Unless I missed some recent discussion, this case is not easy to handle.
>> > Yes, I know that these kind of things should be handled by a
>> > next-generation bootloader, but in our case, we want to avoid a loader
>> > update of already shipped hardware by all means.
>>
>> There was some discussion about appending multiple DTBs recently.  I
>> can't actually recall anything about it though so that's not an entirely
>> helpful thing...
>
> Yes, it keeps coming up, I think by now everybody agreed it's a good
> idea to extend the ATAGS compat mode, but so far nobody has implemented
> it. Magnus Damm was very interested in this feature last year and
> was planning to work on it, but I don't know how far he got.

Correct, I was and still am a bit interested in it. I did however
never get around to write any code. My apologies if that stalled
anyone.

With mach-shmobile we're now getting to a point where most of our
boards are using DT_MACHINE and appended DTB instead of the MACHINE
and mach-type. Because of that I feel that the moment has sort of
passed for me.

Regardless of this nearly all our boot loaders pass mach-type so it
would be nice to match on that instead of the appended DTB.

Thanks,

/ magnus
