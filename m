From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 13:27:25 +0300
Subject: [PATCH v7 5/9] ARM: OMAP: USB: Add phy binding information
In-Reply-To: <51C030B4.5070707@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-6-git-send-email-kishon@ti.com>
 <20130618094438.GT5461@arwen.pp.htv.fi> <51C030B4.5070707@ti.com>
Message-ID: <20130618102725.GB7843@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 18, 2013 at 03:34:36PM +0530, Kishon Vijay Abraham I wrote:
> On Tuesday 18 June 2013 03:14 PM, Felipe Balbi wrote:
> >On Thu, Jun 13, 2013 at 02:13:55PM +0530, Kishon Vijay Abraham I wrote:
> >>In order for controllers to get PHY in case of non dt boot, the phy
> >>binding information (phy device name) should be added in the platform
> >>data of the controller.
> >>
> >>Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >
> >I would rather not pass strings around, any other way to handle this ?
> >Why do you need to pass this string ?
> 
> Our old way of binding the controller and the phy using device name
> started creating problems after the devices are created using
> PLATFORM_DEVID_AUTO. Infact non-dt boot is broken in mainline for
> OMAP3 platforms for which I have posted a RFC series
> http://www.serverphorums.com/read.php?12,708632 which also uses
> strings.
> I'm not sure of any other way to deal with this.

have you checked how other frameworks handle it ? Regulator has some
sort of binding in board-files, but I guess it passes the regulator
name?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/b245c2bb/attachment.sig>
