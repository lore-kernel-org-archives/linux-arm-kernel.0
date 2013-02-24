From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 24 Feb 2013 18:00:05 +0100
Subject: [PATCH] i2c: s3c2410: check for NULL pinctrl handle
In-Reply-To: <CACRpkdYBjZgEo6qEyBOcYuPzpQUAZ9x-kvFabz0y0pEQs35sKw@mail.gmail.com>
References: <201302231855.47560.heiko@sntech.de> <31669750.ZZOiY1AEPv@flatron>
 <CACRpkdYBjZgEo6qEyBOcYuPzpQUAZ9x-kvFabz0y0pEQs35sKw@mail.gmail.com>
Message-ID: <1366216.NzXQfD1BG7@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 of February 2013 02:01:45 Linus Walleij wrote:
> On Sun, Feb 24, 2013 at 1:58 AM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > [Me]
> > 
> >> Surely you know this when setting up the pdata from your machine?
> > 
> > Cases 2) and 3) are both DT-enabled cases, where there is no pdata
> > coming from board-specific code.
> 
> (...)
> 
> > Note that we are talking here about a temporary solution. The legacy
> > DT- based pin configuration will go away after all the DT-enabled
> > platforms using this driver get migrated to pin control and so will
> > the need to check if pin control is available.
> 
> So use AUXDATA, and you get a pdata for that driver?

Hmm, and then have some platform data passed statically and some parsed 
from device tree? Not even saying that we are going towards getting rid of 
auxdata, not adding further dependencies for it.

Sorry, but this sounds more broken to me than checking the return value of 
devm_pinctrl_get_select_default for NULL in the driver.

Still, all the platforms relying on the legacy DT GPIO support should have 
been already migrated to pin control, so ideally instead of "fixing" the 
drivers to continue supporting the deprecated method, such platforms 
should be fixed.

Best regards,
Tomasz
