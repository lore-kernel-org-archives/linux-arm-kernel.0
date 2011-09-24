From: sjg@chromium.org (Simon Glass)
Date: Fri, 23 Sep 2011 21:10:30 -0700
Subject: [RFC PATCH 0/3] Add accurate boot timing to a Linux system
In-Reply-To: <37959.1316820861@turing-police.cc.vt.edu>
References: <1316818998-30711-1-git-send-email-sjg@chromium.org>
	<37959.1316820861@turing-police.cc.vt.edu>
Message-ID: <CAPnjgZ3P0aHbvXagd0QsxmRCw+1mTWNZb6HhwJheTd8XL1-6Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 4:34 PM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Fri, 23 Sep 2011 16:03:15 PDT, Simon Glass said:
>> This experimental patch set adds boot timing to a Linux system. The
>> timing starts with the boot loader and extends through the kernel into
>> user space to the completion of the boot process. The timing starts when
>> the system leaves reset, not later when the kernel starts.
>> The bootstage record aims to provide 20-30 timestamps ranging from reset
>> to login prompt (or some other definition of completion).
>
> Any way to make this play nice with bootchart, which provides much finer
> detail records once userspace gets started?
>
> https://github.com/mmeeks/bootchart

It would be great to collect CPU utilization, disk activity, etc. in
the boot loader and the kernel start-up. I don't know if we have the
hooks for that though.  Everything seems to be based around user space
at the moment. Still, we could integrate in the sense that it could
show the various boot stages on the chart. Could be useful.

Regards,
Simon

>
>
>
