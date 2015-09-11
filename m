From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 10:57:48 +0100
Subject: [PATCH v3 02/18] of/platform: add of_platform_probe
In-Reply-To: <CAAObsKAZ0kaT2TZQdMnxy9ZjHMz2jFeYQvQjrCsa90J11bOVpA@mail.gmail.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
 <20150807121913.GS20873@sirena.org.uk>
 <CAAObsKCrakupiZMQ9AoiWo6fDYT6Cfi_khdssUS6pv61zYS1Zg@mail.gmail.com>
 <CAAObsKAZ0kaT2TZQdMnxy9ZjHMz2jFeYQvQjrCsa90J11bOVpA@mail.gmail.com>
Message-ID: <20150911095748.GC12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 02:31:06PM +0200, Tomeu Vizoso wrote:
> On 11 August 2015 at 11:37, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> > On 7 August 2015 at 14:19, Mark Brown <broonie@kernel.org> wrote:

> >> This sounds like it's going to break in the case where we have MFDs that
> >> represent their functions in DT (not a pattern I'm a fan of but it's a
> >> thing people do).  We'll walk back to the platform device for the MFD
> >> function, try to probe it and then give up.  Perhaps that's good enough
> >> anyway but it's not clear to me why we don't just try every parent we
> >> find?

> > Agreed. In the attempt at probing dependencies before a device is
> > probed, I considered that a device's parent is also a dependency and

> Actually I'm not sure how we could probe the ascendants on demand, as
> currently the parent's device lock is taken when probing so trying to
> probe a sibling from within a probe callback will cause a deadlock.

How do silbilings come into this?  There is an issue there but it's
going to happen anyway.

> AFAICS this is only needed for USB interface devices and this
> behaviour could be limited to them, but I don't like much assuming
> that no USB device will ever have a dependency on a sibling (though
> that probably won't happen ever).

I don't see the connection with USB here, sorry - my initial thought was
about MFDs?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/f70cb0ee/attachment.sig>
