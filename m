From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 17 Jan 2018 12:00:01 +0100
Subject: [PATCH 07/12] i2c: rk3x: account for const type of
 of_device_id.data
In-Reply-To: <20180115182456.zkx2ehdlxzrc2scu@ninjato>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr>
 <20180115182456.zkx2ehdlxzrc2scu@ninjato>
Message-ID: <9191715.Ndy7U9z6f6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 15. Januar 2018, 19:24:56 CET schrieb Wolfram Sang:
> On Tue, Jan 02, 2018 at 02:28:03PM +0100, Julia Lawall wrote:
> > This driver creates a number of const structures that it stores in
> > the data field of an of_device_id array.
> > 
> > The data field of an of_device_id structure has type const void *, so
> > there is no need for a const-discarding cast when putting const values
> > into such a structure.
> > 
> > Furthermore, adding const to the declaration of the location that
> > receives a const value from such a field ensures that the compiler
> > will continue to check that the value is not modified.  The
> > const-discarding cast on the extraction from the data field is thus
> > no longer needed.
> > 
> > Done using Coccinelle.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Heiko, you okay with the patch?

Looks good to me and does not seem to contain any changes related
to actual functionality, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
