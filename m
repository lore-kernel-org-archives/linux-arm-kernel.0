From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 16 Oct 2015 12:11:53 -0700
Subject: [PATCH v2 0/3] ARM: handle imprecise aborts from firmware in
 common code
In-Reply-To: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <CANMBJr5DdOOa7EMCxCAowNVFaw2wYvXHZTDgmWJP5bM2hgsbmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On 15 October 2015 at 03:32, Lucas Stach <l.stach@pengutronix.de> wrote:
> This series implements the handling of a pending imprecise abort left behind
> by the bootloader/firmware running before Linux in the common ARM startup code.
>
> It turns pending imprecise aborts that may signal during the first unmasking
> of such aborts on the boot CPU into a non-faulting event and warns the user
> that the firmware of the machine might be buggy.
>
> Handling this in the common code makes sure that we only ignore already pending
> aborts and not those that may happen later during system boot/usage. It also
> allows to remove the custom fault handler from the 3 architectures that are
> known to have bad firmware/bootloaders.
>
> V2 adapts patch 1 to suggestions from Russell and Hauke and drops former
> patch 3 (ARM: mvebu: remove the workaround imprecise abort fault handler)
> as it has already been applied.

I have build and boot tested the three patches in this series on top
of next-20151016 with the kernelci.org system[1][2]. It found no new
build/boot regressions and also I can confirm it fixes the issue
reported here[3].

Tested-by: Tyler Baker <tyler.baker@linaro.org>

Cheers,

Tyler

[1] http://kernelci.org/boot/all/job/tbaker/kernel/v4.3-rc5-8587-g6890e51b69b2/
[2] http://kernelci.org/build/tbaker/kernel/v4.3-rc5-8587-g6890e51b69b2/
[3] http://www.spinics.net/lists/arm-kernel/msg451280.html
