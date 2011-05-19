From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 19 May 2011 09:53:12 +0200
Subject: atmel-mci causes kernel panic when CONFIG_DEBUG_VM is set
Message-ID: <4DD4CC68.80408@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

There is a bug with the atmel-mci driver when the debug feature 
CONFIG_DEBUG_VM is set.

Into the atmci_read_data_pio function we use flush_dcache_page (do we 
really need it?) which call the page_mapping function where we can find 
VM_BUG_ON(PageSlab(Page)). Then a kernel panic happens.

I don't understand the purpose of the VM_BUG_ON(PageSlab(Page)) (the 
page comes from a scatter list). How could I correct this problem?

Thanks for your help

Regards,

Ludovic
