From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 20 Mar 2014 10:09:31 -0700
Subject: [PATCH v1 1/2] PSCI: Use DT Function ID values only for old
 versions of spec
In-Reply-To: <CAL_JsqLbNnkyg9pnjROBEeqmPRYerq52GK6yPOLTXgKbk6e0yg@mail.gmail.com>
References: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAL_Jsq+XXMjZ_qCCWD7u98Tq-u4Pj+fHyupJbAov98Zs8xttKg@mail.gmail.com>
 <20140320142623.GD23372@e106331-lin.cambridge.arm.com>
 <CAL_JsqLbNnkyg9pnjROBEeqmPRYerq52GK6yPOLTXgKbk6e0yg@mail.gmail.com>
Message-ID: <20140320170931.GV1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 12:04:45PM -0500, Rob Herring wrote:

[...]

> >>
> >> With the KVM patches[1], this makes 4 copies of these defines in the
> >> kernel (and then QEMU has more). This needs to go into a common header
> >> under include/linux. Probably under uapi so QEMU can use. There is
> >> some sync of headers between the kernel and QEMU I think.
> >
> > I agree we should have a common header, but I don't think this is uapi
> > material. This is most definitely _not_ part of the user API, and it's
> > from an external spec that we're not in control of -- I don't see why we
> > should have to export a set of numbers forever because it happens to be
> > marginally useful at this point in time.
> 
> I mention uapi only in that it is expected to be stable (in an ABI
> sense) from kernel release to release, and I would assume that QEMU
> would only sync ABI stable headers. Someone familiar with the QEMU
> import process should comment on where this stuff should live.
> 

AFAIK, only uapi headers are imported to QEMU.
