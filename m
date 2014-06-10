From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 10 Jun 2014 19:08:39 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <53973AA8.9020301@codeaurora.org>
References: <20140328184517.GA27219@cbox>
 <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
 <53973AA8.9020301@codeaurora.org>
Message-ID: <CAFEAcA8RttCvbOAw-m-W6C-mh1o4hj6nqGMkDbRsSF6ZoQZ7Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 June 2014 18:04, Christopher Covington <cov@codeaurora.org> wrote:
> On 06/10/2014 10:42 AM, Peter Maydell wrote:
>> I just noticed that this doesn't mandate that the platform
>> provides an RTC. As I understand it, the UEFI spec mandates
>> that there's an RTC (could somebody more familiar with UEFI
>> than me confirm/deny that?) so we should probably put one here.
>
> Pardon my ignorance, but what exactly disqualifies Generic Timer
> implementations from being used as Real Time Clocks?

So my naive view was that an RTC actually had to have
support for dealing with real (wall) clock time, ie
knowing it's 2014 and not 1970. The generic timers are
just timers. Or am I wrong and UEFI doesn't really
require that?

It's also handy if you're booting Linux directly without
UEFI, since it means you can actually have a /dev/rtc0
(and QEMU's implementation at least will correctly give
you the time based on the host's RTC).

thanks
-- PMM
