From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 11 Dec 2014 22:26:32 +0100
Subject: [PATCH 0/3] i2c: slave support framework for Linux devices
In-Reply-To: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20141211212632.GA21482@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 05:04:52PM +0100, Wolfram Sang wrote:
> Finally, here is my take on the often desired feature that Linux can not only
> be an I2C master, but also an I2C slave. Since RFC, most open issues have been
> dealt with. Find details in the patch descriptions. Documentation is still
> missing and will come later this or next week, but surely early enough for
> the 3.19 release which this series wants to go in. Yet, I'd like to encourage
> code-review and build-testing already.
> 
> Basically, an I2C slave is a standard I2C client providing a callback function.
> When registering as a slave, the connection to the I2C adapter is made which
> uses the callback when a slave event happens. That splits the HW support
> (enabling slave mode on the adapter) and SW support (here a generic eeprom
> simulator) nicely IMO.
> 
> The patches have been tested with a Renesas R8A7790 based Lager board. They are
> based on top of 3.18-rc5, but will easily apply to renesas/devel. A git tree
> can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/slave-support
> 
> Comments welcome! Thanks,

This series applied to for-next (with some typos corrected)!

I think I have an idea to improve the API thanks to Uwe's comments.
Still, I'd like to send out my pull request soonish and fix this
later. It won't be a massive overhaul, so I think it is okay.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/7392b9bf/attachment.sig>
