From: lig.fnst@cn.fujitsu.com (lig.fnst at cn.fujitsu.com)
Date: Wed, 23 Apr 2014 02:47:37 +0000
Subject: =?utf-8?B?562U5aSNOiBbUWVtdS1kZXZlbF0gW1BBVENIXSBRRU1VOiBBUk06IGJvb3Q6?=
 =?utf-8?Q?_Load_kernel_at_an_Image_friendly_address?=
In-Reply-To: <CAEgOgz6hQBCD694PL_euJMngDkc7QGPZJuNr+KqTEoG_cHfVSA@mail.gmail.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
 <CAEgOgz6Tou7aOOKsWO2cOaPjWJrkWBFyU-_bApf+ks=qzSKDdA@mail.gmail.com>
 <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
 <CAFEAcA96XGvwPM=OpqW8EU5nFksiEruGgncwqUPEWeU2ryCoJg@mail.gmail.com>
 <534FD87C.4090708@codeaurora.org>
 <CAEgOgz6hQBCD694PL_euJMngDkc7QGPZJuNr+KqTEoG_cHfVSA@mail.gmail.com>
Message-ID: <534C5107B281854290643468BBAAD41F0FCD0D@G08CNEXMBPEKD01.g08.fujitsu.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----????-----
> ???: qemu-devel-bounces+lig.fnst=cn.fujitsu.com at nongnu.org
> [mailto:qemu-devel-bounces+lig.fnst=cn.fujitsu.com at nongnu.org] ?? Peter
> Crosthwaite
> ????: 2014?4?23? 10:20
> ???: Christopher Covington
> ??: Joel Fernandes; Peter Maydell; QEMU Developers; Linux ARM Kernel List
> ??: Re: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
> friendly address
> 
> On Thu, Apr 17, 2014 at 11:34 PM, Christopher Covington
> <cov@codeaurora.org> wrote:
> > On 04/17/2014 06:02 AM, Peter Maydell wrote:
> >> On 2 April 2014 13:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>> On 2 April 2014 13:11, Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> wrote:
> >>>> Like others, I have been carrying this change locally. Good to see it up!
> >>>
> >>> Why are you all booting raw Images anyway (just out of curiosity)?
> >>
> >> Given the recent feedback from the kernel mailing list (viz "don't
> >> boot Image unless you really know what you're doing, the correct load
> >> image may change randomly depending what other board support is in a
> >> multikernel image, etc") maybe we should just remove the Image
> >> booting support instead? Clearly nobody who hasn't locally patched
> >> QEMU is using it at the moment...
> >
> > An opportunity for a fresh start at low-level loading facilities,
> > should anyone be inclined to pursue it, sounds good to me.
> >
> 
> FWIW, im already using my own bootloader out of tree that cuts in on this
> lower level. I'm getting close to be able to throw away -kernel and friends
> completely. 

Me too :-)

To implement I have it as a QOMified device so you just add it on
> the command line:
> 
> qemu-system-foo -device
> loader,image=/path/to/file[,addr=0xdeadbeef][,cpunr=X] 
> To load a particular image to a particular CPU (and it is repeatable).

Why in to a particular CPU?
The motivation is ?

Thanks!

> 
> You can:
> 
> 1: Load elfs and uImages (addr= is ignored)
> 2: Load raw or zImages
> 3: Load data files at arbitrary addresses (cpunr= is ignored)
> 
> With this, you can BYO secondary bootloops or even run multiple guests of
> different CPUs. You can also boot on a non-zeroth CPU. You can place raw
> images wherever you want (the issue in this thread). You can also load in
> firmware to ROMs.
> 
> I then have a tiny hack to make -kernel optional for all ARM.
> Bootloader works for at least ARM and Microblaze, haven't tested for others
> yet.
> 
> Regards,
> Peter
> 
> > Christopher
> >
> > --
> > Employee of Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > hosted by the Linux Foundation.
> >
