From: robherring2@gmail.com (Rob Herring)
Date: Mon, 10 Mar 2014 11:05:40 -0500
Subject: [PATCH 0/9] Doc/DT: DT bindings for various display components
In-Reply-To: <53143796.2050309@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <20140228162752.GU21483@n2100.arm.linux.org.uk>
 <5310BDE3.60603@ti.com>
 <20140228165628.GX21483@n2100.arm.linux.org.uk>
 <53143796.2050309@ti.com>
Message-ID: <CAL_JsqLppZHjND_LFMxscR0WCD4Ox7vF0fDbQFoYg=TENXxY8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 2:04 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi Rob, Pawel, Mark, Ian, Kumar,
>
> On 28/02/14 18:56, Russell King - ARM Linux wrote:
>> On Fri, Feb 28, 2014 at 06:48:35PM +0200, Tomi Valkeinen wrote:
>>> This is totally unclear to me. How does it become a public standard?
>>> What's the forum for this?
>>
>> Me too.  That's where I'd hope someone on devicetree-discuss will be
>> able to help us work out what's the right approach here. :)
>
> The story briefly so far: I've implemented DT support for OMAP display,
> and created bindings for various (non-OMAP) display components,
> including generic connector bindings for DVI, HDMI and analog-tv.
>
> Russell's point was that these connector bindings are very generic, i.e.
> they are not for any particular chip from a particular vendor, but for
> any connector for DVI, HDMI or analog-tv. And he's worried that maybe we
> shouldn't define such generic bindings without consulting the whole
> device-tree community (i.e including non-linux users).

So re-work it to be generic and send it out. DT maintainers would
rarely disagree that something shouldn't be made generic.

> So the question is, is there such a community and a forum to bring up
> this kind of things? If yes, should we bring this up there? If yes, what
> kind of things in general should be brought into the attention of
> non-linux users?

devicetree list is just that. It is not just for Linux. There is the
newly created devicetree-spec at vger.kernel.org which is for more
core/common binding discussion.

>
> What I wonder here is that while a thing like DVI connector is, of
> course, more generic than, say, "ti,tfp410" encoder chip, but isn't the
> case still the same: we're defining global bindings for hardware that
> should work for everyone, not only Linux users?

Defining the connectors in DT is a useful thing although mainly when
you have multiple connectors of the same type. Labels for composite,
SVideo, VGA, DVI, HDMI seem less useful to me. Describing position or
printed label (like front vs. rear connections) seem more useful to
me.

Rob
