From: avinashhm@ti.com (Avinash.H.M.)
Date: Thu, 7 Apr 2011 12:15:50 +0530
Subject: [PATCH 2/2 v2] OMAP2/3: hwmod: fix gpio-reset timeouts seen
	during bootup.
In-Reply-To: <BANLkTikwyk6b+d-QAz5LxuU_Lxgo4-A-hg@mail.gmail.com>
References: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
	<1302018015-8858-3-git-send-email-avinashhm@ti.com>
	<BANLkTikwyk6b+d-QAz5LxuU_Lxgo4-A-hg@mail.gmail.com>
Message-ID: <20110407064550.GA19781@avinash-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 11:28:00AM +0530, Gulati, Shweta wrote:
> Hi,
> 
> On Tue, Apr 5, 2011 at 9:10 PM, Avinash.H.M <avinashhm@ti.com> wrote:
> > GPIO module expects the debounce clocks to be enabled during reset. It doesn't
> > reset properly and timeouts are seen, if this clock isn't enabled during
> > reset. Add the HWMOD_CONTROL_OPT_CLKS_IN_RESET flags to the GPIO HWMODs, with
> > which the debounce clocks are enabled during reset.
> Minor comment,
> Rephrase as " GPIO module doesn't reset properly and timeouts are seen
> during bootup, if
> debounce clock is not enabled"
> to make commit log more clear.


Hi Shweta ,

thanks for the review.

i will fix the rephrase the change log .

br ,

- avinash

> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
