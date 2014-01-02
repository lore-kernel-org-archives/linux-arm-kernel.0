From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 2 Jan 2014 18:03:42 +0100
Subject: [PATCH 4/6] ARM: tegra: rework fuse.c
In-Reply-To: <20140102143221.GR26588@tbergstrom-lnx.Nvidia.com>
References: <1387468474-26521-1-git-send-email-pdeschrijver@nvidia.com>
 <1387468474-26521-5-git-send-email-pdeschrijver@nvidia.com>
 <CACRpkdbXc_yH-=WgpQyVwHC_TSPfbfx=tHwziNhmB6t0HuSfRw@mail.gmail.com>
 <20140102143221.GR26588@tbergstrom-lnx.Nvidia.com>
Message-ID: <CACRpkdZzaiU-BAmkBS1usLRVKxVEyiTuciNpKATK7k+zA3YKZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 2, 2014 at 3:32 PM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> On Thu, Jan 02, 2014 at 01:37:43PM +0100, Linus Walleij wrote:
>> On Thu, Dec 19, 2013 at 4:54 PM, Peter De Schrijver
>> <pdeschrijver@nvidia.com> wrote:
>>
>> > Reduce fuse.c to the minimum functionality required for the early bootstages.
>> > Also export tegra_read_straps() for use by the fuse driver.
>> >
>> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>
>> Aha, but why?
>>
>
> The efuse driver in patch 2 of this series, adds the randomness, so we don't
> need to add it here then?

Aha I wasn't CC:ed on patch 2 so I didn't see that...

> Yes, it's done in the efuse driver now, do you think that's too late?

Don't know but I don't think so. The important part is that it's done
before drivers needing good randomness (as opposed to good
entropy). The only Tegra driver I'm aware of that needs this is the
crypto driver (which I patched a bit) and I think that will only come
into play when you do something like set up a VPN tunnel or
similar which will be waaaaay later, so no problem AFAICT.

Yours,
Linus Walleij
