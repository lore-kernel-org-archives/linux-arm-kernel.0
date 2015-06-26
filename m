From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 26 Jun 2015 17:44:03 +0200
Subject: [PATCH 2/2] arm/smmu: Make use of of_parse_phandle_with_var_args
In-Reply-To: <20150626111047.GA9791@arm.com>
References: <1435247548-32201-1-git-send-email-joro@8bytes.org>
 <1435247548-32201-2-git-send-email-joro@8bytes.org>
 <20150626111047.GA9791@arm.com>
Message-ID: <20150626154403.GD18569@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Jun 26, 2015 at 12:10:47PM +0100, Will Deacon wrote:
> Thanks for looking at this! I'm fine with the general idea, but obviously
> the first patch needs an Ack from a devicetree person.

Yeah, sure. I was looking into a simple solution that does not require
to rewrite all the callers. Lets see what the device-tree maintainers
think about it :)

> >  out_put_masters:
> > +
> > +	of_free_phandle_args(masterspec);
> 
> Shouldn't we also free the masterspec on success?

Right, thanks. This code is only the error path. I'll add this in the
next version.


	Joerg
