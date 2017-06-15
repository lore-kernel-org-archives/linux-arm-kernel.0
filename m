From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 15 Jun 2017 16:23:44 -0700
Subject: [PATCH 1/3] ARM: Generalize fncpy implementation
In-Reply-To: <20170615232117.29727-2-f.fainelli@gmail.com>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
 <20170615232117.29727-2-f.fainelli@gmail.com>
Message-ID: <577f22f3-ff16-05a0-8204-39e86d47dd9f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2017 04:21 PM, Florian Fainelli wrote:
> ARM's fncpy implementation is actually suitable for a large number of
> platforms since the only assumption it makes is just the function's
> alignment (8 bytes) which also happens to fulfil other architectures,
> including but not limited to ARM64.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/include/asm/fncpy.h | 77 ++----------------------------------
>  include/asm-generic/fncpy.h  | 94 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 74 deletions(-)
>  create mode 100644 include/asm-generic/fncpy.h
> 
> diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncpy.h
> index de5354746924..32465aef7932 100644
> --- a/arch/arm/include/asm/fncpy.h
> +++ b/arch/arm/include/asm/fncpy.h
> @@ -16,79 +16,8 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>   */
> +#ifndef _ASMARM_FNCPY_H

and of course I missed a

#define _ASMARM_FNCPY_H

I will wait for feedback on whether this is acceptable before
resubmitting...
-- 
Florian
