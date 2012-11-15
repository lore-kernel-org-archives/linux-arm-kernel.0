From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 20:18:33 +0100
Subject: [PATCH 2/4] pinctrl: kirkwood: Prevent NULL dereference if
 of_match_device returns NULL
In-Reply-To: <1352955159.6793.2.camel@phoenix>
References: <1352955096.6793.1.camel@phoenix> <1352955159.6793.2.camel@phoenix>
Message-ID: <20121115201833.07ec01c6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Axel Lin,

On Thu, 15 Nov 2012 12:52:39 +0800, Axel Lin wrote:
> of_match_device() may return NULL.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Why? We already discussed together that this situation could not
happen: if you are in the probe() function, then there *must* be a
match, because the probe() function precisely gets called when there is
a match.

So unless you give more details about what the problem is, I don't
think this patch and the similar one you sent for Dove are useful.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
