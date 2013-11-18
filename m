From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Nov 2013 14:14:44 +0100
Subject: [PATCH v2] ARM: sunxi: dt: add EMAC aliases
In-Reply-To: <CAOMqctQc7K4OwOiCu1UuRpQLmU-Gh43HE_y2tYVnokk84ignJw@mail.gmail.com>
References: <1384546600-14384-1-git-send-email-emilio@elopez.com.ar>
 <1384625849-29849-1-git-send-email-emilio@elopez.com.ar>
 <CAOMqctTb0-B4y0DD6CWEi8Z7Bpd+pP-dWvvn5GiAkCeRD2v43g@mail.gmail.com>
 <52880460.9050700@elopez.com.ar> <20131117083829.GK3538@lukather>
 <CAOMqctQc7K4OwOiCu1UuRpQLmU-Gh43HE_y2tYVnokk84ignJw@mail.gmail.com>
Message-ID: <20131118131444.GC5325@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 02:07:07PM +0100, Michal Suchanek wrote:
> >> That was my first thought, and partly why I did it per-board on v1
> >> (the other part being that some boards do not have a phy, so having
> >> an ethernet0 alias felt "wrong"). But after some quick testing, it
> >> appears that aliases are overridable, so we could just add ethernet0
> >> = &gmac; on qualifying boards when the gmac support is ready.
> >
> > Or we will just add it as ethernet1. U-boot is able to put the
> > mac-address in the DT for every ethernet* nodes for as much ethernet
> > nodes as you need.
> 
> I guess that would be fine for CT and CB2 which can have only one
> physical ethernet (unless there are pins for adding another PHY) but
> if there is ever board with two ethernets you want only one of them to
>  get the mac address from u-boot.

I'm not sure to get why. ethernet0 would get ethaddr, ethernet1 would
get eth1addr. How is that an issue?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/6e37df2d/attachment.sig>
