From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 09 Oct 2013 10:21:37 +0100
Subject: [PATCH 0/3] KVM: ARM: Cortex-A7 support and fixes
In-Reply-To: <CA+eFSM1Gp4ZrEysN-ib3FxBbVYMrKZO2TdP0XwkF=p68PEyq6Q@mail.gmail.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
 <CA+eFSM1Gp4ZrEysN-ib3FxBbVYMrKZO2TdP0XwkF=p68PEyq6Q@mail.gmail.com>
Message-ID: <52552021.5080800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gavin,

On 08/10/13 15:16, Gavin Guo wrote:
> On Thu, Sep 26, 2013 at 11:49 PM, Jonathan Austin
> <jonathan.austin@arm.com> wrote:
>> This series adds support for using KVM on ARM Cortex-A7 CPUs. As the Cortex-A7
>> is architecturally identical to the A15 there is not a huge amount of code
>> required, however there are a number of fixups necessary to core KVM code that
>> testing on A7 has revealed.
>>
> 
> Hi Jonathan,
> 
> I'd like to help test the kvm on Cortex-A7. I've applied your 3 kernel
> patches, and download the Virtual Open Systems's kvmtools to test. But
> the guest os can't be brought up. Could you provide the steps about
> where to download kvmtools and the command to bring up the guest?
> 

Firstly, if you're on a TC2, you need to make sure the A15s are held
in reset, and you need a shim to boot the kernel in hyp mode. For now
I'll assume you're *not* in that situation.

Assuming your platform does enter the kernel in Hyp mode (it needs to!)
then you need a couple of patches to kvmtool:

http://www.spinics.net/lists/kvm/msg96662.html

At the moment, I think you're still in the business of picking up
individual patches from the list - Will (Deacon) has offered to host
them in his kvm branch but is waiting until the core A7 support is in
Christoffer's 'next'.

Once you've applied the patches, build lkvm and a kernel image, copy them
over to your host, then try something like:

/lkvm run /Image -d /fs.img -m 512 -c 2 --console virtio -p "console=hvc0,38400"

Finally have a check in /proc/cpuinfo to be sure that you've got the kind of CPUs
you were expecting!

Hope that helps,
Jonny
> Thanks,
> Gavin
> 
