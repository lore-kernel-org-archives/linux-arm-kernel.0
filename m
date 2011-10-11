From: govindraj.ti@gmail.com (Govindraj)
Date: Tue, 11 Oct 2011 12:15:36 +0530
Subject: [PATCH v6 05/16] OMAP2+: UART: Cleanup part of clock gating
	mechanism for uart
In-Reply-To: <87ty7gfpik.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-5-git-send-email-govindraj.raja@ti.com>
	<87ty7gfpik.fsf@ti.com>
Message-ID: <CAAL8m4ygQfZZ-FX_o+AyVWrQNghyHCsp0vdiCV_QHGxXFXzDKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 4:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Currently we use a shared irq handler to identify uart activity and then
>> trigger a timer.
>
> OK.
>
>> Based the timeout value set from sysfs the timer used to expire.
>
> Please re-phrase as I'm not sure what is being said here.
>
>> If no uart-activity was detected timer-expiry func sets can_sleep
>> flag. Based on this we will disable the uart clocks in idle path.
>>
>> Since the clock gating mechanism is outside the uart driver, we currently
>> use this mechanism. In preparation to runtime implementation for omap-serial
>> driver we can cleanup this mechanism and use runtime API's to gate uart clocks.
>>
>> Also remove timer related info from local uart_state struct and remove
>> the code used to set timeout value from sysfs. Remove un-used function
>> omap_uart_check_wakeup.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> The patch itself fine, and is a well-neede cleanup, but changelog
> (especially the first part) does not read well.
>

Okay, Will Correct.

--
Thanks.
Govindraj.R
