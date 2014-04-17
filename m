From: timur@tabi.org (Timur Tabi)
Date: Thu, 17 Apr 2014 08:46:01 -0500
Subject: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable baudclk when used
In-Reply-To: <20140416072738.GC6159@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
 <20140414152850.GB7197@MrMyself> <20140416072738.GC6159@pengutronix.de>
Message-ID: <534FDB19.7060100@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> Is there always exactly one hw_free call for one hw_params call?

I don't think so.  It's been a while since I've worked on this code, but 
I do remember noticing that hw_params could be called multiple times, 
whereas hw_free was called only once.  This made a big impact on my 
design of the code.
