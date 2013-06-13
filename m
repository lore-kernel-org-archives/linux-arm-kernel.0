From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Jun 2013 10:56:24 +0300
Subject: [GIT PULL] omap dss board clean-up for v3.10 merge window
In-Reply-To: <51AC89F6.1050308@ti.com>
References: <20130418033936.GC10155@atomide.com>
 <20130419184518.GA30836@quad.lixom.net> <51AC89F6.1050308@ti.com>
Message-ID: <51B97B28.3060609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 03/06/13 15:20, Tomi Valkeinen wrote:

Any feeback about the below? I'm currently aiming for the option 2, and
pushing only the driver changes for the next merge window, as that
allows me to go forward without any arch/arm changes.

 tomi

> I have a somewhat similar situation again for 3.11 (or possibly for
> 3.12). I hope to hear from you what you think would be the best approach.
> 
> The background is that the omap display subsystem has a bunch of panel
> drivers, and these drivers have used an OMAP DSS specific bus and driver
> model. For various reasons I'm now converting the panel drivers to be
> based on the panel's control bus, i.e. a panel controlled via i2c would
> be an i2c device/driver, a panel not controlled at all would be a
> platform device/driver, etc.
> 
> The work involves changing the omapdss driver, converting the panel
> drivers to the new driver model, and changing the board files that use
> the panel.
> 
> I see two main approaches to this:
> 
> 1) Convert the panel drivers "in-place", i.e. have a commit which
> changes a panel driver to the new model. This would mean that the
> instant the commit is in, the boards using the panel do not work until
> the board file has been changed.
> 
> 2) Convert the panel to a new file, i.e. basically make a copy of the
> panel driver while converting it. This way the boards using the old
> panel drivers will continue working. (This is how I have my patches
> currently organized).
> 
> Option 1) feels more natural, but if the arch and driver changes go
> through separate trees, there's a piece of history during the merge
> window where the displays won't work on the OMAP boards.
> 
> Option 2) allows us to keep the boards always functional if the new
> panel drivers are merged in 3.11, and the board file changes are merged
> in 3.12.
> 
> The downside is that it takes two kernel versions to get this in, and a
> third kernel version to finally remove all the old code. 3.11 and 3.12
> would contain unused code, some of which will be in the kernel image
> (omapdss side changes) and some of which won't be compiled at all (the
> new panel drivers).
> 
> Do you think option 2 and splitting the work into three kernel versions
> is the way to go? Do you have some other ideas how to organize the merge
> of these kind of changes?
> 
>  Tomi
> 
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130613/5bbd01d1/attachment.sig>
