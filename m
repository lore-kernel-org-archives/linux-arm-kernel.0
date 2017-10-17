From: robh@kernel.org (Rob Herring)
Date: Tue, 17 Oct 2017 08:02:12 -0500
Subject: [RESEND][PATCH 1/4] of: platform: populate /firmware/ node from
 of_platform_default_populate_init()
In-Reply-To: <1506595562-10592-2-git-send-email-sudeep.holla@arm.com>
References: <1506595562-10592-1-git-send-email-sudeep.holla@arm.com>
 <1506595562-10592-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAL_JsqJYNXoZbN4zydkkZHWYxJuH4ObYJGgz2L7++kMgTWC1vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 5:45 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Since "/firmware" does not have its own "compatible" property as it's
> just collection of nodes representing firmware interface, it's sub-nodes
> are not populated during system initialization.
>
> Currently different firmware drivers search the /firmware/ node and
> populate the sub-node devices selectively. Instead we can populate
> the /firmware/ node during init to avoid more drivers continuing to
> populate the devices selectively.
>
> To generalize the solution this patch populates the /firmware/ node
> explicitly from of_platform_default_populate_init().
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/of/platform.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
