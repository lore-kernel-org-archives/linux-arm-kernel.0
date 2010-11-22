From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 22 Nov 2010 17:00:18 +0800
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
	(try #8)
In-Reply-To: <1290071469.3431.4.camel@tubuntu>
References: <1290000875-11508-1-git-send-email-bryan.wu@canonical.com>
	<1290003526.26444.30.camel@tubuntu>
	<AANLkTinP=xJ66qTZA4JTXFNH+xqvKWgV-XhExoPr6o-C@mail.gmail.com>
	<1290071469.3431.4.camel@tubuntu>
Message-ID: <AANLkTik7Ny+eEPTziqwW0CeV9YO4JHVweQ-Dwi-HBF+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 5:11 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Thu, 2010-11-18 at 10:14 +0800, ext Bryan Wu wrote:
>> On Wed, Nov 17, 2010 at 10:18 PM, Tomi Valkeinen
>
>> > Are you also interested in solving the backlight issue? =)
>>
>> Yeah, can I start with
>> drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c. I plan to move
>> the blacklight code to drivers/video/blacklight/ and let sharp_ls to
>> use panel-generic-dpi.c driver.
>
> Yes, I think that's a good solution for the panels which have a separate
> backlight (ie. all these "dummy" panels"). However, I'm not sure how
> that would work for panels with more integrated backlight, for example
> Taal. But we don't need to worry about that right now.
>

As I'm working on the sharp-ls panel driver, I just find the backlight
code is almost dummy functions which will call
dssdev->set_backlight().
How about create platform driver for sharp-ls backlight driver? We
pass those dssdev data from platform data struct.

Thanks a lot,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
