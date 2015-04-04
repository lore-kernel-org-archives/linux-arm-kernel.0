From: broonie@kernel.org (Mark Brown)
Date: Sat, 4 Apr 2015 13:33:02 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
 <CABxcv=nCROiQ2COrTmnwvhtSJzh83BWKaxgn0EkFuwW8HqSiQw@mail.gmail.com>
Message-ID: <20150404123302.GY6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 04, 2015 at 02:18:12PM +0200, Javier Martinez Canillas wrote:
> On Tue, Mar 31, 2015 at 12:23 AM, Maxime Ripard

> > No, it's defining which regulators are provided by the regulator, and
> > the voltage boundaries they have. It doesn't make any assumption with
> > regards to what is connected to what, and if a particular regulator is
> > connected to something. That's something that the board DTS should
> > describe as accurately as possible.

This is broken - think about what this means.  If you are defining a
voltage (or any other constraint) you're saying that it's safe to use on
a given board.  If you provide a voltage constraint saying that the
maximum allowable range for a voltage regulator is safe.  That's
unlikely to be true on any given board, usually only a limited set of
regulators can vary voltages at runtime safely at all and then rarely
over their full supported range.  Similarly for other constraints, for
example allowing a regulator to be disabled when there are driverless
things (or drivers without regulator support or mappings for that board)
relying on it is going to break.

Providing a list of the regulators is safe but not really doing a huge
amount.

Note that I've not seen the original patch so it's possible it's doing
something different.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150404/a64ae418/attachment-0001.sig>
