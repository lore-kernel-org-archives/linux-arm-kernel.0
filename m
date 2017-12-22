From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 22 Dec 2017 15:58:13 +0100
Subject: [PATCH v5 5/5] misc serdev: w2sg0004: add debugging code and
 Kconfig
In-Reply-To: <A2720858-5172-4627-8133-C677E4B4DC72@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <5816bfb9e7cab68591c133e20696d6188ebe70de.1512114577.git.hns@goldelico.com>
 <20171222125150.GJ3374@localhost>
 <A2720858-5172-4627-8133-C677E4B4DC72@goldelico.com>
Message-ID: <20171222145813.GA28720@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 03:41:24PM +0100, H. Nikolaus Schaller wrote:
> 
> > Am 22.12.2017 um 13:51 schrieb Johan Hovold <johan@kernel.org>:
> > 
> > On Fri, Dec 01, 2017 at 08:49:38AM +0100, H. Nikolaus Schaller wrote:
> >> This allows to set CONFIG_W2SG0004_DEBUG which will
> >> make the driver report more activities and it will turn on the
> >> GPS module during boot while the driver assumes that it
> >> is off. This can be used to debug the correct functioning of
> >> the hardware. Therefore we add it as an option to the driver
> >> because we think it is of general use (and a little tricky to
> >> add by system testers).
> >> 
> >> Normally it should be off.
> >> 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >> drivers/misc/Kconfig    |  8 ++++++++
> >> drivers/misc/w2sg0004.c | 37 +++++++++++++++++++++++++++++++++++++
> >> 2 files changed, 45 insertions(+)
> > 
> > I'd say say this does not belong in the kernel at all.
> 
> There are other examples of such DEBUG options for drivers.
> E.g. CONFIG_LIBERTAS_DEBUG.

And that is wrong and should be removed.

> It helps the hardware developer to test things and should of course
> be disabled in a production kernel.

dev_dbg() should be used instead.  And you can always hard-code #define DEBUG
at the top of your file when doing bringup.

thanks,

greg k-h
