From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 18 Nov 2016 09:29:05 -0500
Subject: [PATCH V8 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <1479438454-28650-2-git-send-email-zhang.chunyan@linaro.org>
References: <1479438454-28650-1-git-send-email-zhang.chunyan@linaro.org>
 <1479438454-28650-2-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <20161118092905.769044bf@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Nov 2016 11:07:32 +0800
Chunyan Zhang <zhang.chunyan@linaro.org> wrote:

> Currently Function traces can be only exported to ring buffer, this
> patch added trace_export concept which can process traces and export
> them to a registered destination as an addition to the current only
> one output of Ftrace - i.e. ring buffer.
> 
> In this way, if we want Function traces to be sent to other destination
> rather than ring buffer only, we just need to register a new trace_export
> and implement its own .write() function for writing traces to storage.
> 
> With this patch, only Function trace (trace type is TRACE_FN)
> is supported.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

This looks good to me, although I would like this to go through my tree
(to make sure it gets all my testing). I understand the next two
patches depend on this, how would you want to go about that?

One is that I can pull it in the next merge window, and the rest go in
after that. Or I can take the other two patches with the proper acks as
well.

-- Steve
