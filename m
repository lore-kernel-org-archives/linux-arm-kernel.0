From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 9 May 2013 22:32:04 +0800
Subject: [PATCH 1/3] driver core: Add API to wait for deferred probe to
 complete during init
In-Reply-To: <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
Message-ID: <CACVXFVO3gPMXwzX0WUS4+-FA-SKEKnJt+aK4nL80aTAcEWNLPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 9, 2013 at 1:18 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> Kernel framework (Eg: regulator, clock, etc) might want to do some clean up
> work (Eg: turn off unclaimed resources) after all devices are done probing
> during kernel init. Before deferred probing was introduced, this was

Generally, system resources should be configured as disabled
at default, and for drivers, the correct usage should be only requesting
and enabling the resources just in need, then the sort of 'cleanup' things
can be avoided.


Thanks,
-- 
Ming Lei
