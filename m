From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Nov 2018 14:16:27 -0800
Subject: [TECH TOPIC] SoC maintainer group
Message-ID: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi KS organizers (and others),

This is a late topic proposal, hopefully there is still time on the agenda.

We?ve recently been discussing some maintainer model changes as
described below, and would like a slot to discuss the idea and solicit
feedback/comments from the others there.


This started with Arnd and I finally being in one place at the same
time, and talking about how we want to evolve arm-soc maintainership
moving forward. We've been independently thinking of ways to expand
the group and making it more self-service for everybody, but there's a
bunch of tooling needed to make it run smoothly beyond the smaller
group we have now.

In the end, we ended up looking at it from a slightly different angle:
Right now, when contributors show up with new platform support, the
first hill they need to climb is figuring out how they need to carve
up their platform among all the various maintainers, how to make sure
they're all handshaking on keeping things stable, and get code
submitted. It's awkward, not well documented and one of the biggest
overheads we have on our side as well.

When we started talking to other maintainers, we're also realizing
that we are currently duplicating a lot of work. In particular, we
often all get cc:d on patch series, so we all need to read and filter,
and assume that other maintainers spot the right patches, etc.

We have discussed a few different options, and it seems like pooling
more of the contribution flow to a group of co-maintainers is a useful
approach. Initially, we're considering the arm-soc platforms, clock
drivers and pinctrl drivers, which all tend to be affected by new
platform contributions in this way, and often end up cross-cc:d on
everything. Additionally, the flow for successfully merging a new
platform or SoC needs to be documented and advertised. This is true
whether or not we change the way that maintainers coordinate amongst
themselves, or whether or not we change the current workflow used by
platform contributors today.

So, we're planning to change things up a bit. We're starting a new
group that pools current arm-soc, clk and pinctrl drivers and
maintainers into one funnel. We'll set up a new mail alias for the
maintainer group, and one shared patchwork to collect contributions.
We still expect developers to use existing mailing lists, and we still
expect for example ARM platform maintainers to keep their workflow of
collecting patches for their platform like they do today. Down the
road it might make sense to incorporate other driver subsystems as
well.

Beyond this, we're going to keep a close eye on the drm-misc tree,
which is exploring a move to gitlab (and working with gitlab on adding
the features they need to move over). If they get a broad maintainer
model working well in that environment it could be something we reuse
for ourselves too.

This group will also take on the responsibility of putting together
the documentation and expected patch flow for new platform/SoC
contributors. That documentation will need to evolve a bit over time
as we try out this new collaboration between maintainers.

To avoid an appearance of "ARM is taking over all architectures",
we'll rename this to just the plain "SoC tree/group", and drop ARM
from the name. As mentioned already initially we're anticipating
covering ARM (32/64-bit like before) and RISC-V platform areas in a
similar way. For other older/minor architectures that are
semi-orphaned, we might pick up code as needed when it affects us,
depending on maintainer status at the other end.

We're doing the groundwork now, and will get trees/lists/patchworks
setup for the next release cycle.


People involved so far are:

Olof Johansson (arm-soc)
Arnd Bergmann (arm-soc)
Kevin Hilman (arm-soc)
Mike Turquette (clk)
Stephen Boyd (clk)
Linus Walleij (pinctrl + more)
Mike Brown (gpio/regmap + more)


Thanks!

-Olof (on behalf of the group)
