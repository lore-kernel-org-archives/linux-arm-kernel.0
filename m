From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Dec 2011 09:32:39 -0800
Subject: [PATCH] arm/tegra: boards: more __init/__initdata annotations
In-Reply-To: <CAOesGMjh2DmzgjvoYZyDygADDcMwf-m7E3Np0f=h8xRWZZ6-4Q@mail.gmail.com>
References: <1324353802-31774-1-git-send-email-olof@lixom.net>
 <20111220082641.GQ14542@n2100.arm.linux.org.uk>
 <CAOesGMjh2DmzgjvoYZyDygADDcMwf-m7E3Np0f=h8xRWZZ6-4Q@mail.gmail.com>
Message-ID: <CAOesGMj73O79=hwFfLFpepTy1WDXCztppZQmZ_5b4tYRhjQFjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 9:06 AM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Dec 20, 2011 at 12:26 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Dec 19, 2011 at 08:03:22PM -0800, Olof Johansson wrote:
>>> Silence a bunch of section warnings, and mark some of the init functions as
>>> __init.
[...]
> Thanks for pointing it out -- looks like a couple of other instances
> use the wrong location as well (probably added by me in the past).
> I'll respin the patch, and fix up those cases as well.


Actually, after some brief discussion on IRC, I'll go the other way
instead: These tables are all moving to devicetree in the next release
or so, and it's uncertain what functions should (long-term) be __init
and not. For now, I'll just remove __initdata from the seaboard pinmux
tables. Sending separate patch for that.


-Olof
