From: dcbw@redhat.com (Dan Williams)
Date: Tue, 15 Dec 2015 15:13:25 -0600
Subject: [PATCH] net: add Qualcomm IPC router
In-Reply-To: <20151215.160114.1178824607335349574.davem@davemloft.net>
References: <1449866519-14551-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20151215.160114.1178824607335349574.davem@davemloft.net>
Message-ID: <1450214005.4464.9.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-12-15 at 16:01 -0500, David Miller wrote:
> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Date: Fri, 11 Dec 2015 12:41:59 -0800
> 
> > +static unsigned int qrtr_local_nid = 1;
> > +module_param_named(node_id, qrtr_local_nid, uint, S_IRUGO);
> > +MODULE_PARM_DESC(idVendor, "Local Node Identifier");

Also s/idVendor/node_id?

Dan

> Module parameters suck.
> 
> Allow the user to choose this dynamically.  You have roughtly two
> choices.
> 
> 1) Subvert the 'protocol' field passed to ->create() and use that, it
> is
>    being ignored otherwise.
> 
> 2) Put it into the socket address for bind().
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
