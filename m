From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Wed, 7 Oct 2015 11:22:58 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <20151006180342.GA13434@gradator.net>
References: <55559D55.6020703@aksignal.cz>
 <20151006180342.GA13434@gradator.net>
Message-ID: <20151007092258.GA15119@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 06, 2015 at 08:03:43PM +0200, Sylvain Rochet wrote:
> 
> I wonder if we should substract from the watchdog_ops->set_timeout() 
> new_timeout argument value the previously set hardware timeout period, 
> this way we would have a "60 - 16 + 12~16" instead of a "60 + 12~16" 
> watchdog timeout. If someone agree I will propose a patch to do that.

A night of thinking later, it may sounds appealing but this is a stupid 
idea. We have an overlap hard to deal with if user chooses a ping time 
close to the timeout (e.g.: 60s timeout, 55s ping time), it sounds 
stupid to do so but we can't prevent nor check that. So let's keep it 
simple.

Sylvain
