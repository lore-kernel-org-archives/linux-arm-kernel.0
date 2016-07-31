From: jolsa@redhat.com (Jiri Olsa)
Date: Sun, 31 Jul 2016 14:02:19 +0200
Subject: [PATCH V3 3/6] perf tools: add infrastructure for PMU specific
 configuration
In-Reply-To: <1469742143-22245-4-git-send-email-mathieu.poirier@linaro.org>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-4-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160731120219.GA12673@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 03:42:20PM -0600, Mathieu Poirier wrote:
> This patch adds PMU driver specific configuration to the parser
> infrastructure by preceding any term with the '@' letter.  As such
> doing something like:
> 
> perf record -e some_event/@cfg1, at cfg2=config/ ...
> 
> will see 'cfg1' and 'cfg2=config' being added to the list of evsel config
> terms.  Token 'cfg1' and 'cfg2=config' are not processed in user space
> and are meant to be interpreted by the PMU driver.
> 
> First the lexer/parser are supplemented with the required definitions to
> recognise the driver specific configuration.  From there they are simply
> added to the list of event terms.  The bulk of the work is done in
> function "parse_events_add_pmu()" where driver config event terms are
> added to a new list of driver config terms, which in turn spliced with
> the event's new driver configuration list.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
