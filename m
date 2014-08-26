From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Aug 2014 15:19:48 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <53FB555E.5040409@suse.de>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com> <53FB555E.5040409@suse.de>
Message-ID: <20140826131948.GK15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 25, 2014 at 05:25:18PM +0200, Andreas F?rber wrote:
> Hi,
> 
> Am 25.08.2014 15:47, schrieb Hans de Goede:
> > On 08/25/2014 03:39 PM, Thierry Reding wrote:
> >> On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> >>> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> >>>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> >>>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> >>>>>> If not, perhaps the clock driver should force the clock to be
> >>>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> [...]
> > As for the suggestion to simply never disable the plls / ahb gates by blocking
> > them from ever being disabled in the sunxi clock driver, that is not really
> > a solution either, as we want to be able to turn these things off to safe
> > power on screen blank once control has been turned over to the kms driver.
> 
> Without wanting to take sides on the simplefb matter, can't you just use
> clk_ignore_unused in bootargs to work around the issue at hand?
> That's what I do on the Spring Chromebook.

Leaving *all* the clocks enabled just to workaround a driver failing
to grab its clocks doesn't look like a solution either.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/67dbc617/attachment.sig>
