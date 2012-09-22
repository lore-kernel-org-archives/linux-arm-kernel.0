From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Sep 2012 22:39:02 -0700
Subject: [PATCH 4/5] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <3910462.8Opr7bJoeX@amdc1227>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <1347524018-19301-5-git-send-email-t.figa@samsung.com>
 <20120916004455.GD7028@quad.lixom.net>
 <3910462.8Opr7bJoeX@amdc1227>
Message-ID: <CAOesGMivzmbNxCeScBAhAzv+eOiF-bagLsW3WJzECaZEg5jFPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 3:10 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Olof,
>
> On Saturday 15 of September 2012 17:44:55 Olof Johansson wrote:
>> On Thu, Sep 13, 2012 at 10:13:37AM +0200, Tomasz Figa wrote:
>> > +static void __iomem *exynos_cpu_boot_reg(int cpu)
>> > +{
>> > +   return S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
>> > +}
>>
>> This communication area in sysram should probably be seen as a part of
>> the firmware interface. It should thus be defined as part of the binding
>> instead, i.e.  through a reg property or similar there. That also would
>> make it easy to convert to using ioremap() instead of iodesc tables,
>> which always a nice thing.
>
> The problem with SYSRAM_NS is that it might be also used in other code, not
> related to firmware only. I don't know exactly all the use cases for it.

If you don't know the use cases, and the use cases are not in the
kernel tree that we care about here (upstream), then there's really
nothing to worry about. It's after all just a define that's moved to
an ioremap, if there's some out of tree code that needs the old legacy
define then it can be added in whatever out-of-tree code that uses it.
Right?

> Is it really a big problem or we could let it be for now, merge the patches
> for firmware and then convert SYSRAM_NS to dynamic mapping when its
> situation clarifies?

What do you expect is required to clarify the situation, and when do
you expect that to happen?


-Olof
