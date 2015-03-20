From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Mar 2015 19:52:44 +0100
Subject: [PATCH 0/5] ARM: sunxi: SRAM mapping support
Message-ID: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a cleaned up version of Maxime's sunxi SRAM controller driver.

I've been using / testing this together with the sunxi musb support patches
I've been working on, and it works well. I've tested it on sun4i, sun5i and
sun7i. See the per patch commit messages for the (minor) changes which I did
compared to Maxime's RFC.

A note about the changing of the compatible to a sun4i-a10 prefix, I've
looked at the user manual for all 3 generations and the sram controller is
the same for all 3. Register 0x1c00024 (SoC version) is only documented in
the A20 manual, but is present and works indentical in all 3 generations.

Since this is a prereq for my musb work, if there are no objections then I
would like to see this go upstream soon.

Since it only touches sunxi files (and one Makefile), it is probably best if
this all goes upstream through Maxime.

Regards,

Hans
