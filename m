From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Nov 2014 14:14:00 +0000
Subject: [PATCH v8 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <546D7860.2010300@linaro.org>
References: <1416273038-15590-1-git-send-email-takahiro.akashi@linaro.org>
 <1416273038-15590-3-git-send-email-takahiro.akashi@linaro.org>
 <20141118140425.GM18842@arm.com> <546C58DB.5080204@linaro.org>
 <20141119190601.GM15985@arm.com> <546D7860.2010300@linaro.org>
Message-ID: <20141125141400.GG3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 02:13:04PM +0900, AKASHI Takahiro wrote:
> On 11/20/2014 04:06 AM, Will Deacon wrote:
> >What does x86 do?
> 
> On x86, syscall(-1) returns -ENOSYS if not traced, and we can change a return
> value if traced.

... which is used for UML (user mode Linux).  UML works by spawning
processes under the host kernel, which run with syscall tracing enabled,
with the UML kernel as the tracer.  The UML kernel tracer receives the
syscall trace event when the child tries to execute a syscall, decodes
the syscall, executes syscall in the UML kernel, and then cancels the
syscall in the host kernel, setting the return code appropriately.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
