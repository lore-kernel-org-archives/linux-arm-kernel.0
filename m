From: broonie@kernel.org (Mark Brown)
Date: Sat, 4 Apr 2015 19:54:01 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <551FE1A8.9060709@redhat.com>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
 <20150404123302.GY6023@sirena.org.uk>
 <20150404125645.GK14618@lukather> <551FE1A8.9060709@redhat.com>
Message-ID: <20150404185401.GB6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 04, 2015 at 03:05:44PM +0200, Hans de Goede wrote:
> On 04-04-15 14:56, Maxime Ripard wrote:

> >What I do see though, is that if we drop the DTSI, all our
> >boards will have to define all the PMIC regulators, even if they're
> >not used at all on the board, just to have the right behaviour. And
> >that's clearly a no-go for me.

> Right the advantage of the dtsi is that it lasts ALL regulators,
> so that unused ones actually get turned off, where as a dts not using
> the dtsi and only containing those it actually uses will result in
> the unused regulators being untouched (since they are not listed)
> rather then turned off.

Like I said in reply to Maxim a .dtsi does not seem the place to do this
- if it's safe to do it we should be doing it in the core code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150404/0006e92a/attachment.sig>
