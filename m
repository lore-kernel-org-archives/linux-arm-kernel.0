From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 31 Mar 2011 10:17:14 -0400
Subject: [PATCH V3 3/6] MTD : add the database for the NANDs
In-Reply-To: <1301566248.2828.40.camel@localhost>
References: <1301474413-28821-1-git-send-email-b32955@freescale.com>
	<1301474413-28821-4-git-send-email-b32955@freescale.com>
	<201103301046.04357.ffainelli@freebox.fr>
	<4D92F277.7060607@freescale.com>
	<1301566248.2828.40.camel@localhost>
Message-ID: <AANLkTi=59br1KueZupGevB4DgP7UqBKRgbGgRvsjgH-8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

2011/3/31 Artem Bityutskiy <dedekind1@gmail.com>:
> Hi,
>
> On Wed, 2011-03-30 at 17:05 +0800, Huang Shijie wrote:
>> > On Wednesday 30 March 2011 10:40:10 Huang Shijie wrote:
>> >> This is a new database for the NANDs which is searched by the id_bytes.
>> > drivers/mtd//nand/nand_base.c will be able to detect all of your chips listed
>> > below based on the ids present in drivers/mtd/nand/nand_ids.c
>> >
>> yes.
>>
>> But I will use the new database to replace the old one.
>>
>> I will ?submit new patches to modify the generic code if my driver is
>> accepted.
>
> Sorry, but this is not how the opensource community works. The common
> practice everywhere in the kernel is that if the generic code/framework
> is too limiting, you first change the framework, then start using it. We
> do not do things like - I'll first create my custom solution, and then I
> promise I will change the framework.
>

got it.

> Again, this is not just MTD, this is everywhere in the kernel. This is
> how linux goes forward - we force people to improve common code and
> accept their drivers, and everyone benefits form this. Yes, this is more
> work for you, of course, sorry :-)
>
thanks :)

>> > If you have new chips to support in the future, you should add them in
>> > drivers/mtd/nand/nand_ids.c and not keep this file.
>> >
>> The data structure ?nand_flash_dev{} does not contain enough information.
>> So I want to the nand_device_info{} to replace it in future.
>
> Just add this information, if it is of generic nature (like SLC/MLC
> flag, required ECC strength, etc).
>
>> > I still do not understand why this would be needed, is it because the generic
>> > code does not provide enough informations for your driver?
>> >
>> yes.
>>
>> IMHO, the generic code is somehow trapped in a wrong way. :(
>
> Fix this please :-)
>
>> Paring the id bytes is not sufficient to get all the information you
>> need which is faced by me.
>
> Fix this too :-)
>
>> What's more, I think the paring code is ugly, see the nand_get_flash_type().
>
> You are welcome to fix this. There is _a lot_ of ugly code in MTD
> because no one loves it. Give it some love :-)
>
>> Why not create a new database which contains all the necessary
>> information for a nand, and can be easy
>> find by the id bytes as the keyword?
>
> You can create this database by extending/improving/cleaning up the
> existing code base with a nice series of patches.
>
ok. I will try to fix the generic code before my driver is submitted.

Best Regards.

> --
> Best Regards,
> Artem Bityutskiy (????? ????????)
>
>
