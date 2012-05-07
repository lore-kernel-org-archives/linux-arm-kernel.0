From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 7 May 2012 09:11:53 +0530
Subject: [PATCH V4] clk: add a fixed factor clock
In-Reply-To: <20120507014241.GA15248@gmail.com>
References: <85453b2bb4d448d0dcd291579bd76e70c1b48e5b.1336039424.git.viresh.kumar@st.com>
 <20120503120821.GJ4141@pengutronix.de>
 <CAOh2x=mF5MjG_TM0S7W+r8=eVXf3v9SBsaxADZYFTjtPKoRm4w@mail.gmail.com>
 <20120507014241.GA15248@gmail.com>
Message-ID: <4FA74481.7010401@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/7/2012 7:12 AM, Mike Turquette wrote:
> I've applied the below fix in my local branch.  Let me know if you have
> issue with it before I send out my pull request to Arnd.
> 
> Thanks,
> Mike
> 
> 
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index 0e8782b..1f2da01 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -88,10 +88,8 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
>  
>  	clk = clk_register(dev, &fix->hw);
>  
> -	if (clk)
> -		return clk;
> +	if (IS_ERR(clk))
> +		kfree(fix);
>  
> -	kfree(fix);
> -
> -	return NULL;
> +	return clk;
>  }

No problems. Please send it to Arnd ASAP.

--
viresh
