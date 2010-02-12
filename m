From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Fri, 12 Feb 2010 11:42:28 +0100
Subject: [WARNING] mxc_w1_probe should not be __init modified
Message-ID: <1265971348.2484.63.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Today linux-next build, report this:

WARNING: drivers/w1/masters/built-in.o(.data+0x0): Section mismatch in reference from the variable mxc_w1_driver to the function .init.text:mxc_w1_probe()
The variable mxc_w1_driver references
the function __init mxc_w1_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 


I don't know if should be modified with __devinit instead or nothing at all.

Best regards.

-- 
Alberto!
