From: w@1wt.eu (Willy Tarreau)
Date: Wed, 10 Aug 2016 17:20:28 +0200
Subject: About the accuracy of delay loop
In-Reply-To: <20160810225939.7f3142ba@JAMIE.lan>
References: <20160810152456.41f6e727@JAMIE> <20160810153429.2489b087@xhacker>
 <20160810225939.7f3142ba@JAMIE.lan>
Message-ID: <20160810152028.GA7732@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 10:59:39PM +0800, Jamie Huang wrote:
> Thank you for reply. But the users may be confused because of the
> different results. You mean there is no need to worry about it? 

The bogomips are already a bogus measure. I've been used to see different
values for kernels running in ARM mode versus Thumb2 mode on the same machine,
likely due to different optimizations. What matters is that the LPJ value is
correct for the executed loop so that udelay calculation is accurate enough.
Here everything's OK.

Willy
