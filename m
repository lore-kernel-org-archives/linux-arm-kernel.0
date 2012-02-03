From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 3 Feb 2012 13:34:55 +0530
Subject: [RFC/PATCH] arm: omap3: pm: do not clear power states twice
In-Reply-To: <1328254094-13978-1-git-send-email-balbi@ti.com>
References: <1328254094-13978-1-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gwtXyLzPNk2_4O+EAWyZaQs+wY_cK4pm_=yJj6ARXnhAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2012 at 12:58 PM, Felipe Balbi <balbi@ti.com> wrote:
> The way the code is written, pwrdm_pre_transion()
> calls _pwrdm_pre_transition_cb() (for each powerdomain)
> which, in turn, calls pwrdm_clear_all_prev_pwrst().
>
> It looks unnecessary to clear all previous power
> states twice, so drop the initial set.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
> Hasn't been tested yet. Compile tested only. It looks
> like we can safely remove those calls, but I would
> like to hear from the PM folks first :-)
>
Bit late :)

Paul already cleaned this up.
http://www.spinics.net/lists/linux-omap/msg63602.html

Regards
santosh
