From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 12 Sep 2013 14:38:47 +0200
Subject: [PATCH 3/3] perf: parse the .debug_frame section in case
 .eh_frame is not present
In-Reply-To: <1378720815-23964-4-git-send-email-jean.pihet@linaro.org>
References: <1378720815-23964-1-git-send-email-jean.pihet@linaro.org>
 <1378720815-23964-4-git-send-email-jean.pihet@linaro.org>
Message-ID: <20130912123847.GB15187@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 12:00:15PM +0200, Jean Pihet wrote:
> On ARM the debug info is not present in the .eh_frame sections but
> in .debug_frame instead, in the dwarf format.
> Use libunwind to load and parse the debug info.
> 
> Dependencies:
>  . if present, libunwind >= 1.1 is needed to prevent a segfault when
>    parsing the dwarf info,
>  . libunwind needs to be configured with --enable-debug-frame
>    to prevent a linkage error. Note: --enable-debug-frame is automatically
>    selected on ARM).
> 
> Signed-off-by: Jean Pihet <jean.pihet@linaro.org>

I tested the .eh_frame code is still functional, but
haven't tested the .debug_frame functionality itself

otherwise it looks ok:
Rewieved-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
