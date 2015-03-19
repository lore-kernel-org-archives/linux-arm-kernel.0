From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Mar 2015 11:36:46 +0000
Subject: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
In-Reply-To: <CAPDyKFrkznbW7k_=BDo99jJhWzDbUgbeU+MXWB_E_UWXh=56Eg@mail.gmail.com>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
 <1426112117-18220-2-git-send-email-dianders@chromium.org>
 <CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
 <CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
 <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
 <CAD=FV=X=1=AnXCGgWWkJDcHLO-MfVqsSB2aJxi3WOgWJhD_ggA@mail.gmail.com>
 <CAPDyKFrkznbW7k_=BDo99jJhWzDbUgbeU+MXWB_E_UWXh=56Eg@mail.gmail.com>
Message-ID: <20150319113646.GQ2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 12:14:11PM +0100, Ulf Hansson wrote:

> Agree. Moreover we need that API to also pick the closest value to
> target, when trying the range "target->minimum". I also believe it

The implementation *should* do that anyway, it's just not trivial to
implement in an efficient fashion with the current information we have
from drivers.

> would be good to allow both upper and lower limits to be zero.

The lower limit can be zero already though it isn't clear to me that
this is useful.  Setting an upper limit of zero seems nonsensical, an
upper limit that is lower than the lower limit isn't terribly obvious
and removing the upper limit isn't safe - it means that we'll happily
oversupply things which is a road to physical damage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150319/7de1b59e/attachment-0001.sig>
