From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 16 May 2018 20:12:26 -0500
Subject: [PATCH 0/3] coresight: Don't use contextID with PID namespaces
In-Reply-To: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
 (Mathieu Poirier's message of "Tue, 15 May 2018 11:13:34 -0600")
References: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87po1vjdad.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> Since the in-kernel value of a PID differs from what is seen from 
> PID namespaces, using contextID tracing with PID namespaces makes the
> feature confusing to use and potentially subject to leaking out internal
> kernel information.
>
> This set returns an error if contextID and PID namespaces are used in
> conjunction and gets rid of the vpid-to-pid translation function as it
> is no longer needed.

I looked the file can only be written by root.  So limiting things to
the initial pid namespace seems like the right solutions.  Especially as
the trace stream will include the global pid and be available to the
tracer.

This sounds like a simple code with a minimal chance of breaking
userspace.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
