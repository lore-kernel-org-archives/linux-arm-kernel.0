From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 2 Jul 2016 20:46:08 +0200
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2: add ETM, ETB and ETMCK node
In-Reply-To: <CALdGsk+KwPMVKXhKtcmoUFqfj6aQRvQSY74F31fSvZhV+QvjAA@mail.gmail.com>
References: <1467383831-6985-1-git-send-email-olivier.schonken@gmail.com>
 <1467383831-6985-2-git-send-email-olivier.schonken@gmail.com>
 <20160701183248.GC2874@piout.net>
 <CALdGsk+KwPMVKXhKtcmoUFqfj6aQRvQSY74F31fSvZhV+QvjAA@mail.gmail.com>
Message-ID: <20160702204608.257b8bc6@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olivier,

On Fri, 1 Jul 2016 22:07:53 +0200
Olivier Schonken <olivier.schonken@gmail.com> wrote:

> Hi Alexandre
> 
> Resending this mail, the previous one was accidentally in html format,
> thus rejected from the list.  My apologies.
> 
> I did try a couple of options regarding the clock, mck included, but
> it would then hang when probing occurs in drivers/amba/bus.c when the
> clock gets disabled. The dummy clock solved this issue, but I'm open
> to better suggestions.

Hm, that's really weird. Is the AMBA bus driver probed before the PIT
driver?
Anyway, I agree that this dummy clock approach is not ideal. Could we
make the apb_pclk clock optional in the AMBA bus driver?

The other approach would be to have someone claim the mck clock before
the AMBA bus driver, and keep it enabled.

Regards,

Boris
