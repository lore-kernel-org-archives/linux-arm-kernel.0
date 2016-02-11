From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 11 Feb 2016 17:15:27 -0600
Subject: [PATCH] of/irq: Fix msi-map calculation for nonzero rid-base
In-Reply-To: <56BC6ABA.5020605@arm.com>
References: <9f6845195d03b0e0b0d187bb510fbf7bd497e836.1455015344.git.robin.murphy@arm.com>
 <56BC6ABA.5020605@arm.com>
Message-ID: <CAL_JsqLScMdfUAtMPDGWphc_PZp4K-c0MfjRZh9G7=A9pLZu9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 5:04 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 09/02/16 11:04, Robin Murphy wrote:
>> The existing msi-map code is fine for shifting the entire RID space
>> upwards, but attempting finer-grained remapping reveals a bug. It turns
>> out that we are mistakenly treating the msi-base part as an offset, not
>> as a new base to remap onto, so things get squiffy when rid-base is
>> nonzero. Fix this, and at the same time add a sanity check against
>> having msi-map-mask clash with a nonzero rid-base, as that's another
>> thing one can easily get wrong.
>>
>> CC: <stable@vger.kernel.org>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>
> Rob, Frank,
>
> Are you willing to take this one through the OF tree? Or should we route
> it through the IRQ tree? It'd be good if it make it into 4.5.

Applied for 4.5. ATM, I don't have anything else to send to Linus.
I'll give it a week or so if this is not urgent. Or send me a bunch of
DT binding fixes and you can get it in sooner. ;)

Rob
