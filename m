From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 08:35:11 +0100
Subject: [PATCH 1/4] pinctrl: dove: Prevent NULL dereference if
 of_match_device returns NULL
In-Reply-To: <1352955096.6793.1.camel@phoenix>
References: <1352955096.6793.1.camel@phoenix>
Message-ID: <20121115083511.08f5a16f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Axel Lin,

On Thu, 15 Nov 2012 12:51:36 +0800, Axel Lin wrote:
> of_match_device() may return NULL.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Could you detail under what conditions of_match_device() may return
NULL in the specific case of this driver? This of_match_device() call
is using the same dove_pinctrl_of_match array that is used to ->probe()
this driver. So I don't see how you can get into ->probe() without
having a matching entry.

Am I missing something?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
