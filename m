From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Wed, 18 Jun 2014 17:38:14 +0530
Subject: Build error - vmlinux.lds [Re: linux-next: Tree for Jun 18]
In-Reply-To: <20140618115602.GA32514@n2100.arm.linux.org.uk>
References: <CAK5sBcEpXboRVD-KzzjBJMi+LF-jhdt_HUYEz7wkJtFAv+BLcg@mail.gmail.com>
 <20140618115602.GA32514@n2100.arm.linux.org.uk>
Message-ID: <CAK5sBcEg1XYQmzshxdLDHFCYFiawV0d8rt7aeAkPoiPhNMX1CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 5:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jun 18, 2014 at 04:50:43PM +0530, Sachin Kamat wrote:
>> Hi,
>>
>> I observe the following build error while building uImage for ARM.
>>
>>   Kernel: arch/arm/boot/Image is ready
>> make[2]: *** No rule to make target
>> `arch/arm/boot/compressed/vmlinux.lds', needed by
>> `arch/arm/boot/compressed/vmlinux'.  Stop.
>> make[1]: *** [arch/arm/boot/compressed/vmlinux] Error 2
>> make: *** [uImage] Error 2
>
> Works fine here against an empty object tree:
>
> http://www.arm.linux.org.uk/developer/build/file.php?lid=9591
>
> Are you building into an already-built object tree or rebuilding an
> already built tree?

I did a clean build after updating the tree to next-20140618.
git status show me the following after doing make clean

# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#    deleted:    arch/arm/boot/compressed/vmlinux.lds.S


My tip of kernel points to commit 4ca1fbc122fcb ("Add linux-next specific
files for 20140618")

>
> This is likely caused by make getting confused over the dependencies.
> I suggest making clean to recover from this error.

I get this error when I do a clean build too.

Regards,
Sachin.
