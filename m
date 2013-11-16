From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Sat, 16 Nov 2013 20:48:48 -0300
Subject: [PATCH v2] ARM: sunxi: dt: add EMAC aliases
In-Reply-To: <CAOMqctTb0-B4y0DD6CWEi8Z7Bpd+pP-dWvvn5GiAkCeRD2v43g@mail.gmail.com>
References: <1384546600-14384-1-git-send-email-emilio@elopez.com.ar>
 <1384625849-29849-1-git-send-email-emilio@elopez.com.ar>
 <CAOMqctTb0-B4y0DD6CWEi8Z7Bpd+pP-dWvvn5GiAkCeRD2v43g@mail.gmail.com>
Message-ID: <52880460.9050700@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 16/11/13 20:37, Michal Suchanek escribi?:
> Unfortunately,
>
> a20 has two Ethernets so you can't alias both to ethernet0.
>
> This has to be done on a per-board basis.
>

That was my first thought, and partly why I did it per-board on v1 (the 
other part being that some boards do not have a phy, so having an 
ethernet0 alias felt "wrong"). But after some quick testing, it appears 
that aliases are overridable, so we could just add ethernet0 = &gmac; on 
qualifying boards when the gmac support is ready.

Cheers,

Emilio
