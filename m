From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 31 Jan 2018 13:19:41 +0000
Subject: [RFC PATCH] tty: pl011: Avoid stuck-off spurious interrupts
In-Reply-To: <CACRpkdb8=vNmwOYYTAuDM21CtoCw1868js8wnHTTofK-pZYKGQ@mail.gmail.com>
References: <1517242181-20652-1-git-send-email-Dave.Martin@arm.com>
 <CACRpkdb8=vNmwOYYTAuDM21CtoCw1868js8wnHTTofK-pZYKGQ@mail.gmail.com>
Message-ID: <20180131131941.GM5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 01:28:43PM +0100, Linus Walleij wrote:
> On Mon, Jan 29, 2018 at 5:09 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> 
> > Commit 9b96fbacda34 ("serial: PL011: clear pending interrupts")
> > clears the RX and receive timeout interrupts on pl011 startup, to
> > avoid a screaming-interrupt scenario that can occur when the
> > firmware or bootloader leaves these interrupts spuriously
> > asserted.
> 
> It looks OK to me.

You mean, the original patch?

I think there is a real potential bug here for SBSA UART, but I also
haven't been able to reproduce it on hardware.

I'm not sure whether it can happen on a real pl011, given that the
driver turns the FIFOs off and on etc.  That may get us back into a
sane state.  On the SBSA UART this does nothing: the SBSA UART
cannot be reset or disabled directly IIRC.

> I could never reproduce this issue myself, it was just reported by
> Chanho, and we came up with this fix. AFAICR it was working fine
> on ARM reference designs and my ST-Ericsson platforms before
> and after.
> 
> I do not remember what hardware Chanho was seeing this problem
> on, but let's loop in Chanho and ask.

OK, thanks
---Dave
