From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 16 Jul 2013 13:16:43 +0200
Subject: [PATCH 4/5] iio: at91: add an optional dt property for for adc
 clock hz.
In-Reply-To: <20130716103014.GB3125@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-5-git-send-email-josh.wu@atmel.com>
 <20130715130610.GD2962@lukather> <51E4FC70.3050207@atmel.com>
 <20130716103014.GB3125@lukather>
Message-ID: <51E52B9B.5030407@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 12:30 PM, Maxime Ripard wrote:
[...]
>> After a further thinking of this, maybe remove the adc_op_clk is
>> better since it is a fake clock, and only used to specify the clock
>> rate.
>> To specify the clock rate use a dt property or platform data
>> parameter is better.
> 
> No, to specify *any* clock, the common clock framework is the better
> solution.

Yep, this patch is not the right approach. It's trying to work around the
limitations of the platforms clock API implementation. Please fix the at91
clock implementation instead (e.g. by switching to the common clock framework).

- Lars
