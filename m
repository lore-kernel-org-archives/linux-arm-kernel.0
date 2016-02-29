From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Feb 2016 12:20:05 -0800
Subject: [PATCH 6/6] clk: bcm2835: clean up coding style issues
In-Reply-To: <1456745963-2403-7-git-send-email-kernel@martin.sperl.org>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-7-git-send-email-kernel@martin.sperl.org>
Message-ID: <87oaaz5kwa.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Fix all the checkpatch complaints for clk-bcm2835.c
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/clk/bcm/clk-bcm2835.c |   14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index da77069..105a42f 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -12,9 +12,6 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
>  /**
> @@ -300,7 +297,7 @@
>  struct bcm2835_cprman {
>  	struct device *dev;
>  	void __iomem *regs;
> -	spinlock_t regs_lock;
> +	spinlock_t regs_lock; /* spinlock for all clocks */
>  	const char *osc_name;

I don't think this comment adds anything at all, but I understand you're
trying to shut checkpatch up and I don't think there's much to say.  I'd
drop it, but I won't block the patch for it.  Everything else in the
patch looks good.

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/c29e5ef3/attachment.sig>
