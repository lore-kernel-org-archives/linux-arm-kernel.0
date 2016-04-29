From: dianders@chromium.org (Doug Anderson)
Date: Fri, 29 Apr 2016 13:04:48 -0700
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
In-Reply-To: <20160429195741.GY19428@n2100.arm.linux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk>
 <CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
 <20160429195741.GY19428@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, Apr 29, 2016 at 12:57 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> * Presumably on a PC you've got an extra bit in the middle (like grub
>> or something like that) that can help you resolve your UUIDs even if
>> you get your kernel from somewhere else.
>
> You are over-estimating what grub does.  Grub doesn't resolve UUIDs at
> all.  Grub just passes the kernel arguments in its configuration file
> for the entry it is booting to the kernel.  It's a static configuration
> found in /boot/grub/grub.conf.
>
> It doesn't probe devices for UUIDs.

OK.  The point was: if folks on PCs have a workflow that works for
them, wonderful.  That workflow doesn't work so great for me.  My
workflow doesn't hurt them.  Why is it bad?


>> * Presumably in the non-embedded world kernel hackers have a different
>> workflow.  They probably don't swap between different devices with
>> different configurations on an hourly basis.  They're not in the habit
>> of totally reimaging their system periodically.  Etc.  Trying to force
>> the workflow of a PC kernel hacker and an embedded kernel hacker to be
>> the same doesn't seem like a worthwhile goal.
>
> In _my_ world with the "embedded" devices I have, I mount by UUID on
> platforms which have multiple MMC devices to avoid exactly the problem
> you're having.  This works fine.
>
> If I were to switch the SD card, and I wanted to avoid changing the
> boot loader configuration, I'd use label instead, and I'd label all
> the SD card rootfs using the same label so I could just swap the cards.

OK.  The point was: if you have a workflow that works for you,
wonderful.  That workflow doesn't work so great for me.  My workflow
doesn't hurt you.  Why is it bad?


>> * Presumably an embedded kernel hacker running with ATA / SCSI could
>> _usually_ assume that "sda" is his/her root filesystem.  It's unlikely
>> an embedded system would have more than one "sda" disk builtin and
>> it's nearly guaranteed (I think) that a builtin ATA / SCSI controller
>> would probe before any USB based devices.
>
> You've got a funny view again.  N2100 has two hard disks.  The clearfog
> board from SolidRun has two mini-PCIe slots, each of which can have two
> SATA interfaces... If you want to use it as a server-type platform with
> lots of disks...

OK.  The point was: if you have a workflow that works for you,
wonderful.  That workflow doesn't work so great for me.  My workflow
doesn't hurt you.  Why is it bad?


>> Sure, if your root
>> filesystem is USB based (really?) and you've got additional USB
>> storage devices then you're SOL.  Sorry.
>
> One of my Versatile Express platforms boots from USB, and has a MMC
> slot...  So this argument does not stack up.

OK.  The point was: if you have a workflow that works for you,
wonderful.  That workflow doesn't work so great for me.  My workflow
doesn't hurt you.  Why is it bad?


-Doug
