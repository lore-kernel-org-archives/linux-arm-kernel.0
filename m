From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 11 Dec 2015 16:12:39 +0200
Subject: [PATCH V6 20/26] perf: changing pmu::setup_aux() parameter to
 include event
In-Reply-To: <1449176702-13213-21-git-send-email-mathieu.poirier@linaro.org>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
 <1449176702-13213-21-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87egetcbvs.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> For Coresight ETMv3/4 tracers the event carries information
> about trace modes such as user or kernel space tracing and
> whether tracing is allowed when operating in secure mode.

Ok, so it looks to me that what you're doing in your setup_aux with the
event, you should rather be doing in pmu::event_init(), which takes
event as a parameter and it even makes more sense semantically, because
that bit is really configuring the parameters of tracing and not
capturing, which setup_aux() is more about. And the above paragraph also
sounds very much like it. Since in Coresight there is a very clear
distinction between trace generation (sources) and capturing (sinks) it
should also be possible to structure the code in such a way that the
former are not as closely tied to the latter. Please correct me if I'm
missing something.

Regards,
--
Alex
