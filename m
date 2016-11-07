From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Nov 2016 12:49:37 +0100
Subject: [PATCH V4 6/6] bus: Add support for Tegra Generic Memory Interface
In-Reply-To: <1478507405-13204-7-git-send-email-mirza.krak@gmail.com>
References: <1478507405-13204-1-git-send-email-mirza.krak@gmail.com>
 <1478507405-13204-7-git-send-email-mirza.krak@gmail.com>
Message-ID: <20161107114937.GD28616@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 09:30:05AM +0100, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> The Generic Memory Interface bus can be used to connect high-speed
> devices such as NOR flash, FPGAs, DSPs...
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board
> ---
> 
> Changes in v2:
>  - Fixed some checkpatch errors
>  - Re-ordered probe to get rid of local variables
>  - Moved of_platform_default_populate call to the end of probe
>  - Use the timing and configuration properties from the child device
>  - Added warning if more then 1 child device exist
> 
> Changes in v3:
>  - added helper function to disable the controller which is used in remove and
>  on error.
>  - Added logic to parse CS# from "ranges" property with fallback to "reg"
>  property
> 
> Changes in v4:
> - added sanity check of chip-select property (fail if invalid)
> - adjusted for device tree binding property name changes
> - fail probe if there are no child nodes
> - removed superfluous error message
> - removed superfluous newline in Kconfig
> 
>  drivers/bus/Kconfig     |   7 ++
>  drivers/bus/Makefile    |   1 +
>  drivers/bus/tegra-gmi.c | 275 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 283 insertions(+)
>  create mode 100644 drivers/bus/tegra-gmi.c

Applied with a bit of code reshuffling to make things more symmetric as
well as a couple of pedantic cleanups because I couldn't resist.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/e087bf16/attachment-0001.sig>
