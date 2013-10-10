From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Oct 2013 13:23:34 +0100
Subject: [PATCH 3/5] drm/bridge: Add PTN3460 bridge driver
In-Reply-To: <063a01cec5ad$8afd1920$a0f74b60$%dae@samsung.com>
References: <1380670860-17621-4-git-send-email-seanpaul@chromium.org>
 <CAAQKjZN_r-=-sj=Vb-o-KUS4ab5=cjCq1ni3VZeMeVc3NL=MMg@mail.gmail.com>
 <CAOw6vbLiJLLKn=gb1=j5TBeM0ijEK13+goG-=mw7MZTyNT1kpQ@mail.gmail.com>
 <CAAQKjZPwyKCpju4Ndd+MB_aN24-zA5xTHFsFsun2617h7YT6dw@mail.gmail.com>
 <CAOesGMgKastzdFHYQzyL8gxkBN=86wFZ4jbgP8BHxfkOuZvJxg@mail.gmail.com>
 <CAAQKjZMhovKLxNfnXnbF-6diM2zF1cWyi+xHGyL3v83vBh4p6g@mail.gmail.com>
 <20131009182905.GY21581@sirena.org.uk>
 <05c701cec56f$b79eea50$26dcbef0$%dae@samsung.com>
 <20131010093708.GC21581@sirena.org.uk>
 <063a01cec5ad$8afd1920$a0f74b60$%dae@samsung.com>
Message-ID: <20131010122334.GJ21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 08:40:38PM +0900, Inki Dae wrote:

> That is what I mentioned. Some boards _could control_ the actual regulator
> for lvds-bridge, and that would be depended on how HW engineer designs the
> board. 

For the driver this should be totally transparent - it should just
control the regulator all the time, the regulator API will just not do
anything if the regulator state can't actually be changed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/97b0ed01/attachment-0001.sig>
