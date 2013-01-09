From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 9 Jan 2013 08:47:09 +0100
Subject: [PATCHv2 1/2] pwm: vt8500: Register write busy test performed
 incorrectly
In-Reply-To: <1357155856-9552-1-git-send-email-linux@prisktech.co.nz>
References: <1357155856-9552-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130109074709.GC12782@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 08:44:15AM +1300, Tony Prisk wrote:
> Correct operation for register writes is to perform a busy-wait
> after writing the register. Currently the busy wait it performed
> before, meaning subsequent register writes to bitfields may occur
> before the previous field has been updated.
> 
> Also, all registers are defined as 32-bit read/write. Change
> pwm_busy_wait() to use readl rather than readb.
> 
> Improve readability of code with defines for registers and bitfields.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> v2:
> Change parenthesis around defines
> Replace pr_warn with dev_warn in pwm_busy_wait()
> 
>  drivers/pwm/pwm-vt8500.c |   64 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 15 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130109/1666bd3b/attachment.sig>
