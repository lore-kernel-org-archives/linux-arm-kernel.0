From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 14 Apr 2015 16:58:22 -0700
Subject: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
In-Reply-To: <20150414223029.GU12732@n2100.arm.linux.org.uk>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <20150414162210.GA29874@dtor-ws>
 <20150414223029.GU12732@n2100.arm.linux.org.uk>
Message-ID: <20150414235822.GA22757@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 11:30:29PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 14, 2015 at 09:22:10AM -0700, Dmitry Torokhov wrote:
> > On Tue, Apr 14, 2015 at 12:41:48PM +0200, Ulf Hansson wrote:
> > > The legacy system PM support has long time ago been dropped from the
> > > AMBA bus. Align to that by converting to the modern system PM
> > > callbacks.
> > > 
> > > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > If this has not been noticed since end of 2013 maybe we should drop the
> > driver?
> 
> That's rather silly.  It isn't a build breakage, and it's not a
> functional breakage.  In fact, this driver gets build and boot tested
> every evening on hardware I have here in my autobuild system.

OK.

> 
> The regression is only visible if it is used on a platform with power
> management support, and that's probably close to none - unless hibernate
> support is enabled.  I'm just pushing up some patches which fix long
> term hibernation issues on ARM.
> 
> If we apply your "lets drop stuff" argument, maybe we should drop ARM
> hibernation support because its been broken for many years... obviously
> that's also a rediculous suggestion.

Why is it a ridiculous suggestion? If it has been broken for  many
years I do not see why it has to be kept? Is there someone who is
actively working on making it functional?

Thanks.

-- 
Dmitry
