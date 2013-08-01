From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 1 Aug 2013 11:17:25 +0200
Subject: [PATCH 8/9] ARM: kirkwood: remove unused common code for LaCie
 platforms
In-Reply-To: <1375346738-21596-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375346738-21596-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130801091725.GV9916@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 10:45:37AM +0200, Thomas Petazzoni wrote:
> Now that all LaCie platforms have been converted to use the Device
> Tree, we can get rid of the lacie_v2-common.{c,h} files.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-kirkwood/lacie_v2-common.c | 114 -------------------------------
>  arch/arm/mach-kirkwood/lacie_v2-common.h |  16 -----
>  2 files changed, 130 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
>  delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h

Please take care...

You can't remove this files. A lot of functions are still used by
netxbig_v2-setup.c. The LaCie "Big" boards are not converted to DT.
Note that I am currently working on the leds-netxbig driver conversion,
which is needed by the "Big" boards.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130801/b2b73ecb/attachment-0001.sig>
