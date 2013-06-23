From: per.strandh@gmail.com (Per Strandh)
Date: Sun, 23 Jun 2013 19:29:52 +0200
Subject: No stable driver/module api?
Message-ID: <CABp-a4eHep=hx7HQ=Og0GC0t=CyE8u2sVt7BwyVMJb9zjA2ePw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working for a company with arm-based embedded-linux products.
Both the hardware and software is developed by ourselves.




In a slightly simplified description our products is moduled
(1) Assembler bootloader in the first partition.
(2) Compressed kernel in the second partion
(3) Root file system in the third partition

The kernel is ported, configured and compiled for our own hardware.
We have selected kernel version 3.0 since it is a LTS track.

The Root file system holds one driver for our hardware.





I have now encountered one problem with this layout.
When upgrading the kernel, our driver in the root file system isn't
always compatible/loading.

When upgrading from 3.0.18 to 3.0.22 it worked out fine.
When upgrading from 3.0.22 to 3.0.23 the driver isn't loading.
When trying to load it if fails with the message:
- "disagrees about version of symbol module_layout"

We have configured the kernel with the option
 CONFIG_MODULE_FORCE_LOAD=y



Isn't the driver/module api stable within the 3.0 track?

Regards
/Per/
