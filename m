From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 26 Oct 2012 10:10:09 -0700
Subject: [PATCH v2 5/7] crypto: omap-sham: Convert to use pm_runtime API
In-Reply-To: <87lieunkat.fsf@deeprootsystems.com>
References: <1351046167-4882-1-git-send-email-mgreer@animalcreek.com>
 <1351046167-4882-6-git-send-email-mgreer@animalcreek.com>
 <87lieunkat.fsf@deeprootsystems.com>
Message-ID: <20121026171009.GA23528@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 05:34:02PM -0700, Kevin Hilman wrote:
> Hi Mark,

Hi Kevin.

> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> >
> > Convert the omap-sham crypto driver to use the
> > pm_runtime API instead of the clk API.
> >
> > CC: Kevin Hilman <khilman@deeprootsystems.com>
> > CC: Paul Walmsley <paul@pwsan.com>
> > CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> I can't pretend to fully understand this driver, It looks like the
> current code is doing a bit more fine-grained clock gating, and leaving
> the IP clocked only when needed.
> 
> The proposed version does a 'get' in probe and a 'put' in remove, which
> means the IP will always be enabled (and thus preventing low-power
> states), even when it's not in use.

You're right, and what I did is wrong.  I'll fix this in the next revision.

Thanks,

Mark
--
