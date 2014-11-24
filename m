From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 24 Nov 2014 13:52:46 +0100
Subject: [PATCH] arm/arm64: vgic: Remove unreachable irq_clear_pending
In-Reply-To: <54731EBB.5080707@arm.com>
References: <1416822116-9044-1-git-send-email-christoffer.dall@linaro.org>
 <54731EBB.5080707@arm.com>
Message-ID: <20141124125246.GN3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 12:04:11PM +0000, Andre Przywara wrote:
> Hej Christoffer,
> 
> On 24/11/14 09:41, Christoffer Dall wrote:
> > When 'injecting' an edge-triggered interrupt with a falling edge we
> > shouldn't clear the pending state on the distributor.  In fact, we
> > don't, because the check in vgic_validate_injection would prevent us
> > from ever reaching this bit of code.
> > 
> > Remove the unreachable snippet.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Acked-by: Andre Przywara <andre.przywara@arm.com>
> 
> I agree on this. Would it make sense to rewrite this function a bit to
> make it more clearer what happens? I find the nesting of the
> if-statements counter-intuitive: I'd prefer to first differentiate
> between level and edge triggered and then only check the actual level in
> the level-triggered branch. Not sure if it's worth the fuss, though.
> 
I disagree, and it's not ;)

-Christoffer
