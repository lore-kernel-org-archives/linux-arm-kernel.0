From: stanley.miao@windriver.com (stanley.miao)
Date: Tue, 15 Feb 2011 17:06:08 +0800
Subject: [PATCH V5 resend 39/63] SPEAr CPU freq: Adding support for CPU
	Freq	framework
In-Reply-To: <01612f9ae6c475b861c2f03cc24a4cb4639e01d1.1295581815.git.viresh.kumar@st.com>
References: <cover.1295581815.git.viresh.kumar@st.com>
	<01612f9ae6c475b861c2f03cc24a4cb4639e01d1.1295581815.git.viresh.kumar@st.com>
Message-ID: <4D5A4200.3000303@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar wrote:
> From: Deepak Sikri <deepak.sikri@st.com>
>
> <snip>
> +
> +	newfreq = clk_round_rate(cpu_clk, spear_cpu_freq[index] * 1000);
> +	if (newfreq < 0) {
> +		pr_err("CPU Freq: clk_round_rate failed: %ld\n", newfreq);
> +		return newfreq;
> +	}
>   

clk_round_rate will call round_rate_index();
--------------------------

static int
round_rate_index(struct clk *clk, unsigned long drate, unsigned long *rate)
{
        unsigned long tmp = 0, prev_rate = 0; 
        int index;

        if (!clk->calc_rate)
                return -EFAULT;

------------------------------------------

The cpu_clk don't have calc_rate, clk_round_rate always return fault.

Stanley.
