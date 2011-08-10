From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 10 Aug 2011 19:06:48 +0530
Subject: [RFC][PATCH 2/2] spi: s3c64xx: Use clkdev for bus clock lookup
In-Reply-To: <CAAgF-Bf=K8M9Qp8EwFTuUY06H4SPNY5cW2Ct3K9FecMLvBHmuA@mail.gmail.com>
References: <1312898301-7229-1-git-send-email-padma.v@samsung.com>
	<CABb+yY1Be3q+5QVaLYnonOUq1VtjyCZMKp0S1yryjF2HRyqoSw@mail.gmail.com>
	<CAAgF-Bf=K8M9Qp8EwFTuUY06H4SPNY5cW2Ct3K9FecMLvBHmuA@mail.gmail.com>
Message-ID: <CABb+yY1tCBK3Hywi_7TuBCc830BP7+C2GRoQxeKWU5OHXenjRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 5:33 PM, padma venkat <padma.kvr@gmail.com> wrote:
> Hi Jassi,
>
> On Tue, Aug 9, 2011 at 6:13 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Tue, Aug 9, 2011 at 7:28 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
>>> SPI driver is modified to lookup the bus clock using the
>>> alias name instead of getting clock name and clock
>>> number from platform data.
>> Cool.
>>
>>> Driver is modified to get the best source clock among the
>>> available source clocks for the required frequency.
>> I am not sure if this driver should be deciding which clock is 'best' for it.
>> Because ...
>> 1) Usually it's the board designer who decides which clock to run at
>> ?what speed based upon target device. So ideally, based upon use-case
>> the driver should simply get the 'best' clock from board via platform in a
>> format that is compliant to the 'generic clock api'.
> As per your comment I modified the code for board designer to supply the
> required list of source clocks. If this list is NULL then it ?uses the
> all available
> clock sources. I will resubmit this patch.
No dear. Not a list of clocks (that is property of the platform - not a board).
But get just one 'generic clock api' compliant clock from the board and use
it.
That will keep the driver simple for sure and IIUIC, in future anyways DT would
specify source clock for each peripheral. Grant ?
