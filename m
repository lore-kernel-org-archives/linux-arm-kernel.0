From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 23 Feb 2012 08:29:19 +0100
Subject: [PATCH v3 00/10] Add PWM framework and device tree support.
In-Reply-To: <201202221602.09116.arnd@arndb.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <201202221602.09116.arnd@arndb.de>
Message-ID: <20120223072917.GA8621@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann wrote:
> On Wednesday 22 February 2012, Thierry Reding wrote:
> > This patch series adds very rudimentary device-tree support for PWM
> > devices. With all of these patches applied (plus one board-specific
> > patch that is not included), I'm able to control the backlight on the
> > device I'm working on using the sysfs interface provided by the pwm-bl
> > driver and the backlight class.
> > 
> > This series is based on Sascha Hauer's series of patches[0] to add a
> > generic PWM framework. The first patch in this series is taken from
> > Sascha's branch, while the second patch enables each PWM chip to provide
> > multiple PWM devices (the Blackfin and PXA drivers have been ported to
> > the framework for reference). When this series is ready I think it would
> > be best to merge patches 1 and 2. Currently a global namespace is still
> > provided to keep backwards-compatibility with the legacy PWM API. In
> > order to achieve this, the number of global PWM devices is limited to
> > 1024. However, patch 2 introduces per-chip indexing of PWM devices in
> > the core, so it should be easy to add an API to request a PWM device on
> > a per-chip basis and get rid of the global namespace eventually. The
> > device tree support code does not use the global namespace.
> 
> Hi Thierry,
> 
> I've just had a chance to look at your series and I think this looks
> very good overall, great work!
> 
> I probably wouldn't bother merging patches 1 and 2 as you listed
> in the TODO section, in order to keep the authorship of each
> part obvious.

Okay, no problem.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/8a98f07f/attachment.sig>
