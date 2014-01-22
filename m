From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 Jan 2014 11:30:49 +0000
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <CAOesGMi9puZSzdDJ-sur5ks7VcDH+XV_MbuA0xeidLgp=uJacg@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <CAPDyKFoywt_LcWXdWJCWMU8-GT2vLW27eiuF0WEyjHJV+96HpA@mail.gmail.com>
 <20140120191302.GA32178@quad.lixom.net>
 <CAPDyKFpfrs=e3bDvdFRpnD3RkmD8ZvAJgFi6XvCRAOocqAKkKw@mail.gmail.com>
 <CAOesGMi9puZSzdDJ-sur5ks7VcDH+XV_MbuA0xeidLgp=uJacg@mail.gmail.com>
Message-ID: <20140122113049.GA20247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 10:14:49AM -0800, Olof Johansson wrote:
> On Tue, Jan 21, 2014 at 12:55 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> > That could make sense, but still I wonder how those shall be handled
> > in a fine grained power management setup. In other words, when shall
> > those be gated/ungated? Is the mmc core able to take the correct
> > decision about these?

> The reference clock is in most cases I've seen 32kHz, and not
> something that's under fine-grained power management. So it's not used
> to regulate interface speed, etc.

I have seen devices connected using SDIO which did use fine grained
power management here with faster clocks.  They're definitely not the
common case but they're there.  :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140122/de54e4eb/attachment.sig>
