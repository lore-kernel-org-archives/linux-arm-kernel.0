From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 1 Dec 2014 21:10:57 +0100
Subject: [PATCH v3 3/8] VFIO: platform: forwarded state tested when
 selecting IRQ handler
In-Reply-To: <547C7D9C.7030909@linaro.org>
References: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
 <1416767760-14487-4-git-send-email-eric.auger@linaro.org>
 <20141130124730.GD82106@macair> <547C7D9C.7030909@linaro.org>
Message-ID: <20141201201057.GK23653@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 03:39:24PM +0100, Eric Auger wrote:
> Hi Christoffer,
> On 11/30/2014 01:47 PM, Christoffer Dall wrote:
> > The subject reads strangely, perhaps just:
> > 
> > VFIO: platform: test forward state when selecting IRQ handler
> OK
> > 
> > On Sun, Nov 23, 2014 at 07:35:55PM +0100, Eric Auger wrote:
> >> In case the IRQ is forwarded, the VFIO platform IRQ handler does not
> >> need to disable the IRQ anymore.
> >>
> >> When setting the IRQ handler we now also test the forwarded state. In
> >> case the IRQ is forwarded we select the edge handler (no automaske).
> >>
> >> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> >>
> >> ---
> >>
> >> v2 -> v3:
> >> - forwarded state was tested in the handler. Now the forwarded state
> >>   is tested before setting the handler. This definitively limits
> >>   the dynamics of forwarded state changes but I don't think there is
> >>   a use case where we need to be able to change the state at any time.
> > 
> > user space can change this by calling the VFIO_IRQ_SET_ACTION_TRIGGER
> > whenever it wants, right?
> yes the user can set/unset the VFIO signaling (and request_irq/free_irq)
> using VFIO_IRQ_SET_ACTION_TRIGGER. In this new version I do not allow
> changing the forwarded state when the handler is attached (request_irq).
> 
> Does it answer your interrogation?
> 
interrogation?  hopefully it wasn't that bad ;)

Yes, that answers my question.

Thanks,
-Christoffer
