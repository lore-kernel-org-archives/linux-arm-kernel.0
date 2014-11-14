From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 14 Nov 2014 18:20:09 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <5465A977.4030605@gmail.com>
References: <20141104205117.GA17606@amd>
 <20141106180335.GA21513@earth.universe>
 <20141106225005.GA14002@amd> <201411070001.46481@pali>
 <545C6F14.8050303@gmail.com>
 <20141113162420.GB8512@xo-6d-61-c0.localdomain>
 <5465A977.4030605@gmail.com>
Message-ID: <20141114172008.GB12250@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 14, 2014 at 09:04:23AM +0200, Ivaylo Dimitrov wrote:
> [...]
> https://gitorious.org/linux-n900/freemangordons-linux-n900/commits/30e9a5c498a89cea4c29523f69e436bf0af3c631
> 
> commits 89ce13b, b81d80d, ec4d0dc, 91256e2 and 8022a6d - e29f558 (no idea
> why gitorious shows those mixed with SGX stuff, on my local tree it is
> contiguous patch series)
> 
> didn't test against the current upstream, but I see no reason why those
> should not apply, build and run.

The patch looks ok. It does not cleanup the cmt-speech driver for
mainline usage, but it should work. Before adding this driver to the
mainline kernel there should be open source userspace support anyway.

Btw. I am aware that this would break existing pulse audio stuff,
but wouldn't it make sense to export a V4L2 device instead of the
custom /dev/cmt_speech ABI?

> > >About the pulseaudio stuff - we're still in process of REing it, so
> > >far there are 2 out of 3 closed Nokia modules ready
> > >(https://gitorious.org/pulseaudio-nokia), but the last one, which is
> > >the one used for voice calls is still not ready and will take it a
> > >while :).
> >
> > Ok, is there a way I could help? Pretty much everything else works with
> > opensource drivers...
> >
> 
> There is, though I am not sure you'll like it much - fire up IDA and join
> the party :P. Ping me on IRC for more details in case you're interested.
> 
> Regards,
> Ivo

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/d7c1564c/attachment.sig>
