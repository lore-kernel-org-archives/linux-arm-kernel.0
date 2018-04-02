From: neil@brown.name (NeilBrown)
Date: Mon, 02 Apr 2018 13:41:33 +1000
Subject: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
In-Reply-To: <1522638255.18424.44.camel@mtkswgap22>
References: <20180329095637.GA16778@kroah.com>
 <20180329124745.24694-1-cmc@babblebit.net>
 <87vada1owt.fsf@notabene.neil.brown.name>
 <1522638255.18424.44.camel@mtkswgap22>
Message-ID: <87po3i1dhu.fsf@notabene.neil.brown.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02 2018, Sean Wang wrote:

> On Mon, 2018-04-02 at 09:34 +1000, NeilBrown wrote:
>> On Thu, Mar 29 2018, Chris Coffey wrote:
>> 
>> > This fixes the following sparse warning:
>> >
>> > drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
>> > 'mtk_set_ethtool_ops' was not declared. Should it be static?
>> >
>> > Signed-off-by: Chris Coffey <cmc@babblebit.net>
>> 
>> Reviewed-by: NeilBrown <neil@brown.name>
>> 
>> Thanks,
>> NeilBrown
>> 
> Hi, Neil
>
> Forgive me I cannot find the cover letter in the original series in my
> mailbox to make a reply, so I rudely made here just letting you know
> something good to the growth of mt7621 support in upstream.
>
> do you have maintained an out-of-tree branch to boot the mt7621 machine
> with those staging patches?

I can boot v4.16 plus staging-next on my mt7621 with no other patches.
An important fix (a63d706ea71919) landed in 4.16-rc7.

It do have
  https://github.com/neilbrown/linux/commits/gnubee/v4.15

which was part of preparation for this, but now that very nearly all I
need is in mainline or on its way, I won't be doing much more in that
tree.

>
> If so, it would become a bit easier for me that maybe I could give a
> hand for migrating these staging driver for mt7621 to mainline. I
> thought mmc, pci, ethernet, gsw and hsdma all could probably reuse the
> current mainline code.

I agree that it is quite likely that several of these drivers could and
should reuse current mainline code.  I would love to have some help
sorting this out.  I won't have much time myself to dig into it for
several weeks, but I'll make time to review and test any code that is
contributed.

Thanks,
NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180402/75ddc73d/attachment.sig>
