From: josh.coombs@gmail.com (Josh Coombs)
Date: Tue, 17 Jul 2012 08:32:35 -0400
Subject: Device tree.
In-Reply-To: <500556CF.6030704@codethink.co.uk>
References: <500552C9.4090107@codethink.co.uk> <20120717140100.7c0ae90c@skate>
 <500556CF.6030704@codethink.co.uk>
Message-ID: <CAMW5UfZR5qrY4K=ty9HDcd9UqYGtfZitH0CBgDbZWvpAoTve2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 8:13 AM, Ian Molton <ian.molton@codethink.co.uk> wrote:
> On 17/07/12 13:01, Thomas Petazzoni wrote:
>>
>> You surely want to have a look at CONFIG_ARM_APPENDED_DTB, which does what
>> you want and is already part of the ARM kernel.
>
>
> Hi, and thanks.
>
> Unless I'm misunderstanding it, thats not quite what I need - although I
> should probably have made my hack depend on it.
>
> I'm using a uImage; The prepending needs to happen to the zImage / Image.
>
> -Ian

CONFIG_ARM_APPENDED_DTB sets the kernel up to expect a dtb appended to
the end of the zImage.  Neither make or make uImage do the appending
for you however.  What I've been doing is:

make
make target.dtb
cat arch/arm/boot/target.dtb >> arch/arm/boot/zImage
make uImage
move arch/arm/boot/uImage to wherever it needs to be and try booting

My understanding is you can only append one DTB, there is no
restriction on how many systems a given kernel could support, so at
the moment there isn't a clean way of defining which DTB to append
during make uImage?

Josh C
