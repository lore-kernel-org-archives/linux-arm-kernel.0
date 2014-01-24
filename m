From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 24 Jan 2014 15:38:33 +0100
Subject: Samsung-clk patches for 3.15
Message-ID: <52E27AE9.7040501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Linux 3.14 is going to include Andrzej Hajda's patches converting 
Samsung clock drivers to use clock ID defines in include/dt-bindings, 
instead of local enums, but to avoid unnecessary merge conflicts we have 
converted only the clock driver, leaving DTS files unchanged yet.

We intend to complete the conversion in 3.15, by replacing magic numbers 
in DTS files with respective preprocessor macros, but to reduce 
potential conflicts we need help of you, Samsung clock patches authors :).

I'd like to ask anybody who already has patches for DTS files adding any 
clock-related contents still using numeric IDs, e.g. clock properties in 
nodes or full nodes containing clock properties, to make sure that the 
patches are merged before Andrzej sends the conversion patches. Then 
Andrzej's script will generate patches updating all clock properties, 
leaving no numeric IDs in DTS files.

If you are just starting your work on a patch that introduces changes as 
mentioned above, please make sure to already use clock macros, not 
numeric IDs. Otherwise you risk having needless rebases with a lot of 
conflicts. You have been warned ;).

Best regards,
Tomasz
