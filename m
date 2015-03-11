From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 11 Mar 2015 11:54:23 +0100
Subject: [PATCH 4/8] pwm: atmel-hlcdc: fix struct clk pointer comparing
In-Reply-To: <1424876018-17852-5-git-send-email-shawn.guo@linaro.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <20150311105422.GC22149@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 10:53:34PM +0800, Shawn Guo wrote:
> Since commit 035a61c314eb ("clk: Make clk API return per-user struct clk
> instances"), clk API users can no longer check if two struct clk
> pointers are pointing to the same hardware clock, i.e. struct clk_hw, by
> simply comparing two pointers.  That's because with the per-user clk
> change, a brand new struct clk is created whenever clients try to look
> up the clock by calling clk_get() or sister functions like clk_get_sys()
> and of_clk_get().  This changes the original behavior where the struct
> clk is only created for once when clock driver registers the clock to
> CCF in the first place.  The net change here is before commit
> 035a61c314eb the struct clk pointer is unique for given hardware
> clock, while after the commit the pointers returned by clk lookup calls
> become different for the same hardware clock.
> 
> That said, the struct clk pointer comparing in the code doesn't work any
> more.  Call helper function clk_is_match() instead to fix the problem.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/8ec93d5f/attachment.sig>
