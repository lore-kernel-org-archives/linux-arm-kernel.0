From: eric@anholt.net (Eric Anholt)
Date: Tue, 16 May 2017 15:04:54 -0700
Subject: arm64 vs arm tree for BCM2837 DT pull requests
Message-ID: <87tw4kbgqh.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm looking for feedback on how the ARM folks would like to see pull
requests for Raspberry Pi 3 devicetree changes.  My problem is trying to
merge patches like:

https://patchwork.kernel.org/patch/9603689/

which depends on:

https://patchwork.kernel.org/patch/9619573/

bcm2837's DT is in arm64/, but includes the bcm283x.dtsi under arm/
(which also contains pi0-2), so we often end up with cross-tree
dependencies when trying to merge a patch series affecting peripherals
common to all of them.  How I've done this in the past is in
http://lists.infradead.org/pipermail/linux-rpi-kernel/2016-November/004804.html:
Send a PR for bcm2835-dt-next for the arm/ BCM283x changes, merge that
tag to bcm2835-dt-64-next, apply the arm64 change, and send a separate
PR for that branch.

This seems silly to me -- in trying to keep a small arm64/ change out of
the branch for arm/, we end up pulling in much larger arm/ changes to
the arm64/ branch.  Also, this process doesn't work if we need to make a
single-commit change across both (like if we decided to change a node
name that's referenced by '&' in the board-specific .dts files).

So, I'd like to ask that I be able to merge all the BCM283x DT changes
through my bcm2835-dt-next branch, if that's OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170516/2e9fc8df/attachment.sig>
