From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Apr 2014 14:39:37 +0100
Subject: New section mismatch warnings
Message-ID: <20140404133937.GB7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the usual build test quality...  This isn't hard to catch, you
just have to build with CONFIG_DEBUG_SECTION_MISMATCH enabled.  You can
even provide that on the make command line to enable the feature for
any configuration you're building, so it really isn't hard to check.
Yet still we have stuff like this creeping in.

WARNING: drivers/of/built-in.o(.text.unlikely+0x18): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: drivers/of/built-in.o(.text.unlikely+0x48): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: drivers/of/built-in.o(.text.unlikely+0x74): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: drivers/of/built-in.o(.text.unlikely+0x9c): Section mismatch in reference from the function __reserved_mem_check_root() to the (unknown reference) .init.data:(unknown)
The function __reserved_mem_check_root() references
the (unknown reference) __initdata (unknown).
This is often because __reserved_mem_check_root lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: drivers/built-in.o(.text.unlikely+0x109c): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: drivers/built-in.o(.text.unlikely+0x10cc): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: drivers/built-in.o(.text.unlikely+0x10f8): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: drivers/built-in.o(.text.unlikely+0x1120): Section mismatch in reference from the function __reserved_mem_check_root() to the (unknown reference) .init.data:(unknown)
The function __reserved_mem_check_root() references
the (unknown reference) __initdata (unknown).
This is often because __reserved_mem_check_root lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text.unlikely+0x83cc): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: vmlinux.o(.text.unlikely+0x83fc): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: vmlinux.o(.text.unlikely+0x8428): Section mismatch in reference from the function __reserved_mem_check_root() to the function .init.text:of_get_flat_dt_prop()
The function __reserved_mem_check_root() references
the function __init of_get_flat_dt_prop().
This is often because __reserved_mem_check_root lacks a __init 
annotation or the annotation of of_get_flat_dt_prop is wrong.

WARNING: vmlinux.o(.text.unlikely+0x8450): Section mismatch in reference from the function __reserved_mem_check_root() to the (unknown reference) .init.data:(unknown)
The function __reserved_mem_check_root() references
the (unknown reference) __initdata (unknown).
This is often because __reserved_mem_check_root lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
