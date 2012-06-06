From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 6 Jun 2012 08:44:17 +0300
Subject: [PATCH] remoteproc: block premature rproc booting
In-Reply-To: <4FCECD8F.8000600@codeaurora.org>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com>
 <4FBDFC4A.1060602@codeaurora.org>
 <CAK=WgbaP5qSso_Eu=Oup4eqLDcorZ-qf=mysMKiEvOS=m7yLmg@mail.gmail.com>
 <4FCD276A.80505@codeaurora.org>
 <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
 <4FCECD8F.8000600@codeaurora.org>
Message-ID: <CAK=WgbakMG5eoSGP3GDFLFjA=z5fc_h_oFdzuC4tL5PcpCdLZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 6, 2012 at 6:25 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> What if I don't want to boot the device at kernel start-up? Do I have to
> make it a module then?

Currently, yeah.

But we can change stuff if needed.

We took that design decision because it was simple and we didn't have
any reason not to do it, but I'm thinking we can let the users decide
about this using runtime pm (e.g. calling pm_runtime_get_sync with an
rpmsg device, which will then be propagated all the way up to the
remoteproc device and power it up).
