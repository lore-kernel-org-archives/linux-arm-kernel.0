From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 10 Jan 2017 15:02:41 +0800
Subject: [PATCH v11 2/8] power: add power sequence library
In-Reply-To: <20170107085456.w5dhm7qadqa6tc7v@kozik-lap>
References: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
 <1483596119-27508-3-git-send-email-peter.chen@nxp.com>
 <20170107085456.w5dhm7qadqa6tc7v@kozik-lap>
Message-ID: <20170110070240.GA29454@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 10:54:56AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jan 05, 2017 at 02:01:53PM +0800, Peter Chen wrote:
> > We have an well-known problem that the device needs to do some power
> > sequence before it can be recognized by related host, the typical
> > example like hard-wired mmc devices and usb devices.
> > 
> > This power sequence is hard to be described at device tree and handled by
> > related host driver, so we have created a common power sequence
> > library to cover this requirement. The core code has supplied
> > some common helpers for host driver, and individual power sequence
> > libraries handle kinds of power sequence for devices. The pwrseq
> > librares always need to allocate extra instance for compatible
> > string match.
> > 
> > pwrseq_generic is intended for general purpose of power sequence, which
> > handles gpios and clocks currently, and can cover other controls in
> > future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > if only one power sequence is needed, else call of_pwrseq_on_list
> > /of_pwrseq_off_list instead (eg, USB hub driver).
> > 
> > For new power sequence library, it can add its compatible string
> > to pwrseq_of_match_table, then the pwrseq core will match it with
> > DT's, and choose this library at runtime.
> > 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested on Odroid U3 (reset sequence for LAN9730):
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

A nice ping...

-- 

Best Regards,
Peter Chen
