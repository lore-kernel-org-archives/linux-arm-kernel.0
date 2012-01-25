From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Jan 2012 11:33:41 +0000
Subject: [PATCH v4 - resend 10/13] ASoC: omap-abe-twl6040: Configure card
 according to platform data
In-Reply-To: <4F1FBBE5.5080804@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <1327405950-6676-11-git-send-email-peter.ujfalusi@ti.com>
 <20120124130008.GC31839@opensource.wolfsonmicro.com>
 <4F1FBBE5.5080804@ti.com>
Message-ID: <20120125113341.GB3687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 10:23:01AM +0200, Peter Ujfalusi wrote:
> On 01/24/2012 03:00 PM, Mark Brown wrote:
> > On Tue, Jan 24, 2012 at 01:52:27PM +0200, Peter Ujfalusi wrote:

> >> Disable the not connected pins on the board based on the
> >> received platform data.
> >> DO not register the jack function on boards, which does not have
> >> means to detect it (jack is always connected).

> > This should no longer be needed with the auto not connected stuff.

> The auto not connected checks if we have connected something in the card
> domain to the codec's input/output/micbias widgets.
> In the machine driver we start from fully wired configuration, and based
> on the received platform data we mark certain connections not connected.
> The audio nc feature would not work here. It will not mark anything nc
> since the DAPM map is complete.

It'd do the right thing if you changed the code to only register the
board widgets and routes as required - from your reply to Jassi it looks
like you ought to do conditional reigstration anyway as the input paths
move around between board variations.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120125/954dbb26/attachment.sig>
