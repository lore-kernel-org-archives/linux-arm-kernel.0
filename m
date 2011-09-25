From: bhelgaas@google.com (Bjorn Helgaas)
Date: Sun, 25 Sep 2011 06:54:26 -0600
Subject: [RFC PATCH 0/3] Add accurate boot timing to a Linux system
In-Reply-To: <1316818998-30711-1-git-send-email-sjg@chromium.org>
References: <1316818998-30711-1-git-send-email-sjg@chromium.org>
Message-ID: <CAErSpo63fYmQVRO2O3sB37k6rAo7Qttdh1xo=WH+QwcVb+neGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 5:03 PM, Simon Glass <sjg@chromium.org> wrote:
> This experimental patch set adds boot timing to a Linux system. The
> timing starts with the boot loader and extends through the kernel into
> user space to the completion of the boot process. The timing starts when
> the system leaves reset, not later when the kernel starts.
>
> The concept is:
> - Boot loader records a timestamp for key events during its operation
> - These timestamps are passed to Linux, which adds more as it boots
> - These timestamps are made available to user space, where more
> timestamps are added as init does its job
> - Finally the whole record is collected by a user-space script run at
> the end of init. This is fed back through some mechanism to monitor
> boot time in the field.

I think this is a cool idea.  It's quite difficult to extract this
sort of information today, and making it easily and consistently
available should help focus attention and improve things.

There are difficult issues about which clock to use, how to correlate
bootloader & kernel timestamps, how to make sure the timestamps stay
sensible even when we use hwclock, ntp, etc., but I think it's worth
pushing on this to see how far you can go.

Bjorn
