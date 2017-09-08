From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 8 Sep 2017 15:55:53 +0100
Subject: [PATCH v11 4/6] target-arm: kvm64: detect guest RAS EXTENSION
 feature
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2015F5973@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015F5973@DGGEMA503-MBX.china.huawei.com>
Message-ID: <CAFEAcA-tCv9HAG4JzgHbW9VC77tYYFD=rp=b1BoKN7UayWc0yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2017 at 15:26, gengdongjiu <gengdongjiu@huawei.com> wrote:


>> Shouldn't we need to also tell the kernel that we actually want
>> it to expose RAS to the guest? Compare the PMU code in this function,
>> where we set a kvm_init_features bit to do this.

> In the PMU code, it indeed sets a kvm_init_features bit. Here ARM
> James has a concern that we are depend on the host CPU RAS extension,
> He means that if userspace receives the SIGBUS delivered by host
> memory_failure(), user space should record the CPER for guest
> and handling the error regardless whether host CPU supports RAS
> extension. But I think if user space receives the SIGBUS signal,
> that means
> host CPU RAS module detects the error or CPU consumes the poison
> data, thus we should check whether physical CPU support RAS extension.

I don't understand what you have in mind here. If the host does
not support the CPU RAS extension then we should never get a
SIGBUS in the first place.

In any case this doesn't seem relevant to the question of whether it
should be optional to expose the RAS extension to the *guest*.
Even if the host does support RAS, you should be able to run a
VM that knows nothing about RAS.

thanks
-- PMM
