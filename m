From: olof@lixom.net (Olof Johansson)
Date: Sun, 10 Sep 2017 18:18:00 -0700
Subject: [GIT PULL 0/3] ARM and arm64 platform updates for v4.14
Message-ID: <1505092683-19362-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are the ARM-SoC updates for this merge window. This time around,
I collapsed down the branches to three main ones and am sending those
as our pull requests; We've had less miscellaneous contents this cycle
so it seemed like the right level of exposing the work going on.

One branch for platform type stuff: It contains what we used to split up
into board updates (back when we had a volume of those), SoC updates and
ARM64 "main" updates. Mostly new SoC support, whatever mach directory
changes are still ongoing on 32-bit and new config options for arm64.

Then there's a drivers branch -- mostly some SoC-related drivers (in
the future we might bias those towards the platform branch instead),
and a few of the smaller driver trees that we've been merging through
arm-soc traditionally (reset, TEE).

Finally, the usual large update of devicetrees. This continues to be
the bulk of updates, which still is a sign of things working the way we
want to.

There are a few smallish conflicts; Some with Media due to a
dependency/rename of options and updating a defconfig. There are also
a couple for DT where developers posted DT updates as part of a driver
series and DaveM applied him (happens sometimes in the volume he's
processing). Nothing too hairy to fix; see comments on that pull request.


A note to our submaintainers in case they're tuned in: Just because we're
choosing to group into fewer branches, we still want to see branches
coming into us in the same granularity as before: We can't tell at the
beginning of a cycle what kind of organization makes sense towards the
end. So don't try to change your organization to match.


Please merge!


Thanks,

-Olof
