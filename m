From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Wed, 14 Dec 2016 20:54:10 +0100
Subject: [PATCH] arm: Adjust memory boundaries after reservations
In-Reply-To: <1481681501-13788-1-git-send-email-labbott@redhat.com>
References: <1481681501-13788-1-git-send-email-labbott@redhat.com>
Message-ID: <CAM=E1R4j_5T--iZJ16dgGtKbx2HA4hjjnTkM7pBrZYU8OcAJnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,


On 14 December 2016 at 03:11, Laura Abbott <labbott@redhat.com> wrote:
> The poorly named sanity_check_meminfo is responsible for setting up the
> boundary for lowmem/highmem. This needs to be set up before memblock
> reservations can occur. At the time memblock reservations can occur,
> memory can also be removed from the system. This can throw off the
> calculation of the lowmem/highmem boundary. On some systems this may be
> harmless, on others this may result in incorrect ranges being passed to
> the main memory allocator. Correct this by recalcuating the
> lowmem/highmem boundary after all reservations have been made.
> As part of this, rename sanity_check_meminfo to actually refect what the
> function is doing.
>
> Reported-by: Magnus Lilja <lilja.magnus@gmail.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---

Thanks! I've applied the patch on a v4.9 kernel tree and tried it on
the i.MX31 board and the patch resolves the issue.

Tested-by: Magnus Lilja <lilja.magnus@gmail.com>

Regards, Magnus
