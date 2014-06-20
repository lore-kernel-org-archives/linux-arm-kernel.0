From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 15:38:19 -0400
Subject: [PATCH v2 2/2] ARM: mvebu: Use system controller to get the
 soc id when possible
In-Reply-To: <20140620191204.GA32533@lunn.ch>
References: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
 <1403274953-21790-3-git-send-email-gregory.clement@free-electrons.com>
 <20140620190052.GD21711@titan.lakedaemon.net>
 <20140620191204.GA32533@lunn.ch>
Message-ID: <20140620193819.GE21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 09:12:04PM +0200, Andrew Lunn wrote:
> > > +int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev)
> > > +{
> > > +	if (of_machine_is_compatible("marvell,armada38x") &&
> > 
> > As Sergei commented on your documentation patch, we try to avoid
> > wildcards in compatible strings.  Perhaps a match list would be more
> > appropriate?
> 
> I'm being pedantic, but in this invocation, it is not a wildcard. It will
> match one and only one compatible string.
> 
> However, we have the issue that 38x is not introduced in this patch,
> it has been there for a while. So would you like another patch series
> removing it from the DT files? 

Please do.  Sorry I missed it the first time around.  Also, may as well
put the documentation patch into the same series.

> A quick grep suggests nothing is using "marvell,armada38x" except this
> patch. So it should not be a backwards compatible issue.

Agreed.

thx,

Jason.
