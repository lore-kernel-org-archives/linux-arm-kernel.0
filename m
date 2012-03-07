From: jwboyer@gmail.com (Josh Boyer)
Date: Wed, 7 Mar 2012 09:15:59 -0500
Subject: [PATCH 1/3] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CA+5PVA7PCow=Z7TpPtQYp3ye6uKFSp3XsdH75Pe9BRu9Vyy21g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 7:30 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> to avoid duplication.
>
> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> parameterized version in Makefile.lib to avoid duplication.
>
> The centralized cmd_uimage definition will allow the future introduction
> of a centralized Kconfig option to make cmd_uimage use -T kernel_noload
> rather than -T kernel.
>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> NOTE: I have not tested this patch in any way at all for architectures
> other than ARM.
>
> ?arch/arm/boot/Makefile ? ? ? ? ?| ? 23 +++++++++--------------
> ?arch/avr32/boot/images/Makefile | ? ?9 +++------
> ?arch/blackfin/boot/Makefile ? ? | ? 19 ++++++++-----------
> ?arch/microblaze/boot/Makefile ? | ? 10 +++-------
> ?arch/sh/boot/Makefile ? ? ? ? ? | ? ?8 ++------
> ?arch/sparc/boot/Makefile ? ? ? ?| ? ?9 +++------
> ?arch/unicore32/boot/Makefile ? ?| ? 12 ++----------
> ?scripts/Makefile.lib ? ? ? ? ? ?| ? 24 ++++++++++++++++++++++++
> ?8 files changed, 54 insertions(+), 60 deletions(-)

Is there a reason you skipped powerpc?

josh
