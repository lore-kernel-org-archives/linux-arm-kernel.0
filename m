From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Aug 2014 14:58:36 +0100
Subject: [PATCH 3/5] regulator: axp20x: Update the bindings to use a
 local parent regulator
In-Reply-To: <20140606160552.GC9791@lukather>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
 <1401297069-7423-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140528185051.GB22488@sirena.org.uk>
 <20140603131204.GJ27722@lukather>
 <20140603144319.GD31751@sirena.org.uk>
 <20140605142729.GG5765@lukather>
 <20140605154931.GY2520@sirena.org.uk>
 <20140606160552.GC9791@lukather>
Message-ID: <20140816135836.GM28623@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 06:05:52PM +0200, Maxime Ripard wrote:
> On Thu, Jun 05, 2014 at 04:49:31PM +0100, Mark Brown wrote:

> > This sounds like you are passing the MFD child device into the regulator
> > API when you should be passing the parent device in.

> We're passing the device coming from the platform_device that is
> passed in probe, that has been created by mfd_add_device, which is
> indeed the child device from the MFD device. So we should always use
> the platform device parent's instead?

Yes.

> > For electrical engineering reasons it's unlikely that the supplies are
> > actually floating but yes, they are mandatory.  This is an issue with
> > registering one device for the entire regulator subsystem on the PMIC,
> > it interacts somewhat poorly with deferred probe.  However for systems
> > with full constraints like DT and ACPI ones it should be mostly
> > sidestepped since the if there is no supply mapped a dummy supply will
> > be substituted.

> Yes, they are actually tied to the ground, but it's still something
> meaningless, that I guess shouldn't be expressed in the DT?

Probably, that does seem like a valid case for omitting them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140816/54db6531/attachment.sig>
