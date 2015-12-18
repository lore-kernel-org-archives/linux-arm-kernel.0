From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 18 Dec 2015 17:00:57 +0200
Subject: OMAP display kconfig options changing
In-Reply-To: <20151218135342.GF23396@atomide.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
Message-ID: <56741FA9.3080607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/12/15 15:53, Tony Lindgren wrote:
> Hi,
> 
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [151218 00:55]:
>> Hi Tony,
>>
>> I've just pushed a patch series to fbdev for-next branch which makes the
>> OMAP DRM and FB drivers independent of each other. This requires
>> changing the related Kconfig options.
> 
> OK

Note that nothing has changed with omapfb and omapdrm as such. The only
(visible) change is the needed Kconfig options.

>> What should I do with omap2plus_defconfig?
>>
>> At the moment omap2plus_defconfig enables the omapfb driver and panels
>> as modules. Should I change it to do the same with the new code? Or
>> should I change it to use omapdrm, which is the better maintained and
>> developed driver (although no one has probably tried omapdrm on omap2)?
> 
> I'm all for changing omap2plus_defconfnig to use omapdrm.
> 
> Do you have a link to a page we can point people to for instructions
> for what needs to be changed to get things working with omapdrm?

Are you referring to Kconfig options? Or userspace?

But no, I don't have links to either.

For the Kconfig options, it's pretty similar to omapfb. After the
patches I'm pushing, one needs to enable DRM, DRM_OMAP, and then the
individual panel/encoder drivers (as for omapfb).

> For omap2, I can try to peek into my rack for n800.

There were a few fixes sent a few days ago which are needed for OMAP2/3.
I think both are now in Linus' tree.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/b81d6ce0/attachment-0001.sig>
