From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Jul 2014 11:31:49 +0200
Subject: [PATCH v2 6/7] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <53C4EC81.1040304@redhat.com>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
 <1403101406-15439-7-git-send-email-mperttunen@nvidia.com>
 <20140708132216.GA4979@htj.dyndns.org>
 <53C3DCF0.3030001@redhat.com> <53C4D472.9010507@nvidia.com>
 <53C4EC81.1040304@redhat.com>
Message-ID: <20140715093148.GA13878@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 10:55:29AM +0200, Hans de Goede wrote:
> On 07/15/2014 09:12 AM, Mikko Perttunen wrote:
[...]
> > Other subsystems I've been in don't have this kind of helper
> > library, so diverging here seems weird.
> 
> Well the usb uhci-platform and ehci-platform drivers are doing the same,
> what we're trying to do here is avoid needless code duplication and
> if possible (for ehci and uhci it currently is) make it so that adding
> support for a new soc only requires adding dt stuff + a phy driver,
> without touching the ?hci code at all. Again I can see that this
> is not possible for the Tegra124.

I don't think helper libraries are good at managing resources. They are
very good for extracting common /functionality/ so that it doesn't have
to be duplicated. That's where the commonalities really are. Resource
allocation and setup are usually where the differences are. Trying to
extract that into common helpers often results in clumsy code.

Also, since resources and setup sequences are often very different, the
chances are that adding support for a new SoC will always require
extending the helpers to cope with that new type of resource that the
new SoC now requires, or bumping the maximum number of resources of an
existing type.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/1f255e55/attachment.sig>
