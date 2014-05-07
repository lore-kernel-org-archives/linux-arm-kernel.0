From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 May 2014 11:03:48 -0700
Subject: [PATCH v5 06/14] ARM: mcpm: support 4 clusters
In-Reply-To: <alpine.LFD.2.11.1405071345540.980@knanqh.ubzr>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-7-git-send-email-haojian.zhuang@linaro.org>
 <20140507164816.GB12692@quad.lixom.net>
 <alpine.LFD.2.11.1405071345540.980@knanqh.ubzr>
Message-ID: <CAOesGMgj3BrB9Tkzy-FFcLdxetyqFHsnt7ak6ZCh9VkT8WrFaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 7, 2014 at 11:00 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 7 May 2014, Olof Johansson wrote:
>
>> On Wed, May 07, 2014 at 10:44:40PM +0800, Haojian Zhuang wrote:
>> > Add the CONFIG_MCPM_QUAD_CLUSTER configuration to enlarge cluster number
>> > from 2 to 4.
>> >
>> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> > ---
>> >  arch/arm/Kconfig            | 9 +++++++++
>> >  arch/arm/include/asm/mcpm.h | 5 +++++
>> >  2 files changed, 14 insertions(+)
>> >
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 0e52a2c..624829f 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -1575,6 +1575,15 @@ config MCPM
>> >       for (multi-)cluster based systems, such as big.LITTLE based
>> >       systems.
>> >
>> > +config MCPM_QUAD_CLUSTER
>> > +   bool "Enable Quad clusters in MCPM"
>> > +   depends on MCPM
>> > +   help
>> > +     To avoid wasting resources unnecessarily, MCPM only supports up
>> > +     to 2 clusters by default.
>> > +     Platforms with 3 or 4 clusters that use MCPM must select this
>> > +     option to allow the additional clusters to be managed.
>> > +
>>
>> Why don't you add an integer config instead, i.e. MCPM_MAX_CLUSTERS, and let
>> that set MAX_NR_CLUSTERS?
>
> I requested for this config symbol not to be visible to users (the
> prompt string should be removed) and be selected by those platforms that
> need it instead.  And there is no way to specify an actual value with
> 'select'. And that wouldn't work in a multi-platform config where
> different platforms could fight over a different value anyway.
>
> I also prefer to keep some control on the actual number that can be used
> here so not to let people go overboard with it.  If this grows too big
> we'll have to consider some dynamic allocation instead.
>
> See previous discussion here:
>
> http://article.gmane.org/gmane.linux.ports.arm.kernel/315228

Ok, fair enough.


-Olof
