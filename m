From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 13:45:39 +0200
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <14224406.FU8QFA3vsD@wuerfel>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <5184912.mY2hCPH20k@wuerfel> <20140826102011.GA31124@ulmo>
 <14224406.FU8QFA3vsD@wuerfel>
Message-ID: <20140826114537.GA641@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 01:35:34PM +0200, Arnd Bergmann wrote:
> On Tuesday 26 August 2014 12:20:13 Thierry Reding wrote:
> > On Tue, Aug 26, 2014 at 11:54:43AM +0200, Arnd Bergmann wrote: > 
> > > I'm not sure if it's really worth it. One thing we might do is just
> > > remove all definitions of ioremap_nocache and add a wrapper to
> > > include/linux/io.h, to make it more obvious what is going on.
> > 
> > Yes, I suppose that would work too. I still think there's an advantage
> > in being explicit and avoid aliases like this. Perhaps a __deprecated
> > annotation would help with that?
> 
> I fear adding __deprecated would be too controversial, because that
> would add hundreds of new warnings to code that is not actually wrong.

Right. __deprecated is enabled via Kconfig, though, so people could turn
that off if they don't want to see the warnings. I don't mind very much
either way.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/12aa178b/attachment.sig>
