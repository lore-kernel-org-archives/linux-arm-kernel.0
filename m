From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Jun 2013 09:57:16 +0100
Subject: [PATCH v2] arm64: kernel: compiling issue, need delete
 read_current_timer().
In-Reply-To: <51B2B50A.1050305@asianux.com>
References: <5199C725.8050102@asianux.com>
 <168084c28e8ba5124c05553e97463172@localhost>
 <20130520095606.GH31359@mudshark.cambridge.arm.com>
 <519AF2DC.2040200@asianux.com>
 <20130521085325.GB10453@mudshark.cambridge.arm.com>
 <519B425D.4030806@asianux.com> <51A32F40.1050309@asianux.com>
 <51B2B50A.1050305@asianux.com>
Message-ID: <20130610085715.GA6580@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 05:37:30AM +0100, Chen Gang wrote:
> Hello Maintainers:
> 
> Please help check it, when you have time.

[...]

> >> Under arm64, we will calibrate the delay loop statically using a known
> >> timer frequency, so delete read_current_timer(), or it will cause
> >> compiling issue with allmodconfig.
> >>
> >> The related error:
> >>   ERROR: "read_current_timer" [lib/rbtree_test.ko] undefined!
> >>   ERROR: "read_current_timer" [lib/interval_tree_test.ko] undefined!
> >>   ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined!
> >>   ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!
> >>
> >>
> >> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> >> ---
> >>  arch/arm64/include/asm/timex.h |    6 +++---
> >>  arch/arm64/kernel/time.c       |    6 ------
> >>  2 files changed, 3 insertions(+), 9 deletions(-)

Looks ok to me. We'll take it for a spin and apply it if it doesn't catch
fire.

Will
