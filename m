From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Jun 2013 09:48:27 +0100
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
In-Reply-To: <CAGsJ_4y4svi0TbUKK1aAW1McM5rFoo5Vb9rGPweq-sHJ2NN5cQ@mail.gmail.com>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
 <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
 <20130527121658.GA3660@sirena.org.uk>
 <CAGsJ_4w867BhFvVze5BNaYheW75pMcOGhscz3wSZiia-neP59w@mail.gmail.com>
 <20130610134535.GB2987@katana>
 <CAGsJ_4y4svi0TbUKK1aAW1McM5rFoo5Vb9rGPweq-sHJ2NN5cQ@mail.gmail.com>
Message-ID: <20130611084827.GS1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 09:14:41AM +0800, Barry Song wrote:

> the mainline idea you mentioned is that you don't care about any early
> device, which means some devices want to start earlier than others in
> some real automative user scenerioes.
> but i think another important idea is that mainline codes come from
> branches of different vendors and serve final users of those drivers,
> but not only make source codes no difference to all environments. the
> auto users i2c-sirf serves, here, actually means some differences with
> PC/tablet/mobilephone. we don't make codes good-looking by losing
> functionality and not close to final users.

It's not that people don't care about these users, it's that people
don't care too much about out of tree users.  Part of the goal here is
to convince people working on such applications that they should make
mainline better for everyone so that you don't need external code to
make the kernel useful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/858938c0/attachment.sig>
