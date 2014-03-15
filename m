From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Mar 2014 10:19:48 +0100
Subject: [PATCH v18 3/4] ata: Add APM X-Gene SoC AHCI SATA host controller
 driver
In-Reply-To: <1394841201-29495-4-git-send-email-lho@apm.com>
References: <1394841201-29495-1-git-send-email-lho@apm.com>
 <1394841201-29495-3-git-send-email-lho@apm.com>
 <1394841201-29495-4-git-send-email-lho@apm.com>
Message-ID: <201403151019.49316.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 March 2014, Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC AHCI SATA host controller
> driver. It requires the corresponding APM X-Gene SoC PHY driver. This
> initial version only supports Gen3 speed.

This version seems workable, thanks for the quick follow-up.

The comment about Gen3 speed above reminds me that you took some
shortcuts to get here and you removed support for some features
as well as some bug workarounds in the process. I'm guessing some
of them won't be necessary because they are only for prototype
hardware or for early boot loader versions that don't yet set up
the hardware right, but others actually need to come back.

That is usually a good approach, but I'd also like to make sure we can
deal with them nicely when you have to add them back later, and don't
have to add ugly extensions to the DT binding to support the old dtb
files.

Can you list (also in the changelog) the parts of the driver that you
have taken out for now and that you expect to add back at later
stage? I think that would be helpful for perspective.

Regarding the support for multiple link speeds, how do you think
it will be done? Can you have a driver-side link speed autoconfiguration,
or do you have to add DT properties and let the driver know about
the attached device?

	Arnd
