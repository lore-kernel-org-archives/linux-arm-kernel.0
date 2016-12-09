From: richardcochran@gmail.com (Richard Cochran)
Date: Fri, 9 Dec 2016 09:57:52 +0100
Subject: [RFC PATCH net-next v3 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <CAFcVECJutEu2=POtAU=jX6E3-ZHsLXpOMMw+UJ0hcQgZ0n4ZVA@mail.gmail.com>
References: <1481134912-2243-1-git-send-email-andrei.pistirica@microchip.com>
 <20161207193908.GA13062@netboy> <20161207210416.GA27622@netboy>
 <07C910AB6AC6C345A093D5A08F5AF568CB74AF28@CHN-SV-EXMX03.mchp-main.com>
 <CAFcVECJutEu2=POtAU=jX6E3-ZHsLXpOMMw+UJ0hcQgZ0n4ZVA@mail.gmail.com>
Message-ID: <20161209085752.GB16009@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 11:07:23AM +0530, Harini Katakam wrote:
> I'm afraid I don't get why we are choosing the most limited max adj..
> Sorry if I'm missing something - could you please help me understand?

This max_adj is only important when the local clock offset is large
and user space chooses not to step the time value.  In that case, user
space will want to run the clock as fast (or as slow) as possible in
order to catch up with the remote clock.

The driver must provide a max_adj that is always safe for user space
to apply via the clock_adjtime() system call.

HTH,
Richard
