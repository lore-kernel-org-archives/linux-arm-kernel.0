From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 26 Sep 2013 14:49:18 +0200
Subject: [PATCH 4/4] perf: parse the .debug_frame section in case
 .eh_frame is not present
In-Reply-To: <1380195398-4402-5-git-send-email-jean.pihet@linaro.org>
References: <1380195398-4402-1-git-send-email-jean.pihet@linaro.org>
 <1380195398-4402-5-git-send-email-jean.pihet@linaro.org>
Message-ID: <20130926124918.GB3284@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 01:36:38PM +0200, Jean Pihet wrote:
> On ARM the debug info is not present in the .eh_frame sections but
> in .debug_frame instead, in dwarf format.
> Use libunwind to load and parse the debug info.
> 
> Dependencies:
>  . if present, libunwind >= 1.1 is needed to prevent a segfault when
>    parsing the dwarf info,
>  . libunwind needs to be configured with --enable-debug-frame. Note:
>    --enable-debug-frame is automatically selected on ARM.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
