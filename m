From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jul 2014 11:50:44 -0500
Subject: [PATCH 0/9] usb: musb: several bugfixes for the musb driver
In-Reply-To: <20140718161636.GA18460@arch.cereza>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <20140718161636.GA18460@arch.cereza>
Message-ID: <20140718165044.GA30821@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 18, 2014 at 01:16:36PM -0300, Ezequiel Garcia wrote:
> Hi Lothar,
> 
> On 18 Jul 11:31 AM, Lothar Wa?mann wrote:
> > The first three patches do some source code cleanup in the files that
> > are modified in the subsequent patches.
> > 
> 
> I've applied patches 4 and 9 on a recent -next, after fixing a conflict
> due to patch 3 ("usb: musb_am335x: source cleanup"):
> 
> > Patch 4 carries the proper fix reported in commit:
> >         7adb5c876e9c ("usb: musb: Fix panic upon musb_am335x module removal")
> > 
> > Patch 9 reinstates module unloading support for the musb_am335x driver
> >         which was disabled due to a false failure analysis
> > 
> 
> For these two patches, Tested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> 
> Tested on a beaglebone with a mass storage USB device, module load/unload
> works without issues. The module_get/put in the phy is now preventing the
> musb_am335x driver unload, which seems to be the real cause of the issue
> I reported. Thanks for providing a proper fix!

I don't that's a good fix. The problem is that even after am335x
removing all its child, someone else tried to release the PHY. That
ordering is the one that needs to be fixed. Doing a module_get on the
parent device looks like a hack to me.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/7dd6352f/attachment.sig>
