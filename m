From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 May 2011 08:46:26 -0700
Subject: [PATCH 2/2] GPIO: OMAP: move to drivers/gpio
In-Reply-To: <BANLkTinqEM-iDhgSMAnMB5uehkt=V1Qq+w@mail.gmail.com> (Grant
	Likely's message of "Fri, 27 May 2011 02:25:33 -0600")
References: <1305898868-9188-1-git-send-email-khilman@ti.com>
	<1305898868-9188-3-git-send-email-khilman@ti.com>
	<20110527073529.GF31953@ponder.secretlab.ca>
	<BANLkTinqEM-iDhgSMAnMB5uehkt=V1Qq+w@mail.gmail.com>
Message-ID: <87pqn4404t.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, May 27, 2011 at 1:35 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Fri, May 20, 2011 at 03:41:08PM +0200, Kevin Hilman wrote:
>>> Move OMAP GPIO driver to drivers/gpio. ?Builds whenever
>>> CONFIG_ARCH_OMAP=y.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>>
>> Patch unfortunately doesn't apply cleanly to Linus' tree. ?There's
>> been some changes to gpio.c compared to the tree this patch was
>> prepared against.
>>
>> Also, if you use the -M flag when preparing the patch, then I'll be
>> able to see what the changes are during the move, and fix things up
>> intelligently if anything breaks.
>>
>> Can you respin and repost the series quickly?
>
> While you're at it, can you name the moved file
> drivers/gpio/gpio-omap.c?  ('-' instead of '_'.  Why, yes, I am a
> nitpicker.)

OK, I rebased onto RMK's for-linus branch (already pulled by Linus),
which contained some other changes touching gpio.c.    I also s/_/-/ in
the filename.

Below is pull request.

Thanks,

Kevin


The following changes since commit 9a55d9752d8abfc62f1ab05ccc790d22a0c8e7c0:

  Merge branch 'devel-stable' into for-linus (2011-05-23 19:28:04 +0100)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_2.6.40/gpio-move

Kevin Hilman (2):
      GPIO: OMAP: move register offset defines into <plat/gpio.h>
      GPIO: OMAP: move to drivers/gpio

 arch/arm/plat-omap/Makefile                        |    2 +-
 arch/arm/plat-omap/include/plat/gpio.h             |  103 +++++++++++++++++++
 drivers/gpio/Makefile                              |    1 +
 .../plat-omap/gpio.c => drivers/gpio/gpio-omap.c   |  105 --------------------
 4 files changed, 105 insertions(+), 106 deletions(-)
 rename arch/arm/plat-omap/gpio.c => drivers/gpio/gpio-omap.c (93%)
