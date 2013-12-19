From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 19 Dec 2013 09:54:07 +0100
Subject: [PATCH v3 1/2] clk: add clk accuracy retrieval support
In-Reply-To: <20131219060431.18119.64699@quantum>
References: <1387290983-6236-1-git-send-email-b.brezillon@overkiz.com>
 <1387290983-6236-2-git-send-email-b.brezillon@overkiz.com>
 <20131219060431.18119.64699@quantum>
Message-ID: <52B2B42F.9010202@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

On 19/12/2013 07:04, Mike Turquette wrote:
> Quoting Boris BREZILLON (2013-12-17 06:36:22)
>> +unsigned long __clk_get_accuracy(struct clk *clk)
>> +{
>> +       unsigned long ret;
>> +
>> +       if (!clk)
>> +               return 0;
>> +
>> +       return clk->accuracy;
>> +}
>> +EXPORT_SYMBOL_GPL(__clk_get_accuracy);
> Any reason for exporting this?

This might be used by clk drivers to choose the most accurate clk
among its parent clks (within the determinate_rate callback).

And as some clk drivers might be compiled as modules we need
to export the symbol (__clk_get_name helper function is exported
too).

Best Regards,

Boris
>
> Regards,
> Mike
