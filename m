From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Tue, 19 Feb 2013 09:09:31 +0530
Subject: Question about fixed-clock
In-Reply-To: <5122BF88.1050007@gmail.com>
References: <5122BF88.1050007@gmail.com>
Message-ID: <20130219033931.GA2479@afzal-ThinkPad-R50e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Feb 19, 2013 at 12:55:52AM +0100, Daniel Mack wrote:

> 	ref25: ref25M {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <25000000>;
> 	};
> 
> 	clock-generator at 0 {
> 				/* ... */
> 				#clock-cells = <1>;
> 				clocks = <&ref25>;
> 	}
> 
> The device driver for clock-generator uses something like the following
> call to get its clock:
> 
> 	clk = of_clk_get(np, 0);
> 
> but the return value is ERR_PTR(-ENOENT) and I also can't find this
> clock in the clk debugfs tree.

Hope invoking of_clk_init before clock generator driver helps

Regards
Afzal
