From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 18:39:47 +0000
Subject: [PATCH 17/31] ASoC: tegra: call pm_runtime APIs around register
 accesses
In-Reply-To: <528A4D9A.10809@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-18-git-send-email-swarren@wwwdotorg.org>
 <20131116100205.GG15393@sirena.org.uk>
 <528A4D9A.10809@wwwdotorg.org>
Message-ID: <20131118183947.GS2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 10:25:46AM -0700, Stephen Warren wrote:
> On 11/16/2013 03:02 AM, Mark Brown wrote:

> > Or alternatively should the driver be making the device
> > cache only when runtime PM is disabled?

> The regmap is already cache-only when runtime-suspended. However the
> registers don't get flushed during resume. I suppose that would require
> only adding one extra call to the PM resume function?

Yup, should probably do that anyway since that's going to bite someone
otherwise.  We probably want a single operation to flush and enable
writes now I think about it, it's the common case.

> For some reason, my gut prefers this current solution, but I could be
> persuaded.

I'm not dead set against doing it this way, it's just that it feels like
if it's required something's not working as well as it should.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/30ac4b2c/attachment.sig>
