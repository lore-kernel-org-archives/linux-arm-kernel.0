From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 09:41:36 -0700
Subject: [PATCH 1/3] ARM: mach-moxart: add MOXA ART SoC files
In-Reply-To: <2428901.voOA9oET8R@wuerfel>
References: <1371040448-28742-1-git-send-email-jonas.jensen@gmail.com>
 <1371040448-28742-2-git-send-email-jonas.jensen@gmail.com>
 <2428901.voOA9oET8R@wuerfel>
Message-ID: <CAOesGMgznJXWN5nE-2igC-d0YY_aFk0Q1D_5p95oTZM-VTs5qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 7:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
arch.h>
>> +
>> +static const char * const moxart_dt_compat[] = {
>> +     "moxa,moxart-uc-7112-lx",
>> +     NULL,
>> +};
>> +
>> +DT_MACHINE_START(MOXART, "MOXA UC-7112-LX")
>> +     .dt_compat              = moxart_dt_compat,
>> +MACHINE_END
>
> If the .dt_compat fields is the only field in the machine descriptor,
> you can leave out the entire descriptor!
>
> Olof, do you have a preference to how we want to handle this? The
> only advantage of having this file at all is to have the
> "MOXA UC-7112-LX" string in /proc/cpuinfo.
> Should we just remove the entire directory or leave it as the trivial
> file above?

I sort of presumed that there might be need for _some_ platform code
later on, just not quite yet, so I didn't want to be quite that
drastic. I suppose leaving it with the trivial file for now is OK, and
we can make a sweeping change down the road in case we want to clean
up and consolidate all the trivial platforms.


-Olof
