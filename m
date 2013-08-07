From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Aug 2013 21:16:40 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: Add spinlocks
In-Reply-To: <CACRpkdYS-7MPTTSg4psJ3NZ_jhA15aMeFLoxFNAN7hSqe4hRTA@mail.gmail.com>
References: <1375612728-20501-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375612728-20501-3-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdYS-7MPTTSg4psJ3NZ_jhA15aMeFLoxFNAN7hSqe4hRTA@mail.gmail.com>
Message-ID: <20130807191640.GG2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Aug 07, 2013 at 08:42:42PM +0200, Linus Walleij wrote:
> On Sun, Aug 4, 2013 at 12:38 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > The current code use no locking at all, which is obviously not that
> > great and can lead to concurrency issues, especially with the newer SMP
> > SoCs from Allwinner.
> >
> > Add some locking where it's needed.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> This does not apply to my fixes branch which is based off
> v3.11-rc4.

I think you're missing this patch that I sent previously:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186342.html

> It is also too big to go into fixes.
> 
> I think it may be requiring the other queued Allwinner things,
> so it is better if I apply this on the devel branch after looking over
> that Allwinner A20/A31 stuff?

The A20/A31 stuff shouldn't conflict with this one, but yes, I you
prefer to do it that way, it's fine for me.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/081021b0/attachment.sig>
