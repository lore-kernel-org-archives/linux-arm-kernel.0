From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 10 May 2012 14:42:30 +0530
Subject: [PATCH 1/7] mmc: dw_mmc: lookup for optional biu and ciu clocks
In-Reply-To: <20120502095311.GZ24211@n2100.arm.linux.org.uk>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
 <20120502095311.GZ24211@n2100.arm.linux.org.uk>
Message-ID: <CAJuYYwSJ8FBQiykcyym9Gg1jVoW+rGZmjtHfy4zgcDEX6edOEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 May 2012 15:23, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, May 01, 2012 at 10:07:40PM -0700, Thomas Abraham wrote:
>> Some platforms allow for clock gating and control of bus interface unit clock
>> and card interface unit clock. Add support for clock lookup of optional biu
>> and ciu clocks for clock gating and clock speed determination.
>
> As we're moving progressively towards the common clk API, which requires
> the new clk_prepare/clk_unprepare calls, new code should be using the
> dated API. ?Please update this to do so (eg, by using clk_prepare_enable()
> instead of clk_enable() for the simple solution.) ?Better solutions
> involve decoupling the two and only using clk_enable()/clk_disable() where
> you really need the clock to be on.

Thanks for your suggestion. I will modify this to use the
clk_prepare_enable and clk_disable_unprepare calls for now.

Thanks,
Thomas.
