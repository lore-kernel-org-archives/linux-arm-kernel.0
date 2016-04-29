From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 29 Apr 2016 17:53:17 +0300
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <20160428092608.GE17159@lukather>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
 <20160425115758.GA4874@lukather>
 <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
 <20160428092608.GE17159@lukather>
Message-ID: <5723755D.9060108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/04/16 12:26, Maxime Ripard wrote:
> On Tue, Apr 26, 2016 at 12:41:29PM +0200, Linus Walleij wrote:
>> On Mon, Apr 25, 2016 at 1:57 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>> On Sat, Apr 23, 2016 at 11:43:58AM +0200, Linus Walleij wrote:
>>>> Hi ARM SoC guys,
>>>>
>>>> these two patches move the ARM character LCD driver from
>>>> misc drivers to the auxdisplay subsystem where it belongs and
>>>> updates the defconfig for the RealView accordingly.
>>>>
>>>> Please pull it into some cleanup branch in the ARM SoC
>>>> tree.
>>>>
>>>> I tried to get some ACK from the auxdisplay maintainer but no
>>>> reaction.
>>>
>>> Auxdisplay is not a new framework, but rather a very old one.
>>>
>>> It got introduced in 2.6.21, and only received a couple of drivers
>>> since.
>>
>> Small problem for me, but Robin is submitting a brand new
>> auxdisplay driver:
>> http://marc.info/?l=linux-kernel&m=146001950512999&w=2
>> http://marc.info/?l=linux-kernel&m=146001988013230&w=2
> 
> My understanding is that Tomi doesn't want any new fbdev drivers, so
> I'm not sure this is the right place for those patches.

Hmm, that one looks like an fbdev driver, not an auxdisplay driver. But,
not relevant for this patch, of course.

>>> It seems to be quite redundant with fbdev deferred_io, which itself is
>>> almost deprecated these days.
>>
>> That is a valid argument for moving cfag12864b* out to
>> drivers/video/* I guess, but it has nothing to do with this
>> driver whatsoever.
>>
>> This driver has nothing to do with fbdev. Nothing at all.
>> It so not connected to any framebuffer.
>>
>> This driver gets moved to auxdisplay to match the existing
>> LCD driver in drivers/auxdisplay/ks0108.c which is a similar
>> hardware, driving an LCD that likewise has nothing to do
>> with fbdev.
> 
> My bad, I thought all auxdisplay drivers were fbdev ones, but I was
> wrong, obviously. And now, I don't really know what auxdisplay is
> about anymore :)
> 
> Still, moving it to a "framework" that has been inactive for so long
> (and you even mention it in your PR) doesn't seem like the right move.

I think this move makes sense. It's only moving a file to a directory
that at least mentions "display", not really moving it into a framework
(because there doesn't seem to be any).

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/33de00d9/attachment-0001.sig>
