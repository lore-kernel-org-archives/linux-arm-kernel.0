From: balbi@ti.com (Felipe Balbi)
Date: Mon, 13 Jul 2015 15:30:28 -0500
Subject: musb-hdrc: "Vbus off, timeout 1100 msec" message does not belong
 in sysfs
In-Reply-To: <559F7193.7090508@linutronix.de>
References: <20150709213922.GA32698@amd> <20150709214610.GA20890@amd>
 <559F7193.7090508@linutronix.de>
Message-ID: <20150713203014.GB32682@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 09:17:39AM +0200, Sebastian Andrzej Siewior wrote:
> On 07/09/2015 11:46 PM, Pavel Machek wrote:
> > On Thu 2015-07-09 23:39:22, Pavel Machek wrote:
> >> Hi!
> 
> Hi,
> 
> >>
> >> sysfs should contain one value per file. This one has at least two,
> >> with nice english sentence as a bonus.
> >>
> >> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
> >> cat vbus
> >> Vbus off, timeout 1100 msec
> >>
> >> :-(.
> > 
> > Plus, documentation for this is nowhere to be seen:
> > 
> > pavel at amd:/data/l/linux-n900$ grep -ri musb Documentation/ABI/
> > pavel at amd:/data/l/linux-n900$
> 
> that is a shame indeed. It is part of the driver since TUSB support was
> merged via commit 550a7375f ("USB: Add MUSB and TUSB support") about 7
> years ago.
> The parameter expects the timeout values which is used to poll the port
> for mode changes (host/device mode) since it can not be detected on its
> own.
> Felipe knows best if it is better to document it or remove it. I can't
> remember that I needed it on am335x.

N900's usersland relies on it, IIRC. But it could be that it was used
just for testing. I'm not entirely sure.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150713/9c93be7f/attachment-0001.sig>
