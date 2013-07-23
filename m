From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 23 Jul 2013 14:23:34 -0700
Subject: [PATCH 01/15] drivers: phy: add generic PHY framework
In-Reply-To: <1769609.rbAYfG9ir3@flatron>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <1731726.KENstTPhkb@flatron> <20130723205007.GA27166@kroah.com>
 <1769609.rbAYfG9ir3@flatron>
Message-ID: <20130723212334.GA21945@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 11:05:48PM +0200, Tomasz Figa wrote:
> > That's not so bad, as long as you let the phy core use whatever name it
> > wants for the device when it registers it with sysfs.
> 
> Yes, in regulator core consumer names are completely separated from this. 
> Regulator core simply assigns a sequential integer ID to each regulator 
> and registers /sys/class/regulator/regulator.ID for each regulator.

Yes, that's fine.

> > Use the name you
> > are requesting as a "tag" or some such "hint" as to what the phy can be
> > looked up by.
> > 
> > Good luck handling duplicate "tags" :)
> 
> The tag alone is not a key. Lookup key consists of two components, 
> consumer device name and consumer tag. What kind of duplicate tags can be 
> a problem here?

Ok, I didn't realize it looked at both parts, that makes sense, thanks.

greg k-h
