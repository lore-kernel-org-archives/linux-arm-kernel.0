From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Tue, 8 Nov 2011 10:21:08 -0600
Subject: [PATCH v3 2/4] OMAP4: hwmod data: add mmu hwmod for ipu and dsp
In-Reply-To: <87sjm31ngz.fsf@ti.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
 <1320185752-568-3-git-send-email-omar.ramirez@ti.com>
 <87sjm31ngz.fsf@ti.com>
Message-ID: <CAB-zwWgd5U+8UNFe_rLY99VpiaHhTqscwYNF+SmuRTyDi+h3+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 4, 2011 at 6:23 PM, Kevin Hilman <khilman@ti.com> wrote:
>> + ? ? .flags ? ? ? ? ?= HWMOD_INIT_NO_RESET,
>
> Why is this needed?
...
>> + ? ? .flags ? ? ? ? ?= HWMOD_INIT_NO_RESET,
>
> And this?

I have this because the hwmod complains about a failure in hard reset,
even though the reset deassert does complete after the clock is
enabled. Later on, hwmod will warn again because of a wrong state when
enabling, I believe because of the failure on _setup but didn't dig
into it yet.

Regards,

Omar
