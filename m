From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Wed, 4 Oct 2017 21:49:37 +0900
Subject: defconfig'ed v4.13 does not boot on ThunderX
In-Reply-To: <20171004100641.GA23092@leverpostej>
References: <135495b6-e13e-5c90-6130-addb60d0fa5c@riken.jp>
 <20171004100641.GA23092@leverpostej>
Message-ID: <90797628-6432-f38b-88c9-6f544f237a5f@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,
I tried to bring up it adding earlycon=p1011,0x87e024000000
but no luck. Not sure if that's the right value to feed either though.

Itaru

On 2017/10/04 19:08, Mark Rutland wrote:
> On Wed, Oct 04, 2017 at 04:25:58PM +0900, Itaru Kitayama wrote:
>> Hi,
> 
> Hi,
> 
>> defconfig'ed kernel v4.13 does not boot on ThunderX, leaving only
>> messages below:
>>
>> EFI stub: Booting Linux Kernel...
>> EFI stub: Using DTB from configuration table
>> EFI stub: Exiting boot services and installing virtual address map...
> 
> These are all message from the EFI stub. It's likely that we get into
> the kernel proper, but it dies before bringing up the usual console.
> 
> Can you try booting with 'earlycon' on the kernel commandline? That
> might get some early boot-time console output.
> 
> Thanks,
> Mark.
> 
