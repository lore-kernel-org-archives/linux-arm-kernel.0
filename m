From: robherring2@gmail.com (Rob Herring)
Date: Thu, 17 Apr 2014 11:58:21 -0500
Subject: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
 friendly address
In-Reply-To: <CAFEAcA96XGvwPM=OpqW8EU5nFksiEruGgncwqUPEWeU2ryCoJg@mail.gmail.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
 <CAEgOgz6Tou7aOOKsWO2cOaPjWJrkWBFyU-_bApf+ks=qzSKDdA@mail.gmail.com>
 <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
 <CAFEAcA96XGvwPM=OpqW8EU5nFksiEruGgncwqUPEWeU2ryCoJg@mail.gmail.com>
Message-ID: <CAL_JsqKxsR6-pKv9sP4z1nnp+sy7GncGDyL+kMkF60efn2=DsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 5:02 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 2 April 2014 13:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 2 April 2014 13:11, Peter Crosthwaite <peter.crosthwaite@xilinx.com> wrote:
>>> Like others, I have been carrying this change locally. Good to see it up!
>>
>> Why are you all booting raw Images anyway (just out of curiosity)?
>
> Given the recent feedback from the kernel mailing list (viz "don't boot
> Image unless you really know what you're doing, the correct load
> image may change randomly depending what other board support
> is in a multikernel image, etc") maybe we should just remove the
> Image booting support instead? Clearly nobody who hasn't locally
> patched QEMU is using it at the moment...

Including AArch64, too? :) It happens to be correct ATM, but really we
should be looking the Image header to determine the offset. I heard
Mark Rutland has some patches to do TEXT_OFFSET randomization in fact.

The choice of 0x10000 is not really a good one either as this forces
the decompressor to move itself out of the way first. I guess it is a
good choice if your goal is to test the worst possible code path for
the decompressor.

Rob
