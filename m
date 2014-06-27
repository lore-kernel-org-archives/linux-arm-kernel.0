From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 28 Jun 2014 01:10:27 +0200
Subject: [RFC 5/5] clk: Add floor and ceiling constraints to clock rates
In-Reply-To: <53ADF6E6.6090705@wwwdotorg.org>
References: <1403855872-14749-1-git-send-email-tomeu.vizoso@collabora.com>
 <1403855872-14749-6-git-send-email-tomeu.vizoso@collabora.com>
 <53ADF6E6.6090705@wwwdotorg.org>
Message-ID: <20140627231026.GA26184@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 04:57:42PM -0600, Stephen Warren wrote:
> On 06/27/2014 01:57 AM, Tomeu Vizoso wrote:
> > Adds a way for clock consumers to set maximum and minimum rates. This can be
> > used for thermal drivers to set ceiling rates, or by misc. drivers to set
> > floor rates to assure a minimum performance level.
> 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> 
> > +static struct rate_constraint *__ensure_constraint(struct clk *clk_user,
> > +						   enum constraint_type type)
> 
> > +	if (!found) {
> > +		constraint = kzalloc(sizeof(*constraint), GFP_KERNEL);
> > +		if (!constraint) {
> > +			pr_err("%s: could not allocate constraint\n", __func__);
> 
> Doesn't kzalloc print an error itself if the allocation fails? I've
> certainly seen quite a few patches ripping out custom "allocation
> failed" errors in code.

Yes, these are unnecessary. There's even a checkpatch warning for this
construct nowadays:

	f9a5a624f414 checkpatch: attempt to find unnecessary 'out of memory' messages

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140628/631482af/attachment.sig>
