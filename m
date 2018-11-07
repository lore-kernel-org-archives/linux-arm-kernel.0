From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Nov 2018 16:46:47 +0100
Subject: [RFC PATCH 00/12] net: introduce Qualcomm IPA driver
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Message-ID: <CAK8P3a15nTnL0tD4TJgtPVEKFwZRcyNy=m6_Pi3+8Nd0W6FQtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> The code has undergone considerable rework to prepare it for
> incorporation into upstream Linux.  Parts of it bear little
> resemblance to the original driver.  Still, some work remains
> to be done.  The current code and its design had a preliminary
> review, and some changes to the data path implementation were
> recommended.   These have not yet been addressed:
> - Use NAPI for all interfaces, not just RX (and WAN data) endpoints.
> - Do more work in the NAPI poll function, including collecting
>   completed TX requests and posting buffers for RX.
> - Do not use periodic NOP requests as a way to avoid TX interrupts.
> - The NAPI context should be associated with the hardware interrupt
>   (it is now associated with something abstracted from the hardware).
> - Use threaded interrupts, to avoid the need for using spinlocks and
>   atomic variables for synchronizing between workqueue and interrupt
>   context.
> - Have runtime power management enable and disable IPA clock and
>   interconnects.
> Many thanks to Arnd Bergmann, Ilias Apalodimas, and Bjorn Andersson
> for their early feedback.

Thanks for getting the current version out even with the long TODO
list. I've had my first deeper look at some of the patches and found
a few more things that likely require substantial rework. I also think
there is still significant room for simplifying it further, and getting
better performance out of it in the process.

Also, despite the criticism in my patch review, I have to say you've
done a great job at cutting out a lot of the things that were present
in the past, it's good to see that you have come this far with the
cleanup!

      Arnd
