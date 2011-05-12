From: kees.cook@canonical.com (Kees Cook)
Date: Thu, 12 May 2011 02:24:24 -0700
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110512074850.GA9937@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
	<20110512074850.GA9937@elte.hu>
Message-ID: <20110512092424.GO28888@outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 12, 2011 at 09:48:50AM +0200, Ingo Molnar wrote:
> 1) We already have a specific ABI for this: you can set filters for events via 
>    an event fd.
> 
>    Why not extend that mechanism instead and improve *both* your sandboxing
>    bits and the events code? This new seccomp code has a lot more
>    to do with trace event filters than the minimal old seccomp code ...

Would this require privileges to get the event fd to start with? If so,
I would prefer to avoid that, since using prctl() as shown in the patch
set won't require any privs.

-Kees

-- 
Kees Cook
Ubuntu Security Team
