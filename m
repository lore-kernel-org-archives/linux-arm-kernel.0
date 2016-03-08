From: broonie@kernel.org (Mark Brown)
Date: Tue, 8 Mar 2016 09:20:56 +0700
Subject: next-20160307 build: 2 failures 19 warnings (next-20160307)
In-Reply-To: <E1actUq-0008MZ-EF@optimist>
References: <E1actUq-0008MZ-EF@optimist>
Message-ID: <20160308022056.GV18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 11:38:44AM +0000, Build bot for Mark Brown wrote:

For the past week or so an arm64 allmodconfig has failed to build.  I've
not been able to perform a bisect to identify where as I've been
travelling but the errors are below, I suspect they are triggered by 
recent changes in the akpm tree adding tracepoints to the page reference
code.

> 	arm64-allmodconfig
> ../include/trace/trace_events.h:703:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_set' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/trace_events.h:703:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_mod' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/trace_events.h:703:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_mod_and_test' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/trace_events.h:703:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_mod_and_return' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/trace_events.h:703:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_mod_unless' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/trace_events.h:703:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_freeze' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/trace_events.h:703:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_unfreeze' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/perf.h:83:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_set' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/perf.h:83:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_mod' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/perf.h:83:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_mod_and_test' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/perf.h:83:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_mod_and_return' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/perf.h:83:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_mod_unless' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/perf.h:83:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_freeze' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../include/trace/perf.h:83:35: error: passing argument 1 of 'check_trace_callback_type_page_ref_unfreeze' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../mm/debug_page_ref.c:8:21: error: passing argument 1 of 'trace_page_ref_set' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../mm/debug_page_ref.c:15:21: error: passing argument 1 of 'trace_page_ref_mod' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../mm/debug_page_ref.c:22:30: error: passing argument 1 of 'trace_page_ref_mod_and_test' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../mm/debug_page_ref.c:29:32: error: passing argument 1 of 'trace_page_ref_mod_and_return' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../mm/debug_page_ref.c:36:28: error: passing argument 1 of 'trace_page_ref_mod_unless' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../mm/debug_page_ref.c:43:24: error: passing argument 1 of 'trace_page_ref_freeze' from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../mm/debug_page_ref.c:50:26: error: passing argument 1 of 'trace_page_ref_unfreeze' from incompatible pointer type [-Werror=incompatible-pointer-types]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160308/95fbcb22/attachment.sig>
