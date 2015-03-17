From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Mar 2015 10:38:29 +0000
Subject: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
In-Reply-To: <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
 <1426112117-18220-2-git-send-email-dianders@chromium.org>
 <CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
 <CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
 <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
Message-ID: <20150317103829.GA28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 11:23:33AM +0100, Ulf Hansson wrote:
> On 16 March 2015 at 16:12, Doug Anderson <dianders@chromium.org> wrote:

> > * Try to set the voltage to exactly 1,200,000 uV (1.2V).
> > * If you can't get 1.2V exactly, a tolerance ("tol") of 100,000 uV
> > (.1V) is OK.
> > * In other words, 1.1V - 1.3V are OK, but aim for 1.2V

> So what happens in the case when 1.3V and 1.1V, but not 1.2V. Which
> value will be used? Is that algorithm defined by the regulator core or
> does it depend per regulator implementation?

It's done in the core.  It first tries to hit the target voltage to the
maximum (picking the lowest voltage in that range) then tries to pick
the lowest voltage to the target, though that's an implementation detail
and we really should be trying to get as close as possible to the
target.  We don't do that yet because it can be expensive to work out so
we do the current thing which is cheap and mostly good enough.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150317/16382021/attachment.sig>
