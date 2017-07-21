From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jul 2017 09:50:10 +0200
Subject: [PATCH v5 0/5] iio: ADC driver for EP93xx SoC
In-Reply-To: <20170611151837.35fc64a4@kernel.org>
References: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
 <20170611151837.35fc64a4@kernel.org>
Message-ID: <CAK8P3a0OvkRJOgxyEqr+imGxf2bCrbFLNFndRJc4fvTLyYjLXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 11, 2017 at 4:18 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun,  4 Jun 2017 01:26:47 +0200
> Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:
>
>> This series prepares the necessary infrastructure for ADC platform device on
>> Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device using
>> IIO subsystem.
> The reason these have been reposted is because the EP93xx don't
> have an actual tree as such.  They are typically handled
> directly through the arm-soc tree.
>
> As such I'm looking for a route to get this applied.
> The dependencies are such that the whole series should go through
> either arm-soc or iio.  I don't really mind which.
> Either I need Acks for applying the patches that touch
> the arch bits (we have Ryan's but I'd like a more general
> arm-soc one given this will be in your area), or
> I will probably ack the driver in a minute so the log can
> go through arm-soc.
>
> Anyhow, don't really mind but let's get this moving!

Alexander just pointed me to the series, I had missed it earlier.

The patches for arch/arm/mach-ep93xx look reasonable to me,
with one minor complaint: please use "ARM:" as the subject prefix.

Alexander, can you send a pull request for the first four patches
to arm at kernel.org, or a set of patches if that is easier for you?

I think the adc driver can just get merged through the iio tree,
as there is no strict build-time dependency. I realize the driver
will fail to link when built on ep93xx or another platform that lacks
the clk_get_parent() implementation, but I think that's ok since
we have an old bug in several platforms concerning this, and
I have proposed a fix for it already.

       Arnd
