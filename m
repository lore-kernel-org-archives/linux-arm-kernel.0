From: olof@lixom.net (Olof Johansson)
Date: Thu, 8 Mar 2012 09:53:06 -0800
Subject: [GIT PULL v4] ARM: kirkwood: fdt conversion progress
In-Reply-To: <20120308173029.GK5050@titan.lakedaemon.net>
References: <20120307221012.GH5050@titan.lakedaemon.net>
 <201203081610.21493.arnd@arndb.de>
 <CAOesGMh2etdQSOjktDGcWGfnsMhyFnVuebWRQeYuR6fvm1_DSA@mail.gmail.com>
 <20120308173029.GK5050@titan.lakedaemon.net>
Message-ID: <CAOesGMikpxMd+MtnjKix7D0KiHD+e8s2YFjB3j9a=7i7S9J+0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 8, 2012 at 9:30 AM, Jason <jason@lakedaemon.net> wrote:
> On Thu, Mar 08, 2012 at 09:15:08AM -0800, Olof Johansson wrote:
>> Hi,
>>
>> On Thu, Mar 8, 2012 at 8:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 07 March 2012, Jason Cooper wrote:
>> >> The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:
>> >>
>> >> ? Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)
>> >>
>> >> are available in the git repository at:
>> >> ? git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt
>> >>
>> >> ---
>> >> Arnd,
>> >>
>> >> My first two should match up with what you have already, the only
>> >> outlier is that Jean-Christophe's patch is needed, but I don't think
>> >> everyone agrees on it yet.
>> >>
>> >
>> > Right now, Olof is handling the pull requests. I would suggest that he
>> > can use your branch to replace the current staging branch but still keep
>> > it in staging until everyone agrees or you replace it with a better version.
>>
>> Jason,
>>
>> Looking at the new pull request I see some differences in device
>> support. For example, the DT conversion of orion-spi and wdt is not in
>> the new branch.
>>
>> Is that intentional? If not I'll hold off replacing your branch.
>
> Yes, Andrew Lunn is working on adding common clock support to
> plat-orion, which mach-kirkwood depends on. ?So, I'm holding off on
> changes to drivers which get passed tclk. ?Once Andrew's clock code is
> up, then I'll add fdt support to it and re-introduce those driver
> changes.
>
> clock gating is a separate issue that is further down the road.
>
> Basically, we're trying to avoid merge conflicts. ?:-)

Ok, great. I'll replace the branch then.

> The following patches should be fine to merge into stable (for 3.4):
>
> af42511 ARM: orion: spi: remove enable_clock_fix which is not used
> d93b2ca ARM: Kirkwood: Remove tclk from kirkwood_asoc_platform_data.
> 2bb9207 ARM: kirkwood: fdt: use mrvl ticker symbol
> ec0ec68 ARM: kirkwood: fdt: absorb kirkwood_init()
> ...
> b5c25c3 ARM: kirkwood: rtc-mv devicetree bindings
> 5e40593 ARM: kirkwood: use devicetree for rtc-mv
> ...

Excellent. Can you build up one or more stable branches that I can
pull those from?

> I'm still working on the interrupt controller and dma. ?orion-ehci,
> mv_cesa and sata_mv depend on one or both of those to work.

Cool.


-Olof
