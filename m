From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 May 2015 20:55:27 +0100
Subject: [PATCH 10/21] regulator: core: Probe regulators on demand
In-Reply-To: <CAAObsKDDMxHPH+QB+SAPUwVa3WGrud61F+_ToB1mrY_FyFfZYw@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-11-git-send-email-tomeu.vizoso@collabora.com>
 <20150525173244.GE21577@sirena.org.uk>
 <CAAObsKDzKzYAx4_xsNm0reXzgSrJi7Q+aZGifmVxvSEQ=Qxjkw@mail.gmail.com>
 <20150526093601.GH21577@sirena.org.uk>
 <CAAObsKA_59z0qYmUqux7dMO38vOrLBUM_eWZ-QeJxEEmunq2ZQ@mail.gmail.com>
 <20150526165458.GV21577@sirena.org.uk>
 <CAAObsKDDMxHPH+QB+SAPUwVa3WGrud61F+_ToB1mrY_FyFfZYw@mail.gmail.com>
Message-ID: <20150526195527.GZ21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 07:53:33PM +0200, Tomeu Vizoso wrote:
> On 26 May 2015 at 18:54, Mark Brown <broonie@kernel.org> wrote:

> >> My understanding is that the problem I'm addressing is specific of
> >> machines in which the kernel is in charge of pretty much everything
> >> and that the information about what devices are present is given in an
> >> arbitrary order.

> > I don't think you've fully understood the problem space here.
> 
> Fair enough, what's your understanding of it?

Basically what I said in the e-mail you quoted fully in your reply,
especially this section:

> > No, not in the least.  Quite aside from anything else as soon as you
> > allow things to be built as modules userspace is free to load things in
> > whatever order amuses it.  Think about what's going on here - it's not
> > just registration of devices, it's also about the order in which
> > subsystems and drivers register themselves.

Probe ordering is fairly weakly related to the interface used to
register devices, you're going to get dependencies more often the more
detail is exposed to the kernel but it's not specific to that.  It's
definitely not something that we have a solution to for board files,
they rely on deferred probing just as much as device tree does.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/0fbb9b47/attachment.sig>
