From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Sep 2014 21:01:52 +0100
Subject: [PATCH 2/5] Documentation: Update documentation for
 UIO_MEM_PHYS_CACHE
In-Reply-To: <1410256619-3213-3-git-send-email-ankit.jindal@linaro.org>
References: <1410256619-3213-1-git-send-email-ankit.jindal@linaro.org>
 <1410256619-3213-3-git-send-email-ankit.jindal@linaro.org>
Message-ID: <20140914200152.GV12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 03:26:56PM +0530, Ankit Jindal wrote:
> This patch update UIO documentation for new mem region
> type UIO_MEM_PHYS_CACHE.
> 
> Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
> Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
> ---
>  Documentation/DocBook/uio-howto.tmpl |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/DocBook/uio-howto.tmpl b/Documentation/DocBook/uio-howto.tmpl
> index bbe9c1f..49e47d4 100644
> --- a/Documentation/DocBook/uio-howto.tmpl
> +++ b/Documentation/DocBook/uio-howto.tmpl
> @@ -530,7 +530,8 @@ the memory region, it will show up in the corresponding sysfs node.
>  <varname>UIO_MEM_PHYS</varname> if you you have physical memory on your
>  card to be mapped. Use <varname>UIO_MEM_LOGICAL</varname> for logical
>  memory (e.g. allocated with <function>kmalloc()</function>). There's also
> -<varname>UIO_MEM_VIRTUAL</varname> for virtual memory.
> +<varname>UIO_MEM_VIRTUAL</varname> for virtual memory and
> +<varname>UIO_MEM_PHYS_CACHE</varname> for physical cacheable memory.

When I read this, I wondered what "physical cacheable memory" was.
Then I found that what you're doing with this is mapping physical
memory into userspace with cacheable attributes.

So, to avoid confusion, this should be "for physical memory, which
will be cacheably mapped" or similar.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
