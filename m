From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 09:38:55 -0500
Subject: [PATCH] arm: plat-orion: fix printing of "MPP config
 unavailable on this hardware"
In-Reply-To: <50FFF489.5070506@keymile.com>
References: <1358949059-10803-1-git-send-email-gerlando.falauto@keymile.com>
 <20130123142510.GN1758@titan.lakedaemon.net>
 <50FFF489.5070506@keymile.com>
Message-ID: <20130123143855.GP1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 03:32:41PM +0100, Gerlando Falauto wrote:
> On 01/23/2013 03:25 PM, Jason Cooper wrote:
> >On Wed, Jan 23, 2013 at 02:50:59PM +0100, Gerlando Falauto wrote:
> >>Commit 3cff484d4b264ff467a3b45c544cbbbab69f0bf8
> >>ARM: dove: Consolidate mpp code with platform mpp.
> >>
> >>refactored printing of the kernel warning
> >>"orion_mpp_conf: requested MPP%u config unavailable on this hardware\n"
> >>which is not to be printed in case of variant_mask = 0 (unknown variant).
> >>This check should be performed using a logical AND (&&) as opposed
> >>to a bitwise AND (&).
> >>Otherwise, test would fail (and message would be printed) if variant_mask != 1
> 
> Whooops, what I meant was "and message would NOT be printed"... sorry. :-(
> Shouldn't really matter anyway.

fixed in mvebu/fixes.

thx,

Jason.
