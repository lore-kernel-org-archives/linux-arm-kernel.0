From: john.stultz@linaro.org (John Stultz)
Date: Fri, 1 Jul 2016 23:03:38 -0700
Subject: [PATCH 00/21] Support qcom's HSIC USB and rewrite USB2 HS phy
 support
In-Reply-To: <146710289677.3879.15364764209076318827@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <CALAqxLUHfsJBTQS=p5oThnOdiAZwu48puRhREx+2G9+KajDA9g@mail.gmail.com>
 <146710289677.3879.15364764209076318827@sboyd-linaro>
Message-ID: <CALAqxLW--yFb2YwX3+x7PB-g_5D0gb6j8CiJwnCC+meb7xqbig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 1:34 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Quoting John Stultz (2016-06-27 20:09:30)
>>
>> I haven't yet been able to test with this, as I need some other fixes
>> it seems too to deal with some of the iommu changes in my flo-WIP tree
>> (it can't find of_dma_configure), but will let you know how things
>> work once I have all that sorted.
>
> Cool, thanks for testing.

So after working out some merge issues w/ my flo-WIP branch for the
nexus7, I was still having trouble, so I backed out to just your
(updated) branch.

But even there, I'm not able to get the usb gadget up. I see:

[    1.869717] msm_hsusb 12500000.usb: failed to get phandle in
/soc/usb at 12500000 node
[    1.882347] 12500000.usb supply vbus not found, using dummy regulator

So I'm not sure if the dts changes were quite right. I've got all the
ULPI configs enabled. Any ideas?

thanks
-john
