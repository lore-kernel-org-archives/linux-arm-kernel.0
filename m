From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Oct 2017 12:02:38 +0100
Subject: [PATCH/RFC 4/5] regulator: bd9571mwv: Add support for backup mode
In-Reply-To: <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
Message-ID: <20171018110238.hjv7huiievhr5obs@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 05:26:17PM +0200, Geert Uytterhoeven wrote:

> Backup mode is not enabled automatically, as e.g. on Renesas
> Salvator-X(S) boards enabling backup mode changes the role of the ACC
> switch from a power switch to a wake-up switch.  Hence enabling it
> prevents the board from being powered off using the ACC switch, which
> may confuse the user.

This sounds an awful lot like the standard power/wakeup, though the
power change is a bit unexpected there.  I'm also wondering if it makes
sense to just only enable the wakeup mode when suspending which
preserves the power off functionality while also keeping the wakeup
support.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/034bf108/attachment.sig>
