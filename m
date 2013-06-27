From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Jun 2013 11:17:32 +0200
Subject: [PATCH 3/4] hwmon: Add a simple driver to read the MXS SoC
 temperature
In-Reply-To: <20130626143927.GB31998@roeck-us.net>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372236673-20725-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20130626143927.GB31998@roeck-us.net>
Message-ID: <20130627091732.GP5803@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 07:39:27AM -0700, Guenter Roeck wrote:
> On Wed, Jun 26, 2013 at 10:51:12AM +0200, Alexandre Belloni wrote:
> > The low resolution ADC of the mxs is able to read an internal temperature
> > sensor, expose that using hwmon.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> 
> Wouldn't it make more sense to use iio-hwmon and improve it if necessary ?

Actually, I wonder if we should not just put the hwmon driver
capabilities directly into the mxs-lradc driver, just like it's already
been done in this driver for the touchscreen support.

The probing of this hwmon driver doesn't really belong to the DT, it's
not really realistic to probe it from the machine definition, and it
really is the IP that is wired that way.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/c335f37b/attachment.sig>
