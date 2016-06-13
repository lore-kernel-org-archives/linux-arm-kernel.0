From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Jun 2016 10:01:24 +0200
Subject: [PATCH 0/1] ARM: dts: sunxi: Fix simplefb not working in 4.7-rc1
In-Reply-To: <21258fc0-0250-951b-2ee7-d022fb3c09ac@redhat.com>
References: <1465063524-4925-1-git-send-email-hdegoede@redhat.com>
 <20160609074643.GA5242@lukather>
 <21258fc0-0250-951b-2ee7-d022fb3c09ac@redhat.com>
Message-ID: <20160613080124.GA4481@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 12:47:36PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09-06-16 09:46, Maxime Ripard wrote:
> >Hi Hans,
> >
> >On Sat, Jun 04, 2016 at 08:05:23PM +0200, Hans de Goede wrote:
> >>Hi Maxime,
> >>
> >>While testing 4.7-rc1 / linux-sunxi/sunxi-next on a A10s I noticed that
> >>hdmi out is no longer working (screen goes black when the kernel turns
> >>of unused clocks).
> >>
> >>This is caused by the dtsi for sun4i / sun5i / sun7i based boards now
> >>listing pll3, without pll3 being added to the clocks list for the
> >>simplefb nodes.
> >
> >Why not do just that then? It's more appropriate for a fix imho.
> 
> You mean just for sun5i-a10s, or for all of sun4i / sun5i-a10s and
> sun7i ?
> 
> For sun4i and sun7i things are already fixed in next:
> 
> https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?id=5a7f2310cc847a73852e70bc720a61ca9bf986a6
> https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?id=c79255ca4d7b67cce4eac4dd532e097ce49f3679
> 
> It seems best to use those fixes, rather then come up with a separate
> fix for 4.7.
> 
> My patch for fixing sun5i-a10s is inline with the 2 above patches,
> which seems best, rather then doing something special for just sun5i-a10s.

Well, you are doing something special for just the A10s: the patches
quoted above just add a bunch of clocks and add the handles to the
list of clocks managed by simplefb.

For the A10s, you also declare the whole display engine block without
anyone having tested that it was actually working.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/b202905d/attachment.sig>
