From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 08:54:58 +0000
Subject: [PATCH v5 14/14] ARM: OMAP2+: gpmc: writeprotect helper
In-Reply-To: <4FD8BFC5.2050007@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <85c5dc5fa3203cc60a12d4b2350e45da07d7f5fd.1339419492.git.afzal@ti.com>
 <4FD78D93.9080906@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99884F@DBDE01.ent.ti.com>
 <4FD8BFC5.2050007@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E999720@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 13, 2012 at 21:58:53, Hunter, Jon wrote:

> > Presently there are no peripherals in mainline turning on writeprotect,
> > initially intention was to just disable writeprotect at the end of probe
> > and not provide platforms opportunity to enable writeprotect as none
> > need it, still a provision has been provided for platform to enable it.
> > 
> > Probably these to be taken care when there is a requirement.
> 
> Ok, but I am still not happy about this. So I did find that our
> omap2420h4 board does route the write protect to both NOR and NAND.
> Therefore, it does appear to be a valid use-case that multiple child
> devices can share the write-protect. So maybe we do not need to reserve
> the write-protect like we are doing for chip-selects, but I think that

:

> devices should indicate if they use the write-protect pin and we should
> either have this "enable on boot" as a global setting not specific to a
> child device or ensure that multiple devices using the wp have the same
> configuration of the wp on boot. In other words, if one device says
> enable on boot and the other does not, then warn.

Which one of Jon's above suggestions would you prefer,

i.e.
writeprotect as a global setting for all devices
Or
Ensure that multiple devices using wp have same configuration

Or anything else you have in mind ?

Regards
Afzal
