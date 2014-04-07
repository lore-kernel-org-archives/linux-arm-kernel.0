From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Apr 2014 10:26:09 +0100
Subject: drivers/clk/bcm/clk-bcm281xx.c breaks on GCC 4.6.4 (and earlier)
Message-ID: <20140407092609.GY7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So this greeted me this morning...

drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'frac_width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:30:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:51:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:51:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:51:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:51:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:59:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:59:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:59:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:59:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:83:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:83:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:83:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:83:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:95:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:95:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:95:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:95:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:107:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:107:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:107:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:107:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:119:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:119:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:119:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:119:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:128:2: error: unknown field 'fixed' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:140:2: error: unknown field 'fixed' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:147:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:147:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:147:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:147:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:151:2: error: unknown field 'fixed' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'frac_width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:164:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'frac_width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:174:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'frac_width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:184:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'frac_width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:194:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:206:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:206:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:206:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:206:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:218:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:218:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:218:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:218:2: error: unknown field 'scaled_div' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:260:2: error: unknown field 'offset' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:260:2: error: unknown field 'shift' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:260:2: error: unknown field 'width' specified in initializer
drivers/clk/bcm/clk-bcm281xx.c:260:2: error: unknown field 'scaled_div' specified in initializer
make[4]: *** [drivers/clk/bcm/clk-bcm281xx.o] Error 1
make[4]: Target `__build' not remade because of errors.
make[3]: *** [drivers/clk/bcm] Error 2
make[3]: Target `__build' not remade because of errors.
make[2]: *** [drivers/clk] Error 2

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
