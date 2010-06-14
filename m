From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 14 Jun 2010 09:08:16 -0600
Subject: Request review of device tree documentation
In-Reply-To: <alpine.LFD.2.00.1006141044510.13427@xanadu.home>
References: <33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
Message-ID: <AANLkTikH6AHQZse6YX6EzT3H3MKQzob_J04my5mLWW0V@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 14, 2010 at 8:59 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 14 Jun 2010, David Gibson wrote:
>
>> On Sun, Jun 13, 2010 at 11:02:15PM -0600, Grant Likely wrote:
>> Indeed. ?In fact, the general rule of thumb is really "put as much as
>> possible into the most easily replaced layer of the stack". ?This is,
>> incidentally, why I've always been dubious about simple firmwares
>> supplying a flattened device tree rather than including the device
>> tree template in the kernel, cuboot style.
>
> The biggest advantage, IMHO, for adding DT to ARM, is actually to
> decouple the hardware config information and the kernel. ?If in the end
> the DT has to be shipped in the kernel then we're losing all this
> advantage over the current state of things on ARM which still works
> pretty well otherwise.
>
> In the best case, the simple firmware simply has to retrieve the
> flattened device tree from flash, and pass it to the kernel just like
> some anonymous blob. ?And the simple firmware only needs to provide a
> way for that DT blob to be updatable, like through an upload of a
> replacement blob that was prepared offline. ?Just like a ramdisk image
> or the like.
>
> That doesn't need to be fancier than that, and the goal of having the DT
> data tied to the hardware instead of the kernel is achieved.

exactly right.

g.
