From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 19 Apr 2013 17:41:00 +0100
Subject: [RFC PATCH v1 0/3] clk: implement remuxing during set_rate
In-Reply-To: <20130403213412.3383.84823@quantum>
References: <1363967031-22781-1-git-send-email-james.hogan@imgtec.com>
 <515B8EAD.8020109@codeaurora.org>
 <CAAG0J99i-AwbGoerTzQvJ+JC9yj-3Owm3e5+6xTijo4Gihcx-Q@mail.gmail.com>
 <20130403213412.3383.84823@quantum>
Message-ID: <5171739C.90707@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 03/04/13 22:34, Mike Turquette wrote:
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 9fdfae7..1a19186 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -126,6 +126,9 @@ struct clk_ops {
>  					unsigned long parent_rate);
>  	long		(*round_rate)(struct clk_hw *hw, unsigned long,
>  					unsigned long *);
> +	s64		(*determine_rate)(struct clk_hw *hw, unsigned long rate,
> +					unsigned long *best_parent_rate,
> +					struct clk *best_parent_clk);

Thanks for the comments. I've sent a new patchset based on this. I've
left the return value for determine_rate the same as round_rate though
(long rather than s64), figuring that introducing s64 would be a can of
worms, and if wanting to convert code to use s64, it should probably be
done together in a separate patchset.

Cheers
James
