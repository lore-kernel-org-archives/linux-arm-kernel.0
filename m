From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 May 2015 18:13:56 -0700
Subject: [PATCHv8 03/10] watchdog: core: Introduce default watchdog policy
In-Reply-To: <1432023969-20736-4-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
 <1432023969-20736-4-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <555BDFD4.6050003@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
> Traditionally there have been no such thing as a policy for
> watchdogs. The watchdog timer was simply explicitly stopped at driver
> probe time and there was nothing else to do. Now that we have ability
> to work around HW disabilities in the watchdog core, it is time to
> introduce more policy options.
>
> The default option is to shut down the watchdog driver, as
> before. This ensures backward compatibility with current kernels and
> hardware that might have a watchdog, but user has not set up a
> watchdog daemon at all.
>
> A new option is introduced to keep the watchdog running or start it up
> at boot up. This is useful on many production systems that rely on the
> watchdog to reboot the device in case a crash. With this option even
> early kernel crashes or early user space crashes will lead to a reboot
> even though watchdog daemon has not opened and started the watchdog
> device yet.
>
> The third introduced option is to not touch the hardware at all in
> case bootloader have made an intelligent decision about the watchdog
> state and does not know how to tell kernel about it. The watchdog
> state is not touched until userspace takes over it.
>
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>

Dislike. I don't think it is a good idea to have configuration options
like this. This means users will have to deal with those "default"
options for an entire distribution, which I don't think is desirable.
Maybe for you, but not for everyone, and definitely not for me.

I think you are trying to do too much in your patch set.
Can we possibly focus on getting early timeout to an acceptable form
instead of trying to do everything at the same time.

Guenter
