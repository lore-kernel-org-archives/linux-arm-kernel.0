From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 Jun 2015 13:58:38 +0200
Subject: [RFC PATCH V3] ARM: dts: sun6i: Add dts file for MSI Primo81
 tablet
In-Reply-To: <1434481869-9432-1-git-send-email-merker@debian.org>
References: <20150616094026.GG11732@lukather>
 <1434481869-9432-1-git-send-email-merker@debian.org>
Message-ID: <20150618115838.GL11732@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 16, 2015 at 09:11:08PM +0200, Karsten Merker wrote:
> On Tue, Jun 16, 2015 at 11:40:27AM +0200, Maxime Ripard wrote:
> 
> > What I meant in my previous review was to use the syntax
> > 
> > &uart0 {
> >        some-property;
> > };
> >   
> > Instead of duplicating the tree structure like you're doing
> > here. We've converted all the DT to that, so you can look around and
> > see how it's done in other boards (note that the nodes should be
> > sorted by alphabetical order).
> 
> Ah, sorry, I had misunderstood your original email in this regard.
> Following is a reworked version of the patch.
> 
> Changelog:
> 
> Version 1
> =========
> - Original patch by Siarhei Siamashka
> 
> Version 2
> =========
> - Use symbolic instead of numeric pinctrl values.
> 
> - Change the include syntax from /include/ to #include to make
>   the dts build with current kernels.
> 
> Version 3
> =========
> - Use labels for nodes with modifications in relation to the dtsi
>   instead of replicating the tree structure.
> 
> - Remove the FSF address from the license header as done in
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340437.html
>   for the other dts files to remove a checkpatch warning.
> 
> - Add msi to the vendor prefix list.
> 
> - Remove earlyprintk from the default kernel commandline.
> 
> - Replace the console kernel commandline parameter by a
>   /chosen/stdout-path node and add an alias serial0 -> uart0.

Next time, pleas try to keep the changelog with your patch, it's much
easier to read.

And please make the vendor prefix change a different patch.

> I have tagged this patch RFC as I am unsure what to do with the
> /chosen/stdout-path node. For now, I have set Siarhei's original
> choice (first serial port), but I am unsure whether this is the
> right thing to do as the Primo81 does by default not have a
> user-accessible serial port.  The only way to get a serial
> console is to either break the case open and find some test
> points that carry the RX/TX lines (which with the Primo81 case
> poses a high risk of breaking the display glass), or to use an SD
> card breakout board and change the pinmuxing for the SD card pins
> to the "serial" function.  The latter would not work without
> modifying the dts, so the SD-breakout case doesn't really count
> for setting the default stdout-path in the general use case.

Having that as a comment on top of whatever uart you've been using
would be great, so that people know where to look at on their device
to find it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150618/3793c082/attachment.sig>
