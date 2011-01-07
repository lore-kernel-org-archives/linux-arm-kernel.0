From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 7 Jan 2011 16:44:05 +0530
Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for
	undefined reference to 'omap2_prm_read_mod_reg'
In-Reply-To: <alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
Message-ID: <e194160102cb8b695465c81eea6582fc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Thursday, January 06, 2011 11:28 PM
Kevin,
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; tony at atomide.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix
> for undefined reference to 'omap2_prm_read_mod_reg'
>
> Hi Santosh
>
[.....]

>
> I think it would be best to use WARN() on these, rather than
> WARN_ONCE().
> That's because these could be called from different parts of the
> code
> base, and the stack backtrace will help someone figure out all the
> code
> that needs to be fixed.
>
> Once you do that, this patch is
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
>
With WARN() instead of WARN_ONCE() and Paul's ack, here
is an updated patch.
