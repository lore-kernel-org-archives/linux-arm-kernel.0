From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 29 Jul 2011 17:35:38 +0530
Subject: [PATCH 02/18] dmaengine/amba-pl08x: Resolve formatting issues
In-Reply-To: <1e5012faf0649e7ed0113960a9ac8302e46f1354.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<1e5012faf0649e7ed0113960a9ac8302e46f1354.1311936524.git.viresh.kumar@st.com>
Message-ID: <1311941138.1536.528.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
> There were few formatting related issues in code. This patch fixes them.
> Fixes include:
> - Remove extra blank lines and spaces
> - align code to 80 cols
> - Don't mix spaces and tabs (use tabs instead)
> - combine several lines to one line
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/amba-pl08x.c   |  192 ++++++++++++++++++++++----------------------
>  include/linux/amba/pl08x.h |    2 +-
>  2 files changed, 97 insertions(+), 97 deletions(-)
> 
>  
> @@ -735,16 +735,15 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
>  			} else {
>  				/*
>  				 * So now we know how many bytes to transfer
> -				 * to get to the nearest boundary.  The next
> -				 * LLI will past the boundary.  However, we
> +				 * to get to the nearest boundary. The next
> +				 * LLI will past the boundary. However, we
>  				 * may be working to a boundary on the slave
> -				 * bus.  We need to ensure the master stays
> +				 * bus. We need to ensure the master stays
>  				 * aligned, and that we are working in
>  				 * multiples of the bus widths.
>  				 */
This looks v ugly, care to fix this.
80chars should be followed with a little common sense, if it sacrifices
code readability then pls ignore it.
In places where you can fix it w/o sacrificing code quality pls do it :)

>  				odd_bytes = lli_len % mbus->buswidth;
>  				lli_len -= odd_bytes;
> -
>  			}
>  
>  			if (lli_len) {
> @@ -756,30 +755,32 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
>  				 */
>  				/* FIXME: use round_down()? */
while you are fixing the driver, care to fix the FIXME as well?
>  				tsize = lli_len / min(mbus->buswidth,
> -						      sbus->buswidth);
> +						sbus->buswidth);
>  				lli_len	= tsize * min(mbus->buswidth,
> -						      sbus->buswidth);
> +						sbus->buswidth);
>  
>  				if (target_len != lli_len) {
>  					dev_vdbg(&pl08x->adev->dev,
> -					"%s can't send what we want. Desired 0x%08zx, lli of 0x%08zx bytes in txd of 0x%08zx\n",
> -					__func__, target_len, lli_len, txd->len);
> +					"%s can't send what we want. Desired "
> +					"0x%08zx, lli of 0x%08zx bytes in txd "
> +					"of 0x%08zx\n", __func__, target_len,
> +					lli_len, txd->len);
>  				}
Oh no, you don't want to do this, see above...

Okay, looking below mostly it would be comments like these, please go
thru above and apply fixes only where they make sense


-- 
~Vinod
