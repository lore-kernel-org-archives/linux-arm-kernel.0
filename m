From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Jun 2013 22:03:38 +0200
Subject: [PATCH 15/15] OF: remove #ifdef from linux/of_platform.h
In-Reply-To: <CAL_Jsq+-7RizbVQSA-JnJRZFc9-3RFCXuCOXP=GfCin2Losfeg@mail.gmail.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-16-git-send-email-arnd@arndb.de>
 <CAL_Jsq+-7RizbVQSA-JnJRZFc9-3RFCXuCOXP=GfCin2Losfeg@mail.gmail.com>
Message-ID: <201306012203.39133.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 June 2013, Rob Herring wrote:
> On Fri, May 31, 2013 at 5:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > A lot of code uses the functions from of_platform.h when built for
> > devicetree-enabled platforms but can also be built without them.
> > In order to avoid using #ifdef everywhere in drivers, this
> > makes all the function declarations visible, which means we
> > can use "if (IS_ENABLED(CONFIG_OF))" in driver code and get build
> > coverage over the code but let the compiler drop the reference
> > in the object code.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> 
> I've got a more complete series for 3.11 that removes OF_DEVICE and
> of_platform_driver completely. I'm waiting on ack from Ben H.

Ok. Does your series also remove the #ifdef CONFIG_OF part from this
header?

	Arnd
