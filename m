From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 11 Nov 2013 15:29:10 +0200
Subject: [PATCH 0/3] omapdss: venc: Add support for bypass and acbias.
In-Reply-To: <CAAfyv34j+YhEjtHyf7zg5oBoCV5ROEXow8VV0PQNHLTF5uDZJg@mail.gmail.com>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
 <CAAfyv34j+YhEjtHyf7zg5oBoCV5ROEXow8VV0PQNHLTF5uDZJg@mail.gmail.com>
Message-ID: <5280DBA6.50303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2013-11-05 09:24, Belisko Marek wrote:
> Hi,
> 
> ping.
> 
> On Mon, Oct 14, 2013 at 11:02 PM, Marek Belisko <marek@goldelico.com> wrote:
>> This patches is adding bypass and acbias functionality to omapdss venc driver.
>> In first patch we export updatin bypass and acbias in devconf1 register. Next patch
>> add handling for updating in venc driver and last patch add driver for opa362 which
>> is used on gta04 board and set bypass + acbias.
> Is there a chance to get this series to 3.13? Thanks.

Sorry, I haven't had time to do much reviewing.

The code in omap3-tvout.c should be included in the display.c file,
which already contains some things like muxing. Also, func(bool, bool)
style functions are rather confusing to read. Maybe an enum would be
better, so you'd instead have something like:

func(OMAP_VENC_TVOUTBYPASS | OMAP_VENC_TVACEN)

But the main issue is: while this series probably works well, I really
don't like it that the OPA driver needs to pass bypass and acbias. It
shouldn't know anything about such things. I'm just not certain how to
implement that with the current omapdss driver.

I'll try to find time to think about this more, but I don't think I can
merge this for 3.13.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131111/2e13c0fe/attachment.sig>
