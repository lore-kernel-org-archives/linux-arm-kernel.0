From: john.stultz@linaro.org (John Stultz)
Date: Tue, 28 Feb 2017 15:50:31 -0800
Subject: [PATCH 4/5] ARM: dts: qcom-apq8064: Collapse usb support into one
 node
In-Reply-To: <20170127004728.22490-5-stephen.boyd@linaro.org>
References: <20170127004728.22490-1-stephen.boyd@linaro.org>
 <20170127004728.22490-5-stephen.boyd@linaro.org>
Message-ID: <CALAqxLVeqn0GJGQsYtkiX454q5Q1OsnJTCBAh4kG-0jWjByTdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 4:47 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> We currently have three device nodes for the same USB hardware
> block, as evident by the reuse of the same reg address multiple
> times. Now that the chipidea driver fully supports OTG with the
> MSM wrapper we can collapse the three nodes into one USB device
> node, reflecting the true nature of the hardware.
>
> Since we're here, we also mark the irq trigger flags correctly,
> as IRQ_TYPE_LEVEL_HIGH instead of IRQ_TYPE_NONE.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>


Applies with noise now, but I was able to get USB working with this
and some changes to my config.

Hotplug still doesn't work, but that was the same situation before as
well, so I need to dig on that.

So..
Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
