From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 17 Apr 2018 16:16:39 +0800
Subject: [PATCH v5 2/7] clk: meson: aoclk: refactor common code into
 dedicated file
In-Reply-To: <1523875084.2601.28.camel@baylibre.com>
References: <20180409143749.71197-1-yixun.lan@amlogic.com>
 <20180409143749.71197-3-yixun.lan@amlogic.com>
 <1523875084.2601.28.camel@baylibre.com>
Message-ID: <759078f5-fcbf-9ef1-6945-67d9d951d8eb@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome

On 04/16/18 18:38, Jerome Brunet wrote:
>> +	 */
>> +	for (clkid = 0; clkid < data->num_clks; clkid++) {
>> +		data->clks[clkid]->map = regmap;
>> +
>> +		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +		(void *) data->hw_data);
>> +}
> Missing new line here. Please run checkpatch and pay attention to git warnings
> about whitespace errors.
> 


I think we actually need to avoid this extra new line, or what's the
benefits with new line?

and besides? I didn't see any complaint from checkpatch.pl ..

 ./scripts/checkpatch.pl
0002-clk-meson-aoclk-refactor-common-code-into-dedicated-.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#235:
new file mode 100644

total: 0 errors, 1 warnings, 302 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or
--fix-inplace.

0002-clk-meson-aoclk-refactor-common-code-into-dedicated-.patch has
style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Yixun
