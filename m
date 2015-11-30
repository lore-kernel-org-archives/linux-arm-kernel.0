From: mkarthi3@visteon.com (Mutharaju, Prasanna (P.))
Date: Mon, 30 Nov 2015 08:05:18 +0000
Subject: [PATCH v2] clk: s3c2410: removed unneeded variable in
 s3c24xx_clkout_set_parent
In-Reply-To: <565BFB57.2000701@samsung.com>
References: <20151130072852.GA25202@jci-VirtualBox>
 <565BFB57.2000701@samsung.com>
Message-ID: <20151130080514.GA27761@jci-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 04:31:35PM +0900, Krzysztof Kozlowski wrote:
> On 30.11.2015 16:28, Mutharaju, Prasanna (P.) wrote:
> > From: Prasanna Karthik <mkarthi3@visteon.com>
> > 
> > Remove unneeded variable used to store return value.
> > V2: Modified subject  
> 
> Changelog (v2) should go after '---' separator so it won't get included
> in the commit message.
> 

Done in v3. 

> Now I see that you Signed-off-by is okay - same email address... I got
> confused by the difference in name.

Yeah, my gitconfig and outlook account differ little. 

> Best regards,
> Krzysztof
> > 
> > Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> > ---
> >  drivers/clk/samsung/clk-s3c2410-dclk.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
> > index e9eb935..ec6fb14 100644
> > --- a/drivers/clk/samsung/clk-s3c2410-dclk.c
> > +++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
> > @@ -77,12 +77,11 @@ static u8 s3c24xx_clkout_get_parent(struct clk_hw *hw)
> >  static int s3c24xx_clkout_set_parent(struct clk_hw *hw, u8 index)
> >  {
> >  	struct s3c24xx_clkout *clkout = to_s3c24xx_clkout(hw);
> > -	int ret = 0;
> >  
> >  	s3c2410_modify_misccr((clkout->mask << clkout->shift),
> >  			      (index << clkout->shift));
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static const struct clk_ops s3c24xx_clkout_ops = {
> > 
> 
