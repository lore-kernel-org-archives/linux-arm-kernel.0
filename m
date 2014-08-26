From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 10:40:27 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140825151822.GC21020@skynet.be>
References: <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
 <53FB47B8.2090104@redhat.com>
 <20140825151255.GA14967@ulmo.nvidia.com>
 <20140825151822.GC21020@skynet.be>
Message-ID: <20140826084026.GF17263@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 05:18:22PM +0200, Luc Verhaegen wrote:
> On Mon, Aug 25, 2014 at 05:12:58PM +0200, Thierry Reding wrote:
> > 
> > Out of curiosity, how does this work in practice? How does the
> > bootloader create this entry? Does it scan the DT to see which clocks
> > the real hardware device references and then simply copies them to the
> > simplefb node?
> > 
> > Thierry
> 
> https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg06619.html

That looks like a royal pain. Again, I think it'd be much simpler (but
not less code, unfortunately) to do this on a per-resource basis. That
way these low-level firmware drivers in the kernel can stay trivial,
keeping the real complexity where they belong: in hardware-specific
drivers such as DRM/KMS.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/6bf72076/attachment.sig>
