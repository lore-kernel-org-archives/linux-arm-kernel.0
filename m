From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 29 Jun 2011 09:31:19 -0600
Subject: [RFC 2/8] remoteproc: add omap implementation
In-Reply-To: <BANLkTi=4Pp1UYWFsBywRvLL1n=ggCZgAeA@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-3-git-send-email-ohad@wizery.com>
	<20110627210007.GC20865@ponder.secretlab.ca>
	<BANLkTi=4Pp1UYWFsBywRvLL1n=ggCZgAeA@mail.gmail.com>
Message-ID: <BANLkTikGaYjjuXOb0ANM4+-j3nWFJ1BaCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 9:04 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Jun 28, 2011 at 12:00 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> Very little for me to comment on here. ?However, something I just
>> noticed. ?Why is it necessary to pass in THIS_MODULE to the
>> rproc_register function? ?Having a reference to the pdev gives you the
>> pointer to the driver, which has the THIS_MODULE value in it. ?That
>> should be sufficient.
>
> Nice one, thanks !
>
>> /me also isn't sure if incrementing the refcount on the module is the
>> best way to prevent the rproc from going away, but I haven't dug into
>> the details in the driver code to find out. ?Drivers can get unbound
>> from devices without the driver being unloaded, so I imagine there is
>> an in-use count on the device itself that would prevent driver
>> unbinding.
>
> Yes, increasing the module refcount is necessary to prevent the user
> from removing the driver when the rproc is used.

That prevents removing the module which necessitates unbinding the
device.  However, I believe it is possible to unbind a driver
/without/ the module being unloaded.  My question (for which I don't
have an answer) is whether or not there is a way to increment a
refcount on users of the driver bound to the device..

g.
