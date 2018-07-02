From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 2 Jul 2018 07:54:44 -0700
Subject: [PATCH v5 09/10] Uprobes/sdt: Document about reference counter
In-Reply-To: <20180628052209.13056-10-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-10-ravi.bangoria@linux.ibm.com>
Message-ID: <20180702145444.GB65296@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-06-28 10:52:08]:

> Reference counter gate the invocation of probe. If present,
> by default reference count is 0. Kernel needs to increment
> it before tracing the probe and decrement it when done. This
> is identical to semaphore in Userspace Statically Defined
> Tracepoints (USDT).
> 
> Document usage of reference counter.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Unlike perf, this mechanism cannot detect ref count and depends on the
users data. What happens if the user mistakenly provides a wrong location?
I guess he can corrupt some other data structures?

Hence I would think twice of advertising this mechanism. i.e keep this
as an undocumented feature.
