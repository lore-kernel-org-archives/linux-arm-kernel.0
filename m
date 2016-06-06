From: hl@rock-chips.com (hl)
Date: Mon, 6 Jun 2016 14:19:12 +0800
Subject: [RFC PATCH v1 4/6] PM / devfreq: event: support rockchip dfi
 controller
In-Reply-To: <20160603165426.GC21013@ulmo.ba.sec>
References: <1464947719-6245-1-git-send-email-hl@rock-chips.com>
 <1464947719-6245-5-git-send-email-hl@rock-chips.com>
 <20160603165426.GC21013@ulmo.ba.sec>
Message-ID: <575515E0.8080108@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On 2016?06?04? 00:54, Thierry Reding wrote:
> On Fri, Jun 03, 2016 at 05:55:17PM +0800, Lin Huang wrote:
> [...]
>> +	ret = clk_prepare_enable(data->clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to enable clk: %d\n", ret);
>> +		clk_disable_unprepare(data->clk);
>> +		return ret;
>> +	}
> This is going to give you a large WARN. clk_prepare_enable() already
> leaves the clock in a proper state when it fails (i.e. it calls
> clk_unprepare() if the clk_enable() part failed), so calling
> clk_disable_unprepare() upon failure is going to unbalance the
> reference counts.
Thanks for reminding, i will fix it next version.
>
> Thierry

-- 
Lin Huang
