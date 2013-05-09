From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 9 May 2013 18:07:56 +0800
Subject: [PATCH 1/3] driver core: Add API to wait for deferred probe to
 complete during init
In-Reply-To: <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
Message-ID: <CACVXFVMd_iRtEM8ZLK6Ps66gZO6SCp1mXSgY6JbWtRJjJUh+ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 9, 2013 at 1:18 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
>
> The most obvious fallback of using late_initcall_sync() also doesn't work
> since the deferred probing work initated during late_initcall() is done in
> a workqueue. So, frameworks that want to wait for all devices to finish
> probing during init will now have to wait for the deferred workqueue to
> finish it's work. This patch adds a wait_for_init_deferred_probe_done() API

flush_workqueue() has been added in deferred_probe_initcall(), so looks it
should be OK for your problem, doesn't it?


Thanks,
-- 
Ming Lei
