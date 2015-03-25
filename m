From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Mar 2015 21:50:54 -0700
Subject: [PATCH] regulator: Defer lookup of supply to regulator_get
In-Reply-To: <1427248565-9680-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1427248565-9680-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20150325045054.GA31311@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 06:56:05PM -0700, Bjorn Andersson wrote:
> Instead of resolving regulator supplies during registration move this to
> the time of a consumer retrieving a handle. The benefit is that it's
> possible for one driver to register regulators with internal
> dependencies out of order.

This looks basically sensible (as we discussed in person) - I'd like to
poke at this on some systems I've got back home to make sure I'm happy
with the debugging output and so on but I'm not expecting any problems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/6b134006/attachment.sig>
