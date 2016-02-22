From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 22 Feb 2016 09:05:22 +0100
Subject: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
In-Reply-To: <CADtm3G7ZHfVyoEcAcFGC4oPX=XHyedSWDMvg6nKPLQ5_is=ZiQ@mail.gmail.com>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
 <CADtm3G7ZHfVyoEcAcFGC4oPX=XHyedSWDMvg6nKPLQ5_is=ZiQ@mail.gmail.com>
Message-ID: <20160222080522.GB1389@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2016 at 10:33:14PM -0800, Gregory Fong wrote:
> On Sun, Feb 21, 2016 at 6:16 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > We want the size of the struct, not of a pointer to it. To be future
> > proof, just dereference the pointer to get the desired type.
> 
> This looks like it fixes like a fairly serious issue: before this
> change, the driver may modify memory that wasn't allocated for this
> struct.  Shouldn't this also have Cc: stable?

Surely. I usually add the tag when committing, not when sending out.

> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

Thanks.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/544259df/attachment.sig>
