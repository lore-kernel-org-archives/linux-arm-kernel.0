From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Oct 2017 10:34:32 +0200
Subject: [PATCH/RFC 4/5] regulator: bd9571mwv: Add support for backup mode
In-Reply-To: <CAMuHMdWnJwMk5DrnAQebKB23X2WJGPQ2m-0OX8-AC2QYguTQ5w@mail.gmail.com>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
 <20171018110238.hjv7huiievhr5obs@sirena.co.uk>
 <CAMuHMdU2PpiSftwnqHjb8uFpu5Huw7hpedk4cSzDY-eeKio_Dw@mail.gmail.com>
 <20171018112419.3eqz34epcshxas3f@sirena.co.uk>
 <CAMuHMdWnJwMk5DrnAQebKB23X2WJGPQ2m-0OX8-AC2QYguTQ5w@mail.gmail.com>
Message-ID: <20171024083432.j3xqepkvprbvg2p4@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 01:28:30PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 18, 2017 at 1:24 PM, Mark Brown <broonie@kernel.org> wrote:

> >> Hence you cannot enable wakeup mode while suspending, as the proper
> >> system suspend/resume procedure is:
> >>   1. Enable backup mode in the PMIC,
> >>   2. Switch ACC off (no-op as backup mode has been enabled),
> >>   3. Suspend to RAM (PSCI suspend) => system suspends,
> >>   4. Switch ACC on => system wakes up.
> >> If you would combine steps 1 and 3, you can no longer do step 2 in between.

> >> Yes, it's complicated :-(

> > I'm confused, I thought this was a physical switch but that's talking
> > about this as something software controlled (at least in step 2)?

> The ACC switch is a physical switch.
> Steps 1 and 3 are performed by software running on the board's SoC.
> Steps 2 and 4 are performed by the external user (human or remote board
> farm control hookup).

That's horrible.  There's still the question about potentially using the
existing wakeup file to manage if the device is a wakeup source but
otherwise I guess the only other thing that'd make sense would be just
having a property in the DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171024/f8b6ad3b/attachment.sig>
