From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 14 Oct 2015 16:12:23 -0700
Subject: [PATCH v7 20/20] of/platform: Defer probes of registered devices
In-Reply-To: <1443517859-30376-21-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
 <1443517859-30376-21-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <561EE157.4070604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/29/2015 2:10 AM, Tomeu Vizoso wrote:
> Instead of trying to match and probe platform and AMBA devices right
> after each is registered, delay their probes until device_initcall_sync.
                                                     ^^^^^^^^^^^^^^^^^^^^
                                                     late_initcall

> 
> This means that devices will start probing once all built-in drivers
> have registered, and after all platform and AMBA devices from the DT
> have been registered already.
> 
> This allows us to prevent deferred probes by probing dependencies on
> demand.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---

< snip >
