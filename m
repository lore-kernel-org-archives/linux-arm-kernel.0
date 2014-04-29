From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 29 Apr 2014 15:00:48 +0100
Subject: [PATCH v2 00/21] FDT clean-ups and libfdt support
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Message-ID: <20140429140048.7C9D0C40992@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Apr 2014 20:18:00 -0500, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This is a series of clean-ups of architecture FDT code and converts the
> core FDT code over to using libfdt functions. This is in preparation
> to add FDT based address translation parsing functions for early
> console support. This series removes direct access to FDT data from all
> arches except powerpc.
> 
> The current MIPS lantiq and xlp DT code is buggy as built-in DTBs need
> to be copied out of init section. Patches 2 and 3 should be applied to
> 3.15.
> 
> Changes in v2 are relatively minor. There was a bug in the unflattening
> code where walking up the tree was not being handled correctly (thanks
> to Michal Simek). I re-worked things a bit to avoid globally adding
> libfdt include paths.
> 
> A branch is available here[1], and I plan to put into linux-next in a few
> days. Please test! I've compiled on arm, arm64, mips, microblaze, xtensa,
> and powerpc and booted on arm and arm64.

This is pretty great work. I'll read through them again and I may have a
comment or two, but in general you can add my tested by tag:

Tested-by: Grant Likely <grant.likely@linaro.org>

>  40 files changed, 280 insertions(+), 598 deletions(-)

I love the diffstat!

g.
