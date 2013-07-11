From: balbi@ti.com (Felipe Balbi)
Date: Thu, 11 Jul 2013 16:28:18 +0300
Subject: [PATCH 0/2] Fix omap serial early crash during hwmod _setup()
In-Reply-To: <1373539986-27272-1-git-send-email-rnayak@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Message-ID: <20130711132818.GE30970@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 04:23:03PM +0530, Rajendra Nayak wrote:
> This series should fix the issue with the early serial crash seen
> during hwmod _setup() as reported by [1]
> 
> The issue was reported on a am33xx device and was not seen on omap4
> or omap5 devices as the hwmod data for both omap4 and omap5 had
> statically defined HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET for
> uart3 which happens to be the debug console used on omap4 panda and
> omap5 uevm boards.
> 
> The series reverts the patch which stubbed out omap_serial_early_init()
> for DT boot and gets rid of the static flags in omap4 and omap5 hwmod
> data.
> 
> This series along with the patch posted by Felipe [2] should fix the
> issue reported by [1] completely and boot to prompt on a am33xx device
> with LL_DEBUG enabled.
> 
> I have boot tested this series (along with [2]) on a omap4 panda es and
> a am335x boneblack.
> 
> [1] http://comments.gmane.org/gmane.linux.ports.arm.omap/100628
> 
> [2] http://marc.info/?l=linux-omap&m=137353783912736&w=2
> 
> Rajendra Nayak (2):
>   Revert "ARM: OMAP2+: Fix serial init for device tree based booting"
>   ARM: OMAP4+: Get rid of the HWMOD_INIT_NO_IDLE and
>     HWMOD_INIT_NO_RESET flags for uart

boot tested on omap4-panda rev a3. Console still works and it suspends
and resumes fine after setting a proper timeout.

Tested-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/b7de8f7f/attachment.sig>
