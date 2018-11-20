From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 20 Nov 2018 17:06:12 +0100
Subject: [PATCH v2] cpuidle: big.LITTLE: add of_node_put()
In-Reply-To: <20181120154617.20903-1-tiny.windzz@gmail.com>
References: <20181120154617.20903-1-tiny.windzz@gmail.com>
Message-ID: <CAJZ5v0hWSCDbDUV1_iQBf-4Y=QgnBTrAqQqcCyOpv9r7yCjGiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 4:46 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> The of_node_put() is missing.So we call the of_node_put() to release
> the refcount.

I would say "of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it."

Thanks,
Rafael
