From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 19:18:05 +0100
Subject: [PATCH] ARM: Thumb-2: Fix out-of-range offset for Thumb-2 in
	proc-v7.S
In-Reply-To: <AANLkTinH0vJsXPkStC8nSqMjCgyv7YPscf2ORry_FdhG@mail.gmail.com>
References: <1294790613-17101-1-git-send-email-dave.martin@linaro.org>
	<20110112081446.GB24920@pengutronix.de>
	<AANLkTinH0vJsXPkStC8nSqMjCgyv7YPscf2ORry_FdhG@mail.gmail.com>
Message-ID: <20110112181805.GJ24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 10:33:33AM -0600, Dave Martin wrote:
> 2011/1/12 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Tue, Jan 11, 2011 at 06:03:33PM -0600, Dave Martin wrote:
> >> The following patch introduces a pre-increment addressing
> >> offset which is out of range for Thumb-2:
> >> ? ? ARM: pgtable: switch order of Linux vs hardware page tables
> > a commit id would be nice here
> >
> > Uwe
> 
> Apologies--- it's commit d30e45eeabefadc6039d7f876a59e5f5f6cb11c6
No need to excuse.

I suggest:

ARM: Thumb-2: Fix out-of-range offset for Thumb-2 in proc-v7.S

Commit

	d30e45e (ARM: pgtable: switch order of Linux vs hardware page tables)

introduced a pre-increment addressing offset which is out of range for
Thumb-2.  Thumb-2 only permits offsets <256.  So split the intruction in
two for Thumb-2.

Signed-off-by: ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
