From: agraf@suse.de (Alexander Graf)
Date: Wed, 9 Jan 2013 23:34:16 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <CANM98qJDvC4jUdvGZMb_o91DdSOTGJg4M2cNsw_LmF7ncLidGQ@mail.gmail.com>
References: <4F8BA51C-1A21-4ED9-80CE-55ECB01C0AAD@suse.de>
 <1357769438.18196.5@snotra>
 <CANM98qJDvC4jUdvGZMb_o91DdSOTGJg4M2cNsw_LmF7ncLidGQ@mail.gmail.com>
Message-ID: <C621FD3F-6726-435E-8E6A-0E9A5661443D@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09.01.2013, at 23:26, Christoffer Dall wrote:

> On Wed, Jan 9, 2013 at 5:10 PM, Scott Wood <scottwood@freescale.com> wrote:
>> On 01/09/2013 03:37:20 PM, Alexander Graf wrote:
>>> 
>>> 
>>> 
>>> Am 09.01.2013 um 22:15 schrieb Scott Wood <scottwood@freescale.com>:
>>> 
>>>> I get that there's a tradeoff between getting something in now, versus
>>>> waiting until the API is more refined.  Tagging it with a particular ISA
>>>> seems like an odd way of saying "soon to be deprecated", though.  What
>>>> happens if we're still squabbling over the perfect replacement API when
>>>> we're trying to push PPC MPIC stuff in?
>>> 
>>> Then we're the ones who have to come up with a good interface.
>> 
>> 
>> How about another bad one, with PPC in the name, and some pleas to hurry
>> things up? :-)
>> 
>> It's not as if there haven't been last-minute requests for API changes on
>> the PPC side in the past...
>> 
>> 
> 
> This is getting out of hand.
> 
> Do you have another API for PPC, which was send for review and not
> commented on several months ago that we can unify right now?
> 
> If not, let's go with the ARM name and work on the generic API in the mean time.
> 
> The end result will be something along 5 lines in a header files and 3
> lines in a switch case that return -EINVAL if the interface is
> completely deprecated later on, which is not a big problem.

Agreed [1].

So what exactly are we waiting for? Acks from kvm maintainers, right?


Alex

[1] It'd probably end up being an ioctl that converts from one calling convention to another, resulting in maybe 5 lines in the switch case.
