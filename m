From: peter.crosthwaite@xilinx.com (Peter Crosthwaite)
Date: Wed, 2 Apr 2014 22:58:20 +1000
Subject: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
 friendly address
In-Reply-To: <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
 <CAEgOgz6Tou7aOOKsWO2cOaPjWJrkWBFyU-_bApf+ks=qzSKDdA@mail.gmail.com>
 <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
Message-ID: <CAEgOgz4gxyDd+LSC+TF2bi_kKsvA8Uo2+iGx3U-ygFS1rngfzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 10:47 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 2 April 2014 13:11, Peter Crosthwaite <peter.crosthwaite@xilinx.com> wrote:
>> Like others, I have been carrying this change locally. Good to see it up!
>
> Why are you all booting raw Images anyway (just out of curiosity)? All my
> test cases boot either a zImage or a uImage, or occasionally a full SD card
> image, or I'd have noticed this earlier...
>

Simplicity more than anything. It is much easier to debug against
head.S (esp. with the -d in_asm option), when you can see the head.s
asm as the very first thing the CPU executes. Otherwise you gotta
filter out the zImage stuffs. There have also been occasions where I
have broken QEMU locally as part of some random work-in-progress
development such that the zImage head doesnt work and i'd rather just
move my debug efforts to kernel proper. None of them are fantastic
reasons from a user perspective but it's just a little easier on
developing.

Regards,
Peter

> thanks
> -- PMM
>
