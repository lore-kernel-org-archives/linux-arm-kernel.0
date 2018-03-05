From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2018 15:12:46 -0800
Subject: Regulator regression in next-20180305
Message-ID: <20180305231246.GB5799@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark and Maciej,

Looks like with next-20180305 there's a regulator regression
where mmc0 won't show any cards or produces errors:

mmcblk0: error -110 requesting status
mmc1: new high speed SDIO card at address 0001
mmcblk0: error -110 requesting status
mmcblk0: recovery failed!
print_req_error: I/O error, dev mmcblk0, sector 0
Buffer I/O error on dev mmcblk0, logical block 0, async page read
mmcblk0: error -110 requesting status
mmcblk0: recovery failed!

I bisected it down to the following commits:

broken		71c33626a802 ("regulator: core: Change voltage setting path")
fails to build	a7348f502ab7 ("regulator: core: Add voltage balancing mechanism")
works		cf6fc8064766 ("regulator: core: Resolve coupled regulators")

Any ideas?

Regards,

Tony
