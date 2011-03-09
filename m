From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 9 Mar 2011 18:33:34 +0530
Subject: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial
	driver
In-Reply-To: <alpine.DEB.2.00.1103081849360.15132@utopia.booyaka.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
	<1298903958-6496-6-git-send-email-govindraj.raja@ti.com>
	<87r5am499h.fsf@ti.com>
	<AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com>
	<87hbbdjc7y.fsf@ti.com>
	<alpine.DEB.2.00.1103081849360.15132@utopia.booyaka.com>
Message-ID: <AANLkTi=wqZc2UCNcj-DyuTcVBwaKiddsxdBF3XEwkhTH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2011 at 7:32 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi Govindraj,
>
> what also would be good to find out is why the UART is apparently sending
> asynchronous wakeups even when the driver doesn't set
> SCR_REG.RX_CTS_WU_EN. ?This seems contrary to the expectation that 34xx
> TRM vZH section 17.4.4.1.4.1 "Wake-up Interrupt" sets. ?Could you please
> clarify under which circumstances the RX_CTS_WU_EN bit is used? ?I suppose
> that, given that it's also mentioned under section 17.4.5.1.1 "Module
> Power Savings", it might only be used when SLEEP_MODE is enabled.
>

AFAIK, sleep_mode is used only for uart internal power saving
options if fifo's are empty which inturn can stop uart internal baud clock.
To enable back uart baud clock and start uart internal activity it
will depend on RX_CTS_WU_EN from scr to restart uart_baud_clock.

For system level powers saving like cutting uart_fclks
wakeup will depend on WER reg for wakeup event or io-pad
wakeup depending on power state.
Since I am cutting fclks directly I am depending on
WER reg wakeup events.

--
Thanks,
Govindraj.R


>
> - Paul
>
