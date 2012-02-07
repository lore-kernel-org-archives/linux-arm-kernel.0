From: olof@lixom.net (Olof Johansson)
Date: Mon, 6 Feb 2012 16:43:04 -0800
Subject: [GIT PULL] i.MX fixes for -rc
In-Reply-To: <CAOMZO5ARnTLrO_+5q+tU501Y2qL5xh8SOM74KU8T9A_+2vCJFA@mail.gmail.com>
References: <20120127111024.GB5446@pengutronix.de>
 <CAOesGMj4k3NcXMh3WtegJgejdDK1QntDnyudD6Ky8Ou6mN3cBg@mail.gmail.com>
 <20120131085637.GM1990@pengutronix.de>
 <CAOMZO5ARnTLrO_+5q+tU501Y2qL5xh8SOM74KU8T9A_+2vCJFA@mail.gmail.com>
Message-ID: <CAOesGMgZZ31gY3oqrw1D8K+mcy_t719n4GCwMiuseSyCRtTaPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 31, 2012 at 2:53 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Jan 31, 2012 at 6:56 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
>>
>> I understood that the second patch is a bugfix and that it depends on
>> the first one. Fabio, can you comment on this?
>
> Yes, this is correct.
>
> The bugfix that my patch addresses is the fact that mx35 is not
> entering LPM (low power mode) in WFI.
> It is using the same behaviour of mx31 and this is not correct for
> mx35 due to the different LPM field.
>
> I saw Olof?s feedback about the patch and will address it soon.

Just to clarify; is this a fix to functionality that used to work but
is now broken, and if so, what broke it? Having that in the patch
description when reposted is very useful.

Fixes for features that never worked is generally not -rc material.
Sometimes during the first -rcs it could be OK, but not later on in
the release cycle. It should instead be queued up in a
fixes-non-critical type branch for the next merge window instead.


-Olof
