From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Aug 2012 18:49:45 +0100
Subject: [PATCH 1/4] ARM: export read_current_timer
In-Reply-To: <503513A2.1030002@codeaurora.org>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-2-git-send-email-arnd@arndb.de>
 <503513A2.1030002@codeaurora.org>
Message-ID: <20120822174945.GS9093@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 06:15:14PM +0100, Stephen Boyd wrote:
> On 08/22/12 07:29, Arnd Bergmann wrote:
> > read_current_timer is used in the get_cycles() function when
> > ARM_ARCH_TIMER is set, and that function can be inlined into
> > driver modules, so we should export the function to avoid
> > errors like
> >
> > ERROR: "read_current_timer" [drivers/video/udlfb.ko] undefined!
> > ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> I ran into this last week but forgot to send the patch. Thanks.

Looks good to me, thanks Arnd:

Acked-by: Will Deacon <will.deacon@arm.com>

On the topic of the timer stuff: Shinya/Stephen, did you have a chance to
look at the registration stuff that was proposed? I'm happy to push it if
people will actually use it.

Cheers,

Will
