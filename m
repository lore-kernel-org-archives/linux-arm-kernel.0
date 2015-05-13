From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 13 May 2015 09:42:48 -0700
Subject: [PATCH v2 02/17] leds: port locomo leds driver to new locomo core
In-Reply-To: <5553654F.4010608@samsung.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-3-git-send-email-dbaryshkov@gmail.com>
 <554A2DB4.3020000@samsung.com>
 <CALT56yNJWapNw1XLrzfbUDUz1LF_BB9DfF94H6GhbnBUEP80_w@mail.gmail.com>
 <555327EA.5060402@samsung.com>
 <CALT56yOJyZvWF9neC2A09Y_w1Ej41uwWvU=aOOM0idbzUkBiFQ@mail.gmail.com>
 <5553654F.4010608@samsung.com>
Message-ID: <20150513164248.GB11891@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 04:53:03PM +0200, Jacek Anaszewski wrote:
> On 05/13/2015 04:14 PM, Dmitry Eremin-Solenikov wrote:
> >2015-05-13 13:31 GMT+03:00 Jacek Anaszewski <j.anaszewski@samsung.com>:
> >>On 05/12/2015 05:35 PM, Dmitry Eremin-Solenikov wrote:
> >>>
> >>>2015-05-06 18:05 GMT+03:00 Jacek Anaszewski <j.anaszewski@samsung.com>:
> >>>>
> >>>>On 04/28/2015 01:55 AM, Dmitry Eremin-Solenikov wrote:
> >>>>>
> >>>>>
> >>>>>Adapt locomo leds driver to new locomo core setup.
> >>>>>
> >>>>>Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >>>>>---
> >>>>>    drivers/leds/Kconfig       |   1 -
> >>>>>    drivers/leds/leds-locomo.c | 119
> >>>>>+++++++++++++++++++++++----------------------
> >>>>>    2 files changed, 61 insertions(+), 59 deletions(-)
> >>>>>
> >>>>>diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> >>>>>index 966b960..4b4650b 100644
> >>>>>--- a/drivers/leds/Kconfig
> >>>>>+++ b/drivers/leds/Kconfig
> >>>>>@@ -79,7 +79,6 @@ config LEDS_LM3642
> >>>>>    config LEDS_LOCOMO
> >>>>>          tristate "LED Support for Locomo device"
> >>>>>          depends on LEDS_CLASS
> >>>>>-       depends on SHARP_LOCOMO
> >>>>
> >>>>
> >>>>
> >>>>Why do you remove this dependency?
> >>>
> >>>
> >>>Because SHARP_LOCOMO is a Kconfig symbol for the old driver. New driver
> >>>uses MFD_LOCOMO Kconfig entry. Also the driver now uses generic platform
> >>>device and regmap interfaces, so there is no direct dependency on main
> >>>LoCoMo driver. And the policy (IIRC) was not to have such dependencies.
> >>
> >>
> >>Ack. Shouldn't you also need "select REGMAP_MMIO" ?
> >
> >No. Maybe I should add "select REGMAP" instead.
> 
> REGMAP is enabled by default if REGMAP_MMIO is enabled. Having

That is unfortunately not how select works: it does not automatically
select parents for the selected symbol.

Thanks.

-- 
Dmitry
