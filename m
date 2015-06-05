From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 5 Jun 2015 12:27:49 -0700
Subject: [PATCH 3/3] ARM: Allow either FLATMEM or SPARSEMEM on the
 multiplatform build
In-Reply-To: <2466892.NW5Y39MQOr@wuerfel>
References: <1433469518-8472-1-git-send-email-gregory.0xf0@gmail.com>
 <1433469518-8472-4-git-send-email-gregory.0xf0@gmail.com>
 <2466892.NW5Y39MQOr@wuerfel>
Message-ID: <CADtm3G5LOzJRutVPnYyQe0+TiW3FM+e61voYo8AmqhQMYcwa=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 5, 2015 at 5:26 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 04 June 2015 18:58:38 Gregory Fong wrote:
>> ARMv7 chips with LPAE can often benefit from SPARSEMEM, as portions of
>> system memory can be located deep in the 36-bit address space.  Allow
>> FLATMEM or SPARSEMEM to be selectable at compile time; FLATMEM remains
>> the default.
>>
>> This is based on Kevin's "[PATCH 3/3] ARM: Allow either FLATMEM or
>> SPARSEMEM on the multi-v7 build" from [1] and shamelessly rips off his
>> commit message text above.  As Arnd pointed out at [2] there doesn't
>> seem to be any reason to tie this specifically to ARMv7, so this has
>> been changed to apply to all multiplatform kernels.
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/286837.html
>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/298950.html
>>
>> Cc: Kevin Cernekee <cernekee@gmail.com>
>> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
>> ---
>> I don't have any platforms other than armv7 handily set up to test SPARSEMEM,
>> so any testing would be appreciated.  FLATMEM is still the default so at least
>> nobody will see anything change unless they deliberately switch.
>>
>
> Can you check that realview at least builds with your series? It probably
> will, but it's not obvious as there are some tricky bits with the
> various realview config options.

I just checked using realview_defconfig and realview-smp_defconfig,
both built successfully.

Best regards,
Gregory
