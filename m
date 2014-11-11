From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Nov 2014 18:34:35 +0100
Subject: [PATCH] ARM: dts: sunxi: Banana Pi: increase startup-delay for
 the GMAC PHY regulator
In-Reply-To: <545FD716.5060305@redhat.com>
References: <1415539714-7652-1-git-send-email-merker@debian.org>
 <1415539714-7652-2-git-send-email-merker@debian.org>
 <545FD716.5060305@redhat.com>
Message-ID: <20141111173435.GJ14919@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 10:05:26PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/09/2014 02:28 PM, Karsten Merker wrote:
> > On the LeMaker Banana Pi, probing the external ethernet PHY connected
> > to the SoC's internal GMAC module sometimes fails.  The PHY power
> > supply is handled via a GPIO-controlled regulator, and the existing
> > regulator startup-delay of 50000us is too short to make sure that the
> > PHY is always fully powered up when it is queried by phylib.  To
> > guarantee a reliable PHY detection, the startup-delay has to be
> > increased to 60000us.
> 
> We should probably just increase it to 100000us to be safe, otherwise:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Soooo, should I merge it or will there be a v2?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141111/1aac765a/attachment.sig>
