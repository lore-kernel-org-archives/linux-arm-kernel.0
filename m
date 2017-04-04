From: stuartl@longlandclan.id.au (Stuart Longland)
Date: Tue, 4 Apr 2017 10:39:53 +1000
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <alpine.LFD.2.20.1704022040380.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
 <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
 <alpine.LFD.2.20.1704022040380.1847@knanqh.ubzr>
Message-ID: <821bef75-3c16-a7f2-ea15-de711d1d9eb8@longlandclan.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/17 11:01, Nicolas Pitre wrote:
> On Mon, 3 Apr 2017, Stuart Longland wrote:
>> On 03/04/17 07:41, Nicolas Pitre wrote:
>>>> No PTYs seems like a big limitation. This means no sshd?
>>> Again, my ultimate system target is in the sub-megabyte of RAM.  I 
>>> really doubt you'll be able to fit an SSH server in there even if PTYs 
>>> were supported, unless sshd (or dropbear) can be made really tiny. 
>>> Otherwise you most probably have sufficient resources to run the regular 
>>> TTY code.
>>
>> Are we talking small microcontrollers here?  The smallest machine in
>> terms of RAM I ever recall running Linux on was a 386SX/25 MHz with 4MB
>> RAM, and that had a MMU.
> 
> Not to repeat what I've said already, I invite you to have a look at 
> https://lkml.org/lkml/2017/3/24/634
> 
>> I recall Slackware requiring that you booted with a mounted floppy (no
>> ramdisk) and possibly even required that you had a second floppy drive
>> formatted as swap so you'd be able to get through the install without
>> oomkiller knocking on your door.
> 
> Did the oom killer even exist in those days? I don't remember.
> All I remember is the stack of 73 flopies or so to install Slackware... 
> and of course floppy #68 would have developed a bad sector preventing 
> you from completing the installation.

It probably didn't, my memory is a bit hazy, even though the machine in
question was long obsolete by the time I did this experiment.  The
version of Slackware was pretty old by that time too.

Luckily for me, I had a network, I could mount the CD disk sets over NFS
that way, and so the only floppies I had to worry about were the boot
and root floppies.

But I digress? :-)

>> Sub-megabyte system support is a noble goal, but I'm wondering how
>> practical such systems would be, and whether an embedded real-time
>> kernel might be a better choice than Linux on such systems.
> 
> Obviously, you need to leave the idea of a _distribution_ behind. If you 
> think of a single user app, and a kernel that only provides those 
> syscalls used by that app, and the minimal subset of kernel services 
> that such an app require, then nothing prevents such and app/kernel from 
> using the actual Linux API. And that's where you get a big advantage 
> over other RTOSes. See the link above for the full rationale.

Fair enough? so basically using the Linux kernel in place of an embedded
kernel like FreeRTOS or eCos.  Still, as I say a noble goal, I wish the
project well.  I guess it can be our answer to RetroBSD. :-)
-- 
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/6971d352/attachment.sig>
