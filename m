From: davem@davemloft.net (David Miller)
Date: Sun, 21 Aug 2016 15:29:15 -0700 (PDT)
Subject: [PATCH -next] net: phy: Add missing of_node_put() in
 xgmiitorgmii_probe()
In-Reply-To: <20160820173605.GE30224@lunn.ch>
References: <1471706815-27723-1-git-send-email-weiyj.lk@gmail.com>
 <20160820173605.GE30224@lunn.ch>
Message-ID: <20160821.152915.360184359793857112.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 20 Aug 2016 19:36:05 +0200

> On Sat, Aug 20, 2016 at 03:26:55PM +0000, Wei Yongjun wrote:
>> This node pointer is returned by of_parse_phandle() with
>> refcount incremented in this function. of_node_put() on it
>> before exitting this function.
> 
> Hi Wei
> 
> You are only releasing on the error path. What about the successful
> path?

Agreed, as far as I can tell we do need to release it unconditionally
here.
