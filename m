From: davem@davemloft.net (David Miller)
Date: Tue, 15 Dec 2015 16:01:14 -0500 (EST)
Subject: [PATCH] net: add Qualcomm IPC router
In-Reply-To: <1449866519-14551-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1449866519-14551-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20151215.160114.1178824607335349574.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Date: Fri, 11 Dec 2015 12:41:59 -0800

> +static unsigned int qrtr_local_nid = 1;
> +module_param_named(node_id, qrtr_local_nid, uint, S_IRUGO);
> +MODULE_PARM_DESC(idVendor, "Local Node Identifier");

Module parameters suck.

Allow the user to choose this dynamically.  You have roughtly two choices.

1) Subvert the 'protocol' field passed to ->create() and use that, it is
   being ignored otherwise.

2) Put it into the socket address for bind().
