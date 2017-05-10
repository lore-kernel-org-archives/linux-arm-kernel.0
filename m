From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 May 2017 09:58:13 +0200
Subject: Updating kernel.org cross compilers?
In-Reply-To: <20170509221843.GZ19687@gate.crashing.org>
References: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
 <20170430052957.GJ19687@gate.crashing.org>
 <ee8a7f2c-976d-fe2a-55f9-ab8eebbf22eb@arm.com>
 <20170509221843.GZ19687@gate.crashing.org>
Message-ID: <CAK8P3a38bCS2rSwtQzYROfVBQ549akQZKPUJhcwDrWPN4NA1+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 12:18 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Tue, May 09, 2017 at 03:59:27PM +0100, Andre Przywara wrote:
>> >> I was able to build (bare-metal) toolchains for
>> >> all architectures except arc, m68k, tilegx and tilepro.
>> >
>> > arc needs a more recent GCC; the other probably as well.  GCC 7 should
>> > be out very soon, you probably want to wait for that :-)
>>
>> Well, GCC 7 indeed builds better, but then again is a very new compiler.
>> For instance in the moment it spits a lot of warnings when compiling the
>> kernel (mostly due to some *printf analysis). It's not hard to fix, but
>> this will take a while to trickle in and it's questionable whether this
>> will be backported everywhere.
>> So in addition to GCC 7.1 I'd like to have at least GCC 6.3 around,
>> which builds kernels without warnings today.
>
> If you don't want warnings, turn off the warnings or just don't look at
> them...  or fix the problems?  Many of the new warnings point out actual
> problems.
>
> Many of those sprintf problems in the kernel have already been fixed.

I've been using gcc-7.0 for a long time and fixed a lot of bugs it found,
along with more harmless warnings, but I had disabled a couple of
warning options when I first installed gcc-7 and ended up ignoring
those.

The exact set of additional options I used is:

-Wimplicit-fallthrough=0 -Wno-duplicate-decl-specifier
-Wno-int-in-bool-context -Wno-bool-operation -Wno-format-truncation
-Wno-format-overflow

there were a couple of others that I sent kernel fixes for instead.
I should probably revisit that list and for each of them either
only enable it with "make W=1" or fix all known warnings.
In the long run, I'd actually hope to fix all W=1 warnings too
and enable them by default.

      Arnd
