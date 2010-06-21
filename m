From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 22 Jun 2010 08:43:06 +1200
Subject: [PATCH 2/2] clk: Generic support for fixed-rate clocks
In-Reply-To: <1277098513.947920.264679354891.2.gpush@pororo>
References: <1277098513.947920.264679354891.2.gpush@pororo>
Message-ID: <4C1FCEDA.3000303@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2010 05:35 PM, Jeremy Kerr wrote:
> Since most platforms will need a fixed-rate clock, add one. This will
> also serve as a basic example of an implementation of struct clk.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> ---
>  include/linux/clk.h |   13 +++++++++++++
>  kernel/clk.c        |   14 ++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 5c1098b..1dce473 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -79,6 +79,19 @@ struct clk_ops {
>   */
>  int __clk_get(struct clk *clk);
>  
> +/* Simple fixed-rate clock */
> +struct clk_fixed {
> +	struct clk	clk;
> +	unsigned long	rate;
> +};

Not sure if this has been discussed already, but shouldn't rate be const
for a fixed clock?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
