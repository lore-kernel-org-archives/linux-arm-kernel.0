From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 18 Nov 2010 10:14:03 +0800
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
	(try #8)
In-Reply-To: <1290003526.26444.30.camel@tubuntu>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
	<1290003526.26444.30.camel@tubuntu>
Message-ID: <AANLkTinP=xJ66qTZA4JTXFNH+xqvKWgV-XhExoPr6o-C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 10:18 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Wed, 2010-11-17 at 21:34 +0800, ext Bryan Wu wrote:
>> There are 4 duplicated DPI panel drivers in DSS2 display driver. They are
>> similar and a generic DPI panel driver can support all them with specific
>> panel configuration. And new DPI panel driver can be easily supported
>> by adding panel configurations into generic panel DPI driver.
>>
>> This patchset introduces a generic panel DPI driver, remove 3 panel drivers and enable
>> generic panel DPI driver in board files. And it is based on 2.6.37-rc2.
>>
>> Building with omap2plus_defconfig is successful.
>>
>> Keep sharp_ls_panel, since it contains blacklight control code which will be
>> moved out later.
>>
>> Bryan Wu (3):
>> ? OMAP: DSS2: Add generic DPI panel display driver
>> ? OMAP: use generic DPI panel driver in board files
>> ? OMAP: DSS2: remove generic DPI panel driver duplicated panel drivers
>
> Thanks, looks good. This is now applied to my tree.
>

Thanks a lot for making this happen, -:))

> Are you also interested in solving the backlight issue? =)

Yeah, can I start with
drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c. I plan to move
the blacklight code to drivers/video/blacklight/ and let sharp_ls to
use panel-generic-dpi.c driver.

-Bryan
