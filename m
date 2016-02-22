From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Sun, 21 Feb 2016 22:33:14 -0800
Subject: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
In-Reply-To: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Message-ID: <CADtm3G7ZHfVyoEcAcFGC4oPX=XHyedSWDMvg6nKPLQ5_is=ZiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2016 at 6:16 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> We want the size of the struct, not of a pointer to it. To be future
> proof, just dereference the pointer to get the desired type.

This looks like it fixes like a fairly serious issue: before this
change, the driver may modify memory that wasn't allocated for this
struct.  Shouldn't this also have Cc: stable?

>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
