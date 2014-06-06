From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Jun 2014 11:24:46 +0100
Subject: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
In-Reply-To: <20140605155509.GH24240@lee--X1>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-8-git-send-email-lee.jones@linaro.org>
 <20140605103009.85BE4C40A4D@trevor.secretlab.ca>
 <20140605103709.GE19550@lee--X1>
 <CACxGe6vLuKygv0E7yq42qe-Lh+nMZ1wrL7PW_TAeoz55wz9q8A@mail.gmail.com>
 <20140605155509.GH24240@lee--X1>
Message-ID: <20140606102446.GK2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 04:55:09PM +0100, Lee Jones wrote:
> On Thu, 05 Jun 2014, Grant Likely wrote:

> > I still think the way to do it is to emulate the missing i2c_device_id
> > when calling the drivers .probe() hook by having a temporary copy on
> > the stack and filling it with data from the OF or ACPI table....

> That's the opposite of what I'm trying to achieve.  I'm trying to get
> rid of unused i2c_device_id tables, rather than reinforce their
> mandatory existence.  I think an i2c_of_match_device() with knowledge
> of how to match via pure DT principles (of_node/compatible) and a
> fall-back, which is able to match on a provided of_device_id table
> alone i.e. without the requirement of an existing of_node.

> I've also been mulling over the idea of removing the second probe()
> parameter, as suggested by Wolfram.  However, this has quite deep
> ramifications which would require a great deal of driver adaptions.

If you're going to do that another option is to refactor the probe()
function to take the driver_data as an argument and then have the core
pass that from whatever table it matched from rather than the entire
i2c_device_id structure.  That way the driver just needs to supply all
the ID tables mapping binding information to whatever it needs and the
core can pass in the driver data from whatever table it matched against.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/847eff00/attachment.sig>
