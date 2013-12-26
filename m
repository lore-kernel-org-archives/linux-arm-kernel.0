From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 26 Dec 2013 15:30:00 -0800
Subject: [PATCH 1/5] input: Add new sun4i-ts driver for Allwinner sunxi
 SoC's rtp controller
In-Reply-To: <52BCAEA2.6040607@redhat.com>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
 <1387923847-1294-2-git-send-email-hdegoede@redhat.com>
 <20131226221558.GA18562@core.coreip.homeip.net>
 <52BCAEA2.6040607@redhat.com>
Message-ID: <20131226233000.GE18562@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 11:33:06PM +0100, Hans de Goede wrote:
> On 12/26/2013 11:15 PM, Dmitry Torokhov wrote:
> >
> >Are we 1000% sure that the device is quiesced here and we will not get a
> >stray interrupt? Even if we are sure I'd still rather allocate input
> >device earlier, together with ts structure.
> 
> I will change things to allocate the input device earlier. What about
> registering it, when is the best time to do that?

The common pattern for the most input drivers is to register it last,
but that usually matters when you are not using managed input devices
since it helps making error unwinding path simpler. I'd still register
it last just so it looks the same as the rest of the drivers.

-- 
Dmitry
