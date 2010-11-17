From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 17 Nov 2010 14:31:13 +0800
Subject: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
In-Reply-To: <1289920866.2668.138.camel@tubuntu>
References: <1289881031-21354-1-git-send-email-bryan.wu@canonical.com>
	<1289881031-21354-2-git-send-email-bryan.wu@canonical.com>
	<1289920866.2668.138.camel@tubuntu>
Message-ID: <AANLkTikcF1OnJjrUmame2HUjTadZLrgZwpam6RuGuKos@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 11:21 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Tue, 2010-11-16 at 05:17 +0100, ext Bryan Wu wrote:
>> Generic DPI panel driver includes the driver and 4 similar panel configurations. It
>> will match the panel name which is passed from platform data and setup the
>> right configurations.
>>
>> With generic DPI panel driver, we can remove those 4 duplicated panel display
>> drivers. In the future, it is simple for us just add new panel configuration
>> date in panel-generic-dpi.c to support new display panel.
>>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> ?.../arm/plat-omap/include/plat/panel-generic-dpi.h | ? 37 +++

[snip]

>> +
>> +static power_on_delay = 0;
>> +
>> +static power_off_delay = 0;
>
> This is not right. There may be multiple panels in a single board, and
> these would be shared by both of the panels.
>
> What you need to do is have a struct, which contains pointer to the
> panel configuration used with that particular dssdev, and set the struct
> with dev_set_drvdata().
>
> Check panel-taal.c for an example. There's struct taal_data, which
> contains also quite a bit other data, but also a pointer to the panel
> config.
>

Exactly, I just fixed it and sent the updated patchset.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
