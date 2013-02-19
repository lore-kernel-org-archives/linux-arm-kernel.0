From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Feb 2013 00:51:08 +0200
Subject: hwmod data duplication (was: Re: [RFC/NOT FOR MERGING 2/3]
 serial: omap: remove hwmod dependency)
In-Reply-To: <20130219223128.GM5724@atomide.com>
References: <20130214224710.GF11362@atomide.com>
 <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
 <20130219154511.GU17852@n2100.arm.linux.org.uk>
 <20130219163053.GE5724@atomide.com>
 <20130219182257.GV17852@n2100.arm.linux.org.uk>
 <20130219193122.GJ5724@atomide.com>
 <20130219194327.GB8978@arwen.pp.htv.fi>
 <20130219220932.GL5724@atomide.com>
 <20130219222215.GA12225@arwen.pp.htv.fi>
 <20130219223128.GM5724@atomide.com>
Message-ID: <20130219225108.GA12474@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 19, 2013 at 02:31:28PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [130219 14:26]:
> > On Tue, Feb 19, 2013 at 02:09:33PM -0800, Tony Lindgren wrote:
> > > 
> > > ..that means massive amount of churn in the board-*.c files to convert
> > > them to various init functions to be called from board-generic.c and
> > > removing the ones that are working with DT.
> > 
> > why ? I meant that only what's not converted to DT today should be
> > handled this way. Also, most of the "churn" is already there
> > (usb_musb_init(), usb_ehci_init(), etc etc), it just needs to be called
> > from a different place. We don't need to have one function for each
> > board, however, maybe we could target by-soc:
> > 
> > if (of_is_compatible("omap3"))
> > 	omap3_init_devices(); /* or whatever you wanna call it */
> > 
> > omap_init_devices() has initialization for everything which isn't DT
> > adapted today and as we move things to DT, there's a single place to
> > remove code from.
> 
> And the pdata for that comes from where? :) I think that means
> converting each board-*.c to device init functions, which leads to
> the churn I was mentioning..

fair enough, still a lot less churn ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130220/84e34824/attachment-0001.sig>
