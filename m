From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Mar 2018 10:28:08 +0800
Subject: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <CAD=FV=XELzjc6h06MhwW-8XCOvH4vhMk1zzK_aD+94RdbCzUtw@mail.gmail.com>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com>
 <184378e4-caf8-6ce3-e089-3690588fcb28@codeaurora.org>
 <CAD=FV=WsVDDaV-mMUvQWUomyBFCJZunKiyDt_K81_syoNhGRZQ@mail.gmail.com>
 <20180327115606.GC29239@sirena.org.uk>
 <CAD=FV=XELzjc6h06MhwW-8XCOvH4vhMk1zzK_aD+94RdbCzUtw@mail.gmail.com>
Message-ID: <20180328022808.GL29239@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 01:51:56PM -0700, Doug Anderson wrote:

> Assuming I didn't mess up my analysis, the entire job of of_map_mode()
> is to convert from one integer to another.  It should take the number
> that was specified in the device tree and convert it to a
> REGULATOR_MODE_XXX.  That means that the regulator framework is
> enforcing a distinct and per-regulator numbering system for the mode
> (I called this "device tree mode").

OK, the confusion comes from your terminology invention rather than the
driver then :(

> So basically it sounds like everyone makes up some arbitrary numbering
> system that is only used in their device tree files and needs to be
> mapped into the standard numbering system...

It's not just that.  The very modes themselves are not defined at all
consistently between regulators - the set of options varies wildly as
does the range of applications they are suitable for.  We want people to
not only define numbers here but also names that make sense in the
context of the regulator documentation that can then be mapped into the
concept of modes we've inherited in the regulator subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/c50f5923/attachment.sig>
