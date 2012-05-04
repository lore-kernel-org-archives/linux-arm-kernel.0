From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 3 May 2012 22:38:15 -0700
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <201205031350.35476.arnd@arndb.de>
References: <201205031350.35476.arnd@arndb.de>
Message-ID: <CAK2p4sJj7FRVSStVkqmn16sUv8S3vHmUYCU_VzTWAWzqV5yVsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2012 06:50, Arnd Bergmann <arnd@arndb.de> wrote:
> Hi everyone,
>
> I've been discussing multiplatform kernels with a few people recently,
> and we will have a lot of discussion sessions about this at Linaro
> Connect in Hong Kong.
>
> One question that came up repeatedly is whether we should support all
> possible board files for each platform in a multiplatform kernel,
> or just the ones that are already using DT probing. I would like
> to get a quick poll of opinions on that and I've tried to put those
> people on Cc that would be most impacted by this, i.e. the maintainers
> for platforms that have both DT and non-DT board files at the moment.
>
> My feeling is that we should just mandate DT booting for multiplatform
> kernels, because it significantly reduces the combinatorial space
> at compile time, avoids a lot of legacy board files that we cannot
> test anyway, reduces the total kernel size and gives an incentive
> for people to move forward to DT with their existing boards.

+1

I'm of the opinion that we support DT only platforms for
multi-platform but this is based on the approach of only caring for
multi-platform for newer systems and not worrying too much for legacy
HW.  I look at this from the perspective of how much return do we get
on investing effort into making it possible for every platform to be
built as part of consolidated zImage.  I don't expect distros (the
main users of a single zImage IMHO) to spend many cycles on older
platforms and those of us who still have some of them sitting around
to use are generally developers who are going to be doing a lot of
builds anyways...

~Deepak
