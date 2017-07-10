From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 10 Jul 2017 15:36:56 +0200
Subject: 4.13-rc0: stopped booting on Nokia N900
In-Reply-To: <20170710130602.GS3730@atomide.com>
References: <20170710074610.GA22846@amd> <20170710081334.GA29726@amd>
 <20170710101608.qdamqomegbjwuweh@earth>
 <20170710130602.GS3730@atomide.com>
Message-ID: <20170710133656.og2egbse5plp3afm@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 10, 2017 at 06:06:03AM -0700, Tony Lindgren wrote:
> > I just rebased my droid4 development branch. I do not have any
> > problems with segfaulting toolchain, but boot also fails on OMAP4
> > based Droid 4. The problem seems to be SPI being accessed without
> > runtime PM (clocks) being enabled:
> 
> Care to check if commit c5b3955828ba ("ARM: OMAP4: Fix legacy code
> clean-up regression") make that one go away? I have already sent
> a pull request for that one.

I bisected to the same commit, that you also found. I just replied
to Thomas' pull-request from yesterday with bootlog + bisect result
+ info that current master works again after reverting the patch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/02c8bae9/attachment.sig>
