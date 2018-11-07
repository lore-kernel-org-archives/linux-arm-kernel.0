From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Nov 2018 12:54:54 -0800
Subject: [Ksummit-discuss] [TECH TOPIC] SoC maintainer group
In-Reply-To: <CAL_Jsq+4d-0_T68r=PWm5ey=NqsCn5j_j1sQ4Kjp1zBz6zgt6A@mail.gmail.com>
References: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
 <CAL_Jsq+4d-0_T68r=PWm5ey=NqsCn5j_j1sQ4Kjp1zBz6zgt6A@mail.gmail.com>
Message-ID: <CAOesGMgUc0r=vw30qw98qggV0P8rEPeJK0ospJdFZq_VTBqyGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 11:45 AM Rob Herring <robherring2@gmail.com> wrote:
>
> On Tue, Nov 6, 2018 at 4:17 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi KS organizers (and others),
> >
> > This is a late topic proposal, hopefully there is still time on the agenda.
> >
> > We?ve recently been discussing some maintainer model changes as
> > described below, and would like a slot to discuss the idea and solicit
> > feedback/comments from the others there.
> >
> >
> > This started with Arnd and I finally being in one place at the same
> > time, and talking about how we want to evolve arm-soc maintainership
> > moving forward. We've been independently thinking of ways to expand
> > the group and making it more self-service for everybody, but there's a
> > bunch of tooling needed to make it run smoothly beyond the smaller
> > group we have now.
> >
> > In the end, we ended up looking at it from a slightly different angle:
> > Right now, when contributors show up with new platform support, the
> > first hill they need to climb is figuring out how they need to carve
> > up their platform among all the various maintainers, how to make sure
> > they're all handshaking on keeping things stable, and get code
> > submitted. It's awkward, not well documented and one of the biggest
> > overheads we have on our side as well.
> >
> > When we started talking to other maintainers, we're also realizing
> > that we are currently duplicating a lot of work. In particular, we
> > often all get cc:d on patch series, so we all need to read and filter,
> > and assume that other maintainers spot the right patches, etc.
> >
> > We have discussed a few different options, and it seems like pooling
> > more of the contribution flow to a group of co-maintainers is a useful
> > approach. Initially, we're considering the arm-soc platforms, clock
> > drivers and pinctrl drivers, which all tend to be affected by new
> > platform contributions in this way, and often end up cross-cc:d on
> > everything. Additionally, the flow for successfully merging a new
> > platform or SoC needs to be documented and advertised. This is true
> > whether or not we change the way that maintainers coordinate amongst
> > themselves, or whether or not we change the current workflow used by
> > platform contributors today.
> >
> > So, we're planning to change things up a bit. We're starting a new
> > group that pools current arm-soc, clk and pinctrl drivers and
> > maintainers into one funnel. We'll set up a new mail alias for the
> > maintainer group, and one shared patchwork to collect contributions.
> > We still expect developers to use existing mailing lists, and we still
> > expect for example ARM platform maintainers to keep their workflow of
> > collecting patches for their platform like they do today. Down the
> > road it might make sense to incorporate other driver subsystems as
> > well.
>
> Given that dts files are a large part of what goes into arm-soc, any
> thoughts on changes to the process around them? I think it would be
> good if dts files were a bit more decoupled from kernel code changes.
> Yes, there's the issue with header dependencies to deal with. Ignoring
> that for a moment, keeping the dts files somewhat separate even if
> ultimately in the same tree and the same maintainers would be
> beneficial both for perception and to be able to do validation
> separately. And if we do ever move things out of the kernel tree, then
> it's less of a work-flow change. And I'm happy to help out here in
> whatever way I can.

Yeah, I think we need to find some good balance here that's not quite
established. I think there's good use in having some sort of superset
of DT bindings for a platform in-tree, maybe for a reference board or
similar that customers often create derivatives from, and then find a
good place for derivative DT contents out of tree. The same applies to
defconfigs, where I think the ARM64 approach of a superset of "can
boot everywhere" is useful, and if someone wants to create more
limited configs for their use case they would be free to do so.

> > Beyond this, we're going to keep a close eye on the drm-misc tree,
> > which is exploring a move to gitlab (and working with gitlab on adding
> > the features they need to move over). If they get a broad maintainer
> > model working well in that environment it could be something we reuse
> > for ourselves too.
>
> AIUI for drm-misc, a major goal there is to have more automated checks
> fed back to submitters which doesn't necessarily have anything to do
> with maintainers. That's something I want to get in front of for DT
> schema so we're not fixing things after we've accepted them. So I've
> been experimenting with gitlab CI and integration with patchwork a bit
> recently. I have gitlab CI running some tests on binding patches
> (checkpatch and schema validation), attaching the results to the DT
> patchwork instance, and updating the patch state. Here is an example
> patch[1], my patchwork related scripts are here[2], and the CI job is
> here[3].

That's really cool, thanks for sharing.

Having a place to collect lint/build/test results like this is
something I've been missing and it seems like patchwork is doing a
pretty good job there. One of the things that I'm getting excited
about is to have a shared place to collect all these signals before
patches are reviewed and applied (or pull requests merged) without
necessarily adding a lot of potentially noisy email generation.


-Olof
