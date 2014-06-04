From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jun 2014 10:01:11 +0100
Subject: mainline boot: 37 passed 4 failed
 (mainline/v3.15-rc8-4569-g3de0ef8)
In-Reply-To: <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
References: <538e6a20.0168440a.7895.422b@mx.google.com>
 <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
Message-ID: <20140604090111.GE2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 06:26:14PM -0700, Olof Johansson wrote:
> On Tue, Jun 3, 2014 at 5:36 PM, Olof's autobooter <build@lixom.net> wrote:

> > [    2.816920] smps9: failed to get the current voltage

> This seems to be from palmas registration failing, which in turns
> causes vmmc regulator lookup to fail. See the errors about palmas-pmic
> above.

Always CC maintainers on things.  This is a bug in the driver, it needs
to support retrieving voltages at all times (and would probably run into
trouble anyway).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/a695c512/attachment.sig>
